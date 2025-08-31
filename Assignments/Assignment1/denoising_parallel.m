function denoising_parallel(rawImages, patterns, noise_regions, mode)
    nImgs = numel(rawImages);
    results = cell(nImgs,1); 

    parfor i = 1:nImgs
        fprintf('Processing RawImage%d in worker %d\n', i, getCurrentTask().ID);

        image_rgb = demosaic(rawImages{i}, patterns{i});
        image_wb = white_balance(image_rgb, 'gray');
        % image_wb = image_rgb;

        coords = noise_regions{i};
        row_start = coords(1,1); col_start = coords(1,2);
        row_end = coords(2,1);   col_end = coords(2,2);

        noise_patch = image_wb(row_start:row_end, col_start:col_end, :);

        sigma_n_R = std2(noise_patch(:,:,1));
        sigma_n_G = std2(noise_patch(:,:,2));
        sigma_n_B = std2(noise_patch(:,:,3));

        sigma_r_factor = 1.95; sigma_s = 2.5; w = 5;
        sigma_r_R = sigma_r_factor * sigma_n_R;
        sigma_r_G = sigma_r_factor * sigma_n_G;
        sigma_r_B = sigma_r_factor * sigma_n_B;

        denoised_R = bfilter2(image_wb(:,:,1), w, [sigma_s, sigma_r_R]);
        denoised_G = bfilter2(image_wb(:,:,2), w, [sigma_s, sigma_r_G]);
        denoised_B = bfilter2(image_wb(:,:,3), w, [sigma_s, sigma_r_B]);

        denoised_image = cat(3, denoised_R, denoised_G, denoised_B);

        results{i} = struct('image_wb', image_wb, ...
                            'denoised_image', denoised_image, ...
                            'coords', coords, ...
                            'idx', i);
    end

    for i = 1:nImgs
        data = results{i};
        row_start = data.coords(1,1); col_start = data.coords(1,2);
        row_end = data.coords(2,1); col_end = data.coords(2,2);

        filename_before = sprintf('RawImage%d_before_denoising.pdf', i);
        filename_after = sprintf('RawImage%d_after_denoising.pdf', i);

        if strcmp(mode,"save")
            f1 = figure('Visible','off');
            imshow(data.image_wb);
            rectangle('Position', [col_start, row_start, col_end-col_start, row_end-row_start], ...
                      'EdgeColor', 'r', 'LineWidth', 2);
            title('Before Denoising');
            exportgraphics(f1, filename_before, 'ContentType','vector');
            close(f1);

            f2 = figure('Visible','off');
            imshow(data.denoised_image);
            title('After Bilateral Filtering');
            exportgraphics(f2, filename_after, 'ContentType','vector');
            close(f2);
        end

        if strcmp(mode,"plot") 
            figure('Name', sprintf('Denoising Results for RawImage%d', i), 'NumberTitle', 'off');
            subplot(1,2,1);
            imshow(data.image_wb);
            title('Before Denoising');
            rectangle('Position', [col_start, row_start, col_end-col_start, row_end-row_start], ...
                      'EdgeColor', 'r', 'LineWidth', 2);

            subplot(1,2,2);
            imshow(data.denoised_image);
            title('After Bilateral Filtering');
        end
    end
end

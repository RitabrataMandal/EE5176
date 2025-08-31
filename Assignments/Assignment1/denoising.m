function denoising(rawImages, patterns, noise_regions, saveFlag)
    w = 5;         
    sigma_s = 2.5; 
    sigma_r_factor = 1.95; 

    for i = 1:numel(rawImages)
        fprintf('RawImage%d\n', i);

        image_rgb = demosaic(rawImages{i}, patterns{i});
        image_wb = white_balance(image_rgb, 'gray');
        % image_wb = min(max(im2double(image_rgb),0),1);

        coords = noise_regions{i};
        row_start = coords(1,1); col_start = coords(1,2);
        row_end = coords(2,1);   col_end = coords(2,2);

        noise_patch = image_wb(row_start:row_end, col_start:col_end, :);

        sigma_n_R = std2(noise_patch(:,:,1));
        sigma_n_G = std2(noise_patch(:,:,2));
        sigma_n_B = std2(noise_patch(:,:,3));
        fprintf(' Noise Std Dev (R,G,B): %.4f, %.4f, %.4f\n', ...
            sigma_n_R, sigma_n_G, sigma_n_B);

        sigma_r_R = sigma_r_factor * sigma_n_R;
        sigma_r_G = sigma_r_factor * sigma_n_G;
        sigma_r_B = sigma_r_factor * sigma_n_B;

        denoised_R = bfilter2(image_wb(:,:,1), w, [sigma_s, sigma_r_R]);
        denoised_G = bfilter2(image_wb(:,:,2), w, [sigma_s, sigma_r_G]);
        denoised_B = bfilter2(image_wb(:,:,3), w, [sigma_s, sigma_r_B]);

        denoised_image = cat(3, denoised_R, denoised_G, denoised_B);

        if saveFlag
            f1 = figure('Visible','off');
            imshow(image_wb);
            title('Before Denoising');
            rectangle('Position', [col_start, row_start, col_end-col_start, row_end-row_start], ...
                      'EdgeColor', 'r', 'LineWidth', 2);
            text(col_start, row_start-10, 'Noise Patch', 'Color', 'red', 'FontSize', 10);
            filename_before = sprintf('RawImage%d_before_denoising.pdf', i);
            exportgraphics(f1, filename_before, 'ContentType','vector');
            close(f1);

            f2 = figure('Visible','off');
            imshow(denoised_image);
            title('After Bilateral Filtering');
            filename_after = sprintf('RawImage%d_after_denoising.pdf', i);
            exportgraphics(f2, filename_after, 'ContentType','vector');
            close(f2);

            figure('Name', sprintf('Denoising Results for RawImage%d', i), 'NumberTitle', 'off');
            subplot(1,2,1), imshow(imread(filename_before)), title('Before Denoising');
            subplot(1,2,2), imshow(imread(filename_after)), title('After Bilateral Filtering');

        else
            figure('Name', sprintf('Denoising Results for RawImage%d', i), 'NumberTitle', 'off');
            subplot(1,2,1);
            imshow(image_wb);
            title('Before Denoising');
            rectangle('Position', [col_start, row_start, col_end-col_start, row_end-row_start], ...
                      'EdgeColor', 'r', 'LineWidth', 2);
            text(col_start, row_start-10, 'Noise Patch', 'Color', 'red', 'FontSize', 10);

            subplot(1,2,2);
            imshow(denoised_image);
            title('After Bilateral Filtering');
        end
    end

    fprintf('\nProcessing complete.\n');
end

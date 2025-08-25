function rgb_balanced = white_balance(rgb_image, method, coords)
    rgb_image = im2double(rgb_image);

    switch lower(method)
        case 'gray'
            meanR = mean(mean(rgb_image(:,:,1)));
            meanG = mean(mean(rgb_image(:,:,2)));
            meanB = mean(mean(rgb_image(:,:,3)));

            meanGray = (meanR + meanG + meanB) / 3;

            scaleR = meanGray / meanR;
            scaleG = meanGray / meanG;
            scaleB = meanGray / meanB;

        case 'whitepatch'
            if nargin < 3
                error('Coordinates required for White Patch method');
            end
            pixel_val = squeeze(rgb_image(coords(2), coords(1), :));

            scaleR = 1 / pixel_val(1);
            scaleG = 1 / pixel_val(2);
            scaleB = 1 / pixel_val(3);

        case 'neutral'
            if nargin < 3
                error('Coordinates required for Neutral Point method');
            end
            pixel_val = squeeze(rgb_image(coords(2), coords(1), :));
            avg_val = mean(pixel_val);

            scaleR = avg_val / pixel_val(1);
            scaleG = avg_val / pixel_val(2);
            scaleB = avg_val / pixel_val(3);

        otherwise
            error('Unknown method. Use "gray", "whitepatch", or "neutral".');
    end

    rgb_balanced = rgb_image;
    rgb_balanced(:,:,1) = rgb_balanced(:,:,1) * scaleR;
    rgb_balanced(:,:,2) = rgb_balanced(:,:,2) * scaleG;
    rgb_balanced(:,:,3) = rgb_balanced(:,:,3) * scaleB;

    rgb_balanced = min(max(rgb_balanced,0),1);
end

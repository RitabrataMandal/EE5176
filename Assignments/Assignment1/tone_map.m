function img_out = tone_map(rgb_image, method, gamma_val)
    rgb_image = im2double(rgb_image);
    switch lower(method)
        case 'histeq'

            ycbcr = rgb2ycbcr(rgb_image);
            ycbcr(:,:,1) = histeq(ycbcr(:,:,1));
            img_out = ycbcr2rgb(ycbcr);

        case 'gamma'
            if nargin < 3
                error('Gamma value required for gamma correction');
            end
            img_out = rgb_image .^ gamma_val;
        otherwise
            error('Unknown method. Use "histeq" or "gamma".');
    end
end

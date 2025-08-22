function demos(bayer1,RawImage1,de,ip)
    s = size(RawImage1);
    
    red = zeros(s);
    green = zeros(s);
    blue = zeros(s);
    
    red(bayer1==1) = RawImage1(bayer1==1);
    green(bayer1==2) = RawImage1(bayer1==2);
    blue(bayer1==3) = RawImage1(bayer1==3);
    
    [X,Y] = meshgrid(1:s(2), 1:s(1));
    
    [xr, yr] = find(red>0);
    vr = double(red(red>0));
    interpolated_red_linear_interp = griddata(xr, yr, vr, Y, X, 'linear');
    interpolated_red_linear_interp(isnan(interpolated_red_linear_interp)) = 0;
    
    [xr, yr] = find(red>0);
    vr = double(red(red>0));
    interpolated_red_cubic_interp = griddata(xr, yr, vr, Y, X, 'cubic');
    interpolated_red_cubic_interp(isnan(interpolated_red_cubic_interp)) = 0;
    
    [xg, yg] = find(green>0);
    vg = double(green(green>0));
    interpolated_green_linear_interp = griddata(xg, yg, vg, Y, X, 'linear');
    interpolated_green_linear_interp(isnan(interpolated_green_linear_interp)) = 0;
    
    [xg, yg] = find(green>0);
    vg = double(green(green>0));
    interpolated_green_cubic_interp = griddata(xg, yg, vg, Y, X, 'cubic');
    interpolated_green_cubic_interp(isnan(interpolated_green_cubic_interp)) = 0;
    
    [xb, yb] = find(blue>0);
    vb = double(blue(blue>0));
    interpolated_blue_linear_interp = griddata(xb, yb, vb, Y, X, 'linear');
    interpolated_blue_linear_interp(isnan(interpolated_blue_linear_interp)) = 0;
    
    [xb, yb] = find(blue>0);
    vb = double(blue(blue>0));
    interpolated_blue_cubic_interp = griddata(xb, yb, vb, Y, X, 'cubic');
    interpolated_blue_cubic_interp(isnan(interpolated_blue_cubic_interp)) = 0;
    
    rgb_image_linear_interp = cat(3, interpolated_red_linear_interp, interpolated_green_linear_interp, interpolated_blue_linear_interp);
    rgb_image_linear_interp = uint8(rgb_image_linear_interp);  
    
    rgb_image_cubic_interp = cat(3, interpolated_red_cubic_interp, interpolated_green_cubic_interp, interpolated_blue_cubic_interp);
    rgb_image_cubic_interp = uint8(rgb_image_cubic_interp);  

    if ip ==2 
        YCBCR = rgb2ycbcr(rgb_image_cubic_interp);
        YCBCR(:,:,2) = medfilt2(YCBCR(:,:,2), [3 3]);  
        YCBCR(:,:,3) = medfilt2(YCBCR(:,:,3), [3 3]);  
        rgb_image_with_median_filter = ycbcr2rgb(YCBCR);
    end

    % keyboard;
    figure;imshow(uint8(interpolated_red_linear_interp));title('R-Channel(linear interp)');
    figure;imshow(uint8(interpolated_green_linear_interp));title('G-Channel(linear interp)');
    figure;imshow(uint8(interpolated_blue_linear_interp));title('B-Channel (linear interp)');
    figure;imshow(rgb_image_linear_interp); title('Reconstructed RGB Image(linear interp)');
    figure;imshow(uint8(interpolated_red_cubic_interp));title('R-Channel(cubic interp)');
    figure;imshow(uint8(interpolated_green_cubic_interp));title('G-Channel(cubic interp)');
    figure;imshow(uint8(interpolated_blue_cubic_interp));title('B-Channel(cubic interp)');
    figure;imshow(rgb_image_cubic_interp); title('Reconstructed RGB Image(cubic interp)');
    if de == "True"
        figure;imshow(demosaic(RawImage1,"rggb")); title('RGB Image(inbuild demosaic)');
    end
    if ip==2
        figure;imshow(rgb_image_with_median_filter); title('RGB Image(cubic interp) with median filter');
    end
end
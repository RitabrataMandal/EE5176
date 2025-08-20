clc; clear;close all;

load("Copy of bayer1.mat");       
load("Copy of RawImage1.mat");  
s = size(RawImage1);

red   = zeros(s);
green = zeros(s);
blue  = zeros(s);

red(bayer1==1)   = RawImage1(bayer1==1);
green(bayer1==2) = RawImage1(bayer1==2);
blue(bayer1==3)  = RawImage1(bayer1==3);

[X,Y] = meshgrid(1:s(2), 1:s(1));

[xr, yr] = find(red>0);
vr = double(red(red>0));
interpolated_red = griddata(xr, yr, vr, Y, X, 'cubic');
interpolated_red(isnan(interpolated_red)) = 0;

[xg, yg] = find(green>0);
vg = double(green(green>0));
interpolated_green = griddata(xg, yg, vg, Y, X, 'cubic');
interpolated_green(isnan(interpolated_green)) = 0;

[xb, yb] = find(blue>0);
vb = double(blue(blue>0));
interpolated_blue = griddata(xb, yb, vb, Y, X, 'cubic');
interpolated_blue(isnan(interpolated_blue)) = 0;

rgb_image = cat(3, interpolated_red, interpolated_green, interpolated_blue);
rgb_image = uint8(rgb_image);  % back to 8-bit

figure;
subplot(2,2,1); imshow(uint8(interpolated_red)); title('Red Channel');
subplot(2,2,2); imshow(uint8(interpolated_green)); title('Green Channel');
subplot(2,2,3); imshow(uint8(interpolated_blue)); title('Blue Channel');
subplot(2,2,4); imshow(rgb_image); title('Reconstructed RGB Image');
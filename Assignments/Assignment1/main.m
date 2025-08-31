clc; clear;close all;

load("bayer1.mat");       
load("RawImage1.mat"); 
load("kodim19.mat");
load("kodim_cfa.mat");
load("RawImage2.mat");
load("RawImage3.mat");

disp("1. Question 1 - Apply Median Filter on Cb, Cr");
disp("2. Question 2 - White Balancing & Tone Mapping");
disp("3. Question 3 - Denoising with Bilateral Filter");
choice = input("Enter choice (1, 2, or 3): ");
switch choice
    case 1
        % ------------ Question-1 ---------------------
        % demos(bayer1, RawImage1, "True",1);
        demos(cfa, raw, "False",2);
        % ---------------------------------------------
    case 2
    % ------------ Question-2 ---------------------
        rawImages = {RawImage1, RawImage2, RawImage3};
        patterns  = {"rggb", "grbg", "rggb"};  % CFA patterns for demosaic
        coords_whitepatch = {[830,814], [1165,280], [175,675]};
        coords_neutral    = {[2000,435], [445,715], [1550,565]};
        
        wb_methods = {'gray', 'whitepatch', 'neutral'}; % white balance methods
        gammas = [0.5, 0.7, 0.9];
        
        for i = 1:3
            image_rgb = demosaic(rawImages{i}, patterns{i});
        
            wb{1} = white_balance(image_rgb, 'gray');
            wb{2} = white_balance(image_rgb, 'whitepatch', coords_whitepatch{i});
            wb{3} = white_balance(image_rgb, 'neutral', coords_neutral{i});
        
            figure('Name',sprintf('RawImage%d - White Balance',i));
            imgs = {image_rgb, wb{1}, wb{2}, wb{3}};
            titles = {sprintf('RawImage%d Original', i), 'Gray World WB', 'White Patch WB', 'Neutral Point WB'};
            
            for k = 1:4
                subplot(2,2,k), imshow(imgs{k}), title(titles{k});
                
                f = figure('Visible','off');
                imshow(imgs{k});
                title(titles{k});
                set(f, 'Color', 'w');
                filename = sprintf('RawImage%d_WB_%d.pdf', i, k);
                exportgraphics(f, filename, 'ContentType','vector');
                close(f);
            end
        
            figure('Name',sprintf('RawImage%d - Tone Mapping',i));
            plot_idx = 1;
            for j = 1:3
                tone_eq = tone_map(wb{j}, 'histeq');
                subplot(3,4,plot_idx), imshow(tone_eq), ...
                    title(sprintf('%s + HistEq', wb_methods{j}));
                
                f = figure('Visible','off');
                imshow(tone_eq);
                title(sprintf('%s + HistEq', wb_methods{j}));
                set(f, 'Color', 'w');
                filename = sprintf('RawImage%d_Tone_%s_HistEq.pdf', i, wb_methods{j});
                exportgraphics(f, filename, 'ContentType','vector');
                close(f);
                
                plot_idx = plot_idx + 1;
        
                for g = 1:length(gammas)
                    tone_gamma = tone_map(wb{j}, 'gamma', gammas(g));
                    subplot(3,4,plot_idx), imshow(tone_gamma), ...
                        title(sprintf('%s + Gamma %.1f', wb_methods{j}, gammas(g)));
                    
                    f = figure('Visible','off');
                    imshow(tone_gamma);
                    title(sprintf('%s + Gamma %.1f', wb_methods{j}, gammas(g)));
                    set(f, 'Color', 'w');
                    filename = sprintf('RawImage%d_Tone_%s_Gamma%.1f.pdf', i, wb_methods{j}, gammas(g));
                    exportgraphics(f, filename, 'ContentType','vector');
                    close(f);
                    
                    plot_idx = plot_idx + 1;
                end
            end
        end
        case 3
            rawImages = {RawImage1, RawImage2, RawImage3};
            patterns  = {"rggb", "grbg", "rggb"};
            noise_regions = {
            [100, 100; 160, 160],   % RawImage1
            [705, 924; 765, 984],   % RawImage2
            [50, 400; 110, 460]     % RawImage3
            };
            denoising(rawImages,pattern,noise_regions,false);
            % denoising_parallel(rawImages,patterns, noise_regions,"plot");
        otherwise
            disp("Invalid choice. Please run again.");
end
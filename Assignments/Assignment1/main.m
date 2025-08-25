clc; clear;close all;

load("bayer1.mat");       
load("RawImage1.mat"); 
load("kodim19.mat");
load("kodim_cfa.mat");
load("RawImage2.mat");
load("RawImage3.mat");

disp("Choose which Question to run:");
disp("1. Question 1 - Apply Median Filter on Cb, Cr");
disp("2. Question 2 - White Balancing & Tone Mapping");
choice = input("Enter choice (1 or 2): ");
switch choice
    case 1
        % ------------ Question-1 ---------------------
        demos(bayer1, RawImage1, "True",1);
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
            % ----- Step 1: Demosaic -----
            image_rgb = demosaic(rawImages{i}, patterns{i});
        
            % ----- Step 2: White Balance -----
            wb{1} = white_balance(image_rgb, 'gray');
            wb{2} = white_balance(image_rgb, 'whitepatch', coords_whitepatch{i});
            wb{3} = white_balance(image_rgb, 'neutral', coords_neutral{i});
        
            % ----- Step 3: Display Original + WB results -----
            figure('Name',sprintf('RawImage%d - White Balance',i));
            subplot(2,2,1), imshow(image_rgb), title(sprintf('RawImage%d Original', i));
            subplot(2,2,2), imshow(wb{1}), title('Gray World WB');
            subplot(2,2,3), imshow(wb{2}), title('White Patch WB');
            subplot(2,2,4), imshow(wb{3}), title('Neutral Point WB');
        
            % ----- Step 4: Tone Mapping -----
            figure('Name',sprintf('RawImage%d - Tone Mapping',i));
            plot_idx = 1;
            for j = 1:3 % WB methods
                % Histogram Equalization
                tone_eq = tone_map(wb{j}, 'histeq');
                subplot(3,4,plot_idx), imshow(tone_eq), ...
                    title(sprintf('%s + HistEq', wb_methods{j}));
                plot_idx = plot_idx + 1;
        
                % Gamma corrections
                for g = 1:length(gammas)
                    tone_gamma = tone_map(wb{j}, 'gamma', gammas(g));
                    subplot(3,4,plot_idx), imshow(tone_gamma), title(sprintf('%s + Gamma %.1f', wb_methods{j}, gammas(g)));
                    plot_idx = plot_idx + 1;
                end
            end
        end
        
        % ---------------------------------------------
        otherwise
            disp("Invalid choice. Please run again.");
end
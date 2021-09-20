clc
clear

img_struct = load('testimage.mat');

original = im2double(img_struct.original);
noisy = im2double(img_struct.noisy);

corrected_img = myMedfilt1(noisy);  % using our median filter to improve the noisy image

mse_err = mse(original, corrected_img); % calculating mse between original image nad filtered image
fprintf("MSE = %d\n", mse_err);

imshow([noisy corrected_img], []);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = myMedfilt1(inputImg)
    [rows, cols] = size(inputImg);
    
    tmp = padarray(inputImg, [1 1], 'both');    % padding input image
    
    output = zeros(rows, cols);
    
    for r = 2:rows+1
        for c = 2:cols+1
            if tmp(r, c) == 0 || tmp(r, c) == 1     % detecting probable noisy pixels
                output(r-1, c-1) = median(tmp(r, c-1:c+1)); % modify noisy pixel
            else
                output(r-1, c-1) = tmp(r, c);
            end
        end
    end
end
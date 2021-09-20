clc
clear

img_struct = load('testimage.mat');

original = im2double(img_struct.original);
noisy = im2double(img_struct.noisy);

corrected_img = myMeanfilt1(noisy, 0, 15);   % using mean filter to improve the noisy image || M1=0, M2=15

mse_err = mse(original, corrected_img); % calculating mse between original image nad filtered image
fprintf("MSE = %d\n", mse_err);

imshow([noisy corrected_img], []);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = myMeanfilt1(inputImg, M1, M2)
    [rows, cols] = size(inputImg);
    
    tmp = padarray(inputImg, [M2 M2], 'both');  % padding input image
    
    output = zeros(rows, cols);
    
    for r = M2+1:rows+M2
        for c = M2+1:cols+M2
            if tmp(r, c) == 0 || tmp(r, c) == 1     % detecting probable noisy pixels
                output(r-M2, c-M2) = mean(tmp(r, c-M2:c+M1));   % modify noisy pixel
            else
                output(r-M2, c-M2) = tmp(r, c);
            end
        end
    end
end
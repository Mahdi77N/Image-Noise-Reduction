clc
clear

img_struct = load('testimage.mat');

original = im2double(img_struct.original);
noisy = im2double(img_struct.noisy);

corrected_img = medfilt1(noisy, 3); % using median filter to improve the noisy image

mse_err = mse(original, corrected_img); % calculating mse between original image nad filtered image
fprintf("MSE = %d\n", mse_err);

imshow([noisy corrected_img], []);
% load the original ct scan image
image = imread('image.jpeg');
image = rgb2gray(image);

% The 3rd argument means zero-mean white Gaussian noise
% The 4th argument is the variance of the image. 
% In addition, the imnoise function adds noise to 
% each color channel independently.
noisy = imnoise(image, 'gaussian', 0, 0.01);

% pretrained denoising convolutional neural network

cnn = denoisingNetwork('DnCNN');

% use CNN to denoisy image
denosiy = denoiseImage(noisy, cnn);

% Display all images original image, noisy image, and denoised image
montage({image, noisy, denosiy}, 'size', [1 NaN]);
title("Original vs Noise vs Denoised");

% Calculate psnr and ssim
noisyPSNR = psnr(noisy,image);
fprintf("\n The PSNR value of the noisy image is %0.4f.", noisyPSNR);

denoisyPSNR = psnr(denosiy,image);
fprintf("\n The PSNR value of the denoisy image is %0.4f.", denoisyPSNR);

noisySSIM = ssim(noisy,image);
fprintf("\n The SSIM value of the noisy image is %0.4f.", noisySSIM);

denoisySSIM = ssim(denosiy,image);
fprintf("\n The SSIM value of the denoisy image is %0.4f.", denoisySSIM);

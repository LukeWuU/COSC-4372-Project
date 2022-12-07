% load the original ct scan image
ori_Image = imread('image.jpeg');
ori_Image = rgb2gray(ori_Image);

% pretrained denoising convolutional neural network
cnn = denoisingNetwork('DnCNN');

% The 3rd argument means zero-mean white Gaussian noise
% The 4th argument is the variance of the image. 
% In addition, the imnoise function adds noise to 
% each color channel independently.
hold on
for i = [0.01 , 0.025, 0.05, 0.075, 0.1]
    noisy = imnoise(image, 'gaussian', 0, i);

    % use CNN to denoisy image
    denosiy = denoiseImage(noisy, cnn);

    % Displays the original, noisy, and denoised images
    montage({image, noisy, denosiy}, 'size', [1 NaN]);
    title("Original vs Noise vs Denoised");
    figure();
end

hold on
for j = [0.01 , 0.025, 0.05, 0.075, 0.1]
    image_2 = imnoise(ori_Image, 'gaussian', 0, j);
    
    % use CNN to denoisy image
    image_3 = denoiseImage(image_2, cnn);

    denoisySSIM = ssim(image_3,image);
    % Plots a SSIM vs. Noise level graph
    plot(j,denoisySSIM,'--bo');
    xlabel('Noise Level');
    ylabel('SSIM');
    title('SSIM Vs Noise Level');
end

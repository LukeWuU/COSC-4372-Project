% Requires Imaging Processing Toolbox
% Requires Deep Learning Toolbox

% ori_Image is the original image
ori_Image = phantom('Modified Shepp-Logan',256);

% Gets the maximum signal value of the original, grayscale image
sMax = max(ori_Image(:));
fprintf('\n Max Signal Value of Grayscale Image is %0.5f', sMax);

% Pretrained Denoising Convolutional Neural Network
net = denoisingNetwork('DnCNN');

% To change ammount of noise density to apply to the image, change the fourth
% argument. i.e. 0.03 applies noise density of 0.03
% logan2 is the original image with added noise
% logan2 = imnoise(logan1, 'gaussian', 0, 0.03);

hold on
for i = [0.01 , 0.025, 0.05, 0.075, 0.1]
    noisy = imnoise(image, 'gaussian', 0, i);

    % Noisy image is denoised by the pretrained network
    denosiy = denoiseImage(noisy, cnn);

    % Displays the original, noisy, and denoised images
    montage({image, noisy, denosiy}, 'size', [1 NaN]);
    title("Original vs Noise vs Denoised");
    figure()
    
end

hold on
for j = [0.01 , 0.025, 0.05, 0.075, 0.1]
    image_2 = imnoise(ori_Image, 'gaussian', 0, j);
    
    % Noisy image is denoised by the pretrained network
    image_3 = denoiseImage(image_2, net);
    
    % Calculates peak Signal-to-Noise Ratio and Signal-to-Noise Ratio of
    % Noisy and Denoised images
    [PSNR, snr] = psnr(image_2, image_3);
    
    % Plots a SSIM vs. Noise level graph
    plot(j,snr,'--bo');
    xlabel('Noise Level')
    ylabel('SSIM')
    title('SSIM Vs Noise Level')
    
    % Prints the Peak Signal-to-Noise Ratio and Signal-to-Noise Ratio of
    % Noisy and Denoised images
    fprintf('\n PSNR value is %0.5f', PSNR);
    fprintf('\n SNR value is %0.5f \n', snr);
end
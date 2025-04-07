function [rotatedImg, adapt_histeq] = preProcessing(I)
    % Rotate the image by 90 degrees clockwise
    rotatedImg = imrotate(I, -90);

    % Convert to grayscale
    grayImg = rgb2gray(rotatedImg);

    % Display the number of distinct gray levels in the image
    gray_level = unique(grayImg);
    number_of_level = numel(gray_level);
    disp(['The image has ', num2str(number_of_level), ' distinct gray levels.']);

    % Apply histogram equalization to improve overall contrast
    n_bins = 10; % 10 because it is much less than the number of distinct gray levels (226)
    hist_eq = histeq(grayImg, n_bins);

    % Apply adaptive histogram equalization
    adapt_histeq = adapthisteq(grayImg, 'NumTiles', [10 10], 'ClipLimit', 0.9);

    % Display original, histogram equalized, and adaptively histogram equalized images
    preProcessing = {grayImg, hist_eq, adapt_histeq};
    montage(preProcessing, 'Size', [1 3]);
    title('Original, Histogram Equalized, and Adaptively Histogram Equalized Images');
end

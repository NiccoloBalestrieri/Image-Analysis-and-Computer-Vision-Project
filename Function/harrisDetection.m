% Perform Harris corner detection on an image after adaptive histogram equalization.
function harrisDetection(adapt_histeq)
    % Detect Harris corners in the image
    corners = detectHarrisFeatures(adapt_histeq);
    % Display the image
    imshow(adapt_histeq);
    hold on;
    % Plot the strongest Harris corners on the image
    plot(corners.selectStrongest(100));
end
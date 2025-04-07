function edgeDetectionResults = edgeDetection(image)
    % Sobel Edge Detection
    Sobel = edge(image, 'Sobel');
    figure, imshow(Sobel), title('Sobel');

    % Prewitt Edge Detection
    Prewitt = edge(image, 'Prewitt');
    figure, imshow(Prewitt), title('Prewitt');

    % Log Edge Detection
    Log = edge(image, 'log');
    figure, imshow(Log), title('Log');

    % Canny Edge Detection
    Canny = edge(image, 'Canny');
    figure, imshow(Canny), title('Canny');

    % Store the results in a cell array for output
    edgeDetectionResults = {Sobel, Prewitt, Log, Canny};
end

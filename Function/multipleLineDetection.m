% Apply Hough transform for multiple line detection.
function multipleLineDetection(resultEdgeImage, rotatedImg)
    % Apply Hough transform for line detection
    [H, theta, rho] = hough(resultEdgeImage, 'Theta', -60:60);

    % Find peaks in the Hough transform
    peaks = houghpeaks(H, 60);

    % Extract coordinates of the peaks
    lines = houghlines(resultEdgeImage, theta, rho, peaks, 'FillGap', 40, 'MinLength', 110);

    % Get the length of the array
    arrayLength = length(lines);

    % Display the length
    disp(['The length of the array is: ', num2str(arrayLength)]);

    % Display the detected lines
    figure;
    imshow(rotatedImg);
    hold on;

    for i = 1:length(lines)
        xy = [lines(i).point1; lines(i).point2];
        plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color', 'red');

        % Plot beginnings and ends of lines
        plot(xy(1,1),xy(1,2),'o','LineWidth',2,'Color','magenta');
        plot(xy(2,1),xy(2,2),'o','LineWidth',2,'Color','green');
    end

    title('Detected Lines with Hough');
    hold off;
end

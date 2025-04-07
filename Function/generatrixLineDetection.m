% Apply Hough transform for generatrix line detection.
function generatrixLineDetection(resultEdgeImage, rotatedImg)
    % Apply Hough transform for line detection
    [H, theta, rho] = hough(resultEdgeImage, 'Theta', 1.5:50);

    % Find peaks in the Hough transform
    peaks = houghpeaks(H, 2); % 2 is the number of peaks to find, you can adjust it

    % Extract coordinates of the peaks
    lines = houghlines(resultEdgeImage, theta, rho, peaks, 'FillGap', 10000);

    % Get the length of the array
    arrayLength = length(lines);

    % Display the length
    disp(['The length of the array is: ', num2str(arrayLength)]);

    % Display the detected lines
    figure;
    imshow(rotatedImg);
    hold on;
    max_len = 0;
    
    for i = 1:length(lines)
        xy = [lines(i).point1; lines(i).point2];
        plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color', 'red');

        % Plot beginnings and ends of lines
        plot(xy(1,1),xy(1,2),'o','LineWidth',2,'Color','magenta');
        plot(xy(2,1),xy(2,2),'o','LineWidth',2,'Color','green');

        % Determine the endpoints of the longest line segment
        len = norm(lines(i).point1 - lines(i).point2);
        if (len > max_len)
            max_len = len;
            xy_long = xy;
        end
    end

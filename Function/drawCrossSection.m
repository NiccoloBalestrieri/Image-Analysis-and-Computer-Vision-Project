% This function is useful if you want to manually draw the cross-sections.
% Uncomment and call this function in the main script if manual drawing is required.
function drawCrossSection(rotatedImg)
    % Display the image
    figure;
    imshow(rotatedImg);
    hold all;

    % Draw the first cross-section manually
    ellipse1 = drawellipse();
    pause; % Pause for user interaction

    % Draw the second cross-section manually
    ellipse2 = drawellipse();
    pause; % Pause for user interaction

    % Save the drawn ellipses to MAT files
    save('ellipse1.mat', 'ellipse1');
    save('ellipse2.mat', 'ellipse2');

end

% This function is useful if you want to manually draw the generatrix lines.
% Uncomment and call this function in the main script if manual drawing is required.
function drawGeneratrixLines(rotatedImg)
    % Display the image
    figure;
    imshow(rotatedImg);
    hold all;

    % Draw the first generatrix line manually
    generatrix_line1 = drawline();

    % Draw the second generatrix line manually
    generatrix_line2 = drawline();

    % Save the drawn lines to a MAT file
    save('generatrix_lines.mat', 'generatrix_line1', 'generatrix_line2');

end

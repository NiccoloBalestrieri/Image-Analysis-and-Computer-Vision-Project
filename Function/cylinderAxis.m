% Compute the centers of the circular points for cylinder axis estimation.
function [c1_center, c2_center] = cylinderAxis(C1, C2, rotatedImg, h)
    % Normalize conic matrices
    C1 = C1 ./ C1(3, 3);
    C2 = C2 ./ C2(3, 3);

    % Normalize the direction vector
    %h = h / norm(h);

    % Calculate the centers of the circular points
    c1_center = inv(C1) * h;
    c2_center = inv(C2) * h;

    % Normalize the centers
    c1_center = c1_center ./ c1_center(3);
    c2_center = c2_center ./ c2_center(3);

    % Save the results
    save("./Utils/c1_center.mat", "c1_center");
    save("./Utils/c2_center.mat", "c2_center");

    % Visualization
    figure;
    imshow(rotatedImg);
    hold all;
    axis equal;

    % Compute the cylinder axis line
    x_a = linspace(-100, 100000, 10000000);
    m_a = (c2_center(2) - c1_center(2)) / (c2_center(1) - c1_center(1));
    b_a = c1_center(2) - m_a * c1_center(1);
    y_a = m_a * x_a + b_a; 
    plot(x_a, y_a, 'b-', 'LineWidth', 2);

    % Display the centers
    plot(c1_center(1), c1_center(2), 'r.', 'MarkerSize', 25);
    plot(c2_center(1), c2_center(2), 'r.', 'MarkerSize', 25);
    text(c1_center(1), c1_center(2), 'A', 'FontSize', 20, 'Color', 'r');
    text(c2_center(1), c2_center(2), 'B', 'FontSize', 20, 'Color', 'r');

    hold off;
end

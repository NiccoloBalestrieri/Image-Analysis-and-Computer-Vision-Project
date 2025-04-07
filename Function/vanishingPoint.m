% Compute the vanishing point of two lines in the image.
function L = vanishingPoint(l1, l2, rotatedImg)
    % Extract coefficients of the lines
    a_l1 = l1(1);
    b_l1 = l1(2);
    c_l1 = l1(3);
    m_l1 = -a_l1 / b_l1;
    q_l1 = -c_l1 / b_l1;

    a_l2 = l2(1);
    b_l2 = l2(2);
    c_l2 = l2(3);
    m_l2 = -a_l2 / b_l2;
    q_l2 = -c_l2 / b_l2;

    % Calculate the intersection point
    x_intersection = (q_l2 - q_l1) / (m_l1 - m_l2);
    y_intersection = m_l1 * x_intersection + q_l1;

    % Display lines and points
    figure;
    imshow(rotatedImg);
    hold all;
    axis equal;

    x_ort_a = linspace(-100, 10000, 1000000);
    y_l1 = m_l1 * x_ort_a + q_l1;
    y_l2 = m_l2 * x_ort_a + q_l2;

    plot(x_ort_a, y_l2, 'b-', 'LineWidth', 2);
    plot(x_ort_a, y_l1, 'b-', 'LineWidth', 2);

    plot(x_intersection, y_intersection, 'g.', 'MarkerSize', 25);
    text(x_intersection, y_intersection, 'V', 'FontSize', 20, 'Color', 'g');
    
    % Return the vanishing point in homogeneous coordinates
    L = [x_intersection, y_intersection, 1];
    L = L ./ L(3);
    L
end

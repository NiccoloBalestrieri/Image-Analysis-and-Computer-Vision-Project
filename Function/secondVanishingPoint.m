% Compute the second vanishing point and visualize the lines and points

function [vp2_x, vp2_y, inter_ellipse1, inter_ellipse2] = secondVanishingPoint(c1_center, c2_center, l1, l2, eq1, eq2, rotatedImg, V, ellipse1, ellipse2)
    % Parameters of line l1
    a_l1 = l1(1);
    b_l1 = l1(2);
    c_l1 = l1(3);
    m_l1 = -a_l1 / b_l1;
    q_l1 = -c_l1 / b_l1;

    % Parameters of line l2
    a_l2 = l2(1);
    b_l2 = l2(2);
    c_l2 = l2(3);
    m_l2 = -a_l2 / b_l2;
    q_l2 = -c_l2 / b_l2;

    % Symbols x and y
    syms x y;

    % Equation of the line orthogonal to l2
    eq_rect = -y - (a_l2 * x + c_l2) / b_l2;

    % Calculation of the intersection points
    inter1 = solve([eq1 == 0, eq_rect == 0]);
    inter2 = solve([eq2 == 0, eq_rect == 0]);

    % Extract the coordinates of the intersection points
    intersection11 = [double(inter1.x(1)); double(inter1.y(1)); 1];
    intersection12 = [double(inter1.x(2)); double(inter1.y(2)); 1];
    intersection21 = [double(inter2.x(1)); double(inter2.y(1)); 1];
    intersection22 = [double(inter2.x(2)); double(inter2.y(2)); 1];
    
    inter_ellipse1 = intersection12; 
    inter_ellipse2 = intersection21;

    % R1
    disp('R1 - Intersection between l2 and ellipse1:');
    disp(intersection11);
    
    % R2
    disp('R2 - Intersection between l2 and ellipse1:');
    disp(intersection12);
    
    % R3
    disp('R3 - Intersection between l2 and ellipse2:');
    disp(intersection21);
    
    % R4
    disp('R4 - Intersection between l2 and ellipse2:');
    disp(intersection22);

    % Calculation of the lines between R1 and c1_center
    m_r1_c1 = (intersection11(2) - c1_center(2)) / (intersection11(1) - c1_center(1));
    b_r1_c1 = intersection11(2) - m_r1_c1 * intersection11(1);

    % Calculation of the lines between R2 and c1_center
    m_r2_c1 = (intersection12(2) - c1_center(2)) / (intersection12(1) - c1_center(1));
    b_r2_c1 = intersection12(2) - m_r2_c1 * intersection12(1);

    % Calculation of the lines between R3 and c2_center
    m_r3_c2 = (c2_center(2) - intersection21(2)) / (c2_center(1) - intersection21(1));
    b_r3_c2 = c2_center(2) - m_r3_c2 * c2_center(1);

    % Calculation of the lines between R4 and c2_center
    m_r4_c2 = (c2_center(2) - intersection22(2)) / (c2_center(1) - intersection22(1));
    b_r4_c2 = c2_center(2) - m_r4_c2 * c2_center(1);

    % R1 - R3 (1.5247, 1.4320) wrong but decent image
    % R1 - R4 (0.8598, 0.7727) wrong and bad image
    % R2 - R3 (1.9476, 18391)  wrong but decent image
    % R2 - R4 (0.6979, 0.6307) wrong and bad image
    % Calculation of the intersection point between the lines
    vp2_x = (b_r3_c2 - b_r2_c1) / (m_r2_c1 - m_r3_c2);
    vp2_y = m_r2_c1 * vp2_x + b_r2_c1;
    
    % Calculation of the line between vp1 and vp2
    m_vp1_vp2 = (vp2_y - V(2)) / (vp2_x - V(1));
    b_vp1_vp2 = V(2) - m_vp1_vp2 * V(1);

    % Visualization of the lines and points
    figure;
    imshow(rotatedImg);
    hold all;
    axis equal;

    x_ort_a = linspace(-100, 10000, 10000000);
    y_l1 = (m_l1) * x_ort_a + q_l1;
    y_l2 = (m_l2) * x_ort_a + q_l2;

    % Plotting of the lines and intersection points
    plot(x_ort_a, y_l2, 'b-', 'LineWidth', 2);
    plot(x_ort_a, y_l1, 'b-', 'LineWidth', 2);
    plot(c1_center(1), c1_center(2), 'r.', 'MarkerSize', 25);
    plot(c2_center(1), c2_center(2), 'r.', 'MarkerSize', 25);
    plot(intersection11(1), intersection11(2), 'r.', 'MarkerSize', 25);
    plot(intersection12(1), intersection12(2), 'r.', 'MarkerSize', 25);
    plot(intersection21(1), intersection21(2), 'r.', 'MarkerSize', 25);
    plot(intersection22(1), intersection22(2), 'r.', 'MarkerSize', 25);
    plot(V(1), V(2), 'g.', 'MarkerSize', 25);
    plot(vp2_x, vp2_y, 'g.', 'MarkerSize', 25);
    
    % Plotting of the lines between intersection1 and c1_center
    plot(x_ort_a, m_r2_c1 * x_ort_a + b_r2_c1, 'm-', 'LineWidth', 2);
    
    % Plotting of the lines between c2_center and intersection3
    plot(x_ort_a, m_r3_c2 * x_ort_a + b_r3_c2, 'c-', 'LineWidth', 2);
    
    % Plotting of the lines between intersection1 and c1_center
    %plot(x_ort_a, m_r1_c1 * x_ort_a + b_r1_c1, 'm-', 'LineWidth', 2);
    
    % Plotting of the lines between c2_center and intersection3
    %plot(x_ort_a, m_r4_c2 * x_ort_a + b_r4_c2, 'c-', 'LineWidth', 2);

    % Plotting of the line between vp1 and vp2
    plot(x_ort_a, m_vp1_vp2 * x_ort_a + b_vp1_vp2, 'y-', 'LineWidth', 2);
    
    % Labeling of points and lines
    text(c1_center(1), c1_center(2), 'A', 'FontSize', 20, 'Color', 'r');
    text(c2_center(1), c2_center(2), 'B', 'FontSize', 20, 'Color', 'r');
    text(intersection11(1), intersection11(2), 'R1', 'FontSize', 20, 'Color', 'r');
    text(intersection12(1), intersection12(2), 'R2', 'FontSize', 20, 'Color', 'r');
    text(intersection21(1), intersection21(2), 'R3', 'FontSize', 20, 'Color', 'r');
    text(intersection22(1), intersection22(2), 'R4', 'FontSize', 20, 'Color', 'r');
    text(vp2_x, vp2_y, 'P', 'FontSize', 20, 'Color', 'g');
    text(V(1), V(2), 'V', 'FontSize', 20, 'Color', 'g');

    % Visualization of ellipses
    drawellipse('Center', ellipse1.Center, 'SemiAxes', ellipse1.SemiAxes, 'RotationAngle', ellipse1.RotationAngle);
    drawellipse('Center', ellipse2.Center, 'SemiAxes', ellipse2.SemiAxes, 'RotationAngle', ellipse2.RotationAngle);
end

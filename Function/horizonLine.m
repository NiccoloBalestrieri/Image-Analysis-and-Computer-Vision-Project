function [eq1, eq2, C1, C2, h, s1, s2] = horizonLine(ellipse1, ellipse2, rotatedImg)
    % Converting geometric parameters to algebraic parameters for ellipse1
    par_geo1 = [ellipse1.Center, ellipse1.SemiAxes, -ellipse1.RotationAngle]';
    par_alg1 = conic_param_geo2alg(par_geo1);
    [a1, b1, c1, d1, e1, f1] = deal(par_alg1(1), par_alg1(2), par_alg1(3), par_alg1(4), par_alg1(5), par_alg1(6));
    C1 = [a1 b1/2 d1/2; b1/2 c1 e1/2; d1/2 e1/2 f1];

    % Sanity check for ellipse1
    im_err = zeros(size(rotatedImg, 1), size(rotatedImg, 2));
    for i = 1:size(rotatedImg, 1)
        for j = 1:size(rotatedImg, 2)
            im_err(i, j) = [j, i, 1] * C1 * [j; i; 1];
        end
    end

    % Converting geometric parameters to algebraic parameters for ellipse2
    par_geo2 = [ellipse2.Center, ellipse2.SemiAxes, -ellipse2.RotationAngle]';
    par_alg2 = conic_param_geo2alg(par_geo2);
    [a2, b2, c2, d2, e2, f2] = deal(par_alg2(1), par_alg2(2), par_alg2(3), par_alg2(4), par_alg2(5), par_alg2(6));
    C2 = [a2 b2/2 d2/2; b2/2 c2 e2/2; d2/2 e2/2 f2];

    % Symbolic variables
    syms x y;

    % Equations for ellipse1 and ellipse2
    eq1 = a1*x^2 + b1*x*y + c1*y^2 + d1*x + e1*y + f1;
    eq2 = a2*x^2 + b2*x*y + c2*y^2 + d2*x + e2*y + f2;

    % Solve the system of equations
    eqns = [eq1 == 0, eq2 == 0];
    S12 = solve(eqns, [x, y], 'IgnoreAnalyticConstraints', true, 'Maxdegree', 4);

    % Extract complex conjugate solutions
    s1 = [double(S12.x(1)); double(S12.y(1)); 1];
    s2 = [double(S12.x(2)); double(S12.y(2)); 1];
    s3 = [double(S12.x(3)); double(S12.y(3)); 1];
    s4 = [double(S12.x(4)); double(S12.y(4)); 1];

    % Calculate the lines at infinity
    l_inf_1 = imag(cross(s1, s2));
    l_inf_2 = imag(cross(s3, s4));

    % Image of circular points of ellipse1
    w = size(rotatedImg, 2);
    
    % Image of circular points of ellipse1 - found through intersection
    % of the two ellipses, complex intersection, so 2 pairs of points of image of circular points.
    % Intersection of these two generates the vanishing lines, which is the image of the line at infinity
    A1 = [0; -l_inf_1(3)/l_inf_1(2); 1];
    B1 = [w; -(l_inf_1(3) + l_inf_1(1)*w)/l_inf_1(2); 1];

    %A2 = [0; -l_inf_2(3)/l_inf_2(2); 1];
    %B2 = [w; -(l_inf_2(3) + l_inf_2(1)*w)/l_inf_2(2); 1];

    % Plotting
    MSZ = 10;
    figure;
    hold all;
    plot(A1(1), A1(2), 'ro', 'MarkerSize', MSZ);
    plot(B1(1), B1(2), 'ro', 'MarkerSize', MSZ);
    %plot(A2(1), A2(2), 'bo', 'MarkerSize', MSZ);
    %plot(B2(1), B2(2), 'bo', 'MarkerSize', MSZ);
    imshow(rotatedImg);
    line([A1(1), B1(1)], [A1(2), B1(2)], 'linewidth', 4, 'Color', 'r');
    %line([A2(1), B2(1)], [A2(2), B2(2)], 'linewidth', 4, 'Color', 'b');
    axis equal;
    h = l_inf_1;
    h = h ./ h(3);
    h
end

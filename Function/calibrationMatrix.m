% Compute the calibration matrix, image of the dual conic to principal points,
% and rectifying homography matrices.
function [w, K, imDCCP, H_rect, H_inv_rect] = calibrationMatrix(s1, s2, V, h)
    % Normalize the horizon vector
    %h = h ./ h(3);

    % Compute the image of the dual conic to principal points
    II = s1; 
    JJ = s2;
    imDCCP = II * JJ.' + JJ * II.';
    imDCCP = imDCCP ./ norm(imDCCP);

    % Singular Value Decomposition
    [U, S, ~] = svd(imDCCP);
    S(3, 3) = 1;

    % Rectifying homography matrix
    H_rect = inv(U * sqrt(S));
    H_rect = H_rect ./ norm(H_rect);
    H_inv_rect = inv(H_rect);

    % Extract components of the rectifying homography matrix
    h1 = H_inv_rect(:, 1);
    h2 = H_inv_rect(:, 2);

    % Define symbolic variables
    syms w1 w2 w3 w4;

    % Define the Image of circular point (IAC)
    w = [w1, 0, w2;
         0, 1, w3;
         w2, w3, w4];

    % Define the system of equations
    eqns = [h1' * w * h2 == 0;
            h1' * w * h1 - h2' * w * h2 == 0;
            V(1) * w1 + V(3) * w2 == h(1);
            V(1) * w2 + V(2) * w3 + V(3) * w4 == h(3)];
    
    %eqns = [h1' * w * h2 == 0;
    %        h1' * w * h1 - h2' * w * h2 == 0;
    %        V(1) * w1 + V(3) * w2 == h(1);
    %        V(2) + V(3) * w3 == h(2)];% V(1)*w2 + V(2)*w3+V(3)*w4 == h(3), V(1) * w1 + V(3) * w2 == h(1),  V(2) + V(3) * w3 == h(2)
    
    %eqns = [h1' * w * h2 == 0;
      %      h1' * w * h1 - h2' * w * h2 == 0;
      %      V(2) + V(3) * w3 == h(2);
      %      V(1)*w2 + V(2)*w3+V(3)*w4 == h(3)];% V(1)*w2 + V(2)*w3+V(3)*w4 == h(3), V(1) * w1 + V(3) * w2 == h(1),  V(2) + V(3) * w3 == h(2)

    % Solve the system of equations
    Sol = solve(eqns, [w1, w2, w3, w4]);

    % Extract parameters
    param = [double(Sol.w1(1)); double(Sol.w2(1)); double(Sol.w3(1)); double(Sol.w4(1))];

    % Construct the IAC w
    w = [param(1), 0, param(2); 0, 1, param(3); param(2), param(3), param(4)];

    % Compute the calibration matrix K
    K = inv(chol(w));
    K = K ./ K(3, 3);
    K
end

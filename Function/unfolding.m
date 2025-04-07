function unfolding(img, vp2_x, vp2_y, w, V)
   % New vanishing point P
    vp2 = [vp2_x, vp2_y, 1];
    vp2

    % Compute the line coefficients using the cross product
    retta_inter_vp1_vp2 = cross(V, vp2);
    retta_inter_vp1_vp2 = retta_inter_vp1_vp2 ./ retta_inter_vp1_vp2(3);

    % Define symbolic variables
    syms x y z;

    % Define the equations
    eq1 = w(1,1)*x^2 + w(2,2)*y^2 + w(3,3)*z^2 + (w(1,2) + w(2,1))*x*y + (w(1,3) + w(3,1))*x*z + (w(2,3) + w(3,2))*y*z == 0;
    eq2 = retta_inter_vp1_vp2(1)*x + retta_inter_vp1_vp2(2)*y + retta_inter_vp1_vp2(3)*z == 0;
    eq3 = x ~= 0;
    eq4 = y ~= 0;
    eq5 = z ~= 0;

    % Set up the system of equations
    eqns = [eq1, eq2, eq3, eq4, eq5];

    % Solve the system
    S = solve(eqns, [x, y, z]);
    I = [double(S.x(1)); double(S.y(1)); double(S.z(1))];
    J = [double(S.x(2)); double(S.y(2)); double(S.z(2))];

    % Compute the image of the dual conic to principal points
    imDCCP = I * J.' + J * I.';
    imDCCP = imDCCP ./ norm(imDCCP);
    [U, S, ~] = svd(imDCCP);
    S(3,3) = 1;

    % Rectifying homography matrix
    H_rect = inv(U * sqrt(S));
    H_rect = H_rect ./ norm(H_rect);

    % Apply rectifying homography to the image
    tform = projective2d(H_rect');
    imgRet = imwarp(imresize(img, 0.6), tform);
    figure;
    imshow(imgRet);

end

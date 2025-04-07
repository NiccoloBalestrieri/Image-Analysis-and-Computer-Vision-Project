% ------------------------------------------------------------------------
% Title: [Computer Vision and Image Analysis - Homework]
% Author: Niccolò Balestrieri
% Matricola: 218338
% University: Politecnico di Milano
% ------------------------------------------------------------------------
%%
% Add relevant paths to MATLAB's search path.
addpath('Function');
addpath('Image');
addpath('Utils');
%%
%Read the image into the workspace and display it.
I = imread('PalazzoTe.jpg');
imshow(I)

%%
%PREPROCESSING
[rotatedImg, adapt_histeq] = preProcessing(I);

%%
%HARRIS - CORNER DETECTION
harrisDetection(adapt_histeq);
%%
%EDGE DETECTION - BASELINE

figure;

% Sobel Edge Detection
subplot(2, 2, 1);
Sobel = edge(adapt_histeq, 'Sobel');
imshow(Sobel);
title("Sobel");

% Prewitt Edge Detection
subplot(2, 2, 2);
Prewitt = edge(adapt_histeq, 'Prewitt');
imshow(Prewitt);
title("Prewitt");

% Log Edge Detection
subplot(2, 2, 3);
Log = edge(adapt_histeq, 'log');
imshow(Log);
title("Log");

% Canny Edge Detection
subplot(2, 2, 4);
Canny = edge(adapt_histeq, 'Canny');
imshow(Canny);
title("Canny");

%%
%CANNY IMAGE
resultEdgeImage = tunedCanny(adapt_histeq);

%%
%MULTIPLE AUTO LINE DETECTION WITH HOUGH TRANSFORM
multipleLineDetection(resultEdgeImage, rotatedImg);

%%
%GENERATRIX LINE DETECTION WITH HOUGH TRANSFORM
generatrixLineDetection(resultEdgeImage, rotatedImg);

%%
%DRAW THE TWO GENERATRIX LINES
%drawGeneratrixLines(rotatedImg); % Comment out this line if manual drawing is required

%%
%DRAW THE TWO CROSS SECTION
%drawCrossSection(rotatedImg); % Comment out this line if manual drawing is required

%%
%LOAD THE TWO CROSS SECTION

ellipse1 = load('ellipse1.mat').ellipse1;
ellipse2 = load('ellipse2.mat').ellipse2;

%%
%HORIZON LINE
[eq1, eq2, C1, C2, h, s1, s2] = horizonLine(ellipse1, ellipse2, rotatedImg);

%%
%LOAD THE TWO GENERATRIX LINE
l1 = load('generatrix_1_auto.mat').l1;
l2 = load('generatrix_2_auto.mat').l2;

%%
%VANISHING POINT V
L = vanishingPoint(l1, l2, rotatedImg);

%%
%IMAGE PROJECTION OF CYLINDER AXIS a
[c1_center, c2_center] = cylinderAxis(C1, C2, rotatedImg, h);

%%
%LOAD VANISHING POINT V
V = load("vp1.mat").L;

%%
%CALIBRATION MATRIX K
[w, K, imDCCP, H_rect, H_inv_rect] = calibrationMatrix(s1, s2, V, h);

%%
%CAMERA REFERENCE - orientation of the cylinder axis wrt the camera reference.
cameraReference(K, H_rect, c1_center, c2_center);

%%
%c1_center = load("c1_center.mat").c1_center;
%c2_center = load("c2_center.mat").c2_center;
%SECOND VANISHING POINT
[vp2_x, vp2_y, inter_ellipse1, inter_ellipse2] = secondVanishingPoint(c1_center, c2_center, l1, l2, eq1, eq2, rotatedImg, V, ellipse1, ellipse2);

%%
%COMPUTE RATIO
[rectifiedImage, ratio1, ratio2] = ratio(vp2_x, vp2_y, w, rotatedImg, c1_center, c2_center, inter_ellipse1, inter_ellipse2, V);

%%
img = imread('ritSurface.png');
unfolding(img, vp2_x, vp2_y, w, V);
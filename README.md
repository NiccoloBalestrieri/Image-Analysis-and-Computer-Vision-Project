# 🏛️ Image Analysis and Computer Vision Project

Welcome to this **Computer Vision and Image Analysis** repository! This project focuses on extracting geometric and metric information from an image depicting a cylindrical vault in Palazzo Te (Mantua), Italy. We use a variety of techniques, from feature extraction (edges, corners, lines, ellipses) to calibration (horizon line, vanishing points, camera matrix), concluding with a partial unrolling (unfolding) of the cylindrical surface.

---

## 📖 Table of Contents
1. [Repository Structure](#repository-structure)  
2. [Requirements](#requirements)  
3. [Setup and Usage](#setup-and-usage)  
4. [Pipeline Overview](#pipeline-overview)  
5. [Key Features](#key-features)  
6. [Computed Results](#computed-results)  
7. [References](#references)  
8. [Author](#author)

---

## 📂 Repository Structure

- **Main.m**  
  This is the main MATLAB script that orchestrates the entire pipeline. Its steps include:
  1. 📷 **Image Preprocessing** (rotation, conversion to grayscale, histogram equalization, etc.)  
  2. 🔎 **Feature Extraction** (corner detection, edge detection, Hough Transform for lines)  
  3. 🌀 **Ellipse Detection** for the cylinder’s circular cross-sections (manual or semi-automatic)  
  4. 🌅 **Horizon Line Computation**  
  5. 📐 **Vanishing Points** and cylinder axis detection in the image  
  6. 🎛️ **Camera Calibration** (estimation of intrinsic matrix **K**)  
  7. 🎯 **Camera Localization** relative to the cylinder axis  
  8. 📏 **Radius-Distance Ratio** calculation for the circular cross-sections  
  9. 🗺️ **Surface Unfolding** attempt for the portion of the cylinder between two cross-sections

- **Homework_IACV.pdf**  
  A PDF with the complete assignment instructions and theoretical background.

- **ComputedResult.txt**  
  A text file with key outcomes, such as the horizon line, vanishing points, and the calibration matrix **K**.

- **Function/**, **Utils/**, **Image/** folders (and similar)  
  These contain helper functions and utilities for:
  - Image preprocessing  
  - Edge detection (Canny, Sobel, etc.)  
  - Hough transform line detection  
  - Ellipse fitting or manual drawing  
  - Computing horizon lines, vanishing points, camera calibration, etc.  

---

## 💻 Requirements
- **MATLAB** (recommended version R2021a or later)  
- **Image Processing Toolbox**  
- Input images (e.g., `PalazzoTe.jpg`) and `.mat` files (e.g., saved ellipse parameters) if loading pre-drawn data

---

## 🚀 Setup and Usage

**Open and run `Main.m` in MATLAB.**

As the script runs, you’ll see figures pop up, showing:
- Edge detection results  
- Detected lines (generatrices)  
- Manually or automatically identified ellipses (cross-sections)  
- Computed horizon line, vanishing points, camera matrix, etc.

Results may also be printed to the MATLAB Command Window or saved to `.mat`/`.txt` files.

**Note**: If you want to draw the ellipses manually, uncomment the relevant lines in `Main.m` (e.g., `drawCrossSection(rotatedImg);`) and comment out the parts that load `.mat` data.

---

## 🔗 Pipeline Overview

### Preprocessing
- Rotate image (if needed)
- Convert to grayscale
- Histogram equalization or adaptive equalization for contrast enhancement

### Feature Extraction
- Edge Detection: (Sobel, Prewitt, LoG, Canny)
- Harris Corner Detection (optional)
- Hough Transform to detect multiple lines (especially the cylinder generatrices)
- Ellipse Detection: Manual or automated approaches for the two circular cross-sections (C1, C2)

### Horizon Line
Compute the vanishing line of the plane orthogonal to the cylinder axis using conic geometry (ellipses → circular points)

### Vanishing Points
- Use parallel lines (generatrices) to find vanishing point **V**
- Possibly compute a second vanishing point **P** for orthogonal directions

### Camera Calibration (K)
Exploit the Image of the Absolute Conic (IAC) to estimate the intrinsic parameters (focal lengths, principal point)

### Camera Localization
- Determine rotation and translation from the planar homography plus the calibration matrix **K**
- Understand the camera’s orientation relative to the cylinder axis

### Metric Computations
- Rectify regions of interest to measure circle radii accurately
- Compute the ratio of cross-section radii and the distance between them

### Surface Unfolding
Attempt a partial unrolling of the cylindrical surface between the two cross sections

---

## 🌟 Key Features
- Automatic detection of the cylinder generatrices via Hough Transform
- Manual or semi-automatic ellipse drawing for the cross-sections
- Horizon line & vanishing points calculation from parallel or orthogonal lines
- Camera calibration (**K**) from the Image of the Absolute Conic
- Perspective rectification for metric analysis
- Unfolding (Unrolling) experiment for cylindrical surfaces

---

## 📊 Computed Results
A summary is provided in **ComputedResult.txt**.

---

## 📚 References
- Image Analysis and Computer Vision course handouts and slides.
- **Homework_IACV.pdf** for the full assignment.
- S. J. Maybank, *Theory of Reconstruction from Image Motion*, Springer.
- R. Hartley and A. Zisserman, *Multiple View Geometry in Computer Vision* (2nd edition).

---

## 👤 Author
**Niccolò Balestrieri**  
Politecnico di Milano – Academic Year 2023/2024  

> **Note**: Numerical results may differ slightly based on manual ellipse placement or edge-detection thresholds. If something doesn’t work, make sure your MATLAB paths are correct and all the necessary `.m` and `.mat` files are present.


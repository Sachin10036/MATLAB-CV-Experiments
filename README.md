# MATLAB Basic Computer Vision Projects

This repository contains four basic computer vision projects implemented using MATLAB. Each project demonstrates fundamental techniques and algorithms in image processing and computer vision. The projects included are:

1. [Lane Detection](#lane-detection)
2. [Edge Detection](#edge-detection)
3. [Object Detection](#object-detection)
4. [Depth Estimation](#depth-estimation)

## Lane Detection

**Description:**
This project involves detecting lane lines on a road from an image using Hough Transform and morphological operations. The goal is to identify and highlight the lane boundaries.

**Input:**
- `highway.jpg`

**Output:**
- Annotated image with detected lane lines.


## Edge Detection

**Description:**
This project performs edge detection on an image using the Canny edge detection algorithm. It highlights the edges in the image, which are important features for many computer vision applications.

**Input:**
- `Coins.jpg`

**Output:**
- Edge-detected image.



## Object Detection

**Description:**
This project uses background subtraction and contour detection to identify moving objects in a video. It draws bounding boxes around detected objects and outputs the processed video.

**Input:**
- Video file: `pexels_videos_2099536.mp4`

**Output:**
- Processed video with detected objects.



## Depth Estimation

**Description:**
This project estimates the depth of objects in a scene from stereo images. It calculates the disparity map and converts it into a depth map, providing a measure of distance from the camera.

**Input:**
- Left image: `sceneLeft.jpg`
- Right image: `sceneRight.jpg`

**Output:**
- Depth map image.


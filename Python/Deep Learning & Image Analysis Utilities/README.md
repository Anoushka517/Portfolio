# 🧠 Deep Learning & Image Analysis Utilities with Keras and NumPy

This project demonstrates a practical application of Python, NumPy, and TensorFlow/Keras for **image analysis** and **neural network construction**. It includes utility functions for image processing, dynamic deep neural network creation, and hyperparameter optimization for image classification using the MNIST dataset.

---

## 🚀 Key Features

### 🖼️ 1. Pixel Intensity Analysis
- `light_pixels(image, threshold, channel)`  
  → Creates a binary mask of pixels above a lightness threshold in a specific color channel (red, green, or blue).

- `histogram(image, buckets, channel)`  
  → Generates histograms of pixel intensity values across defined ranges for a specific color channel.

### 🧠 2. Dynamic Deep Neural Network Builder
- `build_deep_nn(rows, columns, channels, layer_options)`  
  → Dynamically builds a deep Keras `Sequential` model using a customizable list of hidden layers, activations, and dropout rates. Allows for flexible model architecture experimentation.

### 🧪 3. Hyperparameter Tuning with Keras Tuner
- Uses `BayesianOptimization` to search for optimal:
  - Number of hidden layers (1–3)
  - Hidden layer size (32–256)
  - Dropout rate (0.0–0.5)

- Final model is compiled, trained, and evaluated on the MNIST dataset to identify the best configuration for digit classification.

---

## 📦 Technologies Used

- **Python 3**
- **NumPy** – for array and image manipulation
- **TensorFlow & Keras** – for neural network modeling
- **Keras Tuner** – for automated hyperparameter search
- **Doctest** – for validating utility functions via inline examples

---

# EE5176 - Image Processing and Computer Vision

[![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2020a+-orange.svg)](https://www.mathworks.com/products/matlab.html)
[![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-orange.svg)](https://jupyter.org/)

This repository contains course materials for **EE5176 - Image Processing and Computer Vision**, including tutorials, assignments, and practical exercises covering fundamental concepts in digital image processing, computer vision, and related mathematical foundations.

## 📚 Course Overview

This course provides a comprehensive introduction to image processing and computer vision techniques. Students will learn essential concepts through hands-on programming exercises using Python and MATLAB, covering topics from basic image manipulation to advanced processing algorithms.

### Learning Objectives
- Master fundamental image processing concepts and techniques
- Develop proficiency in Python programming for scientific computing
- Understand NumPy for efficient array operations and mathematical computations
- Implement image processing algorithms using OpenCV and related libraries
- Apply mathematical concepts to solve real-world image processing problems
- Gain experience with MATLAB for advanced image processing tasks

## 🗂️ Repository Structure

```
EE5176/
├── tutorials/                          # Interactive learning materials
│   ├── Python_Basics.ipynb            # Python fundamentals for beginners
│   ├── NumPy_tutorial.ipynb            # NumPy arrays and operations
│   ├── Basics_of_Image_Processing_*.ipynb  # Image processing fundamentals
│   ├── requirement.txt                 # Python dependencies
│   └── *.png, *.jpg, *.jpeg           # Sample images for exercises (37 files)
├── Assignments/                        # Course assignments
│   └── Assignment1/                    # Image demosaicing and filtering
│       ├── demosicing.m               # MATLAB demosaicing implementation
│       ├── Copy of bfilter2.m         # Bilateral filtering algorithm
│       ├── *.mat                      # MATLAB data files (9 files)
│       ├── *.png                      # Sample images and results
│       └── EE5176_Assignment1_2025.pdf # Assignment instructions
└── README.md                          # This file
```

## 🚀 Getting Started

### Prerequisites
- **Python 3.8+** with Jupyter Notebook support
- **MATLAB R2020a+** (for assignments)
- Basic understanding of mathematics (linear algebra, calculus)
- Familiarity with programming concepts (helpful but not required)

### Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/RitabrataMandal/EE5176.git
   cd EE5176
   ```

2. **Set up Python environment:**
   ```bash
   # Create virtual environment (recommended)
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   
   # Install required packages
   pip install -r tutorials/requirement.txt
   ```

3. **Launch Jupyter Notebook:**
   ```bash
   jupyter notebook
   ```

### Key Dependencies
The course utilizes the following Python libraries:
- **NumPy (2.2.6)**: Numerical computing and array operations
- **OpenCV (4.12.0.88)**: Computer vision and image processing
- **Matplotlib (3.10.5)**: Plotting and visualization
- **SciPy (1.16.1)**: Scientific computing algorithms
- **Pillow (11.3.0)**: Image manipulation
- **IPython & Jupyter**: Interactive computing environment

## 📖 Tutorial Contents

### 1. Python Basics (`Python_Basics.ipynb`)
**Duration:** ~2-3 hours  
**Topics Covered:**
- **Data Structures**: Lists, strings, tuples, sets, dictionaries
- **Functions**: Definition, parameters, return values, scope
- **Lambda Functions**: Anonymous functions and functional programming
- **Control Flow**: Conditionals, loops, list comprehensions
- **File I/O**: Reading and writing files
- **Error Handling**: Try-except blocks and debugging

**Learning Outcomes:** Students will gain solid foundation in Python programming essential for scientific computing.

### 2. NumPy Tutorial (`NumPy_tutorial.ipynb`)
**Duration:** ~2-3 hours  
**Topics Covered:**
- **Array Creation**: Different methods to create arrays (zeros, ones, random, etc.)
- **Array Operations**: Element-wise operations, broadcasting, mathematical functions
- **Array Manipulation**: Reshaping, indexing, slicing, and advanced indexing
- **Statistical Operations**: Sum, mean, max, min, standard deviation
- **Linear Algebra**: Matrix operations, dot products, eigenvalues

**Learning Outcomes:** Students will master NumPy for efficient numerical computations required in image processing.

### 3. Image Processing Fundamentals
**Multiple notebooks covering:**
- **Basic Image Operations**: Loading, displaying, and saving images
- **Image Properties**: Dimensions, color channels, data types
- **Pixel Manipulations**: Accessing and modifying pixel values
- **Color Spaces**: RGB, grayscale, and other color representations
- **Basic Filtering**: Convolution, edge detection, and noise reduction
- **Frequency Domain**: Fourier transforms and spectral analysis

## 📝 Assignments

### Assignment 1: Advanced Image Processing
**File:** `Assignments/Assignment1/`

**Techniques Implemented:**

1. **Image Demosaicing (`demosicing.m`)**
   - Reconstructs full-color RGB images from Bayer pattern sensor data
   - Uses cubic interpolation for missing color channel values
   - Handles raw camera sensor data conversion
   - **Input**: Raw Bayer pattern data (.mat files)
   - **Output**: Full RGB images with separate channel visualization

2. **Bilateral Filtering (`Copy of bfilter2.m`)**
   - Advanced noise reduction preserving edges
   - Implements both grayscale and color image filtering
   - Uses spatial and intensity-based Gaussian weights
   - **Features**: Progress bar, CIELab color space conversion, edge preservation

**Skills Developed:**
- Understanding of digital camera sensor technology
- Advanced filtering techniques for noise reduction
- MATLAB programming for image processing
- Color space conversions and manipulations

## 🎯 How to Use This Repository

### For Students:
1. **Start with Python Basics**: Complete `Python_Basics.ipynb` if new to Python
2. **Master NumPy**: Work through `NumPy_tutorial.ipynb` for array operations
3. **Image Processing**: Progress through image processing notebooks
4. **Practice**: Use provided sample images for experimentation
5. **Assignments**: Complete assignments to apply learned concepts

### For Instructors:
- Notebooks include exercises with clear marking (`# YOUR CODE STARTS HERE`)
- Sample solutions and expected outputs provided
- Progression from basic to advanced concepts
- Mix of theoretical concepts and practical implementation

### Running the Code:
```bash
# For Python tutorials
jupyter notebook tutorials/

# For MATLAB assignments (in MATLAB environment)
cd Assignments/Assignment1/
run demosicing.m
```

## 🔧 Troubleshooting

### Common Issues:
1. **Missing Dependencies**: Ensure all packages in `requirement.txt` are installed
2. **MATLAB Path Issues**: Add assignment folder to MATLAB path
3. **Image Loading Problems**: Verify image file paths and formats
4. **Memory Issues**: Large images may require system with adequate RAM

### Getting Help:
- Check notebook markdown cells for detailed explanations
- Refer to official documentation for libraries (NumPy, OpenCV, etc.)
- Review sample outputs and expected results

## 🤝 Contributing

This repository is primarily for educational purposes. If you find errors or have suggestions for improvements:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request with clear description

## 📄 License

This educational material is provided for academic use. Please respect intellectual property and cite appropriately when using materials for research or publication.

## 📞 Contact

For questions about course content or technical issues, please refer to your course instructor or teaching assistants.

---

**Happy Learning! 🎓**

*Last Updated: January 2025*

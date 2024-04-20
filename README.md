# Epitech Project, second Year -> Image Compressor

## Description
**Image Compressor** is a Haskell application designed for compressing images using the k-means clustering algorithm. The process involves reducing the number of colors in an image, which consists of three main steps: reading the image and extracting pixel colors, clustering these colors using k-means, and creating a compressed image by indexing the mean colors of the clusters.

## Functionality
The application focuses on the clustering aspect of image compression, specifically implementing the k-means algorithm. It reads a file containing the list of pixels with their positions and colors, groups them into a specified number of clusters based on their colors, and outputs the clustered colors.

## Usage
To utilize **Image Compressor**, follow the usage syntax:

./imageCompressor -n N -l L -f F

- `N`: Number of colors in the final image
- `L`: Convergence limit
- `F`: Path to the file containing the colors of the pixels

## Input Format
The input file should adhere to the following grammar:

IN ::= POINT ' ' COLOR ('\n' POINT ' ' COLOR ) *
POINT ::= '(' int ',' int ')'
COLOR ::= '(' SHORT ',' SHORT ',' SHORT ')'
SHORT ::= '0 '.. '255 '

## Output Format
The output consists of the list of clustered colors printed on the standard output, following this grammar:

OUT ::= CLUSTER *
CLUSTER ::= '- -\n' COLOR '\n -\ n' ( POINT ' ' COLOR '\n ') *
POINT ::= '(' int ',' int ')'
COLOR ::= '(' SHORT ',' SHORT ',' SHORT ')'
SHORT ::= '0 '.. '255 '
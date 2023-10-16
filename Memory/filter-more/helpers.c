#include "helpers.h"
#include <math.h>
#include <string.h>

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    // loop through the pixels
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            // find the average of the rgb values for each pixel
            int sum = (image[i][j].rgbtBlue + image[i][j].rgbtGreen + image[i][j].rgbtRed);
            int avg = round((double) sum / 3);
            // assign the average to the values of rgb (bg&r)
            image[i][j].rgbtBlue = avg;
            image[i][j].rgbtGreen = avg;
            image[i][j].rgbtRed = avg;
        }
    }
    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width / 2; j++)        // the algorithm below 'swaps' pixels symmetrically of a central vertical axis
        {                                          //  so we only want to do this once, hence `j < width / 2;`
            RGBTRIPLE temp = image[i][j];          // temporarily assign the pixel of the loop to temp
            image[i][j] = image[i][width - j - 1]; // move pixels on the right to the left relative to a vertical axis
            image[i][width - j - 1] = temp;        // move pixels on the left to the right utilizing the pixels assigned to temp
        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    // create a copy of the image array to modify
    RGBTRIPLE copy[height][width];
    memcpy(copy, image, sizeof(RGBTRIPLE) * height * width);
    // loop through the pixels of the copy of the image array
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            int count = 0;
            int blue = 0;
            int green = 0;
            int red = 0;
            // loop through the adjacent pixels
            for (int k = -1; k <= 1; k++)
            {
                for (int l = -1; l <= 1; l++)
                {
                    // ensure that the adjacent pixels are actually there
                    if (i + k >= 0 && i + k < height && j + l >= 0 && j + l < width)
                    {
                        // gather bgr values of adjacent and target pixels
                        blue += copy[i + k][j + l].rgbtBlue;
                        green += copy[i + k][j + l].rgbtGreen;
                        red += copy[i + k][j + l].rgbtRed;
                        count++;
                    }
                }
            }
            // calcute the average bgr values and assign them to the original image
            image[i][j].rgbtBlue = round((float) blue / count);
            image[i][j].rgbtGreen = round((float) green / count);
            image[i][j].rgbtRed = round((float) red / count);
        }
    }
    return;
}

// Detect edges
void edges(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE copy[height][width];
    memcpy(copy, image, sizeof(RGBTRIPLE) * height * width);
    // horizontal and vertical Sobel kernels
    int kernel_x[3][3] = {{-1, 0, 1}, {-2, 0, 2}, {-1, 0, 1}};
    int kernel_y[3][3] = {{-1, -2, -1}, {0, 0, 0}, {1, 2, 1}};
    // loop through the copy of the image array
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            int gx_blue = 0, gx_green = 0, gx_red = 0;
            int gy_blue = 0, gy_green = 0, gy_red = 0;
            // loop through adjacent pixels
            for (int k = -1; k <= 1; k++)
            {
                for (int l = -1; l <= 1; l++)
                {
                    // ensure that adjacent pixels are actually there
                    if (i + k >= 0 && i + k < height && j + l >= 0 && j + l < width)
                    {
                        // calculate the weighted sums
                        gx_blue += kernel_x[k + 1][l + 1] * copy[i + k][j + l].rgbtBlue;
                        gx_green += kernel_x[k + 1][l + 1] * copy[i + k][j + l].rgbtGreen;
                        gx_red += kernel_x[k + 1][l + 1] * copy[i + k][j + l].rgbtRed;

                        gy_blue += kernel_y[k + 1][l + 1] * copy[i + k][j + l].rgbtBlue;
                        gy_green += kernel_y[k + 1][l + 1] * copy[i + k][j + l].rgbtGreen;
                        gy_red += kernel_y[k + 1][l + 1] * copy[i + k][j + l].rgbtRed;
                    }
                }
                // calculate the magnitude of the gradient - an integer between 0 - 255
                int blue = round(sqrt(gx_blue * gx_blue + gy_blue * gy_blue));
                int green = round(sqrt(gx_green * gx_green + gy_green * gy_green));
                int red = round(sqrt(gx_red * gx_red + gy_red * gy_red));
                image[i][j].rgbtBlue = blue > 255 ? 255 : blue;
                image[i][j].rgbtGreen = green > 255 ? 255 : green;
                image[i][j].rgbtRed = red > 255 ? 255 : red;
            }
        }
    }
    return;
}

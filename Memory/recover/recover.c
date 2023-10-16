#include <cs50.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BLOCK_SIZE 512

void read_write_file(FILE *raw_file);
int find_jpeg_start(char *buffer);

int main(int argc, char *argv[])
{
    // check if the right number of arguments are provided
    if (argc != 2)
    {
        printf("Usage: ./recover IMAGE\n");
        return 1;
    }
    // programatically open the file
    FILE *raw_file = fopen(argv[1], "r");
    if (raw_file != NULL)
    {
        read_write_file(raw_file);
    }
    else
    {
        printf("file could not be opened!\n");
        return 2;
    }
    // close the raw file
    fclose(raw_file);
    printf("raw file closed\n");
    return 0;
}

void read_write_file(FILE *raw_file)
{
    char buffer[BLOCK_SIZE];
    int bytes_read = 0;
    int bytes_written = 0;
    int file_num = 0;
    FILE *img = NULL;
    while ((bytes_read = fread(buffer, 1, BLOCK_SIZE, raw_file)) > 0)
    {
        // check if start of a jpeg is found
        int start_index = find_jpeg_start(buffer);
        if (start_index != -1)
        {
            if (img != NULL)
            {
                // close the current file if it's open
                fclose(img);
                printf("%i bytes written to %03i.jpg\n", bytes_written, file_num);
                bytes_written = 0;
                file_num++;
            }
            // open a new file
            char filename[8];
            sprintf(filename, "%03i.jpg", file_num);
            img = fopen(filename, "w");
        }
        if (img != NULL)
        {
            // write the block to the file and return bytes_written
            bytes_written += fwrite(buffer, 1, bytes_read, img);
        }
    }
    if (img != NULL)
    {
        // close the last file
        fclose(img);
        printf("%i bytes written to %03i.jpg\n", bytes_written, file_num);
        printf("%i files recovered\n", file_num + 1);
    }
}

int find_jpeg_start(char *buffer)
{
    // beginning JPEG signature == {0xff, 0xd8, 0xff, 0xe*,}
    unsigned char signature[4] = {0xff, 0xd8, 0xff, 0xe0};
    if (memcmp(buffer, signature, 4) == 0)
    {
        // beginning of JPEG found
        return 0;
    }
    return -1;
}

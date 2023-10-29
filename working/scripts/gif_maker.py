import imageio
import os

image_folder = 'path/to/images'
fps = 10
file_name = 'my_gif.gif'

images = []
for filename in sorted(os.listdir(image_folder)):
    if filename.endswith('.png'):
        file_path = os.path.join(image_folder, filename)
        images.append(imageio.imread(file_path))

imageio.mimsave(file_name, images, fps=fps)


# from moviepy.editor import ImageSequenceClip

# image_folder = 'path/to/images'
# fps = 10
# file_name = 'my_gif.gif'

# images = []
# for filename in sorted(os.listdir(image_folder)):
#     if filename.endswith('.png'):
#         file_path = os.path.join(image_folder, filename)
#         images.append(file_path)

# clip = ImageSequenceClip(images, fps=fps)
# clip.write_gif(file_name)

# # Using OpenCV
# import cv2
# import os

# image_folder = 'path/to/images'
# fps = 10
# file_name = 'my_gif.gif'

# images = []
# for filename in sorted(os.listdir(image_folder)):
#     if filename.endswith('.png'):
#         file_path = os.path.join(image_folder, filename)
#         image = cv2.imread(file_path)
#         images.append(image)

# height, width, _ = images[0].shape
# size = (width, height)

# out = cv2.VideoWriter(file_name, cv2.VideoWriter_fourcc(*'mp4v'), fps, size)

# for image in images:
#     out.write(image)

# out.release()


# # to convert mp4 to gif
# #     ffmpeg -i my_gif.mp4 my_gif.gif
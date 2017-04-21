from PIL import Image, ImageEnhance, ImageOps

image = Image.open('cameraman.tif')
size = 256, 256
img = ImageOps.fit(image, size, Image.ANTIALIAS)
contrast = ImageEnhance.Contrast(img)
value = 0.0
while value <= 2:
    value += 0.2
    contrast.enhance(value).show()
    input()

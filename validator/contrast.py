from PIL import Image, ImageEnhance, ImageOps
image = Image.open('flower.jpg')
size = 256, 256
img = ImageOps.fit(image, size, Image.ANTIALIAS)
contrast = ImageEnhance.Contrast(img)
value = 0.0
cnt = 1
while value <= 2:
    value += 0.2
    tmp_img = contrast.enhance(value)
    tmp_img.show()
    tmp_img.save(str(cnt) + ".png")
    cnt += 1

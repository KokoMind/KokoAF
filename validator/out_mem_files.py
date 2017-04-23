import numpy as np
from scipy import misc

# position = int(input("inter el index ya mo7trm\n"))
position = 310
row = int(position / 256)
column = position - row * 256

print(row, column)

file_num = open("../mems/numbers.txt", 'w')

for cnt in range(1, 12):
    image = misc.imread(str(cnt) + ".png", flatten=True)
    image = image.astype('uint8')
    img = image
    image_flattened = img.ravel()
    #### NVM mem FILE
    with open("../mems/test_nvm_" + str(cnt) + ".mem", 'w') as f:
        f.write("""// memory data file (do not edit the following line - required for mem load use)
    // instance=/nvm1/ram
    // format=mti addressradix=d dataradix=b version=1.0 wordsperline=1\n""")
        for i in range(65536):
            ss = ""
            if i<65520:
                for k in range(16):
                    ss = bin(image_flattened[i+k])[2:].zfill(8) + ss
            f.write(str(i) + ": ")
            f.write(ss)
            f.write('\n')

    block = image[row:row + 16, column:column + 16]

    block_f = open("../mems/block_" + str(cnt) + ".txt", 'w')
    for i in range(16):
        for j in range(16):
            block_f.write(str(block[i, j]))
            block_f.write('\n')
    block_f.close()

    padded = np.lib.pad(block, ((1, 1), (1, 1)), 'constant', constant_values=((0, 0), (0, 0)))

    padded_f =  open("../mems/padded_" + str(cnt) + ".txt", 'w')
    for i in range(18):
        for j in range(18):
            padded_f.write(str(padded[i, j]))
            padded_f.write('\n')
    padded_f.close()

    total = 0

    for i in range(1, 17):
        for j in range(1, 17):
            total += abs(int(padded[i, j]) - int(padded[i - 1, j]))
            total += abs(int(padded[i, j]) - int(padded[i + 1, j]))
            total += abs(int(padded[i, j]) - int(padded[i, j - 1]))
            total += abs(int(padded[i, j]) - int(padded[i, j + 1]))

    file_num.write("../mems/total"+str(cnt)+"= "+ str(total)+"\n")

file_num.close()

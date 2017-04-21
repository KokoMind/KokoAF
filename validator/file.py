with open("test_cache.mem", 'w') as f:
    f.write("""// memory data file (do not edit the following line - required for mem load use)
// instance=/dma/ram/ram
// format=mti addressradix=d dataradix=d version=1.0 wordsperline=1\n""")
    for i in range(65536):
        f.write(str(i) + ":  0")
        f.write('\n')
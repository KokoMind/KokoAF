vsim work.dma
add wave sim:/dma/*
mem load -i /home/moemen/CMP/KokoAF/test_nvm.mem /dma/ram/ram
mem load -i /home/moemen/CMP/KokoAF/test_cache.mem /dma/cache/ram
force -freeze sim:/dma/in_addr 0000000100110110 0
force -freeze sim:/dma/enable 0 0
force -freeze sim:/dma/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/dma/clk_mem 1 0, 0 {50 ps} -r 100
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
force -freeze sim:/dma/enable 1 0
run 25600ps
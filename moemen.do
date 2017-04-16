vsim work.system
add wave sim:/system/*
mem load -i /home/moemen/CMP/KokoAF/test_nvm.mem system/dma1/ram/ram
mem load -i /home/moemen/CMP/KokoAF/test_cache.mem system/dma1/cache/ram
force -freeze sim:/system/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/system/rst 1 0
force -freeze sim:/system/start 0 0
force -freeze sim:/system/move_done 0 0
force -freeze sim:/system/address_focus_matrix 0000000100110110 0
run
force -freeze sim:/system/rst 0 0
run
force -freeze sim:/system/start 1 0
run

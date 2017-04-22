vsim work.system
add wave sim:/system/*
mem load -i /home/moemen/CMP/KokoAF/mems/test_nvm_2.mem system/nvm1/ram
mem load -i /home/moemen/CMP/KokoAF/mems/test_cache.mem system/cache1/ram
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
run 259000ps
force -freeze sim:/system/move_done 1 0
run
run
force -freeze sim:/system/move_done 0 0
mem load -i /home/moemen/CMP/KokoAF/mems/test_nvm_1.mem system/nvm1/ram
mem load -i /home/moemen/CMP/KokoAF/mems/test_cache.mem system/cache1/ram
run
run
run
run 259000ps
force -freeze sim:/system/move_done 1 0
run
run
force -freeze sim:/system/move_done 0 0
mem load -i /home/moemen/CMP/KokoAF/mems/test_nvm_2.mem system/nvm1/ram
mem load -i /home/moemen/CMP/KokoAF/mems/test_cache.mem system/cache1/ram
run
run
run
run 259000ps
force -freeze sim:/system/move_done 1 0
run
run
force -freeze sim:/system/move_done 0 0
mem load -i /home/moemen/CMP/KokoAF/mems/test_nvm_3.mem system/nvm1/ram
mem load -i /home/moemen/CMP/KokoAF/mems/test_cache.mem system/cache1/ram
run
run
run
run 259000ps
force -freeze sim:/system/move_done 1 0
run
run
force -freeze sim:/system/move_done 0 0
mem load -i /home/moemen/CMP/KokoAF/mems/test_nvm_4.mem system/nvm1/ram
mem load -i /home/moemen/CMP/KokoAF/mems/test_cache.mem system/cache1/ram
run
run
run
run 259000ps
force -freeze sim:/system/move_done 1 0
run
run
force -freeze sim:/system/move_done 0 0
mem load -i /home/moemen/CMP/KokoAF/mems/test_nvm_5.mem system/nvm1/ram
mem load -i /home/moemen/CMP/KokoAF/mems/test_cache.mem system/cache1/ram
run
run
run
run 259000ps
force -freeze sim:/system/move_done 1 0
run
run
force -freeze sim:/system/move_done 0 0
mem load -i /home/moemen/CMP/KokoAF/mems/test_nvm_6.mem system/nvm1/ram
mem load -i /home/moemen/CMP/KokoAF/mems/test_cache.mem system/cache1/ram
run
run
run
run 259000ps



# This is a 32x32 bit pipelined multiplier in verilog
This multiplier has 5 main stages (since log 32 base 2 is 5) Why so?
Because, at each stage, parallel addition happen in pairs and stored into registers in between stages. So after each stage,pairs to add gets halved.

## This multiplier is able to do multiplication which gives result upto 4.29 billion!
but this costs lot of hardware ( > 300,000 transistors easily) :) 

## Here is the synthesised hardware design (design where simple N_bit_add module used)
![schematic](https://raw.githubusercontent.com/uma899/32_bit_pipelined_mul/refs/heads/main/schematic.jpg)


### Future aim: 
* Make this multiplier parametrised

Note that CLA_adder is modified (that is, carry bit not used) such a way that it fits here in this use case. In this current version, N_bit_adder module was replaced with CLA. This may not work in ModelSim as the number of initiations of modules are huge.
Older commit can be seen at [with simple adder](https://github.com/uma899/32_bit_pipelined_mul/commit/28d3134ebd90daa980d8d6c15a1b724964c302c8#diff-cb23eab430db53bf7724d8bb84ea0d08945b3ec7f8e78012f119539d026ccd97)

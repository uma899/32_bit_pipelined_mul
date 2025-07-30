# This is a 32*32 bit pipelined multiplier in verilog
This multiplier has 5 main stages (since log 32 base 2 is 5) Why so?
Because, at each stage, parallel addition happen in pairs and stored into registers in between stages. So after each stage,pairs to add gets halved.

## This multiplier is able to do multiplication which gives result upto 4.29 billion!
but this costs lot of hardware ( > 100,000 easily) :) 

## Here is the synthesised hardware design
![Alt text](https://example.com/path/to/image.png)

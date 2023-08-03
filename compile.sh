#!/bin/bash
project_name=CH559USB
xram_size=0x0800
xram_loc=0x0600
code_size=0xEFFF
dfreq_sys=48000000
SDCC_DIR=../vendor/sdcc-4.3.0/bin
H2B_DIR=../vendor/Hex2bin-2.5
ARGS="-V -mmcs51 --model-large --xram-size $xram_size --xram-loc $xram_loc"
ARGS="$ARGS --code-size $code_size -I/ -DFREQ_SYS=$dfreq_sys"

mkdir -p build
pushd build
$SDCC_DIR/sdcc -c $ARGS ../main.c
$SDCC_DIR/sdcc -c $ARGS ../util.c
$SDCC_DIR/sdcc -c $ARGS ../USBHost.c
$SDCC_DIR/sdcc -c $ARGS ../uart.c
$SDCC_DIR/sdcc main.rel util.rel USBHost.rel uart.rel -V $ARGS -o $project_name.ihx
$SDCC_DIR/packihx $project_name.ihx > $project_name.hex
$H2B_DIR/hex2bin -c $project_name.hex
popd

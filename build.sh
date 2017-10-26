#!/bin/sh
cd "${0%/*}"

# get bennu binaries directory parameter, or set default
BGD_RUNTIME=${1:-"bennugd-binaries/linux"}

# add bennugd to system path
export PATH=$BGD_RUNTIME/bin:$PATH
export LD_LIBRARY_PATH=$BGD_RUNTIME/lib:$LD_LIBRARY_PATH

# concatenate every prg file into one new prg
cat prg/globals.prg prg/functions.prg prg/main.prg > fpgtools.prg
bgdc fpgtools.prg

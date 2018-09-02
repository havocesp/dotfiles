#!/usr/bin/env bash

# -l arg let bc to be more precise
# alias bc='bce'
alias numextract="grep -Eo '[^-]{2,}' | sed 's/[ ]\{2,\}/ /g' | grep -Eo '[^a-dA-DF-Zf-z;:*^¿?\`%/]*' | xargs |sed 's/[Ee][ ]//g'"
alias grep-numbers="grep -oE '[+-]?([0-9]*\.|[0-9]+\.?)[0-9]*([eE][-][0-9]+)?'"

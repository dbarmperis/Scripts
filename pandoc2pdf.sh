#!/usr/bin/env bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PANDOC="pandoc -s -N \
    -F pandoc-imagine \
    -F $SCRIPT_DIR/pandoc/dilawar.py \
    -F pandoc-crossref -F pandoc-citeproc "

# This script uses pandoc to convert markdown to pdf. 
if [ $# -lt 1 ]; then
    echo "USAGE: ./$0 filename.pandoc [optional]"
    exit
fi

filename=$1; shift
outputFile="${filename%.pandoc}.pdf"
outTex="${filename%.pandoc}.tex" 
$PANDOC $filename "$@" -o $outTex 
latexmk -pdf -lualatex -shell-escape -silent $outTex || lualatex --shell-escape $outTex

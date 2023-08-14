#!/usr/bin/env bash
# arguments:
# input directory of directories of pdfs (plots) --orig
# output directory to put converted imgs (png) --conv
function swapdir {
  input=$1
  outdir=$2
  id=$(basename $(dirname $input))
  fn=$(basename $input)
  fileout=$(echo $fn | sed -e "s/.pdf/.png/g")
  echo "$outdir/$id/$fileout"
}

function pdf2png {
  input=$1
  outdir=$2

  output=$(swapdir $input $outdir)
  mkdir -p $(dirname $output)
  # echo "$output"
  magick \
    -density 300 \
    $input \
    -quality 100 \
    -flatten \
    -sharpen 0x1.0 \
    $output
}
export -f pdf2png swapdir
# parallel pdf2png {} $2 ::: $1/**/*.pdf
ls $1/**/*.pdf | parallel --bar -j pdf2png {} $2

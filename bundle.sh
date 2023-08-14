#!/usr/bin/env bash
# arguments: 
# srcdir is directory of directories of pngs (png)
# destdir is where zips get written (release)
# for every folder in src, zip and put in dest
# default to png in, release out
srcdir=$1
destdir=${2:-release}

# take png/andover, zip, write as release/andover.zip
function makefn {
  indir=$1 # e.g. png/andover
  outdir=$2 # e.g. release
  type=$3 # png or pdf
  id=$(basename $indir) # e.g. andover
  output="$outdir/${id}_${type}.zip"
  echo "$output"
}

# zip folder, write to output of makefn
function zipdir {
  indir=$1
  outdir=$2
  type=$3
  zipout=$(makefn $indir $outdir $type)
  imgs="$indir/*.$type"
  zip -j -q $zipout $imgs
}

export -f makefn zipdir

mkdir -p $destdir
ls $srcdir   | parallel --bar -j zipdir $srcdir/{} "$destdir" png
# ls plots | parallel --bar -j 14 zipdir plots/{} "$destdir" pdf
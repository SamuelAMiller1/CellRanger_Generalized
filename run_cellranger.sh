#!/bin/bash

while [[ $# -gt 0 ]]; do
  key=$1
  case $key in
  
    -s|--seq-dir)
      seqdir="$2"
      shift 2
      ;;
    -b|--bcl-dir)
      BCLFILE="$2"
      shift 2
      ;;
    -c|--csv-dir)
      BCLCSV="$2"
      shift 2
      ;;
    -m|--mkfastqout-dir)
      MKFASTQOUT="$2"
      shift 2
      ;;
    -r|--ref-dir)
      REFERENCE="$2"
      shift 2
      ;;
    -k|--countout-dir)
      COUNTOUT="$2"
      shift 2
      ;;
    -f|--fastqs-dir)
      FASTQS="$2"
      shift 2
      ;;
    -t|--threads)
      CORES="$2"
      shift 2
      ;;
    -k|--countout-dir)
      COUNTOUT="$2"
      shift 2
      ;;
    -o|--out-dir)
      outdir="$2"
      shift 2
      ;;


  esac
done


# Navigate to parent directory
cd $outdir

###############
# Run mkfastq #
###############

cellranger mkfastq \
--id=$MKFASTQOUT \
--run=$BCLFILE \
--csv=$BCLCSV


#############
# Run count #
#############

# Download reference transcriptome
TRANSCRIPTOME='https://cf.10xgenomics.com/supp/cell-exp/refdata-cellranger-GRCh38-3.0.0.tar.gz'
wget $TRANSCRIPTOME | tar -zxvf > $REFERENCE

# Add loop for --sample argument
# Count
cellranger count \
--id=$COUNTOUT \
--fastqs=$FASTQS \
--transcriptome=$REFERENCE



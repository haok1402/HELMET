#!/bin/bash
# Activate the environment.
# Usage: source workspace/activate.sh

export CUDA_HOME=/usr/local/cuda-12.8
export WORKSPACE=${WORKSPACE:-/tmp/HELMET}
export HF_HUB_CACHE=${HF_HUB_CACHE:-/tmp/hf_hub_cache}
export HF_DATASETS_CACHE=${HF_DATASETS_CACHE:-/tmp/hf_datasets_cache}

# Activate the conda environment.
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate HELMET

# Pull a directory from Google Cloud Storage.
# Usage: gspull <directory>
gspull()
{
    local DIR=$1
    gcloud storage rsync -r gs://cmu-gpucloud-$USER/HELMET/$DIR $WORKSPACE/$DIR
}

# Push a directory to Google Cloud Storage.
# Usage: gspush <directory>
gspush()
{
    local DIR=$1
    gcloud storage rsync -r $WORKSPACE/$DIR gs://cmu-gpucloud-$USER/HELMET/$DIR
}

# Remap the workspace directories to remain compatible with the codebase.
mkdir -p $WORKSPACE/data
ln -sfnT -- $WORKSPACE/data $PWD/data

mkdir -p $WORKSPACE/output $PWD/output
ln -sfnT -- $WORKSPACE/output $PWD/output/$(hostname)

mkdir -p $WORKSPACE/logging $PWD/logging
ln -sfnT -- $WORKSPACE/logging $PWD/logging/$(hostname)

# Pull the dataset for evaluation.
gspull data

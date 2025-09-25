#!/bin/bash

ulimit -n 4096

# Activate the conda environment.
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate HELMET

# Specify the model checkpoint and output directory.
MODEL_NAME_OR_PATH=Qwen/Qwen3-0.6B
OUTPUT_DIR=workspace/outputs/Qwen3-0.6B

# Run the 8k to 64k versions.
for task in recall rag rerank icl longqa summ; do
    python eval.py --config configs/${task}_short.yaml --model_name_or_path ${MODEL_NAME_OR_PATH} --output_dir ${OUTPUT_DIR}
done

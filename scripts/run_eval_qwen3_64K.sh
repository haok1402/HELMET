#!/bin/bash

ulimit -n 4096

# Activate the conda environment.
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate HELMET

# Specify the model checkpoint and output directory.
MODEL_NAME_OR_PATH=workspace/checkpoints/lcft_Qwen3-0.6B_long-context-65536_ProLong64KMix_bsz64_steps1000_lr1e-5_warmup0.1_rope4000000/checkpoint-250
OUTPUT_DIR=workspace/outputs/Qwen3-0.6B-64K-rope4M/checkpoint-250

# Run the 8k to 64k versions.
for task in recall rag rerank icl longqa summ; do
    python eval.py --config configs/${task}_short.yaml --model_name_or_path ${MODEL_NAME_OR_PATH} --output_dir ${OUTPUT_DIR}
done

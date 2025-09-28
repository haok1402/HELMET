#!/bin/bash

ulimit -n 4096

# Activate the conda environment.
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate HELMET

# Evaluate with the base Qwen3-0.6B model, from 8K to 64K context, after long-context extension.
MODEL_NAME_OR_PATH=workspace/checkpoints/lcft_Qwen3-0.6B_long-context-65536_ProLong64KMix_bsz64_steps1000_lr1e-5_warmup0.1_rope4000000/checkpoint-1000/
OUTPUT_DIR=workspace/outputs/Qwen3-0.6B-64K-rope4M/checkpoint-1000/short

for CONFIG in recall rag icl rerank longqa summ cite; do
    python eval.py --config configs/${CONFIG}_short.yaml --model_name_or_path $MODEL_NAME_OR_PATH --output_dir $OUTPUT_DIR
done

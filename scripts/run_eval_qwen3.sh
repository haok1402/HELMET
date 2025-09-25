#!/bin/bash

ulimit -n 4096

# Activate the conda environment.
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate HELMET

# Make use of the cluster-wise cached models.
export HF_HUB_CACHE=/data/hf_cache

# Evaluate with the base Qwen3-0.6B model, from 8K to 64K context.
MODEL_NAME_OR_PATH=Qwen/Qwen3-0.6B
OUTPUT_DIR=workspace/outputs/Qwen3-0.6B/short

for CONFIG in recall rag icl rerank longqa summ cite; do
    python eval.py --config configs/${CONFIG}_short.yaml --model_name_or_path $MODEL_NAME_OR_PATH --output_dir $OUTPUT_DIR
done

# Evaluate with the base Qwen3-1.7B model, from 8K to 64K context.
MODEL_NAME_OR_PATH=Qwen/Qwen3-1.7B
OUTPUT_DIR=workspace/outputs/Qwen3-1.7B/short

for CONFIG in recall rag icl rerank longqa summ cite; do
    python eval.py --config configs/${CONFIG}_short.yaml --model_name_or_path $MODEL_NAME_OR_PATH --output_dir $OUTPUT_DIR
done

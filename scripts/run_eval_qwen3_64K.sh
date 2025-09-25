#!/bin/bash

ulimit -n 4096

# Activate the conda environment.
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate HELMET

# Specify the model checkpoint and output directory.
MODEL_NAME_OR_PATH=workspace/checkpoints/lcft_Qwen3-0.6B_long-context-65536_ProLong64KMix_bsz64_steps1000_lr1e-5_warmup0.1_rope4000000/checkpoint-500
OUTPUT_DIR=workspace/outputs/Qwen3-0.6B-64K-rope4M/checkpoint-500/short

# Make use of reduced sample sizes for quick validation.
CONFIG=configs/recall_short.yaml; MAX_TEST_SAMPLES=25
python eval.py --config $CONFIG --model_name_or_path $MODEL_NAME_OR_PATH --output_dir $OUTPUT_DIR --max_test_samples $MAX_TEST_SAMPLES
CONFIG=configs/rag_short.yaml; MAX_TEST_SAMPLES=25
python eval.py --config $CONFIG --model_name_or_path $MODEL_NAME_OR_PATH --output_dir $OUTPUT_DIR --max_test_samples $MAX_TEST_SAMPLES
CONFIG=configs/rerank_short.yaml; MAX_TEST_SAMPLES=25
python eval.py --config $CONFIG --model_name_or_path $MODEL_NAME_OR_PATH --output_dir $OUTPUT_DIR --max_test_samples $MAX_TEST_SAMPLES
CONFIG=configs/icl_short.yaml; MAX_TEST_SAMPLES=125
python eval.py --config $CONFIG --model_name_or_path $MODEL_NAME_OR_PATH --output_dir $OUTPUT_DIR --max_test_samples $MAX_TEST_SAMPLES
CONFIG=configs/longqa_short.yaml; MAX_TEST_SAMPLES=25
python eval.py --config $CONFIG --model_name_or_path $MODEL_NAME_OR_PATH --output_dir $OUTPUT_DIR --max_test_samples $MAX_TEST_SAMPLES
CONFIG=configs/summ_short.yaml; MAX_TEST_SAMPLES=25
python eval.py --config $CONFIG --model_name_or_path $MODEL_NAME_OR_PATH --output_dir $OUTPUT_DIR --max_test_samples $MAX_TEST_SAMPLES

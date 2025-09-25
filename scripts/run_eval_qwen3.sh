#!/bin/bash

ulimit -n 4096

# Activate the conda environment.
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate HELMET

# Specify the model checkpoint and output directory.
MODEL_NAME_OR_PATH=Qwen/Qwen3-0.6B
OUTPUT_DIR=workspace/outputs/Qwen3-0.6B

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

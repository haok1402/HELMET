#!/bin/bash
# Run the evaluation script, for 8K-64K context length.
# Usage: bash workspace/evaluate_short.sh <model_name_or_path>

source workspace/activate.sh
export MODEL_NAME_OR_PATH=${1:-Qwen/Qwen3-0.6B}

# Set up output and logging directories.
export OUTPUT_DIR=$WORKSPACE/output/$MODEL_NAME_OR_PATH/short
mkdir -p $OUTPUT_DIR

export LOGGING_DIR=$WORKSPACE/logging/$MODEL_NAME_OR_PATH/short
mkdir -p $LOGGING_DIR

# Launch a task on a specific GPU device.
# Usage: launch <task> <device>
launch()
{
    local task=$1
    local device=$2

    ARGS=()
    ARGS+=(--config configs/${task}_short.yaml)
    ARGS+=(--model_name_or_path $MODEL_NAME_OR_PATH)
    ARGS+=(--output_dir $OUTPUT_DIR)

    CUDA_VISIBLE_DEVICES=$device python eval.py ${ARGS[@]} 2>&1 | tee $LOGGING_DIR/${task}.log
    gspush logging; gspush output
}

# Launch each task on GPUs 0..N and wait for all to complete.
tasks=(recall rag icl rerank longqa summ cite)

for i in ${!tasks[@]}; do
    launch ${tasks[$i]} $i &
done

wait

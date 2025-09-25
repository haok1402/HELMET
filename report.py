import json
import statistics
from pathlib import Path

metrics = {
    "Recall": {
        "json_kv": "substring_exact_match",
        "ruler_niah_mk_2": "ruler_recall",
        "ruler_niah_mk_3": "ruler_recall",
        "ruler_niah_mv": "ruler_recall",
    },
    "RAG": {
        "nq": "substring_exact_match",
        "hotpotqa": "substring_exact_match",
        "popqa": "substring_exact_match",
        "triviaqa": "substring_exact_match",
    },
    "Re-rank": {
        "msmarco_rerank_psg": "NDCG@10",
    },
    "ICL": {
        "trec_coarse": "exact_match",
        "trec_fine": "exact_match",
        "banking77": "exact_match",
        "clinic150": "exact_match",
        "nlu": "exact_match",
    },
    "LongQA": {
        "narrativeqa": "gpt-4-score",
        "infbench_qa": "rougeL_f1",
        "infbench_choice": "exact_match",
    },
    "Summ": {
        "infbench_sum": "gpt-4-f1",
        "multi_lexsum": "gpt-4-f1",
    },
}


def main(workspace: Path, maxlen: int):

    records = {key: [] for key in metrics.keys()}

    for file in workspace.glob("*.json.score"):
        for length in [8192, 16384, 32768, 65536, 131072]:
            if "in%d" % length in file.name and length > maxlen:
                continue
        data = json.load(file.open())
        for group, task_metrics in metrics.items():
            for task, metric in task_metrics.items():
                if task in file.name:
                    if metric in data:
                        records[group].append(data[metric])

    print(f"Results from {workspace}:")
    for group, values in records.items():
        if values:
            print(f"\t{group}: {statistics.mean(values):.4f}")


if __name__ == "__main__":
    # For a fair comparison, we use 32K context length for both models.
    # That is the max length supported by Qwen3-0.6B, without any extension.
    workspace, maxlen = Path("workspace/outputs/Qwen3-0.6B/short"), 32768
    main(workspace, maxlen)
    workspace, maxlen = Path("workspace/outputs/Qwen3-0.6B-64K-rope4M/checkpoint-500/short"), 32768
    main(workspace, maxlen)

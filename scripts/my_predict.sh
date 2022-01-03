#!/bin/bash

export SEED=1 # 15270, 1 , 2

# training params
export cuda_device=0
export BATCH_SIZE=4

MODEL_DIR=models/full_text/conflated_train_and_val_1/model.tar.gz
INPUT_FILE=data/my_data/arxiv_pubmed/arxiv_val.jsonl
OUTPUT_FILE=prediction/arxiv_val.txt
#INPUT_FILE=data/my_data/arxiv_pubmed/pubmed_val.jsonl
#OUTPUT_FILE=prediction/pubmed_val.txt

python -m allennlp.run predict \
	$MODEL_DIR \
	$INPUT_FILE \
	--include-package sequential_sentence_classification \
	--predictor SeqClassificationPredictor \
	--output-file $OUTPUT_FILE   

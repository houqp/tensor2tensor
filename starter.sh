#! /bin/bash

pip install -e .

# algorithmic_reverse_nlplike_decimal8K
# algorithmic_multiplication_decimal40
PROBLEM=algorithmic_multiplication_decimal40
MODEL=baseline_lstm_seq2seq
HPARAMS=basic_1

DATA_DIR=$HOME/t2t_data
TMP_DIR=/tmp/t2t_datagen
TRAIN_DIR=$HOME/t2t_train/$PROBLEM/$MODEL-$HPARAMS

mkdir -p $DATA_DIR $TMP_DIR $TRAIN_DIR

# Generate data
t2t-datagen \
  --data_dir=$DATA_DIR \
  --tmp_dir=$TMP_DIR \
  --num_shards=100 \
  --problem=$PROBLEM

# Train
# *  If you run out of memory, add --hparams='batch_size=2048' or even 1024.
t2t-trainer \
  --data_dir=$DATA_DIR \
  --problems=$PROBLEM \
  --model=$MODEL \
  --hparams_set=$HPARAMS \
  --output_dir=$TRAIN_DIR \
  --hparams="optimizer=YellowFin"

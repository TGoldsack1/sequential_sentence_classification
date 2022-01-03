#!/bin/bash
#SBATCH --account=dcs-acad2
#SBATCH --partition=dcs-acad

module load Anaconda3/5.3.0
module load CUDA/10.2.89-GCC-8.3.0

sh ./scripts/my_train.sh models/full_text/conflated_train_and_val

#!/bin/bash
#SBATCH --time=168:00:00
#SBATCH --partition=gpu
#SBATCH --qos=gpu
#SBATCH --mem=16GB
#SBATCH --nodes=1 
#SBATCH --gpus-per-node=1
#SBATCH --mail-user=tgoldsack1@sheffield.ac.uk
#SBATCH --mail-type=ALL

module load Anaconda3/5.3.0
module load CUDA/10.2.89-GCC-8.3.0

#sh ./scripts/my_train.sh models/full_text/conflated_train_and_val
sh ./scripts/my_train.sh models/pubmed-rtc


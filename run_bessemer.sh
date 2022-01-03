#!/bin/bash
#SBATCH --account=dcs-acad2
#SBATCH --partition=dcs-acad

sh ./scripts/my_train.sh models/full_text/conflated_train_and_val

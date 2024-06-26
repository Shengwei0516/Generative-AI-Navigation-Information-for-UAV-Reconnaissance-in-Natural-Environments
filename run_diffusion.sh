echo "[Diffusion] Downloading pre-trained model..."
python ./diffusion/preprocess/download.py


echo "[Diffusion] Preprocessing data..."
python ./diffusion/preprocess.py \
  --train_data_folder="./training_dataset" \
  --test_data_folder="./testing_dataset" \
  --output_folder="./diffusion/datasets"


echo "[Diffusion] Training for river data..."
export LOGDIR=./checkpoints/diffusion/RI/upsample
MODEL_FLAGS="--learn_sigma True --uncond_p 0 --image_size 256 --super_res 64 --num_res_blocks 2 --finetune_decoder True --model_path ./diffusion/ckpt/upsample.pt"
TRAIN_FLAGS="--lr 1e-5 --batch_size 4 --lr_anneal_steps 20000"
DIFFUSION_FLAGS="--noise_schedule linear"
SAMPLE_FLAGS="--num_samples 2 --sample_c 1"
DATASET_FLAGS="--data_dir ./diffusion/datasets/RI_train.txt --val_data_dir ./diffusion/datasets/RI_train.txt --mode coco-edge"
python ./diffusion/train.py $MODEL_FLAGS  $TRAIN_FLAGS $SAMPLE_FLAGS $DIFFUSION_FLAGS $DATASET_FLAGS
export CUDA_LAUNCH_BLOCKING=1
export LOGDIR=./checkpoints/diffusion/RI/base/stage1
MODEL_FLAGS="--learn_sigma True --uncond_p 0. --image_size 64 --finetune_decoder False"
TRAIN_FLAGS="--lr 3.5e-5 --batch_size 24  --schedule_sampler loss-second-moment  --model_path ./diffusion/ckpt/base.pt --lr_anneal_steps 20000"
DIFFUSION_FLAGS=""
SAMPLE_FLAGS="--num_samples 2 --sample_c 1"
DATASET_FLAGS="--data_dir ./diffusion/datasets/RI_train.txt --val_data_dir ./diffusion/datasets/RI_train.txt --mode coco-edge"
python ./diffusion/train.py $MODEL_FLAGS  $TRAIN_FLAGS $SAMPLE_FLAGS $DIFFUSION_FLAGS  $DATASET_FLAGS
export CUDA_LAUNCH_BLOCKING=1
export LOGDIR=./checkpoints/diffusion/RI/base/stage1-cont/
MODEL_FLAGS="--learn_sigma True --uncond_p 0.2 --image_size 64 --finetune_decoder False --encoder_path ./checkpoints/diffusion/RI/base/stage1/checkpoints/ema_0.9999_020000.pt"
TRAIN_FLAGS="--lr 2e-5 --batch_size 24  --schedule_sampler loss-second-moment  --model_path ./diffusion/ckpt/base.pt --lr_anneal_steps 20000"
DIFFUSION_FLAGS=""
SAMPLE_FLAGS="--num_samples 2 --sample_c 1"
DATASET_FLAGS="--data_dir ./diffusion/datasets/RI_train.txt --val_data_dir ./diffusion/datasets/RI_train.txt --mode coco-edge"
python ./diffusion/train.py $MODEL_FLAGS  $TRAIN_FLAGS $SAMPLE_FLAGS $DIFFUSION_FLAGS  $DATASET_FLAGS
export CUDA_LAUNCH_BLOCKING=1
export LOGDIR=./checkpoints/diffusion/RI/base/stage2-decoder/
MODEL_FLAGS="--learn_sigma True --uncond_p 0.2 --image_size 64 --finetune_decoder True --encoder_path ./checkpoints/diffusion/RI/base/stage1-cont/checkpoints/ema_0.9999_020000.pt"
TRAIN_FLAGS="--lr 3.5e-5 --batch_size 20 --schedule_sampler loss-second-moment --model_path ./diffusion/ckpt/base.pt --lr_anneal_steps 20000"
DIFFUSION_FLAGS=""
SAMPLE_FLAGS="--num_samples 2 --sample_c 2.5"
DATASET_FLAGS="--data_dir ./diffusion/datasets/RI_train.txt --val_data_dir ./diffusion/datasets/RI_train.txt --mode coco-edge"
python ./diffusion/train.py $MODEL_FLAGS  $TRAIN_FLAGS $SAMPLE_FLAGS $DIFFUSION_FLAGS  $DATASET_FLAGS


echo "[Diffusion] Training for road data..."
export LOGDIR=./checkpoints/diffusion/RO/upsample 
MODEL_FLAGS="--learn_sigma True --uncond_p 0 --image_size 256 --super_res 64 --num_res_blocks 2 --finetune_decoder True --model_path ./diffusion/ckpt/upsample.pt"
TRAIN_FLAGS="--lr 1e-5 --batch_size 4 --lr_anneal_steps 20000"
DIFFUSION_FLAGS="--noise_schedule linear"
SAMPLE_FLAGS="--num_samples 2 --sample_c 1"
DATASET_FLAGS="--data_dir ./diffusion/datasets/RO_train.txt --val_data_dir ./diffusion/datasets/RO_train.txt --mode coco-edge"
python ./diffusion/train.py $MODEL_FLAGS  $TRAIN_FLAGS $SAMPLE_FLAGS $DIFFUSION_FLAGS $DATASET_FLAGS
export CUDA_LAUNCH_BLOCKING=1
export LOGDIR=./checkpoints/diffusion/RO/base/stage1
MODEL_FLAGS="--learn_sigma True --uncond_p 0. --image_size 64 --finetune_decoder False"
TRAIN_FLAGS="--lr 3.5e-5 --batch_size 24  --schedule_sampler loss-second-moment  --model_path ./diffusion/ckpt/base.pt --lr_anneal_steps 20000"
DIFFUSION_FLAGS=""
SAMPLE_FLAGS="--num_samples 2 --sample_c 1"
DATASET_FLAGS="--data_dir ./diffusion/datasets/RO_train.txt --val_data_dir ./diffusion/datasets/RO_train.txt --mode coco-edge"
python ./diffusion/train.py $MODEL_FLAGS  $TRAIN_FLAGS $SAMPLE_FLAGS $DIFFUSION_FLAGS  $DATASET_FLAGS
export CUDA_LAUNCH_BLOCKING=1
export LOGDIR=./checkpoints/diffusion/RO/base/stage1-cont/
MODEL_FLAGS="--learn_sigma True --uncond_p 0.2 --image_size 64 --finetune_decoder False --encoder_path ./checkpoints/diffusion/RO/base/stage1/checkpoints/ema_0.9999_020000.pt"
TRAIN_FLAGS="--lr 2e-5 --batch_size 24  --schedule_sampler loss-second-moment  --model_path ./diffusion/ckpt/base.pt --lr_anneal_steps 20000"
DIFFUSION_FLAGS=""
SAMPLE_FLAGS="--num_samples 2 --sample_c 1"
DATASET_FLAGS="--data_dir ./diffusion/datasets/RO_train.txt --val_data_dir ./diffusion/datasets/RO_train.txt --mode coco-edge"
python ./diffusion/train.py $MODEL_FLAGS  $TRAIN_FLAGS $SAMPLE_FLAGS $DIFFUSION_FLAGS  $DATASET_FLAGS
export CUDA_LAUNCH_BLOCKING=1
export LOGDIR=./checkpoints/diffusion/RO/base/stage2-decoder/
MODEL_FLAGS="--learn_sigma True --uncond_p 0.2 --image_size 64 --finetune_decoder True --encoder_path ./checkpoints/diffusion/RO/base/stage1-cont/checkpoints/ema_0.9999_020000.pt"
TRAIN_FLAGS="--lr 3.5e-5 --batch_size 20 --schedule_sampler loss-second-moment --model_path ./diffusion/ckpt/base.pt  --lr_anneal_steps 20000"
DIFFUSION_FLAGS=""
SAMPLE_FLAGS="--num_samples 2 --sample_c 2.5"
DATASET_FLAGS="--data_dir ./diffusion/datasets/RO_train.txt --val_data_dir ./diffusion/datasets/RO_train.txt --mode coco-edge"
python ./diffusion/train.py $MODEL_FLAGS  $TRAIN_FLAGS $SAMPLE_FLAGS $DIFFUSION_FLAGS  $DATASET_FLAGS


echo "[Diffusion] Testining for river data..."
export LOGDIR=./results/diffusion/
MODEL_FLAGS="--learn_sigma True --model_path ./checkpoints/diffusion/RI/base/stage2-decoder/checkpoints/model020000.pt --sr_model_path ./checkpoints/diffusion/RI/upsample/checkpoints/model020000.pt"
SAMPLE_FLAGS="--num_samples 720 --sample_c 1.3 --batch_size 72"
DATASET_FLAGS="--data_dir ./diffusion/datasets/RI_train.txt --val_data_dir ./diffusion/datasets/RI_test.txt --mode coco-edge"
python ./diffusion/test.py $MODEL_FLAGS $SAMPLE_FLAGS  $DATASET_FLAGS


echo "[Diffusion] Testining for road data..."
export LOGDIR=./results/diffusion/
MODEL_FLAGS="--learn_sigma True --model_path ./checkpoints/diffusion/RO/base/stage2-decoder/checkpoints/model020000.pt --sr_model_path ./checkpoints/diffusion/RO/upsample/checkpoints/model020000.pt"
SAMPLE_FLAGS="--num_samples 720 --sample_c 1.3 --batch_size 72"
DATASET_FLAGS="--data_dir ./diffusion/datasets/RO_train.txt --val_data_dir ./diffusion/datasets/RO_test.txt --mode coco-edge"
python ./diffusion/test.py $MODEL_FLAGS $SAMPLE_FLAGS  $DATASET_FLAGS

#!/bin/bash

# Clone repository (THIS CODE ASSUMED RUN)
#git clone https://github.com/mvsoom/TimeChat
#cd TimeChat

# Update package repositories and install necessary packages
sudo apt update
sudo apt install ffmpeg -y

# Install git-lfs
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt install git-lfs -y

# Install Miniconda
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

# Initialize Conda
~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh

# Install dependencies for TimeChat
conda env create -f environment.yml
conda activate timechat
pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 torchaudio==0.12.1 --extra-index-url https://download.pytorch.org/whl/cu113
pip install torchshow

# Download model weights and other files
mkdir -p ckpt
cd ckpt

mkdir -p eva-vit-g
cd eva-vit-g
wget https://storage.googleapis.com/sfr-vision-language-research/LAVIS/models/BLIP2/eva_vit_g.pth
cd ..

mkdir -p instruct-blip
cd instruct-blip
wget https://storage.googleapis.com/sfr-vision-language-research/LAVIS/models/InstructBLIP/instruct_blip_vicuna7b_trimmed.pth
cd ..

git clone https://huggingface.co/DAMO-NLP-SG/Video-LLaMA-2-7B-Finetuned

git clone https://huggingface.co/ShuhuaiRen/TimeChat-7b timechat

cd ..
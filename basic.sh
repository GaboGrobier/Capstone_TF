#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y net-tools 
sudo apt install -y  python3-pip 
sudo apt-get install -y git
git clone https://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@github.com/GaboGrobier/chatbot_capstone2023 
cd chatbot_capstone2023 
pip install requeriments.txt 
python3 main.py 
#!/bin/bash

sudo apt install -y software-properties-common git make libssl-dev g++-5
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 10

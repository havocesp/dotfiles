#!/bin/bash
which git || sudo apt-get install git # if git is not installed
git clone https://github.com/forrestv/p2pool.git
cd p2pool
make

#!/bin/sh

kubectl cluster-info
# make install
# make ketch
curl -s https://raw.githubusercontent.com/shipa-corp/ketch/main/install.sh | bash

ketch -v

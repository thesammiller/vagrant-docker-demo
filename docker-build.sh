#!/bin/bash

docker build -f /home/vagrant/mapdocker/dockerfile_master -t vu_mr_master .
docker build -f /home/vagrant/mapdocker/dockerfile_map -t vu_mr_map .
docker build -f /home/vagrant/mapdocker/dockerfile_reduce -t vu_mr_reduce .

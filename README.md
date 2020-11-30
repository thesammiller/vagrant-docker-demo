# vagrant-docker-demo

===================================================================
                      Docker instructions for the federated cloud execution
===================================================================

In the following we discuss how to use the Docker implementation of
the code base both in a standalone VM mode or in Swarm mode.

+++++++++++++++++++++++++++++++++
Testing standalone in Laptop VM
+++++++++++++++++++++++++++++++++

Start your 18.04 VM on the laptop and open three shells

Step (1): Build images
-------------------------------
docker build -f ./dockerfile_master -t <some tag for master> .
docker build -f ./dockerfile_map -t <some tag for map> .
docker build -f ./dockerfile_reduce -t <some tag for reduce> .

I am using tags: vu_mr_master, vu_mr_map, vu_mr_reduce, respectively

Step (2): Run each image in its own shell
-------------------------------------------------------
In Shell 1, we run the master as follows:

         docker run -it --name <some name> vu_mr_master 

I used the name MyMR_Master

In Shell 2, we run the map worker as follows:

         docker run -it --name <some name> vu_mr_map /bin/bash

I used the name MyMR_Map

In Shell 3, we run the reduce worker as follows:

         docker run -it --name <some name> vu_mr_reduce /bin/bash

I used the name MyMR_Reduce

Step (3): Running the map-reduce wordcount
-------------------------------------------------------------

On shell 1 which is now running master, type the following at the prompt
which is # (# is not part of the command):

# ifconfig

and note down the IP address of the container. On my machine it was
172.17.0.2. 

# cd /root
# python mr_wordcount.py -p 5556 -M 1 -R 1 small.txt

On shell 2 which is now running map worker, type the following at the prompt
which is # (# is not part of the command):

# cd /root
# python mr_mapworker.py <master IP addr> <master port>

For me, it was python mr_mapworker.py 172.17.0.2 5556

On shell 3 which is now running reduce worker, type the following at
the prompt which is # (# is not part of the command):

# cd /root
# python mr_reduceworker.py <master IP addr> <master port>

For me, it was python mr_reduceworker.py 172.17.0.2 5556

Shell 1: Watch the completion of the program and time it took to run.

You can try the same with M = 1 and R = 1 as above but for the big.txt
file.

The master file runs 20 iterations of the same experiment and saves
the results in a file called "metrics.csv". The contents look like
this (using the -i 10 i.e., 10 iterations):

Map phase       Shuffle Phase   Reduce Phase    Finalize        Total
9.90979909897, 10.3850190639, 2.70907187462, 0.00508713722229, 23.0089771748
10.027493, 10.3473410606, 2.68525505066, 0.00602102279663, 23.0661101341
9.85127687454, 10.6124820709, 2.69362902641, 0.00514888763428, 23.1625368595
....

#!/bin/bash
# Prereq: Copy the DNS key to the .ssh folder but renamed as id_ed25519 (remove the _DNS)

# Usage: ./repo_clone.sh <number of nodes> <mode>
# Mode: 0 - Clone the repo, switch to DNS branch, kernel patch
# Mode: 1 - Execute further_setup.sh (only after kernel patching)
# Does not execute on current node

mode=$2
nodes=$1
end=$((nodes-1))

sudo apt-get update
sudo apt-get install parallel -y

if [ $mode -eq 0 ]
then
    
    seq 1 $end | parallel --lb -j 0 '
        i={}
        echo "Cloning repo on node $i"
        ssh -o StrictHostKeyChecking=no node$i "git clone https://github.com/adityavidyadharan/HomaModule.git"
        echo "Cloned repo on ndoe $i"
        ssh -o StrictHostKeyChecking=no node$i "cd HomaModule; git switch DNS"
        ssh -o StrictHostKeyChecking=no node$i "cd HomaModule; git pull"
        echo "On DNS branch on node $i"

        # Start kernel patching
        ssh -o StrictHostKeyChecking=no node$i "cd HomaModule/setup; ./kernel_patch.sh"
    '

fi

if [ $mode -eq 1 ]
then
    seq 1 $end | parallel --lb -j 0 '
        i={}
        echo "Executing further_setup.sh on node $i"
        ssh -o StrictHostKeyChecking=no node$i "cd HomaModule; ./setup/further_setup.sh"
    '
fi


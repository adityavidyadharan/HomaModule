
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
    
    seq 1 $end | parallel -j 0 '
        echo "Cloning repo on node $i"
        ssh node$i "git clone https://github.com/adityavidyadharan/HomaModule.git"
        ssh node$i "cd HomaModule; git switch DNS"
        ssh node$i "cd HomaModule; git pull"

        # Start kernel patching
        ssh node$i "cd HomaModule/setup; ./kernel_patch.sh"
    '

endif

if [ $mode -eq 1 ]
then
    seq 1 $end | parallel -j 0 '
        echo "Executing further_setup.sh on node $i"
        ssh node$i "cd HomaModule/setup; ./further_setup.sh"
    '
endif
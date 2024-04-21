nodes=$1
end=$((nodes-1))

sudo tc qdisc del dev eno1d1 root
sudo tc qdisc add dev eno1d1 root netem loss 0.5%

seq 1 $end | parallel --lb -j 0 '
    i={}
    ssh -o StrictHostKeyChecking=no node$i sudo tc qdisc del dev eno1d1 root
    ssh -o StrictHostKeyChecking=no node$i sudo tc qdisc add dev eno1d1 root netem loss 0.5%
'
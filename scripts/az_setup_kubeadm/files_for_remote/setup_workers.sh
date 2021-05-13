set -x
for i in `cat /tmp/worker_ips.txt`
do

scp -o StrictHostKeyChecking=no /tmp/setup* $i:/tmp/

ssh -o StrictHostKeyChecking=no $i << EOF

chmod 755 /tmp/setup_*

/tmp/setup_docker.sh | tee /tmp/setup_docker.log
/tmp/setup_kube.sh | tee /tmp/setup_kube.log
/tmp/setup_join.sh | tee /tmp/setup_join.log

EOF

done

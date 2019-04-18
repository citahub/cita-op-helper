#!/bin/bash

CITA_DIR="$1"

LOG_COUNT=50

CITA_INFO_DIR="/tmp/cita_info"

cita_info(){
    echo $CITA_DIR 
    mkdir -p ${CITA_INFO_DIR}
    cd $CITA_DIR
    if [  -f "./env.sh" ]; then 
        echo "CITA software version number" > ${CITA_INFO_DIR}/cita_info.txt
        ./env.sh ./bin/cita-jsonrpc --version | grep JsonRpc |awk '{print $2}' >> ${CITA_INFO_DIR}/cita_info.txt
        
	echo "CITA process information" >> ${CITA_INFO_DIR}/cita_info.txt
        ps -ef | grep -E "cita-|rabbitmq" |grep -v grep |wc -l && ps -ef | grep -E "cita-|rabbitmq" |grep -v grep >> ${CITA_INFO_DIR}/cita_info.txt
        
	echo "Memory info" >>${CITA_INFO_DIR}/cita_info.txt
        free -h >> ${CITA_INFO_DIR}/cita_info.txt
        
	echo "Disk info" >> ${CITA_INFO_DIR}/cita_info.txt
        df -h >> ${CITA_INFO_DIR}/cita_info.txt
        
        echo "Operating system info" >> ${CITA_INFO_DIR}/cita_info.txt
        lsb_release -a  >> ${CITA_INFO_DIR}/cita_info.txt
        
	node_list=`find ./ -name "network.toml" | awk -F "/" '{print $2"/"$3 }' | grep -v template`
        for i in $node_list:
            do
            i=`echo ${i} |awk -F ":" '{print $1}'`
            mkdir -p ${CITA_INFO_DIR}/${i}
            tail -n ${LOG_COUNT} ${i}/logs/cita-auth.log > ${CITA_INFO_DIR}/${i}/cita-auth.log
            tail -n ${LOG_COUNT} ${i}/logs/cita-bft.log > ${CITA_INFO_DIR}/${i}/cita-bft.log
            tail -n ${LOG_COUNT} ${i}/logs/cita-chain.log > ${CITA_INFO_DIR}/${i}/cita-chain.log
            tail -n ${LOG_COUNT} ${i}/logs/cita-executor.log > ${CITA_INFO_DIR}/${i}/cita-executor.log
            tail -n ${LOG_COUNT} ${i}/logs/cita-forever.log > ${CITA_INFO_DIR}/${i}/cita-forever.log
            tail -n ${LOG_COUNT} ${i}/logs/cita-jsonrpc.log > ${CITA_INFO_DIR}/${i}/cita-jsonrpc.log
            tail -n ${LOG_COUNT} ${i}/logs/cita-network.log > ${CITA_INFO_DIR}/${i}/cita-network.log
            cp -rp ${i}/*.toml ${CITA_INFO_DIR}/${i}/
        done
        
	cd /tmp/
        tar czf cita_info.tar.gz cita_info
        
	echo Please submit the cita_info.tar.gz file to the administrator to help troubleshoot the issue.
    fi
}


usage(){
    echo "      usage: $0 CITA DIR"
    echo "      Please fill in the CITA real deployment directory after the script. "
    echo "      ./check_cita_health.sh /data/cita_secp256k1_sha3"

}

if [ $# -lt 1 ];
    then
    usage
else
    cita_info
fi

#!/bin/sh
proxy_work_dir="/home/jenkins"
proxy_conf_dir="/export/shardingsphere-benchmark/yaml_conf"
if [ ! -d $proxy_work_dir  ];then
  mkdir -p $proxy_work_dir
fi

cd $proxy_work_dir
./apache-shardingsphere-*-shardingsphere-proxy-bin/bin/stop.sh
sleep 5
rm -f  /home/jenkins/apache-shardingsphere-*-shardingsphere-proxy-bin/conf/config-*.yaml
cp -f $proxy_conf_dir/fullrouting/sharding-masterslave-encrypt/proxy/config-proxy-fullrouting-smallshards-sharding-masterslave-enc.yaml $proxy_conf_dir/server.yaml /home/jenkins/apache-shardingsphere-*-shardingsphere-proxy-bin/conf
./apache-shardingsphere-*-shardingsphere-proxy-bin/bin/start.sh
sleep 10
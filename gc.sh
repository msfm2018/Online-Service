#!/bin/sh
nodename=gc_gateway
ProjPath=/usr/work/websocket
cd $ProjPath/etc

datetime=`date "+%Y%m%d-%H%M%S"`
LogFile=$ProjPath/logs/$nodename$datetime.log
erl  +K true +P 1024000 -pa ../ebin -pa ../deps/*/ebin -name gateway@127.0.0.1 -setcookie wolf -boot start_sasl -kernel error_logger \{file,\"$LogFile\"\} -sasl sasl_error_logger false  -s entry start  gc_gateway_app  






cd ../ebin
mkdir logs
cd ../etc
set LogFile=\"../ebin/logs/gc.log\"
werl +K true   +P 1024000  -pa ../ebin -pa ../deps/jsx/ebin  -boot start_sasl -kernel error_logger {file,"%LogFile%"}  -sasl sasl_error_logger false  -s entry start  gc_gateway_app 
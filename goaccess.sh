#! /bin/bash

cat nginx/log/access.log | docker run -v $PWD/goaccess/goaccess.conf:/goaccess/goaccess.conf --rm -i -e LANG=$LANG allinurl/goaccess --no-global-config --config-file=/goaccess/goaccess.conf -a -o html --log-format COMBINED - > report.html
#!/bin/sh
hexo generate
rm -rf /opt/release/proxy/nginx/oneblog
mv public /opt/release/proxy/nginx/oneblog

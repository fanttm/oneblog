#!/bin/sh
hexo generate
mv public /opt/release/proxy/nginx/oneblog

#!/bin/sh
sudo chown godfat:godfat -R .
git pull
git submodule update --init
sudo chown http:http -R static

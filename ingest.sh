#!/bin/bash

echo "installing garminexport .."
pip install garminexport

echo "installing garminexport[cloudflare] .."
pip install garminexport[cloudflare]

echo "path download data = $1 "
echo "mail = $2 "

garmin-backup --backup-dir=$1 $2
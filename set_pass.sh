#!/bin/bash

count=$(wc -l identities | cut -d' ' -f1)
for i in $(seq 1 $count); do
echo "export $(head -$i identities | tail -1)=$(openssl rand -hex 12)" >> passwords
done

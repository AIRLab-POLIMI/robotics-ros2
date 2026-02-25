#!/bin/bash
docker build  --network=host --ssh default -t smentasti/robotics:2026 --push . 


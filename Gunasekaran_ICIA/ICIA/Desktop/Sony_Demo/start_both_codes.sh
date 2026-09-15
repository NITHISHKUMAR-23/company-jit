#!/bin/bash

cd /home/jasminuser/Desktop/Sony_Demo/

#Run the executable
./acs -c /home/jasminuser/Desktop/Sony_Demo/config.json &

sleep 5

#Run the Python script
python main.py --config Jasmin_IN_Demo_AIQ-H-P-U_DPL6-0-0_V03_250516_FINAL_DEMO.prod.interface.json

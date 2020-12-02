#!/bin/bash

rm quarter_plate.dmg quarter_plate.geo

mpicxx make_geo_dmg_pair.cpp -o make_geo_dmg_pair.exe -I/home/pogo/gmodel/install/include -L/home/pogo/gmodel/install/lib -lgmodel

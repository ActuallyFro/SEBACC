#!/bin/bash

echo "{"

#source: https://www.spaceengineerswiki.com/Category:Components
#Bulletproof Glass
./BASH_generate_skcsv_str.sh "jc;bg,si;15"

#Canvas
./BASH_generate_skcsv_str.sh "jc;ca,fe;2,si;35"

#Computer
./BASH_generate_skcsv_str.sh "jc;co,fe;0.5,si;0.2"

#Construction Component
./BASH_generate_skcsv_str.sh "jc;cc,fe;8"

#Detector Components
./BASH_generate_skcsv_str.sh "jc;dc,fe;5,ni;15"

#Display
./BASH_generate_skcsv_str.sh "jc;di,fe;1,si;5"

#Explosives
./BASH_generate_skcsv_str.sh "jc;ex,mg;2,si;0.5"

#Girder
./BASH_generate_skcsv_str.sh "jc;gi,fe;6"

#Gravity Generator Components
./BASH_generate_skcsv_str.sh "jc;gc,co;2200,au;10,fe;600,ag;5"

#Interior Plate
./BASH_generate_skcsv_str.sh "jc;ip,fe;3"

#Large Steel Tube
./BASH_generate_skcsv_str.sh "jc;lt,fe;30"

#Medical Components
./BASH_generate_skcsv_str.sh "jc;mc,fe;60,ni;70,ag;20"

#Metal Grid
./BASH_generate_skcsv_str.sh "jc;mg,co;3,fe;12,ni;5"

#Motor
./BASH_generate_skcsv_str.sh "jc;mo,fe;20,ni;5"

#Power Cell
./BASH_generate_skcsv_str.sh "jc;pc,fe;10,ni;2,si;1"

#Radio-Communication
./BASH_generate_skcsv_str.sh "jc;rc,fe;8,si;1"

#Reactor Components
./BASH_generate_skcsv_str.sh "jc;ec,gravel;20,fe;15,,ag;5"

#Small Steel Tube
./BASH_generate_skcsv_str.sh "jc;st,fe;5"

#Solar Cell
./BASH_generate_skcsv_str.sh "jc;sc,ni;3,si;6"

#Steel Plate
./BASH_generate_skcsv_str.sh "jc;sp,fe;21"

#Superconductor Component
./BASH_generate_skcsv_str.sh "jc;uc,au;2,fe;10"

#Thruster Components
finalStr=`./BASH_generate_skcsv_str.sh "jc;tc,co;10,au;1,fe;30,pt;0.4"`
finalStr=${finalStr%?}
echo "$finalStr"
echo "}"
#!/bin/bash

echo "{"

#source: https://www.spaceengineerswiki.com/Category:Components
#Bulletproof Glass
./BASH_generate_skcsv_str.sh "jc;bg,si;5"

#Canvas
./BASH_generate_skcsv_str.sh "jc;ca,fe;0.67,si;11.67"

#Computer
./BASH_generate_skcsv_str.sh "jc;co,fe;0.17,si;0.07"

#Construction Component
./BASH_generate_skcsv_str.sh "jc;cc,fe;2.67"

#Detector Components
./BASH_generate_skcsv_str.sh "jc;dc,fe;1.67,ni;5"

#Display
./BASH_generate_skcsv_str.sh "jc;di,fe;0.33,si;1.67"

#Explosives
./BASH_generate_skcsv_str.sh "jc;ex,mg;0.67,si;0.17"

#Girder
./BASH_generate_skcsv_str.sh "jc;gi,fe;2.0"

#Gravity Generator Components
./BASH_generate_skcsv_str.sh "jc;gc,co;73.33,au;3.33,fe;200,ag;1.67"

#Interior Plate
./BASH_generate_skcsv_str.sh "jc;ip,fe;1"

#Large Steel Tube
./BASH_generate_skcsv_str.sh "jc;lt,fe;10"

#Medical Components
./BASH_generate_skcsv_str.sh "jc;mc,fe;20,ni;23.33,ag;6.67"

#Metal Grid
./BASH_generate_skcsv_str.sh "jc;mg,co;1,fe;4,ni;1.67"

#Motor
./BASH_generate_skcsv_str.sh "jc;mo,fe;6.67,ni;1.67"

#Power Cell
./BASH_generate_skcsv_str.sh "jc;pc,fe;3.33,ni;0.67,si;0.33"

#Radio-Communication
./BASH_generate_skcsv_str.sh "jc;rc,fe;2.67,si;0.33"

#Reactor Components
./BASH_generate_skcsv_str.sh "jc;ec,gravel;6.67,fe;5,ag;1.67"

#Small Steel Tube
./BASH_generate_skcsv_str.sh "jc;st,fe;1.67"

#Solar Cell
./BASH_generate_skcsv_str.sh "jc;sc,ni;1.0,si;2.0"

#Steel Plate
./BASH_generate_skcsv_str.sh "jc;sp,fe;7"

#Superconductor Component
./BASH_generate_skcsv_str.sh "jc;uc,au;0.67,fe;3.33"

#Thruster Components
finalStr=`./BASH_generate_skcsv_str.sh "jc;tc,co;3.33,au;0.33,fe;10,pt;0.13"`
finalStr=${finalStr%?}
echo "$finalStr"
echo "}"
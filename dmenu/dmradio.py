#!/usr/bin/python3

import sys
import os
import subprocess
from subprocess import PIPE
import json
import argparse




#######################
##  Args & Defaults  ##
#######################

scriptDir = os.path.dirname(os.path.realpath(__file__))
defStations = scriptDir + "/stations.json"

parser = argparse.ArgumentParser(description = "Dmenu/mpd/mpc wrapper for radio streams.")
parser.add_argument("-s", "--stations", dest="stations", action="store", default=defStations, help="json file containing stations as map")

args = parser.parse_args()

stationFile = args.stations

if not os.path.isfile(stationFile):
    sys.exit("Stations file %s does not exist (or is not a file)" % stationFile)

with open(stationFile) as stream:
    stations = json.load(stream)




########################
##  Dmenu & mpc prep  ##
########################

dmenuPrompt = "Station: "

mpcProcess = subprocess.Popen(["mpc", "status", "-f", "%file%"], stdout=PIPE)
currentStation = mpcProcess.stdout.readline().decode("utf-8").strip()
mpcProcess.stdout.close()

for stationName, streamUrl in stations.items():
    if streamUrl == currentStation:
        dmenuPrompt += "[%s]" % stationName
        break


playStr =   "===[ Play ]===="
pauseStr =  "===[ Pause ]==="

dmenuItemList = list(stations)
dmenuItemList.append(playStr) 
dmenuItemList.append(pauseStr)

dmenuInputText = "\n".join(dmenuItemList)

dmenuCmdList = ["dmenu", "-i", "-p", dmenuPrompt, "-l", str(len(dmenuItemList))] 

dmenuEnvArg = os.environ.get('DMENU_ARGS')
if(dmenuEnvArg != None):
    dmenuEnvArgList = dmenuEnvArg.split(' ')
    dmenuCmdList += dmenuEnvArgList



######################
##  Dmenu & mpc IO  ##
######################

dmenuProcess = subprocess.Popen(dmenuCmdList, stdin=PIPE, stdout=PIPE)

dmenuProcess.stdin.write(bytes(dmenuInputText, 'UTF-8'))
dmenuProcess.stdin.close()

station = dmenuProcess.stdout.readline().decode("utf-8").rstrip()
dmenuProcess.stdout.close()

if station in stations:
    subprocess.call(["mpc", "--wait", "clear"])
    subprocess.call(["mpc", "--wait", "add", stations[station]])
    subprocess.call(["mpc", "--wait", "play"])
elif station == pauseStr:
    subprocess.call(["mpc", "pause"])
elif station == playStr:
    subprocess.call(["mpc", "play"])
else:
    exit(1)

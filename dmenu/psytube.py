#!/bin/python

import subprocess
from subprocess import PIPE

stations = {
    'OroChill':         'http://psytube.at:10120/;stream.ogg',
    'Progressive':      'http://psytube.at:12120/;stream.ogg',
    'Dark Progressive': 'http://psytube.at:17120/;stream.ogg',
    'Goa Trance':       'http://psytube.at:9120/;stream.ogg',
    'FullOn':           'http://psytube.at:13120/;stream.ogg',
    'Suomi-Psy':        'http://psytube.at:16120/;stream.ogg',
    'Forest':           'http://psytube.at:15120/;stream.ogg',
    'Dark Psy':         'http://psytube.at:8120/;stream.ogg',
    'HiTech & Core':    'http://psytube.at:18120/;stream.ogg',
    'Drum & Bass':      'http://psytube.at:11120/;stream.ogg',
    'Techno':           'http://psytube.at:19120/;stream.ogg',
    'Minimal':          'http://psytube.at:14120/;stream.ogg',
}

pauseStr =  "===[ Pause ]==="
playStr =   "===[ Play ]===="
dmenuItemList = list(stations)
dmenuItemList.append(pauseStr)
dmenuItemList.append(playStr) 

dmenuInputText = "\n".join(dmenuItemList)
dmenuProcess = subprocess.Popen(["dmenu", "-i", "-p", "Station:", "-l", str(len(dmenuItemList))], stdin=PIPE, stdout=PIPE)
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

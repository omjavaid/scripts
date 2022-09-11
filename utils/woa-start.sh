arguments="$1"

# check if command line argument is empty or not present
if [ -z $1 ]; then
  screen -dmS "WOA1" ssh -p2020 -Snone -L 3394:192.168.17.34:3389 ci.linaro.org
  screen -dmS "WOA2" ssh -p2020 -Snone -L 2222:192.168.17.34:22 ci.linaro.org
else
  screen -dmS "WOA3" ssh -p2020 -Snone -L 3399:192.168.17.39:3389 ci.linaro.org
  screen -dmS "WOA4" ssh -p2020 -Snone -L 2223:192.168.17.39:22 ci.linaro.org
fi




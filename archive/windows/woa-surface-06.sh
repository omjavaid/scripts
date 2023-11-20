# check if command line argument is empty or not present
screen -dmS "WOA60" ssh -p2020 -Snone -L 3396:192.168.17.36:3389 ci.linaro.org
screen -dmS "WOA61" ssh -p2020 -Snone -L 2226:192.168.17.36:22 ci.linaro.org




# check if command line argument is empty or not present
screen -dmS "WOA40" ssh -oStrictHostKeyChecking=no -p2020 -Snone -L 3394:192.168.17.34:3389 ci.linaro.org
screen -dmS "WOA41" ssh -oStrictHostKeyChecking=no -p2020 -Snone -L 2224:192.168.17.34:22 ci.linaro.org




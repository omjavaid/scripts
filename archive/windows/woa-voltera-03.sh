screen -dmS "WOA30" ssh -p2020 -Snone -L 3402:192.168.17.63:3389 ci.linaro.org
screen -dmS "WOA31" ssh -p2020 -Snone -L 2223:192.168.17.63:22 ci.linaro.org


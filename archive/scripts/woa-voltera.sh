if [ -z $1 ]; then
  screen -dmS "WOA20" ssh -p2020 -Snone -L 3403:192.168.17.62:3389 ci.linaro.org
  screen -dmS "WOA21" ssh -p2020 -Snone -L 2222:192.168.17.62:22 ci.linaro.org
else
  screen -dmS "WOA30" ssh -p2020 -Snone -L 3404:192.168.17.63:3389 ci.linaro.org
  screen -dmS "WOA31" ssh -p2020 -Snone -L 2223:192.168.17.63:22 ci.linaro.org
fi


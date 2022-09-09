screen -ls | grep WOA | cut -d. -f1 | awk '{print $1}' | xargs kill

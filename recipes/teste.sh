z=$(curl --silent http://169.254.169.254/latest/meta-data/public-ipv4) 

echo "teste"$z":4440" >> log.txt

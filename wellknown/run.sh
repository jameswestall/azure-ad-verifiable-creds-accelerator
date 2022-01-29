
#sometimes ACI is a bit slow to expose the ports, adding sleep to counter this.
sleep 120

#request a cert
certbot certonly --standalone -d $dnsCname -d $aciHostname -m $adminEmail --agree-tos --no-eff-email

#configure crontab for auto renew of certs
# echo "0 0,12 * * * certbot renew" >> certrenew
# crontab certrenew

# cat /var/log/letsencrypt/letsencrypt.log

#run application
node app.js

#incase node crashes, gives us 5 minutes to see the logs when developing
sleep 300
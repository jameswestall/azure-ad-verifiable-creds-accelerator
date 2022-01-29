#echo env secret to container file
echo $didconfig > didconfig.json

#request a cert
certbot certonly --standalone -d $dnsCname -d $aciHostname -m $adminEmail --agree-tos --no-eff-email

#run application
node app.js
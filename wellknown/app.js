// Lazy hosting of file for Verifiable Credentials Domain Registration

////////////// Node packages
var express = require('express')
var fs = require('fs')
var https = require('https')
const http = require('http');
var session = require('express-session')
var secureRandom = require('secure-random');


//////////// Main Express server function
// Note: You'll want to update port values for your setup.
const app = express()
const port = process.env.PORT || 80;


//should use an environment variable for the below secrets locations.
//Certificate configuration 
const domain = process.env.dnsCname ; 
const private_key_file = '/etc/letsencrypt/live/' + domain + '/privkey.pem';
const privateKey = fs.readFileSync(private_key_file, 'utf8');
const cert_location = '/etc/letsencrypt/live/' + domain +  '/cert.pem';
const certificate = fs.readFileSync(cert_location, 'utf8');
const chain_location = '/etc/letsencrypt/live/' + domain +  '/chain.pem';
const ca = fs.readFileSync(chain_location, 'utf8');

const credentials = {
	key: privateKey,
	cert: certificate,
	ca: ca
};

// Serve static files out of the /public directory
app.use(express.static('public'))

// Starting both http & https servers
const httpServer = http.createServer(app);
const httpsServer = https.createServer(credentials, app);

httpServer.listen(80, () => {
	console.log('HTTP Server running on port 80');
});

httpsServer.listen(443, () => {
	console.log('HTTPS Server running on port 443');
});
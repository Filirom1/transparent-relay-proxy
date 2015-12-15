var http = require('http');
var setup = require('proxy');
var url = require('url');
var net = require('net');
var PacProxyAgent = require('pac-proxy-agent');
var getsockopt = require('./getsockopt')
 
var proxy = process.argv[2]
console.log('using PAC proxy proxy file at %j', proxy);
 


var agent = new PacProxyAgent(proxy, {tunnel: true});

// HTTP(s) Proxy Relay
var server = setup(http.createServer());
server.agent = agent;
server.listen(3128, function () {
  var port = server.address().port;
  console.log('HTTP(s) proxy server listening on port %d', port);
});


// Transparent tunnel TCP-To-Proxy 
var server = net.createServer(onconnection);

function onconnection(socket) {
  var arr = getsockopt.get_original_dst(socket);
  var host = arr[0];
  var port = arr[1];
  if (host == '127.0.0.1') return
  socket.used = true

  // transparent proxy
  agent.callback(server, {host: host, port: port}, function(err, target){
    if(err) return console.log(err)
    target.pipe(socket)
    socket.pipe(target)
  });
}

server.listen(12345);

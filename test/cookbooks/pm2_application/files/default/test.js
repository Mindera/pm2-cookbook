var http = require('http');
var server = http.createServer(function (request, response) {
    response.writeHead(200);
});
server.listen(8000);
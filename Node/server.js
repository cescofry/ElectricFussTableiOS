var redScore = 0;
var blueScore =  0;


var WebSocketServer = require('./index').Server
  , wss = new WebSocketServer({port: 8080});



wss.on('connection', function(ws) {
    ws.on('message', function(message) {
			console.log('received message');
			sendGame(ws);
    });

    console.log('New Connection from : xxx');
});

console.log("Server UP");

// Functions

function sendGame(ws)  {
	try {
		ws.send(currentGame());
	}
	catch (e) {
		console.log("Connection Down: " + e);
		return;
	}


  if (redScore > 10 || blueScore > 10) return;
	
  setTimeout(function(){
    sendGame(ws);
  }, 2000);
	
}


function currentGame() {

	if (randomIntInc(0, 1) == 0) {
		redScore++;	
	}
	else {
		blueScore++;
	}

	return '{"team_1" : {\
	    "score" : '+ redScore +',\
	    "user_1" : {\
	      "mugshot_url" : "https:\/\/mug0.assets-yammer.com\/mugshot\/images\/DbGKPzNWP5ST9xhW5R4Skxr-0H680t3c",\
	      "full_name" : "Francesco Frison"\
	    },\
	    "type" : "red",\
	    "user_2" : {\
	      "mugshot_url" : "https:\/\/mug0.assets-yammer.com\/mugshot\/images\/Rhd3G9PsQHZbl1mcDZqqqKQpsx50f7V9",\
	      "full_name" : "Mario Caropreso"\
	    }\
	  },\
	  "id" : 1,\
	  "final_score" : 10,\
	  "team_2" : {\
	    "score" : 0,\
	    "user_1" : {\
	      "mugshot_url" : "",\
	      "full_name" : "Ray Brooks"\
	    },\
	    "type" : "blue",\
	    "user_2" : {\
	      "mugshot_url" : "https:\/\/mug0.assets-yammer.com\/mugshot\/images\/DkvCd1WQQXk3Q32qGk7F-nhQc3w6Shjl",\
	      "full_name" : "Nick Campbell"\
	    }\
	  }\
	}';
}

function randomIntInc (low, high) {
    return Math.floor(Math.random() * (high - low + 1) + low);
}

	

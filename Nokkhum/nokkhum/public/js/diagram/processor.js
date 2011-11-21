var canvas;
var ctx;
var x = 0;
var y = 0;

// constance
var grid_start_x = 130;
var grid_start_y = 10;
var grid_width = 150;
var grid_height = 90;
var WIDTH = 800;
var HEIGHT = 600;

var dragok = false;

function rect(x,y,w,h) {
 	ctx.beginPath();
 	ctx.rect(x,y,w,h);
 	ctx.closePath();
 	ctx.fill();
}

function clear() {
 	ctx.clearRect(0, 0, WIDTH, HEIGHT);
}

function drawBackground(){
	ctx.fillStyle = "#ffffcc";
	rect(0,0,WIDTH,HEIGHT);
}

function drawArrow(fromx, fromy, tox, toy){

    var headlen = 10;   // length of head in pixels
    var angle = Math.atan2(toy-fromy,tox-fromx);
    ctx.beginPath();
    ctx.moveTo(fromx, fromy);
    ctx.lineTo(tox, toy);
    ctx.lineTo(tox-headlen*Math.cos(angle-Math.PI/6),toy-headlen*Math.sin(angle-Math.PI/6));
   	ctx.moveTo(tox, toy);
    ctx.lineTo(tox-headlen*Math.cos(angle+Math.PI/6),toy-headlen*Math.sin(angle+Math.PI/6));
    ctx.closePath();
    
    ctx.lineWidth = 2;
    ctx.strokeStyle = "#ff0000"; // line color
    ctx.stroke();
}

function drawProcessor(name, x, y, color) {
	var box_width	= 100;
	var box_height  = 60;
	
	ctx.fillStyle = color;
	ctx.beginPath();
 	ctx.rect(x, y, box_width, box_height);
 	ctx.closePath();
 	ctx.fill();
 	
 	ctx.strokeStyle = "#000000";
 	ctx.lineWidth = 2;
 	ctx.stroke();
 	
 	ctx.fillStyle = "#000000";
 	ctx.font = "14pt Calibri";
 	ctx.textAlign = "center";
 	ctx.textBaseline = "middle";
 	
 	if(name == "Motion Detector"){
 		ctx.fillText("Motion", box_width/2, box_height/3);
 		ctx.fillText("Detector", box_width/2, 2*box_height/3);
 	}
 	else if(name == "Face Detector"){
 		ctx.fillText("Face", box_width/2, box_height/3);
 		ctx.fillText("Detector", box_width/2, 2*box_height/3);
 	}
 	else if(name == "Image Recorder"){
 		ctx.fillText("Image", box_width/2, box_height/3);
 		ctx.fillText("Recorder", box_width/2, 2*box_height/3);
 	}
 	else if(name == "Video Recorder"){
 		ctx.fillText("Video", box_width/2, box_height/3);
 		ctx.fillText("Recorder", box_width/2, 2*box_height/3);
 	}
}

function drawCamera(name, x, y, color) {
	var box_width	= 60;
	var box_height  = 40;
	var gap = 12;
	
	ctx.fillStyle = color;
	ctx.beginPath();
 	ctx.rect(x+gap, y, box_width+gap, box_height);
 	var small_box_height = gap+10;
 	ctx.rect(x, box_height/2-small_box_height/2, gap, small_box_height);
 	ctx.closePath();
 	ctx.fill();
 	
 	ctx.fillStyle = "#000000";
 	ctx.stroke();
 	
 	ctx.font = "14pt Calibri";
 	ctx.textAlign = "center";
 	ctx.fillText(name, (box_width+gap)/2, box_height+20);
}


function myMove(e){
	if (dragok){
		x = e.pageX - canvas.offsetLeft;
		y = e.pageY - canvas.offsetTop;
  		message = "move to x = " + x + " y = " + y;
 	}
}

function myUp(){
 	dragok = false;
 	canvas.onmousemove = null;
}

function myOut(){
 	dragok = false;
 	canvas.onmousemove = null;
}

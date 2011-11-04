<%inherit file="../base/base.mako"/>

<%def name="title()" >
Setting camera of ${camera.name}
</%def>

<%def name="body()">
<h2>Camera infomation</h2>
<ul>
	<li><strong>Camera: </strong>${camera.name}</li>
	<li><strong>Create Date: </strong>${camera.create_date}</li>
	<li><strong>Setting: </strong>
		<a href="/cameras/${camera.name}/processor">Image Processor Setting</a>
	</li>
</ul>
<p>
<strong>Current Image Processor:</strong>
</p>
<p>
	${camera.processors}
</p>

<section>
	<div>
	<canvas id="display_processor" width="800" height="600" style="border:1px solid #c3c3c3;">
		This text is displayed if your browser does not support HTML5 Canvas.
	</canvas>

<script type="text/javascript" src="/js/jquery-1.6.4.min.js"></script>
<script type="text/javascript">

var canvas;
var ctx;
var x = 0;
var y = 0;

// constance
var grid_start_x = 10;
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
 	ctx.lineWidth = 1;
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

function init() {
	canvas = $("canvas#display_processor")[0]
 	ctx = canvas.getContext("2d");
 	WIDTH = $("canvas#display_processor").width();
 	HEIGHT = $("canvas#display_processor").height();
 	
 	drawBackground();
 	 	
 	ctx.save()
 	ctx.translate(grid_start_x, grid_start_y);
 	drawCamera("test", 0, 0, "#3333ff");
 	ctx.restore();
 	
 	ctx.save(); 
 	ctx.translate(grid_width + grid_start_x, grid_start_y);
 	drawProcessor("Motion Detector", 0, 0, "#ccffff");
 	ctx.restore();
 	
 	ctx.save(); 
 	ctx.translate(grid_width*2 + grid_start_x, grid_start_y);
 	drawProcessor("Face Detector", 0, 0, "#ccffff");
 	ctx.restore();
 	
 	ctx.save(); 
 	ctx.translate(grid_width + grid_start_x, grid_height + grid_start_y);
 	drawProcessor("Image Recorder", 0, 0, "#ccffff");
 	ctx.restore();
 	
 	ctx.save(); 
 	ctx.translate(grid_width*2 + grid_start_x, grid_height + grid_start_y);
 	drawProcessor("Video Recorder", 0, 0, "#ccffff");
 	ctx.restore();
 	
 	ctx.save(); 
 	drawArrow(grid_width + grid_start_x+100, grid_height + grid_start_y+30,
 			grid_width*2 + grid_start_x, grid_height + grid_start_y+30);
 	ctx.restore();
 	//return setInterval(drawBackground, 10);
}

$(document).ready(init())

//canvas.onmousedown = myDown;
//canvas.onmouseup = myUp;
//canvas.onmouseout = myOut;

</script>

	</div>
</section>

<div id="test1"></div>
end
</%def>
<%inherit file="../base/base.mako"/>
<%! import json %>
<%block name='title'>Setting camera of ${camera.name}</%block>
<h2>Camera infomation</h2>
<ul>
	<li><strong>Camera: </strong>${camera.name}</li>
	<li><strong>URL: </strong>${camera.url}</li>
	<li><strong>FPS: </strong>${camera.fps}</li>
	<li><strong>Image Size: </strong>${camera.image_size}</li>
	<li><strong>Create Date: </strong>${camera.create_date}</li>
	<li><strong>Last Update: </strong>${camera.update_date}</li>
	<li><strong>Operating: </strong>${camera.operating.status}, last update: ${camera.operating.update_date}</li>
	<li><strong>Setting: </strong>
		<a href="${request.route_path('camera_processor', name=camera.name)}">Image Processor Setting</a>
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
<script type="text/javascript" src="/js/diagram/processor.js"></script>
<script type="text/javascript">
var arow_begin_x = 0;
var arow_begin_y = 0;

var max_index_y = 0;

function drawProcessors(processor, index_x, index_y){
	ctx.save(); 
	var x = grid_width*index_x + grid_start_x;
	var y = grid_height*index_y + grid_start_y;
 	ctx.translate(x, y);
 	drawProcessor(processor["name"], 0, 0, "#ccffff");
 	ctx.restore();
 	if( arow_begin_x!=0 && arow_begin_y!=0 ){
 		drawArrow(arow_begin_x, arow_begin_y,
 	 			x, y+30);
 		arow_begin_x = 0;
 		arow_begin_y = 0;
 	}
 	
 	index_x++;
 	for( var index in processor.processors){
 		arow_begin_x =x + 100;
 		arow_begin_y = y+30;
 		drawProcessors(processor.processors[index], index_x, index_y);
 		if(index_y > max_index_y){
 			max_index_y = index_y;
 		}
 		index_y++;
 	 	//arow_begin_x = 10+80;
 	 	//arow_begin_y = grid_start_y+20;
 	}

}

function init() {
	canvas = $("canvas#display_processor")[0]
 	ctx = canvas.getContext("2d");
 	WIDTH = $("canvas#display_processor").width();
 	HEIGHT = $("canvas#display_processor").height();
 	
 	var processor_json = ${json.dumps(camera.processors) | n};
 	
 	drawBackground();
 	 	
 	ctx.save();
 	ctx.translate(10, grid_start_y+10);
 	drawCamera("${camera.name}", 0, 0, "#3333ff");
 	ctx.restore();
 	
 	var index_x = 0;
 	var index_y = 0;
 	
 	arow_begin_x = 10+80;
 	arow_begin_y = grid_start_y+30;
 	
 	for( var index in processor_json){
 		drawProcessors(processor_json[index], index_x, index_y);
 	 	index_x = 0;
 	 	index_y = ++max_index_y;
 	 	arow_begin_x = 10+80;
 	 	arow_begin_y = grid_start_y+30;
 	}
 	
 	/*
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
 	*/
 	//return setInterval(drawBackground, 10);
}

$(document).ready(init());

//canvas.onmousedown = myDown;
//canvas.onmouseup = myUp;
//canvas.onmouseout = myOut;

</script>

	</div>
</section>

<div id="test1"></div>
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
<script type="text/javascript" src="/js/diagram/processor.js"></script>
<script type="text/javascript">
function init() {
	canvas = $("canvas#display_processor")[0]
 	ctx = canvas.getContext("2d");
 	WIDTH = $("canvas#display_processor").width();
 	HEIGHT = $("canvas#display_processor").height();
 	
 	processor_json = ${camera.processors}
 	
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
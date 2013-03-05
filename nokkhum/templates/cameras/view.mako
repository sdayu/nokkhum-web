<%inherit file="/base/base.mako"/>
<%! import json, datetime %>
<%block name='title'>Setting camera of ${camera.name}</%block>
<%block name='addition_header'>
<link href="/js/syntax_highlighter/styles/shThemeDefault.css" rel="stylesheet" type="text/css" />
<script src="/js/syntax_highlighter/scripts/XRegExp.js" type="text/javascript"></script>
<script src="/js/syntax_highlighter/scripts/shCore.js" type="text/javascript"></script>
<script src="/js/syntax_highlighter/scripts/shBrushJScript.js" type="text/javascript"></script>
<script language="javascript">
SyntaxHighlighter.defaults['smart-tabs'] = false;
SyntaxHighlighter.all();
</script>
</%block>
<h2>Camera infomation</h2>
<ul>
	<li><strong>Camera: </strong>${camera.name}</li>
	<li><strong>URL: </strong>${camera.video_url}</li>
	<li><strong>Username: </strong>${camera.username}</li>
	<li><strong>Password: </strong>${camera.password}</li>
	<li><strong>FPS: </strong>${camera.fps}</li>
	<li><strong>Image Size: </strong>${camera.image_size}</li>
	<li><strong>Camera Model: </strong>${camera.camera_model.name}</li>
	<li><strong>Manufatory: </strong>${camera.camera_model.manufactory.name}</li>
	<li><strong>Create Date: </strong>${camera.create_date}</li>
	<li><strong>Last Update: </strong>${camera.update_date}</li>
	<li><strong>Keep Record: </strong>${camera.storage_periods} day</li>
	<li><strong>Operating:</strong>
		<ul>
			<li><strong>user status: <span style="color: red;">${camera.operating.user_command}</span></strong></li>
			<li><strong>status: <span style="color: red;">${camera.operating.status}</span></strong></li>
			<li><strong>last update:</strong> ${camera.operating.update_date}</li>
			<li><strong>diff time:</strong> <span style="color: red;">${(datetime.datetime.now()-camera.operating.update_date).seconds}</span> seconds ago</li>
		</ul>
	</li>
	<li><strong>Setting: </strong>
		<a href="${request.route_path('cameras.processor', camera_id=camera.id)}">Image Processor Setting</a>
	</li>
</ul>
<p>
<strong>Current Image Processor:</strong>
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
 	
 	var processor_json = ${json.dumps(camera.processors) | n};
 	
 	drawCameraAttribute("${camera.name}", processor_json)
 	 	
}

$(document).ready(init());

</script>

	</div>
</section>

<div id="test1"></div>
<p>JSON Description</p>
<pre name="code" class="brush: js; toolbar: false;">
	${json.dumps(camera.processors, indent=4)}
</pre>

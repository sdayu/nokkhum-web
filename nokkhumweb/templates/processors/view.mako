<%inherit file="/base/base.mako"/>
<%! import json, datetime %>
<%block name='title'>Processor: ${processor.name}</%block>
<%block name='addition_header'>
## codemirror2 for html editor
<link rel="stylesheet" href="/libs/codemirror/lib/codemirror.css">
<script src="/libs/codemirror/lib/codemirror.js"></script>
<script src="/libs/codemirror/addon/runmode/runmode.js"></script>
<script src="/libs/codemirror/mode/xml/xml.js"></script>
<script src="/libs/codemirror/mode/javascript/javascript.js"></script>
<script src="/libs/codemirror/mode/css/css.js"></script>
<script src="/libs/codemirror/mode/htmlmixed/htmlmixed.js"></script>
</%block>

<h2>Processor information</h2>
<ul>
	<li><strong>Name: </strong>${processor.name}</li>
	<li><strong>ID: </strong>${processor.id}</li>
	<li><strong>Camera: </strong>
	% for camera in processor.cameras:
		<a href="${request.route_path('cameras.view', project_id=project.id, camera_id=camera.id)}">${camera.name}</a>
	% endfor
	</li>
	<li><strong>Create Date: </strong>${processor.create_date}</li>
	<li><strong>Last Update: </strong>${processor.update_date}</li>
	<li><strong>Keep Record: </strong>${processor.storage_period} day</li>
	<li><strong>Operating:</strong>
		<ul>
			<li><strong>user status: <span style="color: red;">${processor.operating.user_command}</span></strong></li>
			<li><strong>status: <span style="color: red;">${processor.operating.status}</span></strong></li>
			<li><strong>last update:</strong> ${processor.operating.update_date}</li>
			<li><strong>diff time:</strong> <span style="color: red;">${(datetime.datetime.now()-processor.operating.update_date).seconds}</span> seconds ago</li>
		</ul>
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

<script type="text/javascript" src="/libs/jquery/jquery-2.0.3.js"></script>
<script type="text/javascript" src="/js/diagram/processor.js"></script>
<script type="text/javascript">
function init() {
	canvas = $("canvas#display_processor")[0]
 	ctx = canvas.getContext("2d");
 	WIDTH = $("canvas#display_processor").width();
 	HEIGHT = $("canvas#display_processor").height();
 	
 	var processor_json = ${json.dumps(processor.image_processors) | n};
 	
 	drawCameraAttribute("${processor.name}", processor_json)
 	 	
}

$(document).ready(init());

</script>

	</div>
</section>

<div id="test1"></div>
<p>JSON Description</p>
<pre name="code" class="brush: js; toolbar: false;">
	${json.dumps(processor.image_processors, indent=4)}
</pre>

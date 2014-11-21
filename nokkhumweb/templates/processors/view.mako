<%inherit file="/base/panel.mako"/>
<%! import json, datetime %>
<%block name='title'>Processor: ${processor.name}</%block>

<%block name='addition_header'>
## codemirror2 for html editor
<link rel="stylesheet" href="/public/bower_components/codemirror/lib/codemirror.css">
<script src="/public/bower_components/codemirror/lib/codemirror.js"></script>
<script src="/public/bower_components/codemirror/addon/runmode/runmode.js"></script>
<script src="/public/bower_components/codemirror/mode/xml/xml.js"></script>
<script src="/public/bower_components/codemirror/mode/javascript/javascript.js"></script>
<script src="/public/bower_components/codemirror/mode/css/css.js"></script>
<script src="/public/bower_components/codemirror/mode/htmlmixed/htmlmixed.js"></script>
</%block>


<%block name="where_am_i">
<li><a href="${request.route_path('projects.index', project_id=request.matchdict['project_id'])}">Projects</a></li>
<li><a href="${request.route_path('processors.index', project_id=request.matchdict['project_id'])}">Processors</a></li>
</%block>
<%block name='panel_title'>Processor information</%block>

<ul>
	<li><b>Name: </b>${processor.name}</li>
	<li><b>ID: </b>${processor.id}</li>
	<li><b>Camera: </b>
	% for camera in processor.cameras:
		<a href="${request.route_path('cameras.view', project_id=project.id, camera_id=camera.id)}">${camera.name}</a>
	% endfor
	</li>
	<li><b>Create Date: </b>${processor.created_date}</li>
	<li><b>Last Update: </b>${processor.updated_date}</li>
	<li><b>Keep Record: </b>${processor.storage_period} day</li>
	<li><b>Operating:</b>
		<ul>
			<li><b>user status: <span style="color: red;">${processor.operating.user_command}</span></b></li>
			<li><b>status: <span style="color: red;">${processor.operating.status}</span></b></li>
			<li><b>last update:</b> ${processor.operating.updated_date}</li>
			<li><b>diff time:</b> <span style="color: red;">${(datetime.datetime.now()-processor.operating.updated_date).seconds}</span> seconds ago</li>
		</ul>
	</li>
	% if request.has_permission('admin'):
	<li><b>Process Status: </b><a href="${request.route_path('admin.processors.show', processor_id=processor.id)}">view</a></li>
	% endif
</ul>
<p>
<b>Current Image Processor:</b>
</p>
<section>
	<div>
	<canvas id="display_processor" width="800" height="600" style="border:1px solid #c3c3c3;">
		This text is displayed if your browser does not support HTML5 Canvas.
	</canvas>

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
<pre name="code" id="image_processors">
${json.dumps(processor.image_processors, indent=4)}
</pre>

<script>
      $('#image_processors').each(function(index, e) {
          $(e).addClass('cm-s-default'); // apply a theme class
          CodeMirror.runMode($(e).text(), "javascript", $(e)[0]);
      });
</script>

<%inherit file="/base/panel.mako"/>
<%block name='title'>Processor Adding</%block>
<%block name='panel_title'>Processor Adding</%block>

<%block name="addition_header">
## codemirror2 for html editor
<link rel="stylesheet" href="/libs/codemirror/lib/codemirror.css">
<script src="/libs/codemirror/lib/codemirror.js"></script>
<script src="/libs/codemirror/addon/runmode/runmode.js"></script>
<script src="/libs/codemirror/mode/xml/xml.js"></script>
<script src="/libs/codemirror/mode/javascript/javascript.js"></script>
<script src="/libs/codemirror/mode/css/css.js"></script>
<script src="/libs/codemirror/mode/htmlmixed/htmlmixed.js"></script>

<style>. {border-top: 1px solid black; border-bottom: 1px solid black;}</style>

</%block>

<%block name="whare_am_i">
<li><a href="${request.route_path('projects.index', project_id=request.matchdict['project_id'])}">Projects</a></li>
<li><a href="${request.route_path('processors.index', project_id=request.matchdict['project_id'])}">Processors</a></li>
</%block>

<form role="form" action="${request.current_route_path()}" method="POST">
	<div class="form-group">
		<label for="processor_name">Name</label>
		${form.name(class_='form-control', id='processor_name', placeholder='Enter processor name')}
		${form.get_error('name')}
	</div>
 	<div class="form-group">
		<label for="camera">Camera</label>
		${form.camera(class_='form-control')}
		${form.get_error('camera')}
	</div>
	<div class="form-group">
		<label for="storage_period">Storage period (days)</label>
		${form.storage_period(class_='form-control', id='storage_period', value='30', min='0', max='360')}
		${form.get_error('storage_period')}
	</div>
	<div class="form-group">
		<label for="image_processor">Image Processor Configuration</label>
		${form.image_processors(class_='form-control')}
		${form.get_error('image_processors')}
	</div>
 
 	<button type="submit" class="btn btn-default">Submit</button>
</form>

<%include file="/base/image_processor.mako"/>

<script>
      var editor = CodeMirror.fromTextArea(document.getElementById("image_processors"), {mode: "javascript", tabMode: "indent", lineNumbers: true});
	
      $('#avialable_image_processors').each(function(index, e) {
          $(e).addClass('cm-s-default'); // apply a theme class
          CodeMirror.runMode($(e).text(), "javascript", $(e)[0]);
      });
</script>
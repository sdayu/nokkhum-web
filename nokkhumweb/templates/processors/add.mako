<%inherit file="/base/panel.mako"/>
<%block name='title'>Processor Adding</%block>
<%block name='panel_title'>Processor Adding</%block>

<%block name="whare_am_i">
<li><a href="${request.route_path('projects.index', project_id=project.id)}">Project</a></li>
<li><a href="#">Processor</a></li>
</%block>

<form role="form" action="${request.current_route_path()}" method="POST">
	<div class="form-group">
		<label for="processor_name">Name</label>
		<input type="text" name="name" class="form-control" id="processor_name" placeholder="Enter processor name">
	</div>
 	<div class="form-group">
		<label for="camera">Camera</label>
		<select name="camera" class="form-control">
			<option>Camera 1</option>
			<option>Camera 2</option>
			<option>Camera 3</option>
			<option>Camera 4</option>
			<option>Camera 5</option>
		</select>
	</div>
	<div class="form-group">
		<label for="storage_period">Storage period (days)</label>
		<input type="number" name="storage_period" class="form-control" id="storage_period" value="30" min="0" max="360">
	</div>
	<div class="form-group">
		<label for="image_processor">Image Processor Configuration</label>
		<textarea class="form-control" id="image_processor" placeholder="Configurate image processor"></textarea>
	</div>
 
 	<button type="submit" class="btn btn-default">Submit</button>
</form>
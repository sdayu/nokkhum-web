<%inherit file="/base/panel.mako"/>
<%block name='title'>Add camera</%block>
<%block name='panel_title'>Camera Adding</%block>

<%block name='addition_header'>
<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){

	$('#camera_man').change(function(){
		$.ajax({
			url: "${request.nokkhum_client.http_client.api_url}"+"/manufactories/"+$(this).val()+"/models"
		})
		.done(function(data, status) {
			var camera_model = null;
			var options = $("#camera_model").prop('options');
			options.length = 0;
			for (var i = 0; i < data.camera_models.length; ++i) {
				options[options.length] = new Option(data.camera_models[i].name, data.camera_models[i].id);
			}
		});
				
	});
});
</script>
</%block>

<%block name="whare_am_i">
<li><a href="${request.route_path('projects.index', project_id=request.matchdict['project_id'])}">Project</a></li>
<li><a href="#">Camera</a></li>
</%block>


<form action="${request.current_route_path()}" method="POST" >
	<div class="form-group">
    	<label for="name">Name: </label>
    	${form.name(class_="form-control", id="camera_name", placeholder="Enter camera name")} ${form.get_error("name")}
    </div>
    <div class="form-group">
    	<label for="uri">URI: </label>
    	${form.uri(class_="form-control", id="uri", placeholder="URI")} ${form.get_error("url")}
    </div >
    <div class="form-group">
    	<label for="host">Host: </label>
    	${form.host(class_="form-control", id="host", placeholder="Enter host name")} ${form.get_error("host")}
    </div>
    <div class="form-group">
    	<label for="port">port: </label>
    	${form.port(class_="form-control", id="port", placeholder="Enter camera port")} ${form.get_error("port")}
    </div>
    <div class="form-group">
    	<label for="username">Username: </label>
    	${form.username(class_="form-control", id="username", placeholder="Enter username")} ${form.get_error("username")}
    </div>
    <div class="form-group">
    	<label for="password">Password: </label>
    	${form.password(class_="form-control", id="password", placeholder="Enter password")} ${form.get_error("password")}
    </div>
    <div class="form-group">
    	<label for="fps">fps: </label>
    	<div class="field">${form.fps(class_="form-control", id="fps")} ${form.get_error("fps")}</div>
    </div>
    <div class="form-group">
    	<label for="image_size">Image size: </label>
    	<div class="field">${form.image_size(class_="form-control", id="image_size")} ${form.get_error("image_size")}</div>
    </div>
    <div class="form-group">
    	<label for="camera_man">Manufactory: </label>
    	<div class="field">${form.camera_man(class_="form-control", id="camera_man")} ${form.get_error("camera_man")}</div>
    </div>
    
    <div class="form-group">
    	<label for="camera_model">Model: </label>
    	<div class="field">${form.camera_model(class_="form-control", id="camera_model")} ${form.get_error("camera_model")}</div>
    </div>

<div class="form-group">
    <input type="submit" value="Submit"/>
</div>
</form>

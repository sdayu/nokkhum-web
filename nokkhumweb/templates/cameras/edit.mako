<%inherit file="/base/panel.mako"/>
<%block name='title'>Edit Camera</%block>
<%block name='panel_title'>Edit camera name: ${camera.name}</%block>

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

<form for="form" action="${request.current_route_path()}" method="POST">
    <div class="form-group">
    	<label for="name">Name: </label>
    	${form.name(class_="form-control", placeholder="Enter camera name")} ${form.get_error("name")}
    </div>
    <div class="form-group">
    	<label for="uri">URI: </label>
    	${form.uri(class_="form-control", placeholder="Enter URI")} ${form.get_error("uri")}
    </div>
    <div class="form-group">
    	<label for="host">Host: </label>
    	${form.host(class_="form-control", placeholder="Enter host ip")} ${form.get_error("host")}
    </div>
    <div class="form-group">
    	<label for="port">port: </label>
    	${form.port(class_="form-control", placeholder="Enter port")} ${form.get_error("port")}
    </div>
    <div class="form-group">
    	<label for="username">Username: </label>
    	${form.username(class_="form-control", placeholder="Enter password")} ${form.get_error("username")}
    </div>
    <div class="form-group">
    	<label for="password">Password: </label>
    	${form.password(class_="form-control", placeholder="Enter confirm password")} ${form.get_error("password")}
    </div>
    <div class="form-group">
    	<label for="fps">fps: </label>
    	${form.fps(class_="form-control")} ${form.get_error("fps")}
    </div>
    <div class="form-group">
    	<label for="image_size">Image size: </label>
    	${form.image_size(class_="form-control")} ${form.get_error("image_size")}
    </div>
    <div class="form-group">
    	<label for="camera_man">Manufactory: </label>
    	${form.camera_man(class_="form-control")} ${form.get_error("camera_man")}
    </div>
    <div class="form-group">
    	<label for="camera_model">Model: </label>
    	${form.camera_model(class_="form-control")} ${form.get_error("camera_model")}
    </div>
    <div class="form-group">
    	<label for="location">Location: </label>
    	<div class="field">${form.location(class_="form-control", placeholder="Enter locattion: latitude, longitude / 7.0073213, 100.5021036")} ${form.get_error("location")} </div>
    </div>
    

	<div style="width: 100px; text-align: right; padding-top: 50px">
	    <input type="submit" value="Edit" />
	</div>
</form>

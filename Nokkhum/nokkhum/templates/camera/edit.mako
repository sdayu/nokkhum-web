<%inherit file="/base/base.mako"/>
<%block name='title'>Edit Camera</%block>
<style type="text/css">
	div.block {
		width: 370px; 
		text-align: right;
	}
	div.block2 {
		width: 350px; 
		text-align: right; 
		clear: both;
	}
	div.label {
		width:110px; 
		float:left;
	}
	div.field {
		float:left;
		padding-left: 5px;
	}
</style>
<h2>Edit camera name: ${camera.name}</h2>
<% 	
	model_options = []
	for model in camera_models:
		model_options.append((model.name, model.name))
	
	camera_man = []
	for man in manufactories:
		camera_man.append((man.name, man.name))
		
	image_size = ['320x240', '640x480']
	
	fps = [
		'1', '2', '4', '5', '6', '8', '10',
		'12', '14', '15', '16', '18', '20', '22',
		'24', '26', '28', '30'
		]
	camera_status_list = ["Active", "Suspend"]
%>

${renderer.begin(request.route_path('camera_edit', name=camera.name))}
<div class="field">
    ${renderer.errorlist("name")}
    <div class="block">
    	<label for="name">Name: </label>
    	${renderer.text("name", size=30, value=camera.name)}
    </div>
    ${renderer.errorlist("url")}
    <div class="block">
    	<label for="url">URL: </label>
    	${renderer.text("url", size=30, value=camera.url)}
    </div>
    ${renderer.errorlist("username")}
    <div class="block">
    	<label for="username">Username: </label>
    	${renderer.text("username", size=30, value=camera.username)}
    </div>
    ${renderer.errorlist("password")}
    <div class="block">
    	<label for="password">Password: </label>
    	${renderer.text("password", size=30, value=camera.password)}
    </div>
    ${renderer.errorlist("fps")}
    <div class="block2">
    	<div class="label"><label for="fps">fps: </label></div>
    	<div class="field">${renderer.select('fps', fps, camera.fps)}</div>
    </div>
    ${renderer.errorlist("image_size")}
    <div class="block2">
    	<div class="label"><label for="image_size">Image size: </label></div>
    	<div class="field">${renderer.select('image_size', image_size, camera.image_size)}</div>
    </div>
    ${renderer.errorlist("camera_man")}
    <div class="block2">
    	<div class="label"><label for="camera_man">Manufactory: </label></div>
    	<div class="field">${renderer.select('camera_man', camera_man, )}</div>
    </div>
    ${renderer.errorlist("camera_model")}
    <div class="block2">
    	<div class="label"><label for="camera_model">Model: </label></div>
    	<div class="field">${renderer.select('camera_model', model_options, camera.camera_model.name)}</div>
    </div>
    ${renderer.errorlist("camera_status")}
    <div class="block2">
    	<div class="label"><label for="camera_model">Status: </label></div>
    	<div class="field">${renderer.select('camera_status', camera_status_list, camera.status)}</div>
    </div>
</div>

<div style="width: 100px; text-align: right; padding-top: 50px">
    ${renderer.submit("submit", "Edit")}
</div>
${renderer.end()}

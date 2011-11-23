<%inherit file="/base/base.mako"/>
<%block name='title'>Add camera</%block>
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
<h2>Add camera</h2>
<% 	
	modelOptions = []
	for model in camera_models:
		modelOptions.append((model.name, model.name))
	
	cameraMan = []
	for man in manufactories:
		cameraMan.append((man.name, man.name))
		
	imageSize = ['320x240', '640x480']
	
	fps = [
		'1', '2', '4', '5', '6', '8', '10',
		'12', '14', '15', '16', '18', '20', '22',
		'24', '26', '28', '30'
		]
%>

${renderer.begin(request.route_path('camera_add'))}
<div class="field">
    ${renderer.errorlist("name")}
    <div class="block">
    	<label for="name">Name: </label>
    	${renderer.text("name", size=30)}
    </div>
    ${renderer.errorlist("url")}
    <div class="block">
    	<label for="url">URL: </label>
    	${renderer.text("url", size=30)}
    </div>
    ${renderer.errorlist("username")}
    <div class="block">
    	<label for="username">Username: </label>
    	${renderer.text("username", size=30)}
    </div>
    ${renderer.errorlist("password")}
    <div class="block">
    	<label for="password">Password: </label>
    	${renderer.text("password", size=30)}
    </div>
    ${renderer.errorlist("fps")}
    <div class="block2">
    	<div class="label"><label for="fps">fps: </label></div>
    	<div class="field">${renderer.select('fps',fps)}</div>
    </div>
    ${renderer.errorlist("image_size")}
    <div class="block2">
    	<div class="label"><label for="image_size">Image size: </label></div>
    	<div class="field">${renderer.select('image_size',imageSize)}</div>
    </div>
    ${renderer.errorlist("camera_man")}
    <div class="block2">
    	<div class="label"><label for="camera_man">Manufactory: </label></div>
    	<div class="field">${renderer.select('camera_man',cameraMan)}</div>
    </div>
    ${renderer.errorlist("camera_model")}
    <div class="block2">
    	<div class="label"><label for="camera_model">Model: </label></div>
    	<div class="field">${renderer.select('camera_model',modelOptions)}</div>
    </div>
</div>

<div style="width: 100px; text-align: right; padding-top: 50px">
    ${renderer.submit("submit", "Submit")}
</div>
${renderer.end()}

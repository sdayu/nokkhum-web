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

${form_renderer.begin(request.current_route_path())}
<div class="field">
    ${form_renderer.get_error("name")}
    <div class="block">
    	<label for="name">Name: </label>
    	${form_renderer.text("name", size=30)}
    </div>
    ${form_renderer.get_error("url")}
    <div class="block">
    	<label for="url">URL: </label>
    	${form_renderer.text("url", size=30)}
    </div>
    ${form_renderer.get_error("username")}
    <div class="block">
    	<label for="username">Username: </label>
    	${form_renderer.text("username", size=30)}
    </div>
    ${form_renderer.get_error("password")}
    <div class="block">
    	<label for="password">Password: </label>
    	${form_renderer.text("password", size=30)}
    </div>
    ${form_renderer.get_error("fps")}
    <div class="block2">
    	<div class="label"><label for="fps">fps: </label></div>
    	<div class="field">${form_renderer.select('fps', fps)}</div>
    </div>
    ${form_renderer.get_error("image_size")}
    <div class="block2">
    	<div class="label"><label for="image_size">Image size: </label></div>
    	<div class="field">${form_renderer.select('image_size',imageSize)}</div>
    </div>
    ${form_renderer.get_error("camera_man")}
    <div class="block2">
    	<div class="label"><label for="camera_man">Manufactory: </label></div>
    	<div class="field">${form_renderer.select('camera_man',cameraMan)}</div>
    </div>
    ${form_renderer.get_error("camera_model")}
    <div class="block2">
    	<div class="label"><label for="camera_model">Model: </label></div>
    	<div class="field">${form_renderer.select('camera_model',modelOptions)}</div>
    </div>
    ${form_renderer.get_error("storage_periods")}
    <div class="block2">
    	<div class="label"><label for="keep_record">Record Store: </label></div>
    	<div class="field">${form_renderer.text('storage_periods')} day</div>
    </div>
</div>

<div style="width: 100px; text-align: right; padding-top: 50px">
    ${form_renderer.submit("submit", "Submit")}
</div>
${form_renderer.end()}

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

<form action="${request.current_route_path()}" method="POST">
<div class="field">
    ${form.get_error("name")}
    <div class="block">
    	<label for="name">Name: </label>
    	${form.name(size=30, value=camera.name)}
    </div>
    ${form.get_error("url")}
    <div class="block">
    	<label for="url">URL: </label>
    	${form.url(size=30, value=camera.url)}
    </div>
    ${form.get_error("username")}
    <div class="block">
    	<label for="username">Username: </label>
    	${form.username(size=30, value=camera.username)}
    </div>
    ${form.get_error("password")}
    <div class="block">
    	<label for="password">Password: </label>
    	${form.password(size=30, value=camera.password)}
    </div>
    ${form.get_error("fps")}
    <div class="block2">
    	<div class="label"><label for="fps">fps: </label></div>
    	<div class="field">${form.fps}</div>
    </div>
    ${form.get_error("image_size")}
    <div class="block2">
    	<div class="label"><label for="image_size">Image size: </label></div>
    	<div class="field">${form.image_size}</div>
    </div>
    ${form.get_error("camera_man")}
    <div class="block2">
    	<div class="label"><label for="camera_man">Manufactory: </label></div>
    	<div class="field">${form.camera_man}</div>
    </div>
    ${form.get_error("camera_model")}
    <div class="block2">
    	<div class="label"><label for="camera_model">Model: </label></div>
    	<div class="field">${form.camera_model}</div>
    </div>
    ${form.get_error("camera_status")}
    <div class="block2">
    	<div class="label"><label for="camera_model">Status: </label></div>
    	<div class="field">${form.camera_status}</div>
    </div>
    ${form.get_error("storage_periods")}
    <div class="block2">
    	<div class="label"><label for="keep_record">Record Store: </label></div>
    	<div class="field">${form.storage_periods(value=camera.storage_periods)} day</div>
    </div>
</div>

<div style="width: 100px; text-align: right; padding-top: 50px">
    <input type="submit" value="Edit" />
</form>

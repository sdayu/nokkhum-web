<%inherit file="/base/panel.mako"/>
<%block name='title'>Show Camera</%block>
<%! import datetime %>

<%block name="where_am_i">
<li><a href="${request.route_path('admin.home')}">Admin</a></li>
<li><a href="${request.route_path('admin.cameras.list')}">Cameras</a></li>
</%block>
<%block name="panel_title">Show Camera</%block>

<section>
	<ul>
		<li><b>Camera id:</b> ${camera.id}</li>
		<li><b>Camera: </b>${camera.name}</li>
		<li><b>Video URI: </b>${camera.video_uri}</li>
		<li><b>Audio URI: </b>${camera.audio_uri}</li>
		<li><b>Image URI: </b>${camera.image_uri}</li>
		<li><b>Username: </b>${camera.username}</li>
		<li><b>Password: </b>${camera.password}</li>
		<li><b>FPS: </b>${camera.fps}</li>
		<li><b>Image Size: </b>${camera.image_size}</li>
		<li><b>Camera Model: </b>${camera.camera_model.name}</li>
		<li><b>Manufactory: </b>${camera.camera_model.manufactory.name}</li>
		<li><b>Create Date: </b>${camera.create_date}</li>
		<li><b>Last Update: </b>${camera.update_date}</li>
		<li><b>Owner: </b> ${camera.owner.email} <b>id:</b> ${camera.owner.id} <b>status:</b> ${camera.owner.status}</li>
	</ul>
</section>
<%inherit file="/base/panel.mako"/>
<%block name='title'>Camera: ${camera.name} information</%block>
<%block name='section_title'>Camera Information</%block>
<%block name='panel_title'>Camera information</%block>

<%block name="whare_am_i">
## <li><a href="${request.route_path('projects.index', project_id=request.matchdict['project_id'])}">Project</a></li>
<li><a href="${request.route_path('cameras.index', project_id=request.matchdict['project_id'])}">Camera</a></li>
</%block>

<ul>
	<li><b>Camera: </b>${camera.name}</li>
	<li><b>Video URI: </b>${camera.video_uri}</li>
	<li><b>Username: </b>${camera.username}</li>
	<li><b>Password: </b>${camera.password}</li>
	<li><b>FPS: </b>${camera.fps}</li>
	<li><b>Image Size: </b>${camera.image_size}</li>
	<li><b>Camera Model: </b>${camera.camera_model.name}</li>
	<li><b>Manufatory: </b>${camera.camera_model.manufactory.name}</li>
	<li><b>Create Date: </b>${camera.create_date}</li>
	<li><b>Last Update: </b>${camera.update_date}</li>
	<li><b>Location: </b>${camera.location}</li>
</ul>

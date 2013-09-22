<%inherit file="/base/panel.mako"/>
<%block name='title'>Camera: ${camera.name} information</%block>
<%block name='section_title'>Camera Information</%block>
<%block name='panel_title'>Camera information</%block>

<%block name="whare_am_i">
## <li><a href="${request.route_path('projects.index', project_id=request.matchdict['project_id'])}">Project</a></li>
<li><a href="${request.route_path('cameras.index', project_id=request.matchdict['project_id'])}">Camera</a></li>
</%block>

<ul>
	<li><strong>Camera: </strong>${camera.name}</li>
	<li><strong>Video URI: </strong>${camera.video_uri}</li>
	<li><strong>Username: </strong>${camera.username}</li>
	<li><strong>Password: </strong>${camera.password}</li>
	<li><strong>FPS: </strong>${camera.fps}</li>
	<li><strong>Image Size: </strong>${camera.image_size}</li>
	<li><strong>Camera Model: </strong>${camera.camera_model.name}</li>
	<li><strong>Manufatory: </strong>${camera.camera_model.manufactory.name}</li>
	<li><strong>Create Date: </strong>${camera.create_date}</li>
	<li><strong>Last Update: </strong>${camera.update_date}</li>
</ul>

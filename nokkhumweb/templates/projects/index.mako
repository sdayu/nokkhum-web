<%inherit file="/base/panel.mako"/>
<%! import urllib %>
<%block name='title'>Hello ${request.user.first_name} ${request.user.last_name}</%block>
<%block name="panel_title">Cameras</%block>

<%block name="whare_am_i">
<li><a href="#">Project</a></li>
</%block>

<%block name="more_body">
<section>
<a href="${request.route_path('cameras.add', project_id=project.id)}">Add camera</a> | 
<a href="${request.route_path('processors.index', project_id=project.id)}">Processors Index</a>
</section>
</%block>

		  		% if cameras:
				<table class="table table-striped table-bordered table-condensed table-hover">
					<thead>
						<tr>
							<th >Name</th>
							<th>URL</th>
							<th colspan="4" style="text-align: center;">Manager</th>
						</tr>
					</thead>
					<tbody>
						% for camera in cameras:
						<tr>
							<td>${camera.name}</td>
							<td><a href="${camera.video_url}">${camera.video_url}</a></td>
							<td><a href="${request.route_path('cameras.edit', camera_id=camera.id, project_id=project.id)}">edit</a></td>
							<td><a href="${request.route_path('cameras.delete', camera_id=camera.id, project_id=project.id)}">delete</td>
							<td><a href="${request.route_path('cameras.setting', camera_id=camera.id, project_id=project.id)}">setting</td>
							<td><a href="${request.route_path('cameras.view', camera_id=camera.id, project_id=project.id)}">view</td>
						</tr>
						% endfor
					</tbody>
				</table>
			% endif
		  	

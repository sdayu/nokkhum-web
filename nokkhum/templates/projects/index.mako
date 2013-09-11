<%inherit file="/base/base.mako"/>
<%block name='title'>Hello ${request.user.first_name} ${request.user.last_name}</%block>
<%! import urllib %>

<article style="background-color:#ffffbd;">
	<section style="text-align: center;">
		<strong>Camera area</strong>
	</section>
	<section>
	% if cameras:
		<table border="1" width="100%">
			<thead>
				<tr>
					<th>Name</th>
					<th>URL</th>
					<th colspan="4">Manager</th>
					<th>Operation</th>
					<th>Status</th>
					<th>Storage</th>
				</tr>
			</thead>
			<tbody>
				% for camera in cameras:
				<tr>
					<td>${camera.name}</td>
					<td><a href="${camera.video_url}">${camera.video_url}</a></td>
					<td><a href="${request.route_path('cameras.edit', camera_id=camera.id, project_id=project.id)}">edit</a></td>
					<td><a href="${request.route_path('cameras.delete', camera_id=camera.id)}">delete</td>
					<td><a href="${request.route_path('cameras.setting', camera_id=camera.id)}">setting</td>
					<td><a href="${request.route_path('cameras.view', camera_id=camera.id)}">view</td>
					<td>
					<a href="${request.route_path('cameras.operating', camera_id=camera.id, operating='start')}">start</a>
					||
					<a href="${request.route_path('cameras.operating', camera_id=camera.id, operating='stop')}">stop</a>
					</td>
					<td>
					<%doc> ${camera.operating.status} </%doc>
					</td>
					<td><a href="${urllib.parse.unquote(request.route_path("storage.list", fizzle="/%s"%camera.id))}">storage</a></td>
				</tr>
				% endfor
			</tbody>
		</table>
	% endif
	</section>
</article>
<section>
<a href="${request.route_path('cameras.add', project_id=project.id)}">Add camera</a> | 
<a href="${request.route_path('processors.index', project_id=project.id)}">Processors Index</a>
</section>
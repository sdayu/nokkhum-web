<%inherit file="/base/base.mako"/>
<%block name='title'>Hello ${request.user.first_name} ${request.user.last_name}</%block>

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
					<td><a href="${camera.url}">${camera.url}</a></td>
					<td><a href="${request.route_path('camera_edit', name=camera.name)}">edit</a></td>
					<td><a href="${request.route_path('camera_delete', name=camera.name)}">delete</td>
					<td><a href="${request.route_path('camera_setting', name=camera.name)}">setting</td>
					<td><a href="${request.route_path('camera_view', name=camera.name)}">view</td>
					% if camera.operating.status == "Stop":
					<td><a href="${request.route_path('camera_operating', name=camera.name, operating='start')}">start</td>
					% else:
					<td><a href="${request.route_path('camera_operating', name=camera.name, operating='stop')}">stop</td>
					% endif
					<td>${camera.operating.status}</td>
					<td><a href="${request.route_path("storage_list", fizzle="/%s"%camera.name)}">storage</a></td>
				</tr>
				% endfor
			</tbody>
		</table>
	% endif
	</section>
</article>
<section>
<a href="${request.route_path('camera_add')}">Add camera</a>
</section>
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
					<td><a href="${camera.url}">${camera.url}</a></td>
					<td><a href="${request.route_path('cameras.edit', name=camera.name)}">edit</a></td>
					<td><a href="${request.route_path('cameras.delete', name=camera.name)}">delete</td>
					<td><a href="${request.route_path('cameras.setting', name=camera.name)}">setting</td>
					<td><a href="${request.route_path('cameras.view', name=camera.name)}">view</td>
					% if camera.operating.status == "Stop":
					<td><a href="${request.route_path('cameras.operating', name=camera.name, operating='start')}">start</td>
					% else:
					<td><a href="${request.route_path('cameras.operating', name=camera.name, operating='stop')}">stop</td>
					% endif
					<td>${camera.operating.status}</td>
					<td><a href="${urllib.parse.unquote(request.route_path("storage.list", fizzle="/%s"%camera.name))}">storage</a></td>
				</tr>
				% endfor
			</tbody>
		</table>
	% endif
	</section>
</article>
<section>
<a href="${request.route_path('cameras.add', project_name=project.name)}">Add camera</a>
</section>
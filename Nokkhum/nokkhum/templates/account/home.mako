<%inherit file="/base/base.mako"/>
<%block name='title'>Hello ${request.user.first_name} ${request.user.last_name}</%block>
<nav style="text-align: right;">
<a href="/signout">Sign out</a>
</nav>
<aside style="float:left; width:200px; background-color:#ffffdc">
	<ul>
		<li><a href="${request.route_path('camera_add')}">Add camera</a></li>
	</ul>
</aside>
<article style="float:left; background-color:#ffffbd; width:70%">
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
				</tr>
			</thead>
			<tbody>
				% for camera in cameras:
				<tr>
					<td>${camera.name}</td>
					<td>${camera.url}</td>
					<td><a href="${request.route_path('camera_edit', name=camera.name)}">edit</a></td>
					<td><a href="${request.route_path('camera_delete', name=camera.name)}">delete</td>
					<td><a href="${request.route_path('camera_setting', name=camera.name)}">setting</td>
					<td><a href="${request.route_path('camera_view', name=camera.name)}">view</td>
					% if camera.operating.status == "Stop":
					<td><a href="${request.route_path('camera_operating', name=camera.name, operating='start')}">start</td>
					% elif camera.operating.status == "Start":
					<td><a href="${request.route_path('camera_operating', name=camera.name, operating='stop')}">stop</td>
					% else:
					<td>${camera.operating.status}</td>
					% endif
				</tr>
				% endfor
			</tbody>
		</table>
	% endif
	</section>
</article>

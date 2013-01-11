<%inherit file="/base/base.mako"/>
<%block name='title'>Hello ${request.user.first_name} ${request.user.last_name}</%block>
<%! import urllib %>

<article style="background-color:#ffffbd;">
	<section style="text-align: center;">
		<strong>Camera area</strong>
	</section>
	<section>
	% if projects:
		<table border="1" width="100%">
			<thead>
				<tr>
					<th>Name</th>
					<th>camera</th>
				</tr>
			</thead>
			<tbody>
				% for project in projects:
				<tr>
					<td><a href="${request.route_path('projects.index', name=project.name)}">${project.name}</a></td>
					<td>${project.get_camera_number()}</td>
				</tr>
				% endfor
			</tbody>
		</table>
	% endif
	</section>
</article>
<section>
<a href="${request.route_path('projects.add')}">Add Project</a>
</section>
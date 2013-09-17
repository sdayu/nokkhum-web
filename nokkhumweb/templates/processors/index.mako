<%inherit file="/base/panel.mako"/>
<%block name='title'>List of Processors</%block>
<%block name="panel_title">Processors</%block>
<%block name="whare_am_i">
<li><a href="${request.route_path('projects.index', project_id=project.id)}">Project</a></li>
<li><a href="#">Processor</a></li>
</%block>

<%block name="more_body">
		<div>
			<a href="${request.route_path('processors.add', project_id=project.id)}">Add processor</a>
		</div>
</%block>
<%! import urllib.parse %>

	  			% if processors:
		  		<table class="table table-striped table-bordered table-condensed table-hover">
					<thead>
						<tr style="text-align: center;">
							<th>Name</th>
							<th>Camera</th>
							<th colspan="3">Manager</th>
							<th>Operation</th>
							<th>Status</th>
							<th>Storage</th>
						</tr>
					</thead>
					<tbody>
						% for processor in processors:
						<tr>
							<td><a href="${request.route_path('processors.view', project_id=project.id, processor_id=processor.id)}">${processor.name}</a></td>
							<td><a href="${request.route_path('cameras.view', project_id=project.id, camera_id=processor.cameras[0].id)}">${processor.cameras[0].name}</a></td>
							<td><a href="${request.route_path('processors.edit', project_id=project.id, processor_id=processor.id)}">edit</a></td>
							<td><a href="${request.route_path('processors.delete', project_id=project.id, processor_id=processor.id)}">delete</a></td>
							<td>setting</td>
							<td>
							<a href="${request.route_path('processors.operating', project_id=project.id, processor_id=processor.id, operating='start')}">start</a>
							|
							<a href="${request.route_path('processors.operating', project_id=project.id, processor_id=processor.id, operating='stop')}">stop</a>
							
							</td>
							<td>${processor.operating.status}</td>
							<td><a href="${urllib.parse.unquote(request.route_path("storage.list", fizzle="/%s"%processor.id))}">storage</a></td>
						</tr>
						% endfor
					</tbody>
				</table>
				% else:
				No processors available.
				% endif


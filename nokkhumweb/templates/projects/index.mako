<%inherit file="/base/panel.mako"/>
<%block name='title'>All Projects</%block>
<%! import urllib %>

<%block name="where_am_i">
<li><a href="${request.route_path('projects.index')}">Projects</a></li>
</%block>

<%block name="panel_title">All Project</%block>

<%block name="more_body">
<section>
<a href="${request.route_path('projects.add')}">Add Project</a>
</section>
</%block>

% if projects:
<table class="table table-striped table-bordered table-condensed table-hover">
	<thead>
		<tr>
			<th>Name</th>
			<th>Cameras</th>
			<th>Processors</th>
		</tr>
	</thead>
	<tbody>
		% for project in projects:
		<tr>
			<td>
				<div class="pull-left">
					<a href="${request.route_path('projects.view', project_id=project.id)}">${project.name}</a>
				</div>
				<div class="pull-right">
					<a href="${request.route_path('projects.edit', project_id=project.id)}">
					 	<span class="glyphicon glyphicon-edit"></span>
					</a>
					<a href="${request.route_path('projects.delete', project_id=project.id)}">
					 	<span class="glyphicon glyphicon-trash"></span>
					</a>
				</div>
			</td>
			<td>
				${project.camera_number} :
			    <a href="${request.route_path('cameras.index', project_id=project.id)}">manage</a>
			</td>
			<td>
				${project.processor_number} :
				<a href="${request.route_path('processors.index', project_id=project.id)}">manage</a>
			</td>
		</tr>
		% endfor
	</tbody>
</table>
% endif
		  

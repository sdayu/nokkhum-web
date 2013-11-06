<%inherit file="/base/panel.mako"/>
<%block name='title'>Show Projects</%block>
<%! import urllib %>

<%block name="where_am_i">
<li><a href="${request.route_path('projects.index')}">Projects</a></li>
</%block>

<%block name="panel_title">Show Project</%block>

<section>
	<ul>
		<li><b>ID :</b>${project.id}</li>
		<li><b>name :</b>${project.name}</li>
		<li><b>description :</b>${project.description}</li>
		<li><b>manager :</b>
			<ul>
				<li><a href="${request.route_path('projects.index', project_id=project.id)}">Overview</a></li>
				<li><a href="${request.route_path('cameras.index', project_id=project.id)}">Cameras Manager</a></li>
				<li><a href="${request.route_path('processors.index', project_id=project.id)}">Processors Manager</a></li>
			</ul>
		</li>
	</ul>
</section>

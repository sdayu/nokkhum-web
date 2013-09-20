<%inherit file="/base/panel.mako"/>
<%block name='title'>Hello ${request.user.first_name} ${request.user.last_name}</%block>
<%! import urllib %>


<%block name="panel_title">Home</%block>

<article>
	<nav>
		<ul>
			<li><a href="${request.route_path('projects.index')}">Project Index</a></li>
			<li><a href="${request.route_path('projects.add')}">Add Project</a></li>
		</ul>
	</nav>
</article>

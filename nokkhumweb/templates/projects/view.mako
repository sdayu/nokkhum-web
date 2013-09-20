<%inherit file="/base/panel.mako"/>
<%block name='title'>Show Projects</%block>
<%! import urllib %>

<%block name="whare_am_i">
<li><a href="${request.route_path('projects.index')}">Project</a></li>
</%block>

<%block name="panel_title">Show Project</%block>

<section>
	<ul><b>ID :</b>${project.id}</ul>
	<ul><b>name :</b>${project.name}</ul>
	<ul><b>description :</b>${project.description}</ul>
</section>

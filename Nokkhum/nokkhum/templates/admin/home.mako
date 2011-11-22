<%inherit file="../base/base.mako"/>
<%block name='title'>Administrator Home</%block>
<h1>This is Administrator Home</h1>
<nav>
	<h2>
	List of tool
	</h2>
	<ul>
		<li>
			<a href="${request.route_path('admin_list_command_queue')}">Display camera command queue</a>
		</li>
		<li>
			<a href="${request.route_path('admin_list_command_log')}">Display command log</a>
		</li>
		<li>
			<a href="${request.route_path('admin_list_compute_node')}">Display compute node</a>
		</li>
		<li>
			<a href="${request.route_path('admin_list_camera')}">Display camera</a>
		</li>
	</ul>
</nav>
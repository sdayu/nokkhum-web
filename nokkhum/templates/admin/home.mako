<%inherit file="../base/base.mako"/>
<%block name='title'>Administrator Home</%block>
<h1>This is Administrator Home</h1>
<nav>
	<h2>
	List of tool
	</h2>
	<ul>
		<li>
			<a href="${request.route_path('admin.command_queue.list')}">Display camera command queue</a>
		</li>
		<li>
			<a href="${request.route_path('admin.command_log.list')}">Display command log</a>
		</li>
		<li>
			<a href="${request.route_path('admin.compute_nodes.list')}">Display compute node</a>
		</li>
		<li>
			<a href="${request.route_path('admin.cameras.list')}">Display camera</a>
		</li>
		<li>
			<a href="${request.route_path('admin.camera_running_fail.list_camera')}">Display camera running fail</a>
		</li>
		<li>
			<a href="${request.route_path('admin.users.list')}">Display user</a>
		</li>
		<li>
			<a href="${request.route_path('admin.cache.stat')}">Cache Statistic</a>
		</li>
	</ul>
</nav>
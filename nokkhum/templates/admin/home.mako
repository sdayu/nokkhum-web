<%inherit file="../base/base.mako"/>
<%block name='title'>Administrator Home</%block>
<h1>This is Administrator Home</h1>
<nav>
	<h2>
	List of tool
	</h2>
	<ul>
		<li>
			<a href="${request.route_path('admin_command_queue_list')}">Display camera command queue</a>
		</li>
		<li>
			<a href="${request.route_path('admin_command_log_list')}">Display command log</a>
		</li>
		<li>
			<a href="${request.route_path('admin_compute_node_list')}">Display compute node</a>
		</li>
		<li>
			<a href="${request.route_path('admin_camera_list')}">Display camera</a>
		</li>
		<li>
			<a href="${request.route_path('admin.camera_running_fail.list_camera')}">Display camera run fail</a>
		</li>
		<li>
			<a href="${request.route_path('admin_user_list')}">Display user</a>
		</li>
		<li>
			<a href="${request.route_path('admin_cache_stat')}">Cache Statistic</a>
		</li>
	</ul>
</nav>
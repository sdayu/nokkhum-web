<%inherit file="/base/panel.mako"/>
<%block name='title'>List Compute Node</%block>
<%! import datetime %>

<%block name="where_am_i">
<li><a href="${request.route_path('admin.home')}">Admin</a></li>
<li><a href="${request.route_path('admin.compute_nodes.list')}">Compute Node</a></li>
</%block>
<%block name="panel_title">Show Compute Node</%block>

<section>
	<ul>
		<li><b>Compute Node id: </b><span style="color: red;">${compute_node.id}</span></li>
		<li><b>name: </b> ${compute_node.name}</li>
		<li><b>system: </b> ${compute_node.system}</li>
		<li><b>host: </b> ${compute_node.host}</li>
		<li><b>machine: </b> ${compute_node.machine}</li>
		<li><b>create date: </b> ${compute_node.created_date}</li>
		<li><b>update date: </b> ${compute_node.updated_date}</li>
		<li><b>diff time: </b> ${(datetime.datetime.now() - compute_node.updated_date).seconds} s</li>
		% if (datetime.datetime.now() - compute_node.updated_date) < datetime.timedelta(minutes=1):
		<li><b>status: </b> <span style="color: red;">Ready</span></li>
		% else:
		<li><b>status: </b> <span style="color: red;">Disconnect</span></li>
		% endif
		<li><b>CPU:</b>
			<ul>
				<li>count: ${compute_node.cpu.count}</li>
				<li>usage: ${compute_node.cpu.used}</li>
				<li>all CPU : ${compute_node.cpu.used_per_cpu}</li>
			</ul>
		</li>
		<li><b>RAM:</b>
			<ul>
				<li>total: ${compute_node.memory.total}</li>
				<li>used: ${compute_node.memory.used}</li>
				<li>free: ${compute_node.memory.free}</li>
			</ul>
		</li>
		<li><b>Disk:</b>
			<ul>
				<li>total: ${compute_node.disk.total}</li>
				<li>used: ${compute_node.disk.used}</li>
				<li>free: ${compute_node.disk.free}</li>
			</ul>
		</li>
	</ul>
</section>
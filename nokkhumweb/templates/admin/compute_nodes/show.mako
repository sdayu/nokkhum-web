<%inherit file="/base/panel.mako"/>
<%block name='title'>List Compute Node</%block>
<%! 
	import datetime 
	import json
%>

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
		<li><b>last resource report date: </b> ${compute_node.updated_resource_date}</li>
		<li><b>diff time: </b> ${(datetime.datetime.now() - compute_node.updated_resource_date).seconds} s</li>
		% if compute_node.online:
		<li><b>status: </b> <span style="color: red;">Ready</span></li>
		% else:
		<li><b>status: </b> <span style="color: red;">Disconnect</span></li>
		% endif
		% if compute_node.is_vm:
		<li><b>VM:</b>
			<ul>
				<li><b><i>name:</i></b> ${compute_node.vm.name}</li>
				<li><b><i>image id:</i></b> ${compute_node.vm.image_id}</li>
				<li><b><i>instance id:</i></b> ${compute_node.vm.instance_id}</li>
				<li><b><i>instance type:</i></b> ${compute_node.vm.instance_type}</li>
				<li><b><i>ip_address:</i></b> ${compute_node.vm.ip_address}</li>
				<li><b><i>private_ip_address:</i></b> ${compute_node.vm.private_ip_address}</li>
				<li><b><i>started_instance_date:</i></b> ${compute_node.vm.started_instance_date}</li>
				<li><b><i>status:</i></b> ${compute_node.vm.status}</li>
				<li><b><i>extra:</i></b> <pre>${json.dumps(compute_node.vm.extra, indent=4) | n}</pre></li>
				
			</ul>
		</li>
		% endif
		<li><b>CPU:</b>
			<ul>
				<li><b><i>count:</i></b> ${compute_node.cpu.count}</li>
				<li><b><i>usage:</i></b> ${compute_node.cpu.used}</li>
				<li><b><i>all CPU:</i></b> ${compute_node.cpu.used_per_cpu}</li>
			</ul>
		</li>
		<li><b>RAM:</b>
			<ul>
				<li><b><i>total:</i></b> ${compute_node.memory.total}</li>
				<li><b><i>used:</i></b> ${compute_node.memory.used}</li>
				<li><b><i>free:</i></b> ${compute_node.memory.free}</li>
			</ul>
		</li>
		<li><b>Disk:</b>
			<ul>
				<li><b><i>total:</i></b> ${compute_node.disk.total}</li>
				<li><b><i>used:</i></b>${compute_node.disk.used}</li>
				<li><b><i>free:</i></b> ${compute_node.disk.free}</li>
			</ul>
		</li>
		<li><b>extra:</b> <pre>${json.dumps(compute_node.extra, indent=4) | n}</pre></li>
	</ul>
</section>
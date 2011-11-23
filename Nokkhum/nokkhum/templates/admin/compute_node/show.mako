<%inherit file="/base/base.mako"/>
<%block name='title'>List Compute Node</%block>
<%! import datetime %>
<h1>List Compute Node</h1>
<section>
	<h2>Compute Node id: <span style="color: red;">${compute_node._id}</span></h2>
			<ul>
				<li><strong>name: </strong> ${compute_node.name}</li>
				<li><strong>system: </strong> ${compute_node.system}</li>
				<li><strong>host: </strong> ${compute_node.host}</li>
				<li><strong>machine: </strong> ${compute_node.machine}</li>
				<li><strong>port: </strong> ${compute_node.port}</li>
				<li><strong>create date: </strong> ${compute_node.create_date}</li>
				<li><strong>update date: </strong> ${compute_node.update_date}</li>
				% if (datetime.datetime.now() - compute_node.update_date) < datetime.timedelta(minutes=1):
				<li><strong>status: </strong> <span style="color: red;">Ready</span></li>
				% else:
				<li><strong>status: </strong> <span style="color: red;">Disconnect</span></li>
				% endif
				<li><strong>CPU:</strong>
					<ul>
						<li>count: ${compute_node.cpu.count}</li>
						<li>usage: ${compute_node.cpu.usage}</li>
						<li>all CPU : ${compute_node.cpu.usage_per_cpu}</li>
					</ul>
				</li>
				<li><strong>RAM:</strong>
					<ul>
						<li>total: ${compute_node.memory.total}</li>
						<li>used: ${compute_node.memory.used}</li>
						<li>free: ${compute_node.memory.free}</li>
					</ul>
				</li>
			</ul>
</section>
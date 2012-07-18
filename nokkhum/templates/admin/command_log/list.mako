<%inherit file="/base/base.mako"/>
<%block name='title'>List Command Log</%block>
<%! import datetime %>
<h1>List Command Log</h1>
<section>
	<table border="1" width="95%" style="text-align: center;">
		<thead>
  			<tr>
    			<th>ID</th>
    			<th>Camera Name</th>
    			<th>Owner</th>
    			<th>Action</th>
    			<th>Date</th>
    			<th>Complete Date</th>
    			<th>Compute Node</th>
    			<th>Status</th>
    			<th>Message</th>
  			</tr>
		</thead>
		<tbody>
			% for command in command_log:
			<tr>
				<td>${command.id}</td>
				<td>${command.attributes["camera"]["id"]}: ${command.attributes["camera"]["name"]}</td>
				<td><a href="${request.route_path('admin_user_show', id=command.owner.id)}">${command.owner.email}</a></td>
				<td>${command.action}</td>
				<td>${command.command_date}</td>
				<td>${command.complete_date}</td>
				% if command.compute_node:
				<td><a href="${request.route_path('admin_compute_node_show', id=command.compute_node.id)}">${command.compute_node.name}</a></td>
				% else:
				<td>None</td>
				% endif
				<td>${command.status}</td>
				<td>${command.message.replace("\n", "<br/>") | n}</td>
			</tr>
			% endfor
		</tbody>
	</table>
</section>
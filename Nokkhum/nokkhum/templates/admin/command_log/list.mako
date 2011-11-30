<%inherit file="/base/base.mako"/>
<%block name='title'>List Command Log</%block>
<%! import datetime %>
<h1>List Command Log</h1>
<section>
	<table border="1" width="800px" style="text-align: center;">
		<thead>
  			<tr>
    			<th>ID</th>
    			<th>Camera Name</th>
    			<th>Owner</th>
    			<th>Action</th>
    			<th>Date</th>
    			<th>Complete Date</th>
    			<th>Compute Node</th>
  			</tr>
		</thead>
		<tbody>
			% for command in command_log:
			<tr>
				<td>${command.id}</td>
				<td><a href="${request.route_path('admin_camera_show', id=command.camera.id)}">${command.camera.name}</a></td>
				<td><a href="${request.route_path('admin_user_show', id=command.owner.id)}">${command.owner.email}</a></td>
				<td>${command.action}</td>
				<td>${command.command_date}</td>
				<td>${command.complete_date}</td>
				<td><a href="${request.route_path('admin_compute_node_show', id=command.compute_node._id)}">${command.compute_node.name}</a></td>
			</tr>
			% endfor
		</tbody>
	</table>
</section>
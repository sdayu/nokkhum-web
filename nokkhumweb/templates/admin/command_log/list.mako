<%inherit file="/base/panel.mako"/>
<%block name='title'>List Command Log</%block>
<%! import datetime %>

<%block name="whare_am_i">
<li><a href="${request.route_path('admin.home')}">Admin</a></li>
<li><a href="${request.route_path('admin.command_log.list')}">Command Log</a></li>
</%block>

<%block name="panel_title">List Command Log</%block>
<section>
<span style="font-weight: bold;">Current Date:</span> ${datetime.datetime.now()}
</section>

<section>
	<table class="table table-striped table-bordered table-condensed table-hover">
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
				<td><a href="${request.route_path('admin.users.show', id=command.owner.id)}">${command.owner.email}</a></td>
				<td>${command.action}</td>
				<td>${command.command_date}</td>
				<td>${command.complete_date}</td>
				% if command.compute_node:
				<td><a href="${request.route_path('admin.compute_nodes.show', id=command.compute_node.id)}">${command.compute_node.name}</a></td>
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
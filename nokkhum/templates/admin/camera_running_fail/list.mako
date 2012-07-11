<%inherit file="/base/base.mako"/>
<%block name='title'>List Command Log</%block>
<%! import datetime %>
<h1>List Command Log</h1>
<section>
	<table border="1" width="95%" style="text-align: center;">
		<thead>
  			<tr>
    			<th>Camera Name</th>
    			<th>Compute Node</th>
    			<th>Report Time</th>
    			<th>Process Time</th>
    			<th>Message</th>
  			</tr>
		</thead>
		<tbody>
			% for fail_status in run_fail_status:
			<tr>
				<td>${fail_status.camera.id}: ${fail_status.camera.name}</td>
				<td><a href="${request.route_path('admin_compute_node_show', id=fail_status.compute_node._id)}">${fail_status.compute_node.name}</a></td>
				<td>${fail_status.report_time}</td>
				<td>${fail_status.process_time}</td>
				<td>${fail_status.message.replace("\n", "<br/>") | n}</td>
			</tr>
			% endfor
		</tbody>
	</table>
</section>

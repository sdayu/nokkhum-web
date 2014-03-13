<%inherit file="/base/panel.mako"/>
<%block name='title'>Processor Running Fail</%block>
<%! import datetime %>

<%block name="where_am_i">
<li><a href="${request.route_path('admin.home')}">Admin</a></li>
<li><a href="${request.route_path('admin.processors.list')}">Processors</a></li>
<li><a href="${request.route_path('admin.processor_running_fail.list')}">Run Fail</a></li>
</%block>

<%block name="panel_title">Processor Running Fail</%block>

<section>
	<table class="table table-striped table-bordered table-condensed table-hover">
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
				<td>${fail_status.processor.id}: ${fail_status.processor.name}</td>
				<td><a href="${request.route_path('admin.compute_nodes.show', compute_node_id=fail_status.compute_node.id)}">${fail_status.compute_node.name}</a></td>
				<td>${fail_status.reported_date}</td>
				<td>${fail_status.processed_date}</td>
				<td>${fail_status.message.replace("\n", "<br/>") | n}</td>
			</tr>
			% endfor
		</tbody>
	</table>
</section>

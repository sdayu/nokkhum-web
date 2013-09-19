<%inherit file="/base/panel.mako"/>
<%block name='title'>List Compute Node</%block>
<%! import datetime %>

<%block name="whare_am_i">
<li><a href="${request.route_path('admin.home')}">Admin</a></li>
<li><a href="${request.route_path('admin.compute_nodes.list')}">Compute Node</a></li>
</%block>
<%block name="panel_title">List Compute Node</%block>

<section>
	<table class="table table-striped table-bordered table-condensed table-hover">
		<colgroup>
      		<col style="width: 10%"/>
      		<col style="width: 20%"/>
      		<col style="width: 10%"/>
      		<col style="width: 5%"/>
      		<col style="width: 5%"/>
      		<col style="width: 5%"/>
      		<col style="width: 5%"/>
      		<col style="width: 5%"/>
      		<col style="width: 10%"/>
      		<col style="width: 5%"/>
   		</colgroup>
		<thead>
  			<tr>
    			<th rowspan="2">Name</th>
    			<th rowspan="2">Host</th>
    			<th rowspan="2">Status</th>
    			<th colspan="2">CPU</th>
    			<th colspan="3">RAM(M)</th>
    			<th rowspan="2">Last update</th>
    			<th rowspan="2">Operation</th>
  			</tr>
  			<tr style="vertical-align: bottom">
         		<th>count</th>
         		<th>usage</th>
         		<th>total</th>
         		<th>used</th>
         		<th>free</th>
      		</tr>
		</thead>
		<tbody>
		% for compute_node in compute_nodes:
			<% td = datetime.datetime.now() - compute_node.update_date %>
			<tr>
				<td><a href="${request.route_path('admin.compute_nodes.show', compute_node_id=compute_node.id)}">${compute_node.name}</a></td>
				<td>${compute_node.host} is VM: ${compute_node.is_vm}</td>
				<td>
				% if td < datetime.timedelta(minutes=1):
					<span style="color: red;">Ready</span>
				% else:
					<span style="color: red;">Disconnect</span>
				% endif
				</td>
				<td>${compute_node.cpu.count}</td>
				<td>${compute_node.cpu.used}</td>
				<td>${compute_node.memory.total/1000000}</td>
				<td>${compute_node.memory.used/1000000}</td>
				<td>${compute_node.memory.free/1000000}</td>
				<td>${"%.2f"%td.total_seconds()} s</td>
				<td><a href="${request.route_path('admin.compute_nodes.delete', compute_node_id=compute_node.id)}">Delete</a></td>
			</tr>
		% endfor
		</tbody>
	</table>
</section>
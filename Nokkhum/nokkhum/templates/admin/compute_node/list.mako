<%inherit file="/base/base.mako"/>
<%block name='title'>List Compute Node</%block>
<%! import datetime %>
<h1>List Compute Node</h1>
<section>
	<table border="1" width="800px" style="text-align: center;">
		<colgroup>
      		<col style="width: 10%"/>
      		<col style="width: 10%"/>
      		<col style="width: 10%"/>
      		<col style="width: 10%"/>
      		<col style="width: 10%"/>
      		<col style="width: 10%"/>
      		<col style="width: 5%"/>
      		<col style="width: 5%"/>
      		<col style="width: 5%"/>
   		</colgroup>
		<thead>
  			<tr>
    			<th rowspan="2">Name</th>
    			<th rowspan="2">Host</th>
    			<th rowspan="2">Port</th>
    			<th rowspan="2">Status</th>
    			<th colspan="2">CPU</th>
    			<th colspan="3">RAM(M)</th>
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
			<tr>
				<td><a href="${request.route_path('admin_compute_node_show', id=compute_node._id)}">${compute_node.name}</a></td>
				<td>${compute_node.host}</td>
				<td>${compute_node.port}</td>
				<td>
				% if (datetime.datetime.now() - compute_node.update_date) < datetime.timedelta(minutes=1):
					<span style="color: red;">Ready</span>
				% else:
					<span style="color: red;">Disconnect</span>
				% endif
				</td>
				<td>${compute_node.cpu.count}</td>
				<td>${compute_node.cpu.usage}</td>
				<td>${compute_node.memory.total/1000000}</td>
				<td>${compute_node.memory.used/1000000}</td>
				<td>${compute_node.memory.free/1000000}</td>
			</tr>
		% endfor
		</tbody>
	</table>
</section>
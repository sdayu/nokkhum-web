<%inherit file="/base/base.mako"/>
<%block name='title'>List Cameras</%block>
<%! import datetime %>
<h1>List Cameras</h1>
<section>
	<table border="1" width="800px" style="text-align: center;">
		<colgroup>
      		<col style="width: 10%"/>
      		<col style="width: 20%"/>
      		<col style="width: 20%"/>
      		<col style="width: 10%"/>
      		<col style="width: 10%"/>
      		<col style="width: 20%"/>
      		<col style="width: 10%"/>
   		</colgroup>
		<thead>
  			<tr>
    			<th rowspan="2">ID</th>
    			<th rowspan="2">Update</th>
    			<th rowspan="2">Owner</th>
    			<th rowspan="2">Status</th>
    			<th colspan="3">Operating</th>
  			</tr>
  			<tr style="vertical-align: bottom">
         		<th>Status</th>
         		<th>Diff times</th>
         		<th>Compute node</th>
      		</tr>
		</thead>
		<tbody>
		% for camera in cameras:
  			<tr>
    			<td>
    				<a href="${request.route_path('admin.cameras.show', id=camera.id)}">${camera.id}
    			</td>
    			<td>${camera.update_date}</td>
    			<td>${camera.owner.email}</td>
    			<td>${camera.status}</td>
    			<td>${camera.operating.status}</td>
    			<td>${(datetime.datetime.now()-camera.operating.update_date).seconds} s</td>
    			<td>
    				% if camera.operating.compute_node is not None:
					<a href="${request.route_path('admin.compute_nodes.show', id=camera.operating.compute_node.id)}">${camera.operating.compute_node.host}</a>
					% else:
					Waiting
					% endif
				</td>
  			</tr>
  		% endfor
		</tbody>
	</table>
</section>
<%inherit file="/base/panel.mako"/>
<%block name='title'>List All Cameras</%block>
<%! import datetime %>

<%block name='panel_title'>List All Cameras</%block>

<section>
	<table class="table table-striped table-bordered table-condensed table-hover">
		<thead>
  			<tr>
    			<th>ID</th>
    			<th>Update</th>
    			<th>Owner</th>
    			<th>Status</th>
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
  			</tr>
  		% endfor
		</tbody>
	</table>
</section>
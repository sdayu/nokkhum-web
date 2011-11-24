<%inherit file="/base/base.mako"/>
<%block name='title'>List Camera Command Queue</%block>
<%! import datetime %>
<h1>List Camera Command Queue</h1>
<section>
	<table border="1" width="800px" style="text-align: center;">
		<colgroup>
      		<col style="width: 10%"/>
      		<col style="width: 10%"/>
      		<col style="width: 10%"/>
      		<col style="width: 10%"/>
      		<col style="width: 10%"/>
      		<col style="width: 10%"/>
      		<col style="width: 20%"/>
      		<col style="width: 20%"/>
   		</colgroup>
		<thead>
  			<tr>
    			<th>ID</th>
    			<th>Camera Name</th>
    			<th>Owner</th>
    			<th>Action</th>
    			<th>Status</th>
    			<th>Date</th>
    			<th>Update Date</th>
    			<th>Diff Time</th>
  			</tr>
		</thead>
		<tbody>
			% for command in camera_command_queue:
			<tr>
				<td><a href="${request.route_path('admin_command_queue_show', id=command.id)}">${command.id}</a></td>
				<td><a href="${request.route_path('admin_camera_show', id=command.camera.id)}">${command.camera.name}</a></td>
				<td><a href="${request.route_path('admin_user_show', id=command.owner.id)}">${command.owner.email}</a></td>
				<td>${command.action}</td>
				<td>${command.status}</td>
				<td>${command.command_date}</td>
				<td>${command.update_date}</td>
				<td>${(datetime.datetime.now()-command.update_date).seconds} s</td>
			</tr>
			% endfor
		</tbody>
	</table>
</section>
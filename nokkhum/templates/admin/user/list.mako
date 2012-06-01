<%inherit file="/base/base.mako"/>
<%block name='title'>List Camera Command Queue</%block>
<%! import datetime %>
<h1>List Camera Command Queue</h1>
<section>
	<table border="1" width="800px" style="text-align: center;">
		<colgroup>
      		<col style="width: 10%"/>
      		<col style="width: 20%"/>
      		<col style="width: 10%"/>
      		<col style="width: 10%"/>
      		<col style="width: 10%"/>
      		<col style="width: 20%"/>
      		<col style="width: 20%"/>
   		</colgroup>
		<thead>
  			<tr>
    			<th>ID</th>
    			<th>Name</th>
    			<th>Email</th>
    			<th>Status</th>
    			<th>Group</th>
    			<th>Regist Date</th>
    			<th>Update Date</th>
  			</tr>
		</thead>
		<tbody>
			% for user in users:
			<tr>
				<td><a href="${request.route_path('admin_user_show', id=user.id)}">${user.id}</a></td>
				<td>${user.first_name} ${user.last_name}</td>
				<td>${user.email}</td>
				<td>${user.status}</td>
				<td>${user.group.name}</td>
				<td>${user.registration_date}</td>
				<td>${user.update_date}</td>
			</tr>
			% endfor
		</tbody>
	</table>
</section>
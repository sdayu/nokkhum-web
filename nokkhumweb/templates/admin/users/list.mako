<%inherit file="/base/panel.mako"/>
<%block name='title'>List All User</%block>
<%! import datetime %>

<%block name="whare_am_i">
<li><a href="${request.route_path('admin.home')}">Admin</a></li>
<li><a href="${request.route_path('admin.users.list')}">User</a></li>
</%block>

<%block name="panel_title">List All User</%block>

<section>
	<table class="table table-striped table-bordered table-condensed table-hover">
		<thead>
  			<tr>
    			<th>ID</th>
    			<th>Name</th>
    			<th>Email</th>
    			<th>Status</th>
    			<th>Roles</th>
    			<th>Regist Date</th>
    			<th>Update Date</th>
  			</tr>
		</thead>
		<tbody>
			% for user in users:
			<tr>
				<td><a href="${request.route_path('admin.users.show', user_id=user.id)}">${user.id}</a></td>
				<td>${user.first_name} ${user.last_name}</td>
				<td>${user.email}</td>
				<td>${user.status}</td>
				<td>
				% for role in user.roles:
				${role.name}, 
				% endfor
				</td>
				<td>${user.registration_date}</td>
				<td>${user.update_date}</td>
			</tr>
			% endfor
		</tbody>
	</table>
</section>
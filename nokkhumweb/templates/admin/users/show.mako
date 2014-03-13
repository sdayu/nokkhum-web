<%inherit file="/base/panel.mako"/>
<%block name='title'>List Camera Command Queue</%block>
<%! import datetime %>

<%block name="where_am_i">
<li><a href="${request.route_path('admin.home')}">Admin</a></li>
<li><a href="${request.route_path('admin.users.list')}">User</a></li>
</%block>

<%block name="panel_title">Show User</%block>

<section>
	<ul>
		<li><b>id: </b>${user.id} </li>
		<li><b>name: </b>${user.first_name} ${user.last_name}</li>
		<li><b>email: </b>${user.email}</li>
		<li><b>status: </b>${user.status}</li>
		<li><b>roles: </b>
% for role in user.roles:
 ${role.name}, 
% endfor
		</li>
		<li><b>registration date: </b>${user.registration_date}</li>
		<li><b>update date: </b>${user.updated_date}</li>
	</ul>	
</section>
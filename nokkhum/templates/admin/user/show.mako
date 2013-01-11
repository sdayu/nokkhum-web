<%inherit file="/base/base.mako"/>
<%block name='title'>List Camera Command Queue</%block>
<%! import datetime %>
<h1>Show User</h1>
<section>
		<h2>User id: <span style="color: red;">${user.id}</span></h2>
			<ul>
				<li><strong>name: </strong>${user.first_name} ${user.last_name}</li>
				<li><strong>email: </strong>${user.email}</li>
				<li><strong>status: </strong>${user.status}</li>
				<li><strong>roles: </strong>
% for role in user.roles:
 ${role.name}, 
% endfor
				</li>
				<li><strong>registration date: </strong>${user.registration_date}</li>
				<li><strong>update date: </strong>${user.update_date}</li>
			</ul>
</section>
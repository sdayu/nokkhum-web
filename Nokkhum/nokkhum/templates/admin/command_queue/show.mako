<%inherit file="/base/base.mako"/>
<%block name='title'>List Camera Command Queue</%block>
<%! import datetime %>
<h1>Show Camera Command Queue</h1>
<section>
		<h2>Command id: <span style="color: red;">${command.id}</span></h2>
			<ul>
				<li><strong>camera name: </strong><a href="${request.route_path('admin_camera_show', id=command.camera.id)}">${command.camera.name}</a></li>
				<li><strong>owner: </strong><a href="${request.route_path('admin_user_show', id=command.owner.id)}">${command.owner.email}</a></li>
				<li><strong>action: </strong>${command.action}</li>
				<li><strong>status: </strong>${command.status}</li>
				<li><strong>date: </strong>${command.command_date}</li>
				<li><strong>update date: </strong>${command.update_date}</li>
				<li><strong>diff time: </strong><span style="color: red;">${(datetime.datetime.now()-command.command_date).seconds}</span> s ago</li>
			</ul>
</section>
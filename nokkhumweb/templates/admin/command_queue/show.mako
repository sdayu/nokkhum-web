<%inherit file="/base/panel.mako"/>
<%block name='title'>Show Command Queue</%block>
<%! import datetime %>

<%block name="whare_am_i">
<li><a href="${request.route_path('admin.home')}">Admin</a></li>
<li><a href="${request.route_path('admin.command_queue.list')}">Command Queue</a></li>
</%block>

<%block name="panel_title">Show Command Queue</%block>

<section>
	<ul>
		<li><b>command id: </b>${command.id}</li>
		<li><b>processor name: </b>
			<a href="${request.route_path('admin.processors.show', processor_id=command.processor_command.processor.id)}">${command.processor_command.processor.name}</a>
		</li>
		<li><b>camera name: </b>
			% for camera in command.processor_command.processor.cameras:
			<a href="${request.route_path('admin.cameras.show', camera_id=camera.id)}">${camera.name}</a>
			% endfor
		</li>
		% if command.processor_command.owner:
		<li><b>owner: </b><a href="${request.route_path('admin.users.show', user_id=command.processor_command.owner.id)}">${command.processor_command.owner.email}</a></li>
		% endif
		<li><b>Command Type: </b>${command.processor_command.command_type}</li>
		<li><b>action: </b>${command.processor_command.action}</li>
		<li><b>status: </b>${command.processor_command.status}</li>
		<li><b>date: </b>${command.processor_command.command_date}</li>
		<li><b>update date: </b>${command.processor_command.update_date}</li>
		<li><b>diff time: </b><span style="color: red;">${(datetime.datetime.now()-command.processor_command.command_date).seconds}</span> s ago</li>
		<li><b>message: </b>${command.processor_command.message}</li>
	</ul>
</section>
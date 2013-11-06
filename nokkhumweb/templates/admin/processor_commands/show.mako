<%inherit file="/base/panel.mako"/>
<%block name='title'>Show Processor Command</%block>
<%! import datetime %>

<%block name="where_am_i">
<li><a href="${request.route_path('admin.home')}">Admin</a></li>
<li><a href="${request.route_path('admin.command_log.list')}">Command Log</a></li>
</%block>

<%block name="panel_title">Show Processor Command</%block>

<section>
	<ul>
		<li><b>command id: </b>${command.id}</li>
		<li><b>processor name: </b>
			<a href="${request.route_path('admin.processors.show', processor_id=command.processor.id)}">${command.processor.name}</a>
		</li>
		<li><b>camera name: </b>
			% for camera in command.processor.cameras:
			<a href="${request.route_path('admin.cameras.show', camera_id=camera.id)}">${camera.name}</a>
			% endfor
		</li>
		% if command.owner:
		<li><b>owner: </b><a href="${request.route_path('admin.users.show', user_id=command.owner.id)}">${command.owner.email}</a></li>
		% endif
		<li><b>Command Type: </b>${command.command_type}</li>
		<li><b>action: </b>${command.action}</li>
		<li><b>status: </b>${command.status}</li>
		<li><b>date: </b>${command.command_date}</li>
		<li><b>update date: </b>${command.update_date}</li>
		<li><b>diff time: </b><span style="color: red;">${(datetime.datetime.now()-command.command_date).seconds}</span> s ago</li>
		<li><b>message: </b>
		% if command.message:
		<p>
			${command.message.replace('\n', '<br/>') | n}
		</p>
		% endif
		</li>
	</ul>
</section>
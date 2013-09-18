<%inherit file="/base/base.mako"/>
<%block name='title'>List Camera Command Queue</%block>
<%! import datetime %>
<h1>Show Camera Command Queue</h1>
<section>
		<h2>Command id: <span style="color: red;">${command.id}</span></h2>
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
				<li><b>owner: </b><a href="${request.route_path('admin.users.show', user_id=command.processor_command.owner.id)}">${command.processor_command.owner.email}</a></li>
				<li><b>action: </b>${command.processor_command.action}</li>
				<li><b>status: </b>${command.processor_command.status}</li>
				<li><b>date: </b>${command.processor_command.command_date}</li>
				<li><b>update date: </b>${command.processor_command.update_date}</li>
				<li><b>diff time: </b><span style="color: red;">${(datetime.datetime.now()-command.processor_command.command_date).seconds}</span> s ago</li>
				<li><b>message: </b>${command.processor_command.message}</li>
			</ul>
</section>
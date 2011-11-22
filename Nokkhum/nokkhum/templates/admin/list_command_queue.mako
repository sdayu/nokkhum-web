<%inherit file="../base/base.mako"/>
<%block name='title'>List Camera Command Queue</%block>
<%! import datetime %>
<h1>List Camera Command Queue</h1>
<section>
	<ul>
	% for command in camera_command_queue:
		<li>
			<strong>Command id: <span style="color: red;">${command.id}</span></strong>
			<ul>
				<li><strong>camera name: </strong> ${command.camera.name} <strong>id:</strong> ${command.camera.id}</li>
				<li><strong>owner: </strong> ${command.owner.email} <strong>id:</strong> ${command.owner.id}</li>
				<li><strong>action: </strong> ${command.action}</li>
				<li><strong>status: </strong> ${command.status}</li>
				<li><strong>date: </strong> ${command.date} / 
					<strong>diff time:</strong> <span style="color: red;">${(datetime.datetime.now()-command.date).seconds}</span> seconds ago</li>
			</ul>
		</li>
	% endfor
	</ul>
</section>
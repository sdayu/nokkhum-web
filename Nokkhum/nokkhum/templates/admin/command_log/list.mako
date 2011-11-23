<%inherit file="/base/base.mako"/>
<%block name='title'>List Command Log</%block>
<%! import datetime %>
<h1>List Command Log</h1>
<section>
	<ul>
	% for command in command_log:
		<li>
			<strong>Command id: <span style="color: red;">${command.id}</span></strong>
			<ul>
				<li><strong>camera name: </strong> ${command.camera.name} (${command.camera.id})</li>
				<li><strong>owner: </strong> ${command.owner.email} (${command.owner.id})</li>
				<li><strong>action: </strong> ${command.action}</li>
				<li><strong>attributes: </strong> ${command.attributes}</li>
				<li><strong>command date: </strong> ${command.command_date}</li>
				<li><strong>complete date: </strong> ${command.complete_date}</li>
				<li><strong>compute node name: </strong> ${command.compute_note.name}</li>
			</ul>
		</li>
	% endfor
	</ul>
</section>
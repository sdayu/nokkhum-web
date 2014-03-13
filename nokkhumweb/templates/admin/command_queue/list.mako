<%inherit file="/base/panel.mako"/>
<%block name='title'>List Command Queue</%block>
<%! import datetime %>

<%block name="where_am_i">
<li><a href="${request.route_path('admin.home')}">Admin</a></li>
<li><a href="${request.route_path('admin.command_queue.list')}">Command Queue</a></li>
</%block>

<%block name="panel_title">List Command Queue</%block>
<section>
<span style="font-weight: bold;">Current Date:</span> ${datetime.datetime.now()}
</section>

<section>
	<table class="table table-striped table-bordered table-condensed table-hover">
		<colgroup>
      		<col style="width: 10%"/>
      		<col style="width: 10%"/>
      		<col style="width: 10%"/>
      		<col style="width: 10%"/>
      		<col style="width: 10%"/>
      		<col style="width: 10%"/>
      		<col style="width: 20%"/>
      		<col style="width: 20%"/>
   		</colgroup>
		<thead>
  			<tr>
    			<th>ID</th>
    			<th>Processor Name</th>
    			<th>Owner</th>
    			<th>Action</th>
    			<th>Status</th>
    			<th>Date</th>
    			<th>Update Date</th>
    			<th>Diff Time</th>
  			</tr>
		</thead>
		<tbody>
			% for command in camera_command_queue:
			<tr>
				<td><a href="${request.route_path('admin.command_queue.show', command_queue_id=command.id)}">${command.id}</a></td>
				<td><a href="${request.route_path('admin.processors.show', processor_id=command.processor_command.processor.id)}">${command.processor_command.processor.name}</a></td>
				% if command.processor_command.command_type == "user":
				<td><a href="${request.route_path('admin.users.show', user_id=command.processor_command.owner.id)}">${command.processor_command.owner.email}</a></td>
				% else:
				<td>system</td>
				% endif
				<td>${command.processor_command.action}</td>
				<td>${command.processor_command.status}</td>
				<td>${command.processor_command.commanded_date}</td>
				<td>${command.processor_command.updated_date}</td>
				<td>${(datetime.datetime.now()-command.processor_command.updated_date).total_seconds()} s</td>
			</tr>
			% endfor
		</tbody>
	</table>
</section>
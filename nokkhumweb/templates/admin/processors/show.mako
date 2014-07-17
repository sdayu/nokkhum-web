<%inherit file="/base/panel.mako"/>
<%block name='title'>List Compute Node</%block>
<%! import datetime %>

<%block name="where_am_i">
<li><a href="${request.route_path('admin.home')}">Admin</a></li>
<li><a href="${request.route_path('admin.processors.list')}">Processor</a></li>
</%block>

<%block name="panel_title">Show Processor</%block>


<section>
			<ul>
				<li><b>ID: </b>${processor.id}</li>
				<li><b>Name: </b>${processor.name}</li>
				<li><b>Camera Name: </b>
					<ul>
						% for camera in processor.cameras:
						<li><b>${camera.name}:</b> <a href="${request.route_path('admin.cameras.show', camera_id=camera.id)}">${camera.id}</a></li>
						% endfor
					</ul>
				</li>
				<li><b>Create Date: </b>${processor.created_date}</li>
				<li><b>Last Update: </b>${processor.updated_date}</li>
				<li>
					<b>Owner: </b> ${processor.owner.email} 
					<b>id:</b> <a href="${request.route_path('admin.users.show', user_id=processor.owner.id)}">${processor.owner.id}</a>
					<b>status:</b> ${processor.owner.status}
				</li>
				<li>
					<b>Storage period:</b> ${processor.storage_period}
				</li>
				<li>
					<b>Project:</b> <a href="${request.route_path('projects.view', project_id=processor.project.id)}">${processor.project.name}</a>
				</li>
				<li><b>Status: </b>${processor.status}</li>
				<li><b>Operating:</b>
				<ul>
					<li><b>user status: <span style="color: red;">${processor.operating.user_command}</span></b></li>
					<li><b>Status: <span style="color: red;">${processor.operating.status}</span></b></li>
					<li><b>Last update:</b> ${processor.operating.updated_date}</li>
					<li><b>Diff time:</b> <span style="color: red;">${(datetime.datetime.now()-processor.operating.updated_date).seconds}</span> seconds ago</li>
					<li><b>Compute node:</b> 
					% if processor.operating.compute_node is not None:
					<a href="${request.route_path('admin.compute_nodes.show', compute_node_id=processor.operating.compute_node.id)}">${processor.operating.compute_node.host}</a>
					% else:
					Waiting
					% endif
					</li>
				</ul>
			</ul>

			<div class="panel panel-default">
				<div class="panel-heading">Operation</div>
				<div class="panel-body">
			    	<a class="btn btn-primary${' disabled' if processor.operating.user_command == 'run' else ''}" href="${request.route_path('processors.operating', project_id=processor.project.id, processor_id=processor.id, action='start')}"><span class="glyphicon glyphicon-play"></span> Start</a>
			    	<a class="btn btn-primary${' disabled' if processor.operating.user_command != 'run' else ''}" href="${request.route_path('processors.operating', project_id=processor.project.id, processor_id=processor.id, action='stop')}"><span class="glyphicon glyphicon-stop"></span> Stop</a>
				</div>
			</div>

</section>
<%inherit file="/base/panel.mako"/>
<%block name='title'>List Compute Node</%block>
<%! import datetime %>

<%block name="whare_am_i">
<li><a href="${request.route_path('admin.home')}">Admin</a></li>
<li><a href="${request.route_path('admin.processors.list')}">Processor</a></li>
</%block>

<%block name="panel_title">Show Processor</%block>


<section>
			<ul>
				<li><b>ID: </b>${processor.id}</li>
				<li><b>Camera: </b>${processor.name}</li>
				<li><b>Create Date: </b>${processor.create_date}</li>
				<li><b>Last Update: </b>${processor.update_date}</li>
				<li><b>Owner: </b> ${processor.owner.email} <b>id:</b> ${processor.owner.id} <b>status:</b> ${processor.owner.status}</li>
				<li><b>Operating:</b>
				<ul>
					<li><b>user status: <span style="color: red;">${processor.operating.user_command}</span></b></li>
					<li><b>Status: <span style="color: red;">${processor.operating.status}</span></b></li>
					<li><b>Last update:</b> ${processor.operating.update_date}</li>
					<li><b>Diff time:</b> <span style="color: red;">${(datetime.datetime.now()-processor.operating.update_date).seconds}</span> seconds ago</li>
					<li><b>Compute node:</b> 
					% if processor.operating.compute_node is not None:
					${processor.operating.compute_node.host}
					% else:
					Waiting
					% endif
					</li>
				</ul>
			</ul>
</section>
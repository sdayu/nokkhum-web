<%inherit file="/base/base.mako"/>
<%block name='title'>List Compute Node</%block>
<%! import datetime %>
<h1>List Compute Node</h1>
<section>
		<h2>Camera id: ${camera.id}</h2>
			<ul>
				<li><strong>Camera: </strong>${camera.name}</li>
				<li><strong>URL: </strong>${camera.url}</li>
				<li><strong>Username: </strong>${camera.username}</li>
				<li><strong>Password: </strong>${camera.password}</li>
				<li><strong>FPS: </strong>${camera.fps}</li>
				<li><strong>Image Size: </strong>${camera.image_size}</li>
				<li><strong>Camera Model: </strong>${camera.camera_model.name}</li>
				<li><strong>Manufactory: </strong>${camera.camera_model.manufactory.name}</li>
				<li><strong>Create Date: </strong>${camera.create_date}</li>
				<li><strong>Last Update: </strong>${camera.update_date}</li>
				<li><strong>Owner: </strong> ${camera.owner.email} <strong>id:</strong> ${camera.owner.id} <strong>status:</strong> ${camera.owner.status}</li>
				<li><strong>Operating:</strong>
				<ul>
					<li><strong>Status: <span style="color: red;">${camera.operating.status}</span></strong></li>
					<li><strong>Last update:</strong> ${camera.operating.update_date}</li>
					<li><strong>Diff time:</strong> <span style="color: red;">${(datetime.datetime.now()-camera.operating.update_date).seconds}</span> seconds ago</li>
					<li><strong>Compute node:</strong> 
					% if camera.operating.compute_node is not None:
					${camera.operating.compute_node.host}
					% else:
					Waiting
					% endif
					</li>
				</ul>
			</ul>
</section>
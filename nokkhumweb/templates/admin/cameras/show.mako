<%inherit file="/base/panel.mako"/>
<%block name='title'>List Compute Node</%block>
<%! import datetime %>

<%block name="panel_title">Show Camera</%block>
<section>
		<h3>Camera id: ${camera.id}</h3>
			<ul>
				<li><strong>Camera: </strong>${camera.name}</li>
				<li><strong>Video URL: </strong>${camera.video_url}</li>
				<li><strong>Audio URL: </strong>${camera.audio_url}</li>
				<li><strong>Image URL: </strong>${camera.image_url}</li>
				<li><strong>Username: </strong>${camera.username}</li>
				<li><strong>Password: </strong>${camera.password}</li>
				<li><strong>FPS: </strong>${camera.fps}</li>
				<li><strong>Image Size: </strong>${camera.image_size}</li>
				<li><strong>Camera Model: </strong>${camera.camera_model.name}</li>
				<li><strong>Manufactory: </strong>${camera.camera_model.manufactory.name}</li>
				<li><strong>Create Date: </strong>${camera.create_date}</li>
				<li><strong>Last Update: </strong>${camera.update_date}</li>
				<li><strong>Owner: </strong> ${camera.owner.email} <strong>id:</strong> ${camera.owner.id} <strong>status:</strong> ${camera.owner.status}</li>
			</ul>
</section>
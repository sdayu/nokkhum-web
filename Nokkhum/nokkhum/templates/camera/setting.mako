<%inherit file="../base/base.mako"/>
<%block name='title'>Setting camera of ${camera.name}</%block>
<h2>Camera infomation</h2>
<ul>
	<li><strong>Camera: </strong>${camera.name}</li>
	<li><strong>Create Date: </strong>${camera.create_date}</li>
	<li><strong>Setting: </strong>
		<a href="${request.route_path('camera_processor', name=camera.name)}">Image Processor Setting</a>
	</li>
</ul>
<p>
<strong>Current Image Processor:</strong>
</p>
<p>
	${camera.processors}
</p>

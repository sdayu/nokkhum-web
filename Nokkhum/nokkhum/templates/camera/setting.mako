<%inherit file="../base/base.mako"/>

<%def name="title()" >
Setting camera of ${camera.name}
</%def>

<%def name="body()">
<h2>Camera infomation</h2>
<ul>
	<li><strong>Camera: </strong>${camera.name}</li>
	<li><strong>Create Date: </strong>${camera.create_date}</li>
	<li><strong>Setting: </strong>
		<a href="/cameras/${camera.name}/processor">Image Processor Setting</a>
	</li>
</ul>
<p>
<strong>Current Image Processor:</strong>
</p>
<p>
	${camera.processors}
</p>
</%def>
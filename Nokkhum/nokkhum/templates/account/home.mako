<%inherit file="../base/base.mako"/>

<%def name="title()" >
Hello ${request.user.username}
</%def>

<%def name="body()">
<nav style="text-align: right;">
<a href="/signout">Sign out</a>
</nav>
<aside style="float:left; width:200px; background-color:#ffffdc">
	<ul>
		<li><a href="/cameras/add">Add camera</a></li>
	</ul>
</aside>
<article style="float:left; background-color:#ffffbd; width:70%">
	<section style="text-align: center;">
		<strong>Camera area</strong>
	</section>
	<section>
	% if cameras:
		<table border="1" width="100%">
			<thead>
				<tr>
					<th>Name</th>
					<th>URL</th>
					<th colspan="3">Operation</th>
				</tr>
			</thead>
			<tbody>
				% for camera in cameras:
				<tr>
					<td>${camera.name}</td>
					<td>${camera.url}</td>
					<td><a href='/cameras/${camera.name}/edit'>edit</a></td>
					<td><a href='/cameras/${camera.name}/delete'>delete</td>
					<td><a href='/cameras/${camera.name}/setting'>setting</td>
				</tr>
				% endfor
			</tbody>
		</table>
	% endif
	</section>
</article>

<footer style="clear: both;">This is footer
</footer>
</%def>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8"/>
		<title><%block name='title'>Nokkhum Web Front-end</%block></title>
		<link rel="icon" type="image/png" href="/public/nokkhum.png">
		<%block name='addition_header'></%block>
	</head>
	<body>
		${next.body()}
	<footer style="clear: both; padding-top: 20px;">
		<hr/>
		<div style="float: left; width: 200px">
			<strong>Quick Link</strong>
			<ul>
				<li><a href="/">Index</a></li>
				<li><a href="/home">Home</a></li>
				% if request.user is None: 
				<li><a href="/login">Login</a></li>
				% else:
				% if request.user.group.name == "admin":
				<li><a href="/admin">Administrator</a></li>
				% endif
				<li><a href="/logout">Logout</a></li>
				% endif
			</ul>
		</div>
		% if request.user.group.name == "admin":
		<div style="float: left; width: 300px">
			<strong>Administrator</strong>
			<ul>
				<li>
					<a href="${request.route_path('admin_command_queue_list')}">Display camera command queue</a>
				</li>
				<li>
					<a href="${request.route_path('admin_command_log_list')}">Display command log</a>
				</li>
				<li>
					<a href="${request.route_path('admin_compute_node_list')}">Display compute node</a>
				</li>
				<li>
					<a href="${request.route_path('admin_camera_list')}">Display camera</a>
				</li>
			</ul>
		</div>
		% endif
		<div style="clear: both;">
			<img alt="นกคุ่ม" src="/public/nokkhum.png" width="20px"/> Nokkhum Web Front-end for Nokkhum Video Surveillance System.
		</div>
	</footer>
	</body>
</html>
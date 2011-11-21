<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8"/>
		<title><%block name='title'>Nokkhum Web Front-end</%block></title>
	</head>
	<body>
		${next.body()}
	<footer style="clear: both; padding-top: 20px;">
		<hr/>
		<div style="float: left; width: 300px">
			<strong>Quick Link</strong>
			<ul>
				<li><a href="/">Index</a></li>
				<li><a href="/home">Home</a></li>
				% if request.user is None: 
				<li><a href="/login">Login</a></li>
				% else:
				<li><a href="/logout">Logout</a></li>
				% endif
			</ul>
		</div>
		<div style="clear: both;">
			<img alt="นกคุ่ม" src="/public/nokkhum.png" width="20px"/> Nokkhum Web Front-end for Nokkhum Video Surveillance System.
		</div>
	</footer>
	</body>
</html>
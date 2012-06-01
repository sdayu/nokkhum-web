<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8"/>
	<title><%block name='title'>Nokkhum Web Front-end</%block></title>
	<link href="/theme/style/default.css" rel="stylesheet" type="text/css">
	<link rel="icon" type="image/png" href="/public/images/nokkhum.png">
	<%block name='addition_header'></%block>
</head>
<body>
	<header>
		<span class="logo"><img src="/theme/images/nokkhum.png" alt="Nokkhum" /></span>
	<h1>Nokkhum</h1>
	<span>The distributed video surveillance system.</span>
	</header>
	<section id="wrapper">
		<aside>
			<ul>
				% if request.userid is None:
				<li><a href="/login" title="login">Log in</a></li>
				% else:
				<li><a href="/home" title="Home">Home</a></li>
				% if request.user.group.name == "admin":
				<li><a href="/admin" title="Administrator">Administrator</a></li>
				% endif
				<li><a href="/logout" title="log out">Log out</a></li>
				% endif
			</ul>
		</aside>
		<section id="content">
			${next.body()}
		</section>
	</section>
	<footer>
		<ul>
    		<li><h2>Quick Lick</h2></li>
			<li><a href="/">Index</a></li>
			<li><a href="/home">Home</a></li>
			<li><a href="/admin">Administrator</a></li>
			% if request.user is None: 
			<li><a href="/login">Login</a></li>
			% else:
			<li><a href="/logout">Logout</a></li>
			% endif
    	</ul>
    	<ul>
    		<li><h2>Administrator</h2></li>
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
			<li>
				<a href="${request.route_path('admin_user_list')}">Display user</a>
			</li>
    	</ul>
    	<ul>
    		<li><h2>Projects</h2></li>
        	<li><a href="https://github.com/sdayu/nokkhum-web" title="Nokkhum Web">Nokkhum Web</a></li>
        	<li><a href="https://github.com/sdayu/nokkhum-controller" title="Nokkhum Controller">Nokkhum Controller</a></li>
        	<li><a href="https://github.com/sdayu/nokkhum-compute" title="Nokkhum Compute">Nokkhum Compute</a></li>
        	<li><a href="https://github.com/sdayu/nokkhum-processor" title="Nokkhum Processor">Nokkhum Processor</a></li>
    	</ul>
    	<ul>
    		<li><h2>About</h2></li>
        	<li><a href="/" title="">About Nokkhum</a></li>
        	<li><a href="/" title="">Tutorial</a></li>
        	<li><a href="/" title="">History</a></li>
        	<li><a href="/" title="">Release</a></li>
    	</ul>
	</footer>
	<span class="detailfooter">
		&copy; 2012 Thanathip Limna. Department of Computer Engineering, Prince of Songkla University. All Rights Reserved. 
	</span>
</body>
</html>

<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title><%block name='title'>Nokkhum Web Front-end</%block></title>
	<link rel="icon" type="image/png" href="/public/images/nokkhum.png"/>
	
	<script src="/libs/jquery/jquery-2.0.3.js" type="text/javascript"></script>
	<script src="/libs/bootstrap/3.0.0/js/bootstrap.js" type="text/javascript"></script>
	<link href="/libs/bootstrap/3.0.0/css/bootstrap.css" rel="stylesheet" type="text/css"/>
	<link href="/theme/style/default.css" rel="stylesheet" type="text/css"/>
	
	<%block name='addition_header'></%block>
</head>
<body>
	
	<div class="row">
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<header>
				<span class="logo"><img src="/theme/images/nokkhum.png" alt="Nokkhum" /></span>
				<h1>Nokkhum</h1>
				<span>The distributed video surveillance system.</span>
			</header>
			<div style="border-top:3px double #22A7BD; margin: 1px 0 20px 0;"></div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-xs-3 col-sm-3 col-md-2 col-lg-2">
			<aside>
				<ul>
					% if request.userid is None:
					<li><a href="/login" title="login">Log in</a></li>
					<li><a href="/register" title="register">Register</a></li>
					% else:
					<li><a href="/home" title="Home">Home</a></li>
					% if len([role.name for role in request.user.roles if role.name == 'admin' ]) > 0:
					<li><a href="/admin" title="Administrator">Administrator</a></li>
					% endif
					<%
						projects = request.nokkhum_client.projects.list_user_projects(
									request.user.id
									)
					%>
					% if projects:
					<li style="height: auto;"><a href="/home" title="Home">Projects</a>
						<ul style="padding-bottom: 0px;">
							% for project in projects:
							<li><a href="${request.route_path('projects.index', project_id=project.id)}">${project.name}</a></li>
							% endfor
						</ul>
					</li>
					% endif
					<li><a href="/logout" title="log out">Log out</a></li>
					% endif
				</ul>
			</aside>
		</div>
		<div class="col-xs-9 col-sm-9 col-md-10 col-lg-10">
			<div id="content">
				${next.body()}
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<footer>
				<div class="row">
					<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
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
			    	</div>
			    	<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
				    	<ul>
				    		<li><h2>Administrator</h2></li>
				        	<li>
								<a href="${request.route_path('admin.command_queue.list')}">Display camera command queue</a>
							</li>
							<li>
								<a href="${request.route_path('admin.command_log.list')}">Display command log</a>
							</li>
							<li>
								<a href="${request.route_path('admin.compute_nodes.list')}">Display compute node</a>
							</li>
							<li>
								<a href="${request.route_path('admin.cameras.list')}">Display camera</a>
							</li>
							<li>
								<a href="${request.route_path('admin.users.list')}">Display user</a>
							</li>
				    	</ul>
				    </div>
				    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
				    	<ul>
				    		<li><h2>Projects</h2></li>
				        	<li><a href="https://github.com/sdayu/nokkhum-web" title="Nokkhum Web">Nokkhum Web</a></li>
				        	<li><a href="https://github.com/sdayu/nokkhum-controller" title="Nokkhum Controller">Nokkhum Controller</a></li>
				        	<li><a href="https://github.com/sdayu/nokkhum-compute" title="Nokkhum Compute">Nokkhum Compute</a></li>
				        	<li><a href="https://github.com/sdayu/nokkhum-processor" title="Nokkhum Processor">Nokkhum Processor</a></li>
				    		<li><a href="https://github.com/sdayu/nokkhum-compute" title="Nokkhum Compute">Nokkhum Compute</a></li>
				        </ul>
				    </div>
				    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
				    	<ul>
				    		<li><h2>About</h2></li>
				        	<li><a href="/" title="">About Nokkhum</a></li>
				        	<li><a href="/" title="">Tutorial</a></li>
				        	<li><a href="/" title="">History</a></li>
				        	<li><a href="/" title="">Release</a></li>
				    	</ul>
				    </div>
			    </div>
			    <div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="detailfooterbox">
							<span class="detailfooter">
								&copy; 2012 Thanathip Limna. Department of Computer Engineering, Prince of Songkla University. All Rights Reserved. 
							</span>
						</div>
					</div>
				</div>
			</footer>
		</div>
	</div>
	
</body>
</html>


<%inherit file="/base/base.mako"/>
<%block name='title'>Hello ${request.user.first_name} ${request.user.last_name}</%block>
<%! import urllib %>

<article style="background-color:#ffffbd;">
	<section title="Projects Section">
		<div class="panel panel-primary">
			<div class="panel-heading">
		    	<h2 class="panel-title">Projects</h2>
		  	</div>
		 	<div class="panel-body">
		    	% if projects:
				<table class="table table-striped table-bordered table-condensed table-hover">
					<thead>
						<tr>
							<th>Name</th>
							<th>Cameras</th>
						</tr>
					</thead>
					<tbody>
						% for project in projects:
						<tr>
							<td><a href="${request.route_path('projects.index', project_id=project.id)}">${project.name}</a></td>
							<td>${project.camera_number}</td>
						</tr>
						% endfor
					</tbody>
				</table>
				% endif
		  	</div>
		</div>
	</section>
	
</article>
<section>
<a href="${request.route_path('projects.add')}">Add Project</a>
</section>
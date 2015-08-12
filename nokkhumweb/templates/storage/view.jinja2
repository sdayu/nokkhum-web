<%inherit file="/base/panel.mako"/>
<%! 
	import urllib 
	from urllib.parse import unquote
%>
<%block name='title'>Show: ${url[url.rfind("/")+1:]}</%block>
<%block name="where_am_i">
${parent.where_am_i()}
<% 
	url_ = unquote(request.current_route_path())
	url_ = url_[len('/home/storage/list/'):]
	end = url_.find('/') if url_.find('/') != -1 else len(url_)
	processor_id = url_[:end]
	processor = request.nokkhum_client.processors.get(processor_id)
%>
<li>
	<a href="${request.route_path('projects.index', project_id=processor.project.id)}">Projects</a>
</li>
<li>
	<a href="${request.route_path('processors.index', project_id=processor.project.id)}">Processers</a>
</li>
<li>
	<a href="${urllib.parse.unquote(request.route_path('storage.list', extension='/%s'%processor.id))}">Storage</a>
</li>

</%block>
<%block name="panel_title">Show: ${url[url.rfind("/")+1:]}</%block>

% if file_type == "image":
<img src="${url}" />
% elif file_type == "video":
<video width="640" controls="controls" autoplay="autoplay">
	<%
	video_type = "video/mp4"
	if ".ogg" in url or ".ogv" in url:
		video_type = "video/ogg"
	else:
		video_type = "video/mp4"
	
	%>
  <source src="${url}" type="${video_type}"/>
  Your browser does not support the HTML 5 video tag.
</video>
<article>
<a href="${url}">Download</a>
<a href="${delete_url}">Delete</a>
</article>
% else:
unknow
% endif

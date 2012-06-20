<%inherit file="/base/base.mako"/>
<%block name='title'>Show</%block>

<h2>Show: ${url[url.rfind("/")+1:]}</h2>
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

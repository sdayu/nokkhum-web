<%inherit file="/base/base.mako"/>
<%block name='title'>Show</%block>

<h2>Show: ${url[url.rfind("/")+1:]}</h2>
% if file_type == "image":
<img src="${url}" />
% elif file_type == "video":
<video width="640" controls="controls" autoplay="autoplay">
  <source src="${url}"/>
  Your browser does not support the HTML 5 video tag.
</video>
<article>
<a href="${url}">Download</a>
<a href="${delete_url}">Delete</a>
</article>
% else:
unknow
%endif

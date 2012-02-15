<%inherit file="/base/base.mako"/>
<%block name='title'>Show</%block>

<h2>Show: ${url[url.rfind("/")+1:]}</h2>
% if file_type == "image":
<img src="${url}" />
% elif file_type == "video":
<video width="640" controls="controls">
  <source src="${url}" type="video/mp4" />
  Your browser does not support the HTML 5 video tag.
</video>
% else:
unknow
%endif

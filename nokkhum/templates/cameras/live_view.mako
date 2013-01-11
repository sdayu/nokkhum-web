<%inherit file="/base/base.mako"/>
<%block name='title'>Show</%block>

<h2>Live View Camera: ${camera.name}</h2>
<video width="640" autoplay="autoplay" controls="controls">
	<source src="${camera.url}" type="video/mp4"></source>
  Your browser does not support the HTML 5 video tag.
</video>
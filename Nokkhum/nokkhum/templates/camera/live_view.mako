<%inherit file="/base/base.mako"/>
<%block name='title'>Show</%block>

<h2>Live View Camera: ${camera.name}</h2>
<video width="640" autoplay="autoplay" controls="controls" src="${camera.url}">
  Your browser does not support the HTML 5 video tag.
</video>
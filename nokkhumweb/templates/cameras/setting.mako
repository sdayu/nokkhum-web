<%inherit file="/base/base.mako"/>
<%! import json %>
<%block name='title'>Setting camera of ${camera.name}</%block>
<%block name='addition_header'>
<link href="/js/syntax_highlighter/styles/shThemeDefault.css" rel="stylesheet" type="text/css" />
<script src="/js/syntax_highlighter/scripts/XRegExp.js" type="text/javascript"></script>
<script src="/js/syntax_highlighter/scripts/shCore.js" type="text/javascript"></script>
<script src="/js/syntax_highlighter/scripts/shBrushJScript.js" type="text/javascript"></script>
<script language="javascript">
SyntaxHighlighter.defaults['smart-tabs'] = false;
SyntaxHighlighter.all();
</script>
</%block>
<h2>Camera infomation</h2>
<ul>
	<li><strong>Camera: </strong>${camera.name}</li>
	<li><strong>Create Date: </strong>${camera.create_date}</li>
	<li><strong>Setting: </strong>
		<a href="${request.route_path('cameras.processor', camera_id=camera.id)}">Image Processor Setting</a>
	</li>
</ul>
<p>
<strong>Current Image Processor:</strong>
</p>
<pre name="code" class="brush: js; toolbar: false;">
	${json.dumps(camera.image_processors, indent=4)}
</pre>

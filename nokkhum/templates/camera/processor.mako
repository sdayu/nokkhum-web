<%inherit file="/base/base.mako"/>
<%block name='title'>Processor camera setting</%block>
<%block name='addition_header'>
<link href="/js/syntax_highlighter/styles/shThemeDefault.css" rel="stylesheet" type="text/css" />
<script src="/js/syntax_highlighter/scripts/XRegExp.js" type="text/javascript"></script>
<script src="/js/syntax_highlighter/scripts/shCore.js" type="text/javascript"></script>
<script src="/js/syntax_highlighter/scripts/shBrushJScript.js" type="text/javascript"></script>

<script language="javascript">
SyntaxHighlighter.defaults['smart-tabs'] = false;
SyntaxHighlighter.all();
</script>

## codemirror2 for html editor
<link rel="stylesheet" href="/libs/codemirror2/lib/codemirror.css">
<script src="/libs/codemirror2/lib/codemirror.js"></script>
<script src="/libs/codemirror2/mode/xml/xml.js"></script>
<script src="/libs/codemirror2/mode/javascript/javascript.js"></script>
<script src="/libs/codemirror2/mode/css/css.js"></script>
<script src="/libs/codemirror2/mode/htmlmixed/htmlmixed.js"></script>
<link rel="stylesheet" href="/libs/codemirror2/doc/docs.css">
<style>.CodeMirror {border-top: 1px solid black; border-bottom: 1px solid black;}</style>
</%block>
<h2>Processor Setting</h2>
<p><strong>Available Processor:</strong></p>
<ul>
% for processor in image_processors:
  <li>${processor.name}</li>
% endfor
</ul>

<div style="float: left; width: 400px">
${renderer.begin(request.route_path('camera_processor', name=camera.name))}
<div class="field">
<label for="name">processors: </label>
    ${renderer.errorlist("processors")}
    <div>
    	
    	${renderer.textarea("processors", cols="40", rows="50", id="processors")}
    </div>
</div>

<div style="width: 200px; text-align: right; padding-top: 10px">
    ${renderer.submit("submit", "Submit")}
</div>
${renderer.end()}
## codemirror2 render
<script>
      var editor = CodeMirror.fromTextArea(document.getElementById("processors"), {mode: "javascript", tabMode: "indent", lineNumbers: true});
</script>
</div>

<div style="float: left; width: 300px; background-color: #ffffcc; padding: 10px;">

<pre name="code" class="brush: js; toolbar: false;">
[
	{
		"name": "Motion Detector", 
		"interval": 3, 
		"resolution": 98, 
		"processors": [],
		"drop_motion": 5
	},
	
	{
		"name": "Face Detector", 
		"interval": 5, 
		"processors": []
	}, 
			
	{
		"name": "Video Recorder",
		"width": 640,
		"height": 480,
		"maximum_wait_motion": 5, 
		"fps": 10,
		"record_motion": true 
	}, 
		
	{
		"name": "Video Recorder",
		"width": 640,
		"height": 480,
		"fps": 10
	},
		
	{
		"name": "Image Recorder", 
		"width": 640, 
		"height": 480
	}
]
</pre>
</div>
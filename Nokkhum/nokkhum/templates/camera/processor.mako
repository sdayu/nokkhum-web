<%inherit file="../base/base.mako"/>
<%block name='title'>Processor camera setting</%block>
<h2>Processor Setting</h2>
<p><strong>Available Processor:</strong></p>
<ul>
% for processor in image_processors:
  <li>${processor.name}</li>
% endfor
</ul>

${renderer.begin(request.route_path('camera_processor', name=camera.name))}
<div class="field">
<label for="name">processors: </label>
    ${renderer.errorlist("processors")}
    <div>
    	${renderer.textarea("processors", cols="70", rows="30")}
    </div>
</div>

<div style="width: 200px; text-align: right; padding-top: 10px">
    ${renderer.submit("submit", "Submit")}
</div>
${renderer.end()}

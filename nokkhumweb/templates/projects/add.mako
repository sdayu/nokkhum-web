<%inherit file="/base/panel.mako"/>
<%block name='title'>Add Project</%block>

<%block name="panel_title">Add Project</%block>

<%block name="whare_am_i">
<li><a href="${request.route_path('projects.index')}">Project</a></li>
</%block>

<form role="form" action="${request.route_path('projects.add')}" method="POST">
<div class="field">
    
    <div class="form-group">
    	<label for="name">Name: </label>
    	${form.name(class_='form-control', id='project_name', placeholder='Enter project name')}
    	${form.get_error("name")}
    </div>
    
    <div class="form-group">
    	<label for="description">Description: </label>
    	${form.description(class_='form-control', placeholder='Enter description')}
    	${form.get_error("description")}
    </div>

	<div style="width: 100px; text-align: right; padding-top: 50px">
    	<input type="submit" value="Submit" />
	</div>
</form>

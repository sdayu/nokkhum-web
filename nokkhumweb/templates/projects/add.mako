<%inherit file="/base/base.mako"/>
<%block name='title'>Add Project</%block>
<style type="text/css">
	div.block {
		width: 370px; 
		text-align: right;
	}
	div.label {
		width:110px; 
		float:left;
	}
	div.field {
		float:left;
		padding-left: 5px;
	}
</style>
<h2>Add Project</h2>

<form action="${request.route_path('projects.add')}" method="POST">
<div class="field">
    ${form.get_error("name")}
    <div class="block">
    	<label for="name">Name: </label>
    	${form.name(size=30)}
    </div>
    ${form.get_error("description")}
    <div class="block">
    	<label for="url">Description: </label>
    	${form.description(cols=29, rows=5)}
    </div>

	<div style="width: 100px; text-align: right; padding-top: 50px">
    	<input type="submit" value="Submit" />
	</div>
</form>

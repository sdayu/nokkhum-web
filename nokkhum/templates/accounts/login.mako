<%inherit file="/base/base.mako"/>
<%block name='title'>User signin</%block>
<%block name='addition_header'>
<style type="text/css">
.input-label {
  font-weight: bold;
  margin: 0 0 .5em;
  display: block;
  -webkit-user-select: none;
  -moz-user-select: none;
  user-select: none;
  }
.input-text {
  border: 1px solid #006;
}
</style>
</%block>
	<h1>This is login page for Nokkhum</h1>

	% if len(message) > 0:
	<p>${message}</p>
	% endif

	<div>
		<form action="/login" method="POST">
		<label for="email" class='input-label'>
			<strong>Email:</strong><br/> 
			<input name='email' type='text' spellcheck="false" /><br/>
		</label>
		<label for="password" class='input-label'>
			<strong>Password:</strong><br/> 
			<input name='password' type='password' spellcheck="false" /><br/>
		</label>
		<input type="hidden" name="came_from" value="${came_from}"/>
		<input name='form.submitted' type="submit" value='Login' />
		</form>
	</div>
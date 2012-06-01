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
	<%! from webhelpers.html import tags %>
	<h1>This is login page for Nokkhum</h1>

	% if len(message) > 0:
	<p>${message}</p>
	% endif

	<div>
		${tags.form('/login', method='post')} 
		<label for="email" class='input-label'>
			<strong>Email:</strong><br/> 
			${tags.text('email', spellcheck="false", class_="input-text")}<br/>
		</label>
		<label for="password" class='input-label'>
			<strong>Password:</strong><br/> 
			${tags.password('password', spellcheck="false", class_="input-text")}<br/>
		</label>
		<input type="hidden" name="came_from" value="${came_from}"/>
		${tags.submit('form.submitted', u'Login')} ${tags.end_form()}
	</div>
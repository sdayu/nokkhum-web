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
	<style type="text/css">
	.error{
		color:red;
	}
	</style>
	<div>
		<form action="/register" method="POST">
		<label for="email" class='input-label'>
			<strong>Email:</strong><br/> 
			${form.email} ${form.get_error('email')}<br/> 
		</label>
		<label for="password" class='input-label'>
			<strong>Password:</strong><br/> 
			${form.password} ${form.get_error('password')}<br/>
		</label>
		<label for="password_conf" class='input-label'>
			<strong>Password Confirm:</strong><br/> 
			${form.password_conf} ${form.get_error('password_conf')}<br/>
		</label>
		<label for="first_name" class='input-label'>
			<strong>First name:</strong><br/> 
			${form.first_name} ${form.get_error('first_name')}<br/>
		</label>
		
		<label for="last_name" class='input-label'>
			<strong>Last name:</strong><br/> 
			${form.last_name} ${form.get_error('last_name')}<br/>
		</label>
		<input name='form.submitted' type="submit" value='Regist' />
		</form>
	</div>
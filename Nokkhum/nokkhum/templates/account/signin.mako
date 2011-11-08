<html>
<head>
<title>User signin</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
	<%! from webhelpers.html import tags %>
	<p>This is login page for Nokkhum</p>

	% if len(message) > 0:
	<p>${message}</p>
	% endif

	<p>
		${tags.form('/signin', method='post')} <label for="username">Username:</label>
		${tags.text('username')}<br /> <label for="password">Password:</label>
		${tags.password('password')}<br /> <input type="hidden"
			name="came_from" value="${came_from}" />
		${tags.submit('form.submitted', u'ลงชื่อเข้าใช้')} ${tags.end_form()}
	</p>
</body>
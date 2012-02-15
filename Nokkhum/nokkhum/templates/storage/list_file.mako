<%inherit file="/base/base.mako"/>
<%block name='title'>Browser</%block>

<h2>List</h2>
% if len(file_list) > 0:
<ul>
% for item in file_list:
	<li style="display:block; width:100%;">
		<a href="${item[1]}">${item[0]}</a> 
		<span style="display: inline-block; text-align: right; width: 200px;">
			<a href="${item[1]}" title="view">view</a> : 
			<a href="${item[2]}" title="delete">delete</a> 
		</span>
	</li>
% endfor
</ul>
% endif


<%inherit file="/base/base.mako"/>
<%block name='title'>Browser</%block>

<h2>List</h2>
% if len(file_list) > 0:
<ul>
% for item in file_list:
	<li style="display:block; width:100%; clear:both;">
		<span style="float: left; width:50%;"><a href="${item[1]}">${item[0]}</a> </span>
		<span style="display: inline-block; text-align: left; width:100px">
			<a href="${item[1]}" title="view">view</a> : 
			<a href="${item[2]}" title="delete">delete</a> 
		</span>
	</li>
% endfor
</ul>
% endif

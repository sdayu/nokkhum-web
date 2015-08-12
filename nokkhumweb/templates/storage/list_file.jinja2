<%inherit file="/base/panel.mako"/>
<%block name='title'>Browser</%block>
<%! 
	import urllib 
	from urllib.parse import unquote
%>

<%block name="where_am_i">
${parent.where_am_i()}
<% 
	url = unquote(request.current_route_path())
	url = url[len('/home/storage/list/'):]
	end = url.find('/') if url.find('/') != -1 else len(url)
	processor_id = url[:end]
	processor = request.nokkhum_client.processors.get(processor_id)
%>
<li>
	<a href="${request.route_path('projects.index', project_id=processor.project.id)}">Projects</a>
</li>
<li>
	<a href="${request.route_path('processors.index', project_id=processor.project.id)}">Processers</a>
</li>
<li>
	<a href="${urllib.parse.unquote(request.route_path('storage.list', extension='/%s'%processor.id))}">Storage</a>
</li>

</%block>

<%block name="panel_title">Storage List</%block>


	    		% if len(file_list) > 0:
				<%
				url = urllib.parse.unquote(request.current_route_path())
				back = url[:url.rfind('/')]
				print(file_list)
				%>
				% if back[back.rfind('/')+1:] != 'list':
				<a href="${back}">Back</a>
				% endif
				<ul>
				% for item in file_list:
					<li style="display:block; width:100%; clear:both;">
						<span style="float: left; width:50%;">
							% if ".png" in item[0]:
								<img src="${item[3]}" width="200px" />
							% else:
							<a href="${item[1]}">${item[0]}</a> 
							% endif
						</span>
						<span style="display: inline-block; text-align: left; width:100px">
							<a href="${item[1]}" title="view">view</a> : 
							<a href="${item[2]}" title="delete">delete</a> 
						</span>
					</li>
				% endfor
				</ul>
				% endif


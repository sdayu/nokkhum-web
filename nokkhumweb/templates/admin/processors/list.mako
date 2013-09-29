<%inherit file="/base/panel.mako"/>
<%block name='title'>List Cameras</%block>
<%! import datetime %>

<%block name="whare_am_i">
<li><a href="${request.route_path('admin.home')}">Admin</a></li>
<li><a href="${request.route_path('admin.processors.list')}">Processor</a></li>
</%block>

<%block name="panel_title">List Processors</%block>

<section>
	<table class="table table-striped table-bordered table-condensed table-hover">
		<thead>
  			<tr>
    			<th rowspan="2">ID</th>
    			<th rowspan="2">Update</th>
    			<th rowspan="2">Owner</th>
    			<th rowspan="2">Status</th>
    			<th colspan="3">Operating</th>
  			</tr>
  			<tr style="vertical-align: bottom">
         		<th>Status</th>
         		<th>Diff times</th>
         		<th>Compute node</th>
      		</tr>
		</thead>
		<tbody>
		% for processor in processors:
  			<tr>
    			<td>
    				<a href="${request.route_path('admin.processors.show', processor_id=processor.id)}">${processor.id}
    			</td>
    			<td>${processor.update_date}</td>
    			<td>${processor.owner.email}</td>
    			<td>${processor.status}</td>
    			<td>${processor.operating.status}</td>
    			<td>${(datetime.datetime.now()-processor.operating.update_date).seconds} s</td>
    			<td>
    				% if processor.operating.compute_node is not None:
					<a href="${request.route_path('admin.compute_nodes.show', compute_node_id=processor.operating.compute_node.id)}">${processor.operating.compute_node.host}</a>
					% else:
					Waiting
					% endif
				</td>
  			</tr>
  		% endfor
		</tbody>
	</table>
</section>
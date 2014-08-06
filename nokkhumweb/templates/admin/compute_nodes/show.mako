<%inherit file="/base/panel.mako"/>

<%! 
	import datetime 
	import json
%>

<%block name='addition_header'>
<script src="/public/bower_components/angular/angular.min.js"></script>
<script src="/public/bower_components/angular-google-chart/ng-google-chart.js"></script>

<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">

	var app = angular.module("app", ["googlechart"]);
	
	app.factory('Resources', function ($http, $interval) {
		
		var resources = {cpu:[[]], memory:[[]], disk:[[]], reported_date:[]};
		
		function get_data(){
			
			var response = $http.get("/apis/admin/compute_nodes/${compute_node.id}/resources");
			response.success(function(data, status, headers, config) {
				
				var cpu = [];
				var memory = [];
				var disk = [];

				angular.forEach( data.resources, function(v, i) {
					cpu.push({c:[{v: new Date(v.reported_date)}, {v: v.cpu.used}]});
					memory.push({c:[{v: new Date(v.reported_date)}, {v: v.memory.used}, {v: v.memory.free}, {v: v.memory.total}]});
					disk.push({c:[{v: new Date(v.reported_date)}, {v: v.disk.used}, {v: v.disk.free}, {v: v.disk.total}]});
				});
				
				resources.cpu = cpu
				resources.memory = memory
				resources.disk = disk

            });
			
			response.error(function(data, status, headers, config) {
                // alert("AJAX failed!");
            });
		};
		
		get_data();
		$interval(get_data, 10000);
		
        return resources
    });
	
	app.controller("CPUChartCtrl", function ($scope, Resources) {
		$scope.resources = Resources
		var chart = {};
	    chart.type = "LineChart";

	    chart.data =  {
	    	     cols: [{id: 'reportedDate', label: 'Reported Date', type: 'datetime'},
	    	            {id: 'cpu_usage', label: '% CPU Usage', type: 'number'}
	    	            ],
	    	     rows: []
	    	   };

	    chart.options = {
	    		title: 'CPU Usage'
	    };

	    chart.formatters = {};

	    $scope.chart = chart;
	    $scope.$watch( "resources", function(data){ 
			  chart.data.rows = data.cpu;
		   }, true);
	});

	app.controller("MemoryChartCtrl", function ($scope, Resources) {
		$scope.resources = Resources
		var chart = {};
	    chart.type = "LineChart";

	    chart.data =  {
	    	     cols: [{id: 'reportedDate', label: 'Reported Date', type: 'datetime'},
	    	            {id: 'memory_usage', label: 'Memory Usage', type: 'number'},
	    	            {id: 'memory_free', label: 'Memory Free', type: 'number'},
	    	            {id: 'memory_total', label: 'Memory Total', type: 'number'}
	    	            ],
	    	     rows: []
	    	   };

	    chart.options = {
	    	title: 'Memory Usage'
	    };

	    chart.formatters = {
	    	timeZone: 7
	    };

	    $scope.chart = chart;
  			
  		$scope.$watch( "resources", function(data){ 
  			  chart.data.rows = data.memory;
  		   }, true);
		});

	app.controller("DiskChartCtrl", function ($scope, Resources) {
		$scope.resources = Resources
		var chart = {};
	    chart.type = "LineChart";

	    chart.data =  {
	    		cols: [{id: 'reportedDate', label: 'Reported Date', type: 'datetime'},
	    	            {id: 'disk_usage', label: 'Disk Usage', type: 'number'},
	    	            {id: 'disk_free', label: 'Disk Free', type: 'number'},
	    	            {id: 'disk_total', label: 'Disk Total', type: 'number'}
	    	            ],
	    	     rows: []
	    	   };

	    chart.options = {
	    	title: 'Disk Usage'
	    };

	    chart.formatters = {};

	    $scope.chart = chart;
  			
  		$scope.$watch( "resources", function(data){ 
  			  chart.data.rows = data.disk;
  		   }, true);
		});
</script>

</%block>

<%block name='title'>List Compute Node</%block>

<%block name="where_am_i">
<li><a href="${request.route_path('admin.home')}">Admin</a></li>
<li><a href="${request.route_path('admin.compute_nodes.list')}">Compute Node</a></li>
</%block>
<%block name="panel_title">Show Compute Node</%block>

<section>
	<div ng-app="app">
		<div class="row">
			<div class="col-sm-4" ng-controller="CPUChartCtrl">
				CPU Resource 
				<div google-chart chart="chart"></div>
			</div>
			<div class="col-sm-4" ng-controller="MemoryChartCtrl">
				Memory Resource
				<div google-chart chart="chart"></div>
			</div>
			<div class="col-sm-4" ng-controller="DiskChartCtrl">
				Disk Resource
				<div google-chart chart="chart"></div>
			</div>
		</div>
	
	</div>
	<ul>
		<li><b>Compute Node id: </b><span style="color: red;">${compute_node.id}</span></li>
		<li><b>name: </b> ${compute_node.name}</li>
		<li><b>system: </b> ${compute_node.system}</li>
		<li><b>host: </b> ${compute_node.host}</li>
		<li><b>machine: </b> ${compute_node.machine}</li>
		<li><b>create date: </b> ${compute_node.created_date}</li>
		<li><b>update date: </b> ${compute_node.updated_date}</li>
		<li><b>last resource report date: </b> ${compute_node.updated_resource_date}</li>
		<li><b>diff time: </b> ${(datetime.datetime.now() - compute_node.updated_resource_date).seconds} s</li>
		% if compute_node.online:
		<li><b>status: </b> <span style="color: red;">Ready</span></li>
		% else:
		<li><b>status: </b> <span style="color: red;">Disconnect</span></li>
		% endif
		% if compute_node.is_vm:
		<li><b>VM:</b>
			<ul>
				<li><b><i>name:</i></b> ${compute_node.vm.name}</li>
				<li><b><i>image id:</i></b> ${compute_node.vm.image_id}</li>
				<li><b><i>instance id:</i></b> ${compute_node.vm.instance_id}</li>
				<li><b><i>instance type:</i></b> ${compute_node.vm.instance_type}</li>
				<li><b><i>ip_address:</i></b> ${compute_node.vm.ip_address}</li>
				<li><b><i>private_ip_address:</i></b> ${compute_node.vm.private_ip_address}</li>
				<li><b><i>started_instance_date:</i></b> ${compute_node.vm.started_instance_date}</li>
				<li><b><i>status:</i></b> ${compute_node.vm.status}</li>
				<li><b><i>extra:</i></b> <pre>${json.dumps(compute_node.vm.extra, indent=4) | n}</pre></li>
				
			</ul>
		</li>
		% endif
		
		<li><b>CPU:</b>
			<ul>
				<li><b><i>count:</i></b> ${compute_node.cpu.count}</li>
				<li><b><i>usage:</i></b> ${compute_node.cpu.used}</li>
				<li><b><i>all CPU:</i></b> ${compute_node.cpu.used_per_cpu}</li>
			</ul>
		</li>
		<li><b>RAM:</b>
			<ul>
				<li><b><i>total:</i></b> ${compute_node.memory.total}</li>
				<li><b><i>used:</i></b> ${compute_node.memory.used}</li>
				<li><b><i>free:</i></b> ${compute_node.memory.free}</li>
			</ul>
		</li>
		<li><b>Disk:</b>
			<ul>
				<li><b><i>total:</i></b> ${compute_node.disk.total}</li>
				<li><b><i>used:</i></b>${compute_node.disk.used}</li>
				<li><b><i>free:</i></b> ${compute_node.disk.free}</li>
			</ul>
		</li>
		<li>
			<b>processors:</b>
			<% processors = compute_node.manager.get_processors(compute_node.id) %>
			% if len(processors) > 0:
				<ul>
					% for processor in processors:
					<li>${processor.name}:<a href="${request.route_path('admin.processors.show', processor_id=processor.id)}">${processor.id}</a></li>
					% endfor
				</ul>
			% endif
		</li>
		<li><b>extra:</b> <pre>${json.dumps(compute_node.extra, indent=4) | n}</pre></li>
	</ul>
</section>
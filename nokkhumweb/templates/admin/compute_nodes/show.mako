<%inherit file="/base/panel.mako"/>

<%! 
	import datetime 
	import json
%>

<%block name='addition_header'>
<script src="/public/bower_components/angular/angular.min.js"></script>
<script src="/public/bower_components/Chart.js/Chart.min.js"></script>
<script src="/public/bower_components/angular-chart.js/dist/angular-chart.js"></script>

<link rel="stylesheet" href="/public/bower_components/angular-chart.js/dist/angular-chart.css">


<script type="text/javascript">

	var app = angular.module("app", ["chart.js"]);
	
	app.factory('Resources', function ($http, $interval) {
		
		var resources = {cpu:[[]], memory:[[]], disk:[[]], reported_date:[]};
		
		function get_data(){
			
			var response = $http.get("/apis/admin/compute_nodes/${compute_node.id}/resources");
			response.success(function(data, status, headers, config) {
				
				var cpu = [];
				var memory_used = [];
				var memory_free = [];
				var memory_total = [];
				var disk_used = [];
				var disk_free = [];
				var disk_total = [];
				var reported_date = [];

				angular.forEach( data.resources, function(v, i) {
					cpu.push(v.cpu.used);
					memory_used.push(v.memory.used);
					memory_free.push(v.memory.free);
					memory_total.push(v.memory.total);
					disk_used.push(v.disk.used);
					disk_free.push(v.disk.free);
					disk_total.push(v.disk.total);
					reported_date.push(new Date(v.reported_date).getMilliseconds());
				});
				
				resources.cpu = [cpu]
				resources.memory = [memory_used, memory_free, memory_total]
				resources.disk = [disk_used, disk_free, disk_total]
				resources.reported_date = reported_date

				// console.log("resources: ", resources.reported_date)
            });
			
			response.error(function(data, status, headers, config) {
                // alert("AJAX failed!");
            });
		};
		
		$interval(get_data, 5000);
		
        return resources
    });

	app.controller("CPUCtrl", function ($scope, Resources) {
		
	  $scope.resources = Resources;
	  $scope.labels = [];
	  $scope.series = ['% Usage'];
	  $scope.data = [[]];
	  $scope.options = {animation: false, bezierCurve : false}
	  $scope.onClick = function (points, evt) {
	    console.log(points, evt);
	  };
	  $scope.$watch( "resources", function(data){ 
		  console.log("re",data.reported_date); 
		  	$scope.labels = data.reported_date;
		  	$scope.data = data.cpu;
	   }, true );
	  $scope.$watch( "data", function(data){ console.log("data",data); }, true );
	  $scope.$watch( "labels", function(data){ console.log("labels",data); }, true );
	});

	app.controller("MemoryCtrl", function ($scope, Resources) {
		$scope.resources = Resources;
  		$scope.labels = [];
  		$scope.series = ['Usage', 'Free', 'Total'];
  		$scope.data = [[]];
  	    $scope.options = {animation: false, bezierCurve: false, datasetFill: false,}
  		$scope.onClick = function (points, evt) {
    		console.log(points, evt);
  			};
		});

	app.controller("DiskCtrl", function ($scope, Resources) {
		$scope.resources = Resources;
		$scope.labels = [];
		$scope.series = ['Usage', 'Free', 'Total'];
		$scope.data = [[]];
		 $scope.options = {animation: false, bezierCurve: false, datasetFill: false,}
		$scope.onClick = function (points, evt) {
			console.log(points, evt);
		  };
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
			<div class="col-sm-4" ng-controller="CPUCtrl">
				CPU Resource 
				<%doc>
				<canvas id="cpu" class="chart chart-line" data="resources.cpu" labels="resources.reported_date" legend="true" series="series" click="onClick" options="options"></canvas> 
				</%doc>
				<canvas id="cpu" class="chart chart-line" data="data" labels="labels" legend="true" series="series" click="onClick" options="options"></canvas> 
				
			</div>
			<div class="col-sm-4" ng-controller="MemoryCtrl">
				Memory Resource
				<canvas id="memory" class="chart chart-line" data="resources.memory" labels="resources.reported_date" legend="true" series="series" click="onClick" options="options"></canvas> 
			</div>
			<div class="col-sm-4" ng-controller="DiskCtrl">
				Disk Resource
				<canvas id="disk" class="chart chart-line" data="resources.disk" labels="resources.reported_date" legend="true" series="series" click="onClick" options="options"></canvas> 
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
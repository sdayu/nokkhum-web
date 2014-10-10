<%inherit file="/base/panel.mako"/>
<%block name='title'>List Compute Node</%block>
<%! import datetime %>

<%block name='addition_header'>

## angular-nvd3
<script src="/public/bower_components/angular/angular.min.js"></script>
<meta charset="utf-8">
<script src="/public/bower_components/d3/d3.js"></script>
<script src="/public/bower_components/nvd3/nv.d3.js"></script>
<script src="/public/bower_components/angular-nvd3/dist/angular-nvd3.js"></script>
<link rel="stylesheet" href="/public/bower_components/nvd3/nv.d3.css">

<script type="text/javascript">

	var app = angular.module("app", ["nvd3"]);
	
	app.factory('Resources', function ($http, $interval) {
		
		var resources = {cpu:[], memory:[]};
		
		function get_data(){
			
			var response = $http.get("/apis/admin/processors/${processor.id}/resources");
			response.success(function(data, status, headers, config) {
				
				var cpu_used = [];
				var memory_used = [];

				angular.forEach( data.resources, function(v, i) {
					cpu_used.push({x:new Date(v.reported_date), y:v.cpu});
					memory_used.push({x:new Date(v.reported_date), y:v.memory});
				});
				
				resources.cpu = {used:cpu_used};
				resources.memory = {used: memory_used};

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

		$scope.options = {
		        chart: {
		            type: 'lineChart',
		            height: 250,
		            x: function(d){ return d.x; },
		            y: function(d){ return d.y; },
		            margin: {
		                "top": 100,
		                "right": 30,
		                "bottom": 40,
		                "left": 40
		              },
		            useInteractiveGuideline: true,
		            transitionDuration: 1,
		            yAxis: {
		            	axisLabel: '% Usage',
		                tickFormat: function(d){
		                   return d3.format()(d);
		                },
		                axisLabelDistance: 50
		            },
		            xAxis: {
		            	axisLabel: 'Time',
		                tickFormat: function(d){
		                   return d3.time.format('%H:%M:%S')(new Date(d));
		                }
		            },
		            forceY:[0],
		        },
		        
				title: {
		            enable: true,
		            text: 'Compute Node CPU Usage'
		        }
		    };
		
		$scope.data = [];
		
	    $scope.$watch( "resources", function(data){ 
	    	if(typeof(data.cpu.used) == 'undefined')
	    		return;
	    	$scope.data = [{values:data.cpu.used, key:"% CPU used"}];
		   }, true);
	});

	app.controller("MemoryChartCtrl", function ($scope, Resources) {
		$scope.resources = Resources
		
		$scope.options = {
		        chart: {
		            type: 'lineChart',
		            height: 250,
		            x: function(d){ return d.x; },
		            y: function(d){ return d.y; },
		            margin: {
		                "top": 100,
		                "right": 30,
		                "bottom": 40,
		                "left": 60
		              },
		            useInteractiveGuideline: true,
		            transitionDuration: 1,
		            yAxis: {
		            	axisLabel: 'Unit (MB)',
		                tickFormat: function(d){
		                   return d3.format('.2f')(d/Math.pow(1024, 2));
		                },
		                axisLabelDistance: 25
		            },
		            xAxis: {
		            	axisLabel: 'Time',
		                tickFormat: function(d){
		                   return d3.time.format('%H:%M:%S')(new Date(d));
		                }
		            },
		            forceY:[0]
		        },
		        
				title: {
		            enable: true,
		            text: 'Compute Node Memory Usage'
		        }
		    };
		    

		$scope.data = [];
	    $scope.$watch( "resources", function(data){ 
	    	if(typeof(data.memory.used) == 'undefined')
	    		return;
	    	$scope.data = [{values:data.memory.used, key:"Memory used"}];
		   }, true);
		
		});
</script>

</%block>

<%block name="where_am_i">
<li><a href="${request.route_path('admin.home')}">Admin</a></li>
<li><a href="${request.route_path('admin.processors.list')}">Processor</a></li>
</%block>

<%block name="panel_title">Show Processor</%block>


<section>
	<div ng-app="app">
		<div class="row">
			<div class="col-sm-6" ng-controller="CPUChartCtrl">
				CPU Resource 
				<nvd3 options='options' data='data'></nvd3>
			</div>
			<div class="col-sm-6" ng-controller="MemoryChartCtrl">
				Memory Resource
				<nvd3 options='options' data='data'></nvd3>
			</div>
		</div>
	</div>
	
	<ul>
		<li><b>ID: </b>${processor.id}</li>
		<li><b>Name: </b>${processor.name}</li>
		<li><b>Camera Name: </b>
			<ul>
				% for camera in processor.cameras:
				<li><b>${camera.name}:</b> <a href="${request.route_path('admin.cameras.show', camera_id=camera.id)}">${camera.id}</a></li>
				% endfor
			</ul>
		</li>
		<li><b>Create Date: </b>${processor.created_date}</li>
		<li><b>Last Update: </b>${processor.updated_date}</li>
		<li>
			<b>Owner: </b> ${processor.owner.email} 
			<b>id:</b> <a href="${request.route_path('admin.users.show', user_id=processor.owner.id)}">${processor.owner.id}</a>
			<b>status:</b> ${processor.owner.status}
		</li>
		<li>
			<b>Storage period:</b> ${processor.storage_period}
		</li>
		<li>
			<b>Project:</b> <a href="${request.route_path('projects.view', project_id=processor.project.id)}">${processor.project.name}</a>
		</li>
		<li><b>Status: </b>${processor.status}</li>
		<li><b>Operating:</b>
		<ul>
			<li><b>user status: <span style="color: red;">${processor.operating.user_command}</span></b></li>
			<li><b>Status: <span style="color: red;">${processor.operating.status}</span></b></li>
			<li><b>Last update:</b> ${processor.operating.updated_date}</li>
			<li><b>Diff time:</b> <span style="color: red;">${(datetime.datetime.now()-processor.operating.updated_date).seconds}</span> seconds ago</li>
			<li><b>Compute node:</b> 
			% if processor.operating.compute_node is not None:
			<a href="${request.route_path('admin.compute_nodes.show', compute_node_id=processor.operating.compute_node.id)}">${processor.operating.compute_node.host}</a>
			% else:
			Waiting
			% endif
			</li>
		</ul>
	</ul>

	<div class="panel panel-default">
		<div class="panel-heading">Operation</div>
		<div class="panel-body">
	    	<a class="btn btn-primary${' disabled' if processor.operating.user_command == 'run' else ''}" href="${request.route_path('processors.operating', project_id=processor.project.id, processor_id=processor.id, action='start')}"><span class="glyphicon glyphicon-play"></span> Start</a>
	    	<a class="btn btn-primary${' disabled' if processor.operating.user_command != 'run' else ''}" href="${request.route_path('processors.operating', project_id=processor.project.id, processor_id=processor.id, action='stop')}"><span class="glyphicon glyphicon-stop"></span> Stop</a>
		</div>
	</div>

</section>
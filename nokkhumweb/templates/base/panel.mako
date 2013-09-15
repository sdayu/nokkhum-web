<%inherit file="/base/base.mako"/>

<section title="where am i">
	<ol class="breadcrumb">
	  <li><a href="${request.route_path('home')}">Home</a></li>
	  <%block name="whare_am_i"></%block>
	</ol>
</section>

<article>
	<section>
		<div class="panel panel-primary">
	  		<div class="panel-heading">
	    		<h2 class="panel-title"><%block name="panel_title"></%block></h2>
	  		</div>
	  		<div class="panel-body">
				${next.body()}
	  		</div>
	  	</div>
	</section>
</article>

<%block name="more_body"></%block>
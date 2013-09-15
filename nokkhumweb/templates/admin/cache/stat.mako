<%inherit file="/base/base.mako"/>
<%block name='title'>Cache File Atatistic</%block>
<%! import datetime %>
<h1>Show Cache File Statistic</h1>
<section>
% if not cache_dir:
	<article>Not cache directory found</article>
% else:
	<article>There are <strong>${file_count}</strong> files in cache.</article>
	<a href="${request.route_path('admin.cache.clear')}">Clear</a>
% endif
</section>
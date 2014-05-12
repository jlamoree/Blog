<cfsilent>
	<cfset env = getSetting("environment")/>
	<cfset rev = getSetting("revision")/>
	<cfset site = getSetting("site")/>

	<cfif event.valueExists("pageTitle")>
		<cfset pageTitle = site.pageTitle & ": " & event.getValue("pageTitle")/>
	<cfelse>
		<cfset pageTitle = site.pageTitle/>
	</cfif>
</cfsilent>
<cfcontent type="text/html" reset="true"/><!DOCTYPE html>
<html lang="en">
<head>
	<cfoutput>
		<title>#pageTitle#</title>
		<meta charset="utf-8"/>
		<meta name="viewport" content="width=device-width, initial-scale=1"/>
		<cfif env eq "production">
			<link rel="stylesheet" href="/css/bootstrap.min.css?r=#rev#"/>
		<cfelse>
			<link rel="stylesheet" href="/css/bootstrap.css?r=#rev#"/>
		</cfif>
	</cfoutput>
</head>

<head>
	<meta charset="utf-8">
	<title>Lamoree Software Blog</title>
	<link rel="icon" href="/favicon.ico" type="image/x-icon"/>
</head>
<body>
<nav class="navbar navbar-default" role="navigation">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse">
				<span class="sr-only">Toggle Navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<cfoutput><a class="navbar-brand" href="/">#site.brandName#</a></cfoutput>
		</div>

		<div class="collapse navbar-collapse" id="navbar-collapse">
			<ul class="nav navbar-nav">
				<li><a href="/blog">Blog</a></li>
			</ul>
		</div>
	</div>
</nav>
<div class="container">
	<cfoutput>
	#renderView()#
	</cfoutput>
</div>

<cfoutput>
	<cfif env eq "production">
		<script src="/js/jquery.min.js?r=#rev#"></script>
		<script src="/js/bootstrap.min.js?r=#rev#"></script>
	<cfelse>
		<script src="/js/jquery.js?r=#rev#"></script>
		<script src="/js/bootstrap.js?r=#rev#"></script>
	</cfif>
</cfoutput>

</body>
</html>

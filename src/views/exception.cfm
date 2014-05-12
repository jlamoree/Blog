<cfsilent>

	<cfset eb = event.getValue("exceptionBean")/>
	<cfset env = getController().getSetting("environment")/>
	<cfset rev = getController().getSetting("revision")/>
	<cfset site = getController().getSetting("site")/>
	<cfset pageTitle = site.pageTitle & ": Error Information"/>

</cfsilent>
<cfcontent type="text/html" reset="true"/><!DOCTYPE html>
<html lang="en">
<head>
	<cfoutput>
		<title>#pageTitle#</title>
		<meta charset="utf-8"/>
		<meta name="viewport" content="width=device-width, initial-scale=1"/>
		<link rel="stylesheet" href="/css/bootstrap.min.css?r=#rev#"/>
	</cfoutput>
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
	<h3>An Error Has Occurred</h3>

	<cfif env eq "production">
		<p>Unfortunately, your request cannot be processed. Information about the problem has been recorded and staff has been alerted. Thanks for your patience.	</p>
	<cfelse>
		<cfoutput>
			<table class="table table-condensed">
			<tr>
				<td valign="top"><strong>Type</strong></td>
				<td valign="top">#eb.getType()#</td>
			</tr>
			<tr>
				<td valign="top"><strong>Message</strong></td>
				<td valign="top">#eb.getMessage()#</td>
			</tr>
			<cfif len(eb.getDetail())>
				<tr>
					<td valign="top"><strong>Detail</strong></td>
					<td valign="top">#eb.getDetail()#</td>
				</tr>
			</cfif>
			<cfif len(eb.getExtendedInfo())>
				<tr>
					<td valign="top"><strong>Extended Info</strong></td>
					<td valign="top">#eb.getExtendedInfo()#</td>
				</tr>
			</cfif>
			<tr>
				<td valign="top"><strong>Tag Context</strong></td>
				<td valign="top">
					<cfloop array="#eb.getTagContext()#" index="ctx">
						<code>#ctx.template# (#ctx.line#)</code><br/>
					</cfloop>
				</td>
			</tr>
			<tr>
				<td valign="top"><strong>Stack Trace</strong></td>
				<td valign="top"><pre class="pre-scrollable">#encodeForHTML(eb.getStackTrace())#</pre></td>
			</tr>
			</table>
		</cfoutput>
	</cfif>
</div>

<cfoutput>
	<script src="/js/jquery.min.js?r=#rev#"></script>
	<script src="/js/bootstrap.min.js?r=#rev#"></script>
</cfoutput>

</body>
</html>

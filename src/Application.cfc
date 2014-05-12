<cfcomponent extends="coldbox.system.Coldbox" output="false">
	<cfset this.root = replace(getDirectoryFromPath(getMetadata(this).path), "\", "/", "all")/>
	<cfset this.parent = reReplace(this.root, "/[^/]+/$", "/")/>

	<cfset this.name = "blog"/>
	<cfset this.sessionManagement = true/>
	<cfset this.sessionTimeout = createTimeSpan(0, 0, 30, 0)>
	<cfset this.clientManagement = false/>
	<cfset this.setClientCookies = false/>
	<cfset this.setDomainCookies = false/>

	<cfset COLDBOX_APP_ROOT_PATH = this.root/>
	<cfset COLDBOX_APP_MAPPING = ""/>
	<cfset COLDBOX_CONFIG_FILE = ""/>
	<cfset COLDBOX_APP_KEY = ""/>

	<cffunction name="onApplicationStart" returntype="boolean" access="public" output="false">
		<cfset request["connection"] = getConnectionInspector().getConnectionMemento()/>
		<cfset application["revision"] = "@WEBAPP_REVISION@"/>
		<cfset loadColdBox()/>
		<cfreturn true/>
	</cffunction>

	<cffunction name="onRequestStart" returnType="boolean" output="true">
		<cfargument name="targetPage" type="string" required="true"/>

		<cfset reloadChecks()/>
		<cfset processColdBoxRequest()/>
		<cfreturn true/>
	</cffunction>

	<cffunction name="onError" access="public" returntype="void" output="true">
		<cfargument name="exception" type="struct" required="true"/>

		<cfset var environment = "@WEBAPP_ENVIRONMENT@"/>
		<cfset var logText = "Exception caught in Application.onError()"/>

		<cfheader statuscode="503" statustext="Service Unavailable"/>
		<cfif environment eq "production">
			<cfoutput>
				<h1>Service Unavailable</h1>
				<p>An error has occurred.</p>
			</cfoutput>
		<cfelse>
			<cfdump var="#arguments.exception#"/>
		</cfif>

		<cfif structKeyExists(arguments.exception, "message")>
			<cfset logText = logText & ": " & arguments.exception.message/>
		</cfif>
		<cflog type="fatal" log="application" text="#logText#"/>
	</cffunction>

	<cffunction name="getConnectionInspector" returntype="ConnectionInspector" access="private" output="false">
		<cfif not structKeyExists(application, "connectionInspector") or structKeyExists(url, "fwreinit")>
			<cfset application["connectionInspector"] = createObject("component", "ConnectionInspector").init()/>
		</cfif>
		<cfreturn application.connectionInspector/>
	</cffunction>

</cfcomponent>
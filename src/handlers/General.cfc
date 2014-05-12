<cfcomponent extends="coldbox.system.eventhandler" output="false">

	<cffunction name="index" access="public" returntype="void" output="false">
		<cfargument name="event" type="coldbox.system.web.context.RequestContext" required="true"/>

		<cfset var _event = arguments.event/>

	</cffunction>

</cfcomponent>
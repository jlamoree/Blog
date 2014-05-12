<cfcomponent output="false">

	<cffunction name="onInvalidEvent" returntype="void" access="public" output="false">
		<cfargument name="event" type="coldbox.system.web.context.RequestContext" required="true"/>

		<cfset var _event = arguments.event/>

		<cfset _event.setView("invalidEvent")/>
	</cffunction>

	<cffunction name="onException" returntype="void" access="public" output="false">
		<cfargument name="event" type="coldbox.system.web.context.RequestContext" required="true"/>

		<cfset var _event = arguments.event/>
		<cfset var eb = _event.getValue("exceptionBean")/>

		<cfset variables.log.error("Exception caught: #eb.getMessage()#")/>

		<!--- 
			The view is automatically set to the value in coldbox.customErrorTemplate
			However, the template won't execute as a normal view. Copy environment to it.
		 --->
		<cfset _event.setValue("environment", getSetting("environment"))/>
	</cffunction>

</cfcomponent>
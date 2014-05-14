<cfcomponent extends="coldbox.system.testing.BaseSpec" output="false">

	<cffunction name="testFoo" returntype="void" access="public" output="false">
		<cfset $assert.isTrue(true)/>
	</cffunction>

</cfcomponent>
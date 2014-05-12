<cfcomponent output="false">

	<cffunction name="configure" returntype="void" access="public" output="false">
		<cfscript>
			variables.coldbox = {
				//Application Setup
				appName = "Blog",
				reinitPassword = "@COLDBOX_REINIT_PASSWORD@",

				//Implicit Events
				defaultEvent = "Home.index",
				requestStartHandler = "",
				requestEndHandler = "",
				applicationStartHandler = "",
				applicationEndHandler = "",
				sessionStartHandler = "",
				sessionEndHandler = "",
				missingTemplateHandler = "",

				//Error Handling
				exceptionHandler = "Error.onException",
				onInvalidEvent = "Error.onInvalidEvent",
				customErrorTemplate = "views/exception.cfm",

				//Application Aspects
				handlerCaching = true,
				eventCaching = true,

				// Flash scope
				flashURLPersistScope = "session"
			};

			variables.settings = {
				version = "@WEBAPP_VERSION@",
				revision = "@WEBAPP_REVISION@",
				site = {
					pageTitle = "Lamoree Software",
					brandName = "Lamoree Software"
				}
			};

			variables.modules = {
				autoReload = false,
				include = [],
				exclude = []
			};

			variables.wireBox = {
				enabled = true,
				singletonReload = false
			};

			variables.logbox = {
				appenders = {
					console = {class="coldbox.system.logging.appenders.ConsoleAppender"},
					logfile = {
						class = "coldbox.system.logging.appenders.AsyncRollingFileAppender",
						properties = {
							filePath = "@WEBAPP_LOG_DIR@",
							filename = "blog",
							fileMaxArchives = 10,
							fileMaxSize = 5000,
							autoExpand = false
						}
					}
				},
				root = {levelMin="FATAL", levelMax="INFO", appenders="*"},
				categories = {
					"coldbox.system.cache" = {levelMax="WARN", appenders="logfile"},
					"interceptors" = {levelMax="WARN", appenders="logfile"},
					"handlers" = {levelMax="WARN", appenders="logfile"},
					"model" = {levelMax="WARN", appenders="logfile"}
				}
			};

			variables.layoutSettings = {
				defaultLayout = "Main"
			};

			variables.interceptorSettings = {
				throwOnInvalidStates = true
			};

			variables.interceptors = [
				 {class="coldbox.system.interceptors.Autowire"},
				 {class="coldbox.system.interceptors.SES"}
			];
		</cfscript>
	</cffunction>

	<cffunction name="detectEnvironment" returntype="string" access="public" output="false">
		<cfset var environment = "@WEBAPP_ENVIRONMENT@"/>

		<cflog type="info" log="application" text="Configured ColdBox using #environment# environment"/>
		<cfreturn environment/>
	</cffunction>

	<cffunction name="development" returntype="void" access="public" output="false">
		<cfset var item = ""/>

		<cfloop collection="#variables.logbox.categories#" item="item">
			<cfif findNoCase("coldbox.", item) eq 0>
				<cfset variables.logbox.categories[item].levelMax = "DEBUG"/>
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="production" returntype="void" access="public" output="false">
	</cffunction>

</cfcomponent>
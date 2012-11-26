dataSource {
	pooled = true
	//dbCreate = "create-drop" // one of 'create', 'create-drop','update'
}
hibernate {
	cache.use_second_level_cache=true
	cache.use_query_cache=true
	cache.provider_class='net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
	development {
		dataSource {
			dbCreate = "create-drop"
			driverClassName = "org.postgresql.Driver"
			url = "jdbc:postgresql://localhost:5432/gskeleton2"
			username = "admin"
			password = "password"
			dialect = "com.siberhus.orm.hibernate.dialect.TableNameSequencePostgreSQLDialect"
		}
	}
	test {
		dataSource {
			dbCreate = "update"
		}
	}
	production {
		dataSource {
			dbCreate = "update"
//			jndiName = "java:comp/env/jdbc/gskeleton"
			driverClassName = "org.postgresql.Driver"
			url = "jdbc:postgresql://localhost:5432/gskeleton2"
			username = "admin"
			password = "password"
			dialect = "com.siberhus.orm.hibernate.dialect.TableNameSequencePostgreSQLDialect"
		}
	}
}
package com.siberhus.gskeleton.resource

import com.siberhus.gskeleton.Auditable
import com.siberhus.gskeleton.base.Role
import org.springframework.util.ClassUtils

/**
 * User Database Connection
 */
class DbConnProfile extends Auditable {

	String profileName
	String dbUsername
	String dbPassword
	String dbUrl
	String dbDriver
	String dbDriverPath
	String description
	String status
	
	String toString(){
		return profileName
	}

	//static transients = ['fieldName']

	static mapping = {
		table 'gsk_dbcon_profiles'
		profileName column: 'profile_name'
		dbUsername column: 'db_username'
		dbPassword column: 'db_password'
		dbUrl column: 'db_url'
		dbDriver column: 'db_driver'
		dbDriverPath column: 'db_driver_path'
		roles column: 'dbcon_profile_id', joinTable: 'gsk_dbcon_profile_roles'
	}

	static constraints = {
		profileName(blank:false)
		dbUsername(nullable:true)
		dbPassword(nullable:true)
		dbUrl(blank:false)
		dbDriver(blank:false, validator: {val, obj->
			try{
				ClassUtils.forName(val)
			}catch(ClassNotFoundException e){
				return '_error.dbConnProfile.classNotFound'
			}
			return true
		})
		dbDriverPath(nullable:true, validator: {val, obj->
			if(val){
				File file = new File(val)
				if(!file.exists()){
					return '_error.dbConnProfile.fileNotFound'
				}else if(!file.isFile()){
					return '_error.dbConnProfile.mustBeNormalFile'
				}
				obj.dbDriverPath = file.getCanonicalPath()
			}
			return true
		})
		description(nullable:true, maxSize:4000)
		status(nullable:false, inList:['A','I'])
	}

	static hasMany = [roles: Role]

	static searchFields = [profileName:'like',dbDriver:'=',dbUsername:'like',description:'like',status:'=']
//	static exportFields = ['fieldName']
//	static lookupFields = [fieldName:]
	static listFields = ['profileName', 'description', 'status']
}

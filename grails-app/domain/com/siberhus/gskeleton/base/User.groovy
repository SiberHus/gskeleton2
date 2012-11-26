package com.siberhus.gskeleton.base

import com.siberhus.gskeleton.Auditable;



class User extends Auditable {
	
	String username
	String password
	boolean systemAdmin = false
	String firstName
	String lastName
	String email
	String mobilePhone
	String workPhone
	String homePhone
	String addressLine1
	String addressLine2
	String city
	String state //state,province,region
	String postalCode
	String country
	String photoImgPath
	String description
	boolean auditTrail = false
	Integer pwdAge = -1//password age in days
	java.sql.Date expiryDate
	java.sql.Date expiryDate_
	Date pwdChangedDate = new Date()
	String status = 'A'
	
	String toString(){
		return username
	}
	
	String getFullName(){
		return "$firstName $lastName"
	}
	
	void setFullName(String fullName){}
	
	static transients = [ "expiryDate_"]
	                      
	static mapping = {
		table 'gsk_users'
		firstName column: 'first_name'
		lastName column: 'last_name'
		systemAdmin column: 'system_admin'
		mobilePhone column: 'mobile_phone'
		workPhone column: 'work_phone'
		homePhone column: 'home_phone'
		addressLine1 column: 'address_line1'
		addressLine2 column: 'address_line2'
		postalCode column: 'postal_code'
		photoImgPath column: 'photo_img_path'
		auditTrail column: 'audit_trail'
		pwdAge column: 'pwd_age'
		expiryDate column: 'expiry_date'
		pwdChangedDate column: 'pwd_changed_date'
	}
	static constraints = {
		username(blank:false, unique:true)
		password(blank:false, password:true)
		systemAdmin()
		firstName(blank:false)
		lastName(blank:false)
		email(blank:false,email:true)
		mobilePhone(nullable:true)
		workPhone(nullable:true)
		homePhone(nullable:true)
		addressLine1(nullable:true)
		addressLine2(nullable:true)
		city(nullable:true)
		state(nullable:true)
		postalCode(nullable:true)
		country(nullable:true)
		photoImgPath(nullable:true)
		description(nullable:true,maxSize:4000)
		auditTrail()
		pwdAge()
		expiryDate(nullable:true)
		//roles(nullable:true)
		//permissions(nullable:true)
		status(blank:false, inList:['A', 'I', 'E', 'S', 'D']) //Active,Inactive,Expired,Suspended,Deleted
	}
	
	static hasMany = [ roles: Role, permissions: String ]
//    static auditable = true
    
	static searchFields = [username:'like',systemAdmin:'=',firstName:'like',lastName:'like',email:'like',expiryDate:'between', status:'=']
	static exportFields = ['username','systemAdmin','firstName','lastName','email','mobilePhone','workPhone','homePhone','addressLine1','addressLine2','city','state','postalCode','country','description','auditTrail','expiryDate','status']
	static lookupFields = [roles:'role']
	static listFields = ['username','systemAdmin','fullName','email','auditTrail','expiryDate','status']
}

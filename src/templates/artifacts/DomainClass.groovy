@artifact.package@class @artifact.name@ {

	String toString(){
		return username
	}

	//static transients = ['fieldName']

	static mapping = {
		table 'table_name'
	}

	static constraints = {
	}

	//static searchFields = [fieldName:operation]
	//static exportFields = ['fieldName']
	//static lookupFields = [fieldName:]
	//static listFields = ['fieldName']
}

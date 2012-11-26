package foo.bar

class BreedType {

	String code
	String name
	
	String toString(){
		return "$name($code)"
	}

	//static transients = [ "expiryDate_"]

	static embedded = ['foo']
	
	static mapping = {
		table 'foo_breed_types'
	}

	static constraints = {
		code(blank:false, unique:true)
		name(blank:false)
	}

	static searchFields = [code:'=',name:'like']
//	static exportFields = []
//	static lookupFields = []
//	static listFields = []
}



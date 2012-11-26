package com.siberhus.gskeleton.base

import java.util.regex.*;


class Ipv4Filter {

	final static Map<Number, Pattern> PATTERNS = new HashMap<Number, Pattern>()
	final static REGEX_PART1 = '[1-9][0-9]{0,2}'
	final static REGEX_PART_ = '[0-9]{0,3}'

	Integer part1
	Integer part2
	Integer part3
	Integer part4
	boolean http
	boolean https = true
	int matchingSeq

	Pattern toPattern(){
		Pattern pattern = PATTERNS.get(id)
		if(pattern==null){
			String p1 = part1==null?REGEX_PART1:String.valueOf(part1)
			String p2 = part2==null?REGEX_PART_:String.valueOf(part2)
			String p3 = part3==null?REGEX_PART_:String.valueOf(part3)
			String p4 = part4==null?REGEX_PART_:String.valueOf(part4)
			pattern = Pattern.compile("$p1\\.$p2\\.$p3\\.$p4")
			PATTERNS.put(id, pattern)
		}
		return pattern
	}

    def beforeUpdate = {
		PATTERNS.remove(id)
	}

	String toString(){
		String p1 = part1==null?'ANY':String.valueOf(part1)
		String p2 = part2==null?'ANY':String.valueOf(part2)
		String p3 = part3==null?'ANY':String.valueOf(part3)
		String p4 = part4==null?'ANY':String.valueOf(part4)
		return "$p1.$p2.$p3.$p4"
	}

	//static transients = ['fieldName']

	static mapping = {
		cache true
		table 'gsk_ipv4_filters'
		matchingSeq column: 'matching_seq'
	}

	static constraints = {
		part1(nullable:true, validator: {val, obj->
			if(val!=null){
				if(!Pattern.matches(REGEX_PART1, String.valueOf(val))){
					return '_error.Ipv4Filter.part1.invalidFormat'
				}
			}
			return true
		})
		part2(nullable:true, validator: {val, obj->
			if(val!=null){
				if(!Pattern.matches(REGEX_PART_, String.valueOf(val))){
					return '_error.Ipv4Filter.part2.invalidFormat'
				}
			}
			return true
		})
		part3(nullable:true, validator: {val, obj->
			if(val!=null){
				if(!Pattern.matches(REGEX_PART_, String.valueOf(val))){
					return '_error.Ipv4Filter.part3.invalidFormat'
				}
			}
			return true
		})
		part4(nullable:true, validator: {val, obj->
			if(val!=null){
				if(!Pattern.matches(REGEX_PART_, String.valueOf(val))){
					return '_error.Ipv4Filter.part4.invalidFormat'
				}
			}
			return true
		})
		http()
		https()
		matchingSeq()
	}

	//static searchFields = [fieldName:operation]
	//static exportFields = ['fieldName']
	//static lookupFields = [fieldName:]
	//static listFields = ['fieldName']
}

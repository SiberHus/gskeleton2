package com.siberhus.gskeleton.doc


import com.siberhus.gskeleton.Auditable;



//FAQ will be displayed in the list format
//The display order of FAQ depends on number of readCount.
//FAQ will not be affected with readCount attribute if it was pinned
//Pinned FAQ displayOrder depends on the value of displayOrder attribute
class Faq extends Auditable {
	
	String question
	String answer
	Boolean pinned
	//displayOrder only work with pinned FAQ
	Integer displayOrder = 0
	Integer readCount = 0

	String toString(){
		return question
	}
	
	static mapping = {
		table 'gsk_faqs'
		displayOrder column: 'display_order'
		readCount column: 'read_count'
	}
	
	static constraints = {
		question(blank:false)
		answer(blank:false, maxSize: 40000)
		pinned()
		displayOrder()
		readCount()
	}

	static belongsTo = [category: FaqCategory]
	
	static searchFields = ['category.id':'=',question:'like', pinned:'=',readCount:'>']
	static listFields = ['question','readCount','pinned']
}

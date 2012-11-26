package com.siberhus.gskeleton.base

import com.siberhus.gskeleton.Auditable
import org.apache.commons.lang.StringEscapeUtils;


class Message extends Auditable{
	
	String language
	String code
	String text
	
	String toString(){
		return text
	}

	void setText(String text){
//		this.text = StringEscapeUtils.escapeHtml(text)
		text = text.replaceAll('<','&lt;')
		this.text = text.replaceAll('>','&gt;')
	}
	
	static mapping = {
//		cache true
		table "gsk_messages"
	}
	
	static constraints = {
		language(blank:false)
		code(blank:false, unique:'language')
		text(blank:false, maxSize:4000)
	}
	
	static searchFields = [language:'=',code:'like',text:'like']
	static exportFields = ['language','code','text']
}

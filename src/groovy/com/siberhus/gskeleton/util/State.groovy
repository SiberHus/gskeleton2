package com.siberhus.gskeleton.util

import java.util.Map;

class State {

	private static final PseudoSingletonMap STATE_MAP = new PseudoSingletonMap()
	
	public static def get(String key){
		Map<String, Object> map = STATE_MAP.get()
		return map.get(key)
	}
	
	public static void set(String key, Object value){
		Map<String, Object> map = STATE_MAP.get()
		map.put(key, value)
	}
	
	
}

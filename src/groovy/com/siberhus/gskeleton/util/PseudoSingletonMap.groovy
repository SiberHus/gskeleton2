package com.siberhus.gskeleton.util

class PseudoSingletonMap extends ContextClassLoaderLocal {
	protected Object initialValue() {
		 return new HashMap()
	};
}

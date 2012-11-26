package com.siberhus.gskeleton.config


import java.io.Serializable;

class SysConfigObject implements Serializable{
	
	public boolean contains(String name){
		return SysConfig.contains(name)
	}
	
	public boolean contains(String systemName, String name){
		return SysConfig.contains(systemName, name)
	}
	
	public def get(String name){
		return SysConfig.get(name)
	}
	
	public def get(String systemName, String name){
		return SysConfig.get(systemName, name)
	}
	
	public void set(String name, String value){
		SysConfig.set(name, value)
	}
	
	public void set(String systemName, String name, String value){
		SysConfig.set(systemName, name, value)
	}
	
}

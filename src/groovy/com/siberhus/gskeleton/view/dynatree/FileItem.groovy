package com.siberhus.gskeleton.view.dynatree

import java.net.URLEncoder;

import org.apache.commons.lang.StringUtils;


class FileItem {
	
	String key
	String title
	boolean folder
	boolean lazy
	Long size
	Boolean executable
	Boolean readable
	Boolean writable
	
	Collection<FileItem> children
	
	def addChild(FileItem fileItem){
		if(children==null){
			children = new ArrayList<FileItem>()
		}
		children.add(fileItem)
	}
	
	public static String toString(Collection<FileItem> fileItems){
		return '['+StringUtils.join( fileItems, ',')+']'
	}
	
	public String toString(){
		def json = new StringBuilder()
		key = URLEncoder.encode(key)
		json << "{key: '${key}'"
		if(folder){
			json << ", isFolder: ${folder}, isLazy: ${lazy}"
		}else{
			if(size!=null){
				json << ", size: ${size}"
			}
		}
		json << ", title: '${title}'"
		if(children!=null){
			json << ", children:" << toString(children)
		}
		
		json << "}"
	}
}

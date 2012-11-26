package com.siberhus.gskeleton.sfm


import java.io.File;

import com.siberhus.gskeleton.Auditable;
import com.siberhus.gskeleton.base.Role;

class DirectoryNode extends Auditable {
	
	String name
	String directoryPath
	String recycleBinPath
	//allowed file extensions which can be upload. 
	//Separate each extension by | (vertical bar)
	//for example: xls|pdf|word
	String acceptFileExts
	String description
	String status = 'A'
	
	String toString(){
		return name
	}
	
	static mapping = {
		table "gsk_directory_nodes"
		
		directoryPath column: 'directory_path'
		recycleBinPath column: 'recycle_bin_path'
		acceptFileExts column: 'accept_file_exts'
			
		roles column: 'directory_node_id', joinTable: 'gsk_dir_nodes_roles'
	}
	
	static constraints = {
		name(blank:false, unique:true)
		directoryPath(blank:false ,unique:true, validator: {val, obj->
			File dir = new File(val)
			if(!dir.exists()){
				return '_error.directoryNode.fileNotFound'
			}else if(!dir.isDirectory()){
				return '_error.directoryNode.fileMustBeDirectory'
			}
			obj.directoryPath = dir.getCanonicalPath()
			return true
		})
		recycleBinPath(nullable:true, uniqie:true, validator: {val, obj->
			if(!val) return true
			File dir = new File(val)
			File dirPath = new File(obj.directoryPath)
			if(dir==dirPath){
				return '_error.directoryNode.cannotBeTheSamePath'
			}
			if(!dir.exists()){
				return '_error.directoryNode.fileNotFound'
			}else if(!dir.isDirectory()){
				return '_error.directoryNode.fileMustBeDirectory'
			}
			obj.recycleBinPath = dir.getCanonicalPath()
//			if(obj.recycleBinPath.startsWith(obj.directoryPath)){
//				return 'invalidRecycleBinPath'
//			}
			return true
		})
		description(nullable:true, maxSize:4000)
		acceptFileExts(nullable:true)
		status(blank:false, inList:['A','I'])
	}

//	static auditable = true
	
	static hasMany = [roles: Role]
	
    static searchFields = [name:'like',directoryPath:'=',status:'=']
	static exportFields = ['name','directoryPath','acceptFileExts','description','status']
	static listFields = ['name','directoryPath','acceptFileExts','status']
	
}

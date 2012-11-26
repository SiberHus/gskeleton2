package com.siberhus.gskeleton.sfm


import java.sql.Timestamp;

class FileRecycleBin {

	String uid //Oracle reserved word
	DirectoryNode directoryNode
	String originalPath
	String fileName
	String checksum
	String fileType //D (Directory), F (File)
	Timestamp deletedDate
	Timestamp deletedDate_

	String toString(){
		return fileName
	}

	static transients = ['deletedDate_']
	
	static mapping = {
		table 'gsk_file_recyclebin'
		uid column: 'file_uid'
		originalPath column: 'original_path'
		fileName column: 'file_name'
		fileType column: 'file_type'
		deletedDate column: 'deleted_date'
	}
	
	static constraints = {
		uid(nullable:false, unique:true)
		directoryNode(nullable:false)
		originalPath(nullable:false)
		fileName(nullable:false)
		fileType(nullable:false, inList:['D','F'])
		checksum(nullable:true)
		deletedDate(nullable:false)
	}

	static searchFields = ['directoryNode.id':'=',fileName:'like',fileType:'=',deletedDate:'between']
	static listFields = ['directoryNode','fileName','fileType', 'checksum','deletedDate']
	
}

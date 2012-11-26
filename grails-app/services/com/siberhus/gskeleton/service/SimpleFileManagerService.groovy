package com.siberhus.gskeleton.service

import java.io.FileNotFoundException;

import com.siberhus.gskeleton.sfm.DirectoryNode;

class SimpleFileManagerService {

	def String getRealPath(String nodeName, String path){
		DirectoryNode dirNode = DirectoryNode.findByName(nodeName)
		if(dirNode==null){
			throw new FileNotFoundException("Directory node name:$nodeName not found")
		}
		return dirNode.directoryPath+path
	}
	
	
}

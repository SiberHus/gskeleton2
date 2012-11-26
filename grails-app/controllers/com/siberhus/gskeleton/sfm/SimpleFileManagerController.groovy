package com.siberhus.gskeleton.sfm

import org.apache.commons.io.IOUtils
import org.apache.commons.io.FileUtils
import org.apache.shiro.SecurityUtils
import org.apache.commons.lang.StringUtils
import org.springframework.web.multipart.MultipartFile
import com.siberhus.gskeleton.web.MessageHelper
import javax.activation.MimetypesFileTypeMap
import java.text.SimpleDateFormat
import org.apache.commons.lang.RandomStringUtils
import java.sql.Timestamp
import org.apache.tools.zip.ZipOutputStream
import org.apache.tools.zip.ZipEntry
import org.apache.tools.zip.ZipFile
import com.siberhus.gskeleton.config.SysConfig

/*
TODO: Change serveral method to static
 */
class SimpleFileManagerController {

	static final FILE_SEP = '/'
	static final MIME_TYPES_MAP = new MimetypesFileTypeMap()
	static final ALLOWED_NODES_ATTR = '_simpleFileManager.allowedNodes'
	static final CLIPBOARD_ATTR = '_simpleFileManager.clipboard'
	static final COPY_MODE_ATTR = '_simpleFileManager.copyMode'
	
    def index = {
		def allowedNodes = [:]
		def allNodes = DirectoryNode.findAllByStatus('A')
		for(node in allNodes){
			if(node.roles.empty){
				allowedNodes[node.name] = node
			}else{
				if (SecurityUtils.subject.hasRoles(node.roles.toArray()).any()){
					allowedNodes[node.name] = node
				}
			}
		}
		session[ALLOWED_NODES_ATTR] = allowedNodes
		render(view:'/sfm/simpleFileManager/list',model:[nodeMap: allowedNodes, rootNode: true])
	}

	def list = {
		DirectoryNode dirNode = findDirectoryNode()
		if(!dirNode){
			return
		}
		String nodePath = dirNode.directoryPath
		String pdir = getParentDirectory(nodePath)
		String realFilePath = nodePath+pdir
		def fileList = getFileList(realFilePath)
		def linkList = getLinkList(dirNode.name, pdir)
		render(view:'/sfm/simpleFileManager/list',
			model:[fileList: fileList,linkList:linkList,dirNodeName:dirNode.name, pdir:pdir])
	}

	def upload = {
		DirectoryNode dirNode = findDirectoryNode()
		if(!dirNode){
			return
		}
		String nodePath = dirNode.directoryPath
		String pdir = getParentDirectory(nodePath)
		MultipartFile multipartFile = request.getFile('uploadFile')
		String fileName = multipartFile.originalFilename
		File file = new File(nodePath+pdir+fileName)
		if(file.exists()){
			if(!params.override){
				MessageHelper.setErrorMessage(flash, '_error.simpleFileManager.fileAlreadyExists',
					"File ${fileName} already exists",[fileName])
				redirect(action:'list', params:[dirNodeName:dirNode.name, pdir: pdir])
				return
			}
			MessageHelper.setInfoMessage(flash, '_error.simpleFileManager.fileOverrided',
					"File ${fileName} was replaced",[fileName])
			multipartFile.transferTo(file)
			FileOpLogController.logFileOperation(file, FileOpLog.OP_MODIFY, null).save()
		}else{
			multipartFile.transferTo(file)
			FileOpLogController.logFileOperation(file, FileOpLog.OP_CREATE, null).save()
		}
		redirect(action:'list', params:[dirNodeName:dirNode.name, pdir: pdir])
	}

	def download = {
		DirectoryNode dirNode = findDirectoryNode()
		if(!dirNode){
			return
		}
		cleanFileParams()
		String nodePath = dirNode.directoryPath
		String pdir = params.pdir
		File file = new File(nodePath+pdir+params.file)
		FileOpLogController.logFileOperation(file, FileOpLog.OP_DOWNLOAD, null).save()
		String fileName = URLEncoder.encode(file.name)
		def contentType = MIME_TYPES_MAP.getContentType(fileName)
//		response.setContentType("application/octet-stream")
		response.setContentType(contentType)
		response.setHeader("Content-disposition", "attachment;filename=${fileName}")
		response.outputStream << file.newInputStream()
	}

	def delete = {
		DirectoryNode dirNode = findDirectoryNode()
		if(!dirNode){
			return
		}
		cleanFileParams()
		String pdir = params.pdir
		String file = params.file
		try{
			deleteFile(dirNode, pdir, file)
			MessageHelper.setInfoMessage(flash, '_info.simpleFileManager.deleted',
					"File ${file} deleted", [file])
		}catch(Exception e){
			e.printStackTrace()
			MessageHelper.setErrorMessage(flash, e)
		}
		redirect(action:'list', params:[dirNodeName:dirNode.name, pdir: pdir])
	}
	
	def rename = {
		DirectoryNode dirNode = findDirectoryNode()
		if(!dirNode){
			return
		}
		cleanFileParams()
		String pdir = params.pdir
		String file = params.file
		File srcFile = new File(dirNode.directoryPath+pdir+file)
		if(srcFile.exists()){
			def renameTo = params.renameTo
			if(!renameTo){
				MessageHelper.setErrorMessage(flash, '_error.simpleFileManager.renameTo.required',
					"Rename To field is required value", null)
				redirect(action:'list', params:[dirNodeName:dirNode.name, pdir: pdir])
				return
			}
			renameTo = URLDecoder.decode(renameTo, 'UTF-8')
			File destFile = new File(srcFile.parent+FILE_SEP+renameTo)
			try{
				if(!srcFile.renameTo(destFile)){
					MessageHelper.setErrorMessage(flash, '_error.simpleFileManager.not.rename',
						"Unable to rename file ${srcFile.name}", [srcFile.name])
				}else{
					FileOpLogController.logFileOperation(destFile, FileOpLog.OP_RENAME, srcFile).save()
				}
			}catch(Exception e){
				MessageHelper.setErrorMessage(flash, e)
			}
		}else{
			MessageHelper.setErrorMessage(flash, '_error.simpleFileManager.fileDoesNotExist',
				"File ${srcFile.name} does not exist", [srcFile.name])
		}
		redirect(action:'list', params:[dirNodeName:dirNode.name, pdir: pdir])
	}

	def create = {
		DirectoryNode dirNode = findDirectoryNode()
		if(!dirNode){
			return
		}
//		def filePath = getFilePath()
		String nodePath = dirNode.directoryPath
		String pdir = getParentDirectory(nodePath)
		File parentFile = new File(nodePath+pdir)
		String parentPath = parentFile.canonicalPath
		parentPath = parentPath.endsWith(FILE_SEP)?parentPath:parentPath+FILE_SEP
		if(parentFile.exists() && parentFile.isDirectory()){
			String newFileName = params.newFileName
			String newFileType = params.newFileType
			String createParents = params.createParents //true, or null
			if(!newFileName){
				MessageHelper.setErrorMessage(flash, '_error.simpleFileManager.fileName.required',
					"File name field is required value", null)
			}else{
				newFileName = URLDecoder.decode(newFileName, 'UTF-8')
				newFileName = newFileName.startsWith(FILE_SEP)?newFileName.substring(1):newFileName
				newFileName = newFileName.endsWith(FILE_SEP)?newFileName.substring(0,newFileName.length()-1):newFileName
			}
			try{
				File newFile
				boolean success = true
				if(newFileType=='D'){
					newFile = new File(parentPath+newFileName)
					success = createParents?newFile.mkdirs():newFile.mkdir()
				}else{
					File subParentDir
					if(createParents){
						if(newFileName.contains(FILE_SEP)){
							String subParentDirPath = StringUtils.substringBeforeLast(newFileName, FILE_SEP)
							newFileName = StringUtils.substringAfterLast(newFileName, FILE_SEP)
							subParentDir = new File(parentPath+subParentDirPath)
							success = subParentDir.mkdirs()
						}
					}
					if(success){
						if(subParentDir){
							newFile = new File(subParentDir.canonicalPath+FILE_SEP+newFileName)
							success = newFile.createNewFile()
						}else{
							newFile = new File(parentPath+newFileName)
							success = newFile.createNewFile()
						}
					}
				}
				if(success){
					FileOpLogController.logFileOperation(newFile, FileOpLog.OP_CREATE, null).save()
				}else{
					MessageHelper.setErrorMessage(flash, '_error.simpleFileManager.unableToCreateFile',
						"Unable to create file ${newFileName}", [newFileName])
				}
			}catch(Exception e){
				MessageHelper.setErrorMessage(flash, e)
			}
		}else{
			MessageHelper.setErrorMessage(flash, '_error.simpleFileManager.parentMustBeExistingDirectory',
				"Parent file ${parentFile.name} must be an existing directory", [parentFile.name])
		}
		redirect(action:'list', params:[dirNodeName:dirNode.name, pdir: pdir])
	}

	def bulkDelete = {
		DirectoryNode dirNode = findDirectoryNode()
		if(!dirNode){
			return
		}
		cleanFileParams()
		String pdir = params.pdir
		if(params.ids){
			if(params.ids instanceof String) params.ids = [params.ids]
			for(file in params.ids){
				try{
					deleteFile(dirNode, pdir, file)
				}catch(Exception e){
					MessageHelper.setErrorMessage(flash, "_error.simpleFileManager.not.deleted",
						"Unable to delete file ${file.name}", [file.name])
					log.warn(e.toString() ,e)
					redirect(action:'list', params:[dirNodeName:dirNode.name, pdir: pdir])
					return
				}
			}
			MessageHelper.setInfoMessage(flash, "_info.simpleFileManager.deleted",
					"File ${params.ids} deleted",[params.ids])
		}
		redirect(action:'list', params:[dirNodeName:dirNode.name, pdir: pdir])
	}

	def bulkCut = {
		DirectoryNode dirNode = findDirectoryNode()
		if(!dirNode){
			return
		}
		cleanFileParams()
		String pdir = params.pdir
		if(params.ids){
			session[CLIPBOARD_ATTR] = []
			session[COPY_MODE_ATTR] = 'CUT'
			if(params.ids instanceof String) params.ids = [params.ids]
			for(file in params.ids){
				session[CLIPBOARD_ATTR] << new File(dirNode.directoryPath+pdir+file)
			}
			MessageHelper.setInfoMessage(flash, "_info.simpleFileManager.cut",
					"File ${params.ids} were cut",[params.ids])
		}
		redirect(action:'list', params:[dirNodeName:dirNode.name, pdir: pdir])
	}

	def bulkCopy = {
		DirectoryNode dirNode = findDirectoryNode()
		if(!dirNode){
			return
		}
		cleanFileParams()
		String pdir = params.pdir
		if(params.ids){
			session[CLIPBOARD_ATTR] = []
			session[COPY_MODE_ATTR] = 'COPY'
			if(params.ids instanceof String) params.ids = [params.ids]
			for(file in params.ids){
				session[CLIPBOARD_ATTR] << new File(dirNode.directoryPath+pdir+file)
			}
			MessageHelper.setInfoMessage(flash, "_info.simpleFileManager.copied",
					"File ${params.ids} were copied",[params.ids])
		}
		redirect(action:'list', params:[dirNodeName:dirNode.name, pdir: pdir])
	}

	def bulkPaste = {
		DirectoryNode dirNode = findDirectoryNode()
		if(!dirNode){
			return
		}
		cleanFileParams()
		String pdir = params.pdir
		def clipboard = session[CLIPBOARD_ATTR]
		def isCut = session[COPY_MODE_ATTR]=='CUT'
		if(!clipboard){
			MessageHelper.setWarningMessage(flash, "_warn.simpleFileManager.clipboardIsEmpty",
				"Clipboard is empty",null)
			redirect(action:'list', params:[dirNodeName:dirNode.name, pdir: pdir])
			return
		}
		def failedFiles = []
		File destDir = new File(dirNode.directoryPath+pdir)
		if(!destDir.isDirectory()){
			MessageHelper.setErrorMessage(flash, "_error.simpleFileManager.destDirDoesNotExist",
				"Destination directory: ${destDir.name} does not exist",[destDir.name])
			redirect(action:'list', params:[dirNodeName:dirNode.name, pdir: pdir])
			return
		}
		for(File srcFile in clipboard){
			try{
				if(isCut){
					FileUtils.moveToDirectory(srcFile, destDir, false)
				}else{
					if(srcFile.isDirectory()){
						FileUtils.copyDirectoryToDirectory(srcFile, destDir)
					}else{
						FileUtils.copyFileToDirectory(srcFile, destDir, false)
					}
				}
			}catch(Exception e){
				failedFiles << srcFile.name
				log.warn("Cannot paste these files ${srcFile} due to ${e.toString()}")
			}
		}
		if(failedFiles){
			MessageHelper.setErrorMessage(flash, "_error.simpleFileManager.cannotPasteFile",
				"Cannot paste these files: ${failedFiles}",[failedFiles])
		}
		redirect(action:'list', params:[dirNodeName:dirNode.name, pdir: pdir])
		return
	}

	def bulkArchive = {
		DirectoryNode dirNode = findDirectoryNode()
		if(!dirNode){
			return
		}
		cleanFileParams()
		String pdir = params.pdir
		String archiveName = params.archiveName
		if(!archiveName){
			MessageHelper.setErrorMessage(flash, "_error.simpleFileManager.empty.archiveName",
				"Archive name cannot be empty",null)
			redirect(action:'list', params:[dirNodeName:dirNode.name, pdir: pdir])
			return
		}
		archiveName = archiveName.endsWith('.zip')?archiveName:archiveName+'.zip'
		if(params.ids){
			if(params.ids instanceof String) params.ids = [params.ids]
			String parentPath = dirNode.directoryPath+pdir
			File archiveFile = new File(parentPath+archiveName)
			if(archiveFile.exists() && !params.replace){
				MessageHelper.setErrorMessage(flash, "_error.simpleFileManager.cannot.replaceFile",
					"Cannot replace existing archive file ${archiveFile.name}",[archiveFile.name])
			}

			zipFile(parentPath, params.ids, archiveFile)
		}else{
			MessageHelper.setWarningMessage(flash, "_warn.simpleFileManager.empty.fileSelected",
				"No file selected",null)
		}
		redirect(action:'list', params:[dirNodeName:dirNode.name, pdir: pdir])
	}
	/**
	 * Output of pdir should be "/a/b/c/" (Start with file sep and end with file sep)
	 * Output of file should be "filename" (Don't start with file sep)
	 */
	def cleanFileParams(){
		String pdir = params.pdir
		String file = params.file
		if(pdir){
			pdir = URLDecoder.decode(pdir, 'UTF-8')
			pdir = pdir.replaceAll('\\\\','/')
			pdir = pdir.startsWith(FILE_SEP)?pdir:FILE_SEP+pdir
			pdir = pdir.endsWith(FILE_SEP)?pdir:pdir+FILE_SEP
			if(params.goUp){
				pdir = StringUtils.chomp(pdir, FILE_SEP)
				pdir = StringUtils.substringBeforeLast(pdir, FILE_SEP)
			}
			params.pdir = pdir
		}else{
			params.pdir = '/'
		}

		if(file){
			file = URLDecoder.decode(file, 'UTF-8')
			file = file.replaceAll('\\\\','/')
			if(pdir){
				file = file.startsWith(FILE_SEP)?file.substring(1):file
			}else{
				file = file.startsWith(FILE_SEP)?file:FILE_SEP+file
			}
			params.file = file
		}
	}

	def findDirectoryNode(){
		def allowedNodes = session[ALLOWED_NODES_ATTR]
		def dirNodeName = params.dirNodeName
		if(!dirNodeName || !allowedNodes || !allowedNodes[dirNodeName]){
			MessageHelper.setErrorMessage(flash, '_error.simpleFileManager.directoryNodeNotFound',
				"Directory node ${dirNodeName} not found", [dirNodeName])
			redirect(action:'index')
			return null
		}
		return allowedNodes[dirNodeName]
	}

    def getParentDirectory(String nodePath){
		cleanFileParams()
		String pdir = params.pdir
		String file = params.file
		if(file){
			File newFile = new File(nodePath+pdir+file)
			if(newFile.isDirectory()){
				params.pdir = pdir+file
				return pdir+file
			}
		}
		return pdir
	}
	
	def getLinkList(def dirNodeName, def filePath){
		def linkList = []
		def pathArray = filePath.split(FILE_SEP=='\\'?'\\\\':FILE_SEP)
		for(int i=0;i<pathArray.size();i++){
			def path = ''
			for(int j=i;j>=0;j--){
				path = pathArray[j]+'\\'+path
			}
			if(pathArray[i]){
				def link = g.link(action:'list',params:[dirNodeName:dirNodeName,pdir:path]){
					pathArray[i]
				}
				linkList << link
			}
		}
		return linkList
	}

	def getFileList(def realPath){
		def realFile = new File(realPath)
		def fileList = []
		for(File file : realFile.listFiles()){
			if(file.isDirectory()){
				fileList << file
			}
		}
		Collections.sort(fileList)
		def tmpFileList = []
		for(File file : realFile.listFiles()){
			if(file.isFile()){
				tmpFileList << file
			}
		}
		Collections.sort(tmpFileList)
		fileList += tmpFileList
		return fileList
	}

	def deleteFile(DirectoryNode dirNode, String pdir, String file){
		String filePath = pdir+file
		File srcFile = new File(dirNode.directoryPath+filePath)
		if(!dirNode.recycleBinPath){
			FileUtils.forceDelete(srcFile)
			return
		}
		String uid = generateUID()
		File destFile = new File(dirNode.recycleBinPath+FILE_SEP+uid)
		if(srcFile.exists()){
			FileRecycleBin recycleBin = new FileRecycleBin()
			recycleBin.uid = uid
			recycleBin.directoryNode = dirNode
			recycleBin.originalPath = pdir+file
			recycleBin.fileName = srcFile.name
			recycleBin.fileType = srcFile.isDirectory()?'D':'F'
			if(!srcFile.isDirectory()){
				recycleBin.checksum = FileUtils.checksumCRC32(srcFile)
			}
			recycleBin.deletedDate = new Timestamp(new Date().getTime())
			def logFileOp = FileOpLogController.logFileOperation(srcFile, FileOpLog.OP_DELETE, null)
			if(srcFile.isDirectory()){
				FileUtils.moveDirectory (srcFile, destFile)
				//FileUtils.deleteDirectory(srcFile)
			}else{
				FileUtils.moveFile(srcFile, destFile)
				//srcFile.delete()
			}
			recycleBin.save()
			logFileOp.save()
		}else{
			throw new FileNotFoundException("File ${filePath} does not exist")
		}
	}

	static def zipFile(String parentPath, def fileNames, File archiveFile){
		// Create a buffer for reading the files
		ZipOutputStream fout
		try{
			fout = new ZipOutputStream(new FileOutputStream(archiveFile))
			fout.setEncoding(SysConfig.get('zip.encoding'))
			for(String fileName in fileNames){
//				println "Compressing file $fileName"
				putZipEntry(fout, parentPath, fileName)
			}
		}finally{
			IOUtils.closeQuietly(fout)
		}
	}
	static def putZipEntry(ZipOutputStream fout, String parentPath, String fileName){
		File file = new File(parentPath+fileName)
		println "Putting zip entry << $file.path"
		if(file.isDirectory()){
			def filesInDir = file.listFiles()
			if(filesInDir){
				for(eachFile in file.listFiles()){
					String eachFileName = fileName+FILE_SEP+eachFile.name
					putZipEntry(fout, parentPath, eachFileName)
				}
			}else{
				//add empty directory (fileName must end with / (slash)
				fout.putNextEntry(new ZipEntry(fileName+'/'))
				fout.closeEntry()
			}
		}else{
			// Create a buffer for reading the files
			byte[] buffer = new byte[1024]
			// Compress the files
			FileInputStream fin
			try{
				fin = new FileInputStream(parentPath+fileName)
				// Add ZIP entry to output stream.
				fout.putNextEntry(new ZipEntry(fileName))
				// Transfer bytes from the file to the ZIP file
				int length
				while ((length = fin.read(buffer)) > 0) {
					fout.write(buffer, 0, length)
				}
				// Complete the entry
				fout.closeEntry()
			}finally{
				IOUtils.closeQuietly(fin)
			}
		}
	}

//	static def unzipFile(String parentPath, File archiveFile){
//		if(!archiveFile.isFile()){
//			throw new FileNotFoundException("Archive file does not exist or it is not a directory")
//		}
//		ZipFile zipFile = new ZipFile(archiveFile)
//		Enumeration<? extends ZipEntry> entries = zipFile.entries()
//		while(entries.hasMoreElements()){
//			ZipEntry entry = entries.nextElement()
//			File file = new File(parentPath, entry.getName())
//			if(entry.isDirectory()){
//				file.mkdirs();
//			}else{
//				if(!file.getParentFile().mkdirs()){
//					throw new IOException("Cannot create directories for "+file)
//				}
//				InputStream inStream
//				OutputStream outStream
//				try{
//					inStream = zipFile.getInputStream(entry)
//					outStream = new FileOutputStream(file)
//					byte[] buffer = new byte[1024]
//					while(true){
//						int length = inStream.read(buffer)
//						if(length<0){
//							break
//						}
//						outStream.write(buffer, 0, length)
//					}
//				}finally{
//					IOUtils.closeQuietly(inStream)
//					IOUtils.closeQuietly(outStream)
//				}
//			}
//		}
//	}

	static def generateUID(){
		SimpleDateFormat sdf = new SimpleDateFormat('yyyyMMddHHmmssSSS')
		def datePart = sdf.format(new Date())
		def randPart = RandomStringUtils.randomAlphabetic(5)
		return 'a'+datePart+randPart
	}
}

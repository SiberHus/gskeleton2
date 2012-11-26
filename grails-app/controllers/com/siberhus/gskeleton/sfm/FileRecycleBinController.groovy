
package com.siberhus.gskeleton.sfm



import com.siberhus.gskeleton.web.MessageHelper
import com.siberhus.gskeleton.web.CrudHelper
import org.springframework.dao.DataIntegrityViolationException
import org.apache.commons.io.FileUtils
import com.siberhus.gskeleton.web.CrudMessageHelper

class FileRecycleBinController {

	static final FILE_SEP = '/'
	
	String VIEW_LIST = '/sfm/fileRecycleBin/list'
//	static String VIEW_CREATE = '/sfm/fileRecycleBin/create'
//	static String VIEW_EDIT = '/sfm/fileRecycleBin/edit'
	String VIEW_SHOW = '/sfm/fileRecycleBin/show'
	
	String SEARCH_COUNT = 'fileRecycleBin.count'
	String SEARCH_QUERY_STRING = 'fileRecycleBin.queryString'
	String SEARCH_QUERY_PARAMS = 'fileRecycleBin.queryParams'
	
	// the delete, save and update actions only accept POST requests
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"];

	String modelName = message(code:'fileRecycleBin')

	private void clearPageSession(){
		session.removeAttribute(SEARCH_COUNT)
		session.removeAttribute(SEARCH_QUERY_STRING)
		session.removeAttribute(SEARCH_QUERY_PARAMS)
	}
	
	def index = {
		clearPageSession()
		render(view:VIEW_LIST, model:[instance:new FileRecycleBin(), instanceTotal:0])
	}
	
	def list = {
		if(session[SEARCH_QUERY_STRING]){
			params.retainCondition = true
			forward(action:'search',params:params)
		}else{
			params.max = CrudHelper.getMaxListSize(params)
			def fileRecycleBinCount = FileRecycleBin.count();
			session[SEARCH_COUNT] = fileRecycleBinCount
			def fileRecycleBinInstance = new FileRecycleBin(params)
			render(view:VIEW_LIST,model:[instanceList: FileRecycleBin.list(params), instanceTotal: fileRecycleBinCount, instance: fileRecycleBinInstance])
		}
	}

	
	def show = {
		def instance = FileRecycleBin.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}else {
			render(view:VIEW_SHOW,model:[instance: instance])
		}
	}

	def delete = {
		FileRecycleBin instance = FileRecycleBin.get(params.id)
		if (instance) {
			try {
				deleteFile(instance)
				CrudMessageHelper.setDeletedMessage(flash, modelName , instance)
				redirect(action: "list")
			}catch (DataIntegrityViolationException e) {
				CrudMessageHelper.setNotDeletedMessage(flash, modelName , instance)
				redirect(action: "show", id: params.id)
			}catch(IOException e){
				redirect(action: "show", id: params.id)
			}
		}else {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}
	}
	
	def bulkDelete = {
		def ids = params.remove('ids')
		params.remove('_ids')
		if(ids){
			if(ids instanceof String) ids = [ids]
			for(id in ids){
				def instance = FileRecycleBin.get(id)
				if (instance) {
					try {
						deleteFile(instance)
					}catch (DataIntegrityViolationException e) {
						CrudMessageHelper.setNotDeletedMessage(flash, modelName , instance)
						redirect(action: "list", params:params)
						return
					}catch(IOException e){
						redirect(action: "list", params:params)
						return
					}
				}else {
					CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
					redirect(action: "list", params:params)
					return
				}
			}
			CrudMessageHelper.setBulkDeletedMessage(flash, modelName , params.ids)
		}
		redirect(action: "list", params:params)
	}
	
	def search = {
		params.max = CrudHelper.getMaxListSize(params)
		params.offset = CrudHelper.getResultOffset(params)
		def queryString = 'from FileRecycleBin as d where 1=1 '
		def queryParams = []
		def paginate = [max:params.max,offset:params.offset]
		if(params.retainCondition){
			queryString = session[SEARCH_QUERY_STRING]
			queryParams = session[SEARCH_QUERY_PARAMS]
		}else{
//			if(params.parent?.id){
//				condString += 'and d.parent.id = ? '
//				queryParams << params.parent.id?.toLong()
//			}
//			if(params.name){
//				condString += 'and lower(d.name) like lower(?) '
//				queryParams << params.name
//			}
			try{
				def queryBean = CrudHelper.parseFindCondition(FileRecycleBin, params)
				queryString += queryBean.queryString
				queryParams += queryBean.queryParams
				log.debug "queryString= $queryString"
				log.debug "queryParams= $queryParams"
			}catch(Exception e){
                MessageHelper.setErrorMessage(flash,e)
			}
		}
		def results = FileRecycleBin.findAll(queryString,queryParams,paginate)
		def resultsCount
		if(session[SEARCH_QUERY_PARAMS] != queryParams){
			resultsCount = FileRecycleBin.executeQuery('select count(*) '+queryString,queryParams)[0]
			session[SEARCH_COUNT] = resultsCount
			session[SEARCH_QUERY_STRING] = queryString
			session[SEARCH_QUERY_PARAMS] = queryParams
		}else{
			resultsCount = session[SEARCH_COUNT]
		}
		def fileRecycleBinInstance = new FileRecycleBin(params)
		render(view:VIEW_LIST,model:[instanceList:results,instanceTotal:resultsCount, instance: fileRecycleBinInstance])
		
	}
	
	def export = {
		if(!FileRecycleBin.metaClass.hasProperty(FileRecycleBin,'exportFields')){
			forward(action:'search',params:params)
			return;
		}
		if(session[SEARCH_QUERY_STRING]){
			def writer = CrudHelper.exportDataToWriterStream(FileRecycleBin, response, params, 
					[subResultSize:100,fullListSize:session[SEARCH_COUNT],
					queryString:session[SEARCH_QUERY_STRING],queryParams:session[SEARCH_QUERY_PARAMS]])
			writer.flush()
			return writer
		}
		redirect(action: "search", params: params)
	}

	def restoreFile = {
		FileRecycleBin frb = FileRecycleBin.get(params.id)
		DirectoryNode dirNode = frb.directoryNode
		File srcFile = new File(dirNode.recycleBinPath+FILE_SEP+frb.uid)
		File destFile = new File(dirNode.directoryPath+FILE_SEP+frb.originalPath)
		log.debug("Restoring file from $srcFile to $destFile")
		try{
			if(srcFile.isDirectory()){
				FileUtils.moveDirectory(srcFile, destFile)
			}else{
				FileUtils.moveFile(srcFile, destFile)
			}
			frb.delete()
			FileOpLogController.logFileOperation(destFile, FileOpLog.OP_RESTORE, srcFile).save()
			MessageHelper.setInfoMessage(flash, '_info.simpleFileManager.restored',
				"File ${destFile.name} was restored", [destFile.name])
		}catch(Exception e){
			MessageHelper.setErrorMessage(flash, e)
		}
		redirect(action: "list", params: params)
	}

	def deleteFile(FileRecycleBin instance){
		DirectoryNode dirNode = instance.directoryNode
		File targetFile = new File(dirNode.recycleBinPath+FILE_SEP+instance.uid)
		if(targetFile.exists()){
			try{
				FileUtils.forceDelete(targetFile)
//				targetFile.delete() <-- If this path name denotes a directory, then the directory must be empty in order to be deleted.
				instance.delete()
				CrudHelper.decrementResultCount(session, SEARCH_COUNT)
				FileOpLogController.logFileOperation(targetFile, FileOpLog.OP_WIPE, null).save()
			}catch(Exception e){
				MessageHelper.setErrorMessage(flash, "_error.fileRecycleBin.unableToDeleteFile",
					"Unable to delete file ${instance.originalPath}", [instance.originalPath])
				throw new IOException("Unable to delete file ${instance.originalPath}")
			}
		}else{
			MessageHelper.setWarningMessage(flash, "_warn.fileRecycleBin.fileDoesNotExist",
				"File ${targetFile.name} does not exist", [targetFile.name])
			instance.delete()
			throw new FileNotFoundException("Unable to find file ${targetFile.name}")
		}
	}
	
}

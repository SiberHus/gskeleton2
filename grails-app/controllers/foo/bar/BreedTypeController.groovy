
package foo.bar



import com.siberhus.gskeleton.web.MessageHelper
import com.siberhus.gskeleton.web.CrudHelper
import com.siberhus.gskeleton.web.CrudMessageHelper
import org.springframework.dao.DataIntegrityViolationException

class BreedTypeController {

	String VIEW_LIST = 'list'
	String VIEW_CREATE = 'create'
	String VIEW_EDIT = 'edit'
	String VIEW_SHOW = 'show'
	
	String SEARCH_COUNT = 'breedType.count'
	String SEARCH_QUERY_STRING = 'breedType.queryString'
	String SEARCH_QUERY_PARAMS = 'breedType.queryParams'
	
	// the delete, save and update actions only accept POST requests
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"];

	String modelName = message(code:'breedType')

	private void clearPageSession(){
		session.removeAttribute(SEARCH_COUNT)
		session.removeAttribute(SEARCH_QUERY_STRING)
		session.removeAttribute(SEARCH_QUERY_PARAMS)
	}

	def index = {
		clearPageSession()
		render(view:VIEW_LIST, model:[instance:new BreedType(), instanceTotal:0])
	}
	
	def list = {
		if(session[SEARCH_QUERY_STRING]){
			params.retainCondition = true
			forward(action:'search',params:params)
		}else{
			params.max = CrudHelper.getMaxListSize(params)
			def breedTypeCount = BreedType.count();
			session[SEARCH_COUNT] = breedTypeCount
			def breedTypeInstance = new BreedType(params)
			render(view:VIEW_LIST,model:[instanceList: BreedType.list(params), instanceTotal: breedTypeCount, instance: breedTypeInstance])
		}
	}

	def create = {
		clearPageSession()
		def instance = new BreedType()
		instance.properties = params
		render(view:VIEW_CREATE,model:[instance: instance])
	}
	
	def save = {
		def instance = new BreedType(params)
		if (!instance.hasErrors() && instance.save()) {
			CrudMessageHelper.setCreatedMessage(flash, modelName , instance)
			redirect(action: "show", id: instance.id)
		}else {
			render(view: VIEW_CREATE, model: [instance: instance])
		}
	}
	
	def show = {
		def instance = BreedType.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}else {
			render(view:VIEW_SHOW,model:[instance: instance])
		}
	}

	def edit = {
		def instance = BreedType.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}else {
			render(view:VIEW_EDIT,model:[instance: instance])
		}
	}

	def update = {
		def instance = BreedType.get(params.id)
		if (instance) {
			if (params.version) {
				def version = params.version.toLong()
				if (instance.version > version) {
					CrudMessageHelper.setOldVersionUpdateMessage(flash, modelName, instance)
					render(view: VIEW_EDIT, model: [instance: instance])
					return
				}
			}
			instance.properties = params
			if (!instance.hasErrors() && instance.save()) {
				CrudMessageHelper.setUpdatedMessage(flash, modelName , instance)
				redirect(action: "show", id: instance.id)
			}else {
				render(view: VIEW_EDIT, model: [instance: instance])
			}
		}else {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "edit", id: params.id)
		}
	}

	def delete = {
		def instance = BreedType.get(params.id)
		if (instance) {
			try {
				instance.delete()
				CrudHelper.decrementResultCount(session, SEARCH_COUNT)
				CrudMessageHelper.setDeletedMessage(flash, modelName , instance)
				redirect(action: "list")
			}catch (org.springframework.dao.DataIntegrityViolationException e) {
				CrudMessageHelper.setNotDeletedMessage(flash, modelName , instance)
				redirect(action: "show", id: params.id)
			}
		}else {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}
	}
	
	def bulkDelete = {
		if(params.ids){
			if(params.ids instanceof String) params.ids = [params.ids]
			for(id in params.ids){
				def instance = BreedType.get(id)
				if (instance) {
					try {
						instance.delete()
						CrudHelper.decrementResultCount(session, SEARCH_COUNT)
					}catch (org.springframework.dao.DataIntegrityViolationException e) {
						CrudMessageHelper.setNotDeletedMessage(flash, modelName , instance)
						redirect(action: "list", id: params.id)
						return
					}
				}else {
					CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
					redirect(action: "list")
					return
				}
			}
			CrudMessageHelper.setBulkDeletedMessage(flash, modelName , params.ids)
		}
		params.remove('ids')
		params.remove('_ids')
		redirect(action: "list", params:params)
	}
	
	def search = {
		params.max = CrudHelper.getMaxListSize(params)
		params.offset = CrudHelper.getResultOffset(params)
		def queryString = 'from BreedType as d where 1=1 '
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
				def queryBean = CrudHelper.parseFindCondition(BreedType, params)
				queryString += queryBean.queryString
				queryParams += queryBean.queryParams
				log.debug "queryString= $queryString"
				log.debug "queryParams= $queryParams"
			}catch(Exception e){
                MessageHelper.setErrorMessage(flash,e)
			}
		}
		def results = BreedType.findAll(queryString,queryParams,paginate)
		def resultsCount
		if(session[SEARCH_QUERY_PARAMS] != queryParams){
			resultsCount = BreedType.executeQuery('select count(*) '+queryString,queryParams)[0]
			session[SEARCH_COUNT] = resultsCount
			session[SEARCH_QUERY_STRING] = queryString
			session[SEARCH_QUERY_PARAMS] = queryParams
		}else{
			resultsCount = session[SEARCH_COUNT]
		}
		def breedTypeInstance = new BreedType(params)
		render(view:VIEW_LIST,model:[instanceList:results,instanceTotal:resultsCount, instance: breedTypeInstance])
		
	}
	
	def export = {
		if(!BreedType.metaClass.hasProperty(BreedType,'exportFields')){
			forward(action:'search',params:params)
			return;
		}
		if(session[SEARCH_QUERY_STRING]){
			def writer = CrudHelper.exportDataToWriterStream(BreedType, response, params, 
					[subResultSize:100,fullListSize:session[SEARCH_COUNT],
					queryString:session[SEARCH_QUERY_STRING],queryParams:session[SEARCH_QUERY_PARAMS]])
			writer.flush()
			return writer
		}
		redirect(action: "search", params: params)
	}
}

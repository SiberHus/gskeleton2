package com.siberhus.gskeleton.doc;

import grails.converters.JSON
import com.siberhus.gskeleton.web.MessageHelper
import com.siberhus.gskeleton.web.CrudHelper
import java.util.regex.Pattern
import java.util.regex.Matcher
import com.siberhus.gskeleton.web.CrudMessageHelper;

class FaqController {

	static final Pattern SCRIPT_PATTERN = Pattern.compile('.*<[sS][cC][rR][iI][pP][tT].*', Pattern.MULTILINE)

	String VIEW_LIST = '/doc/faq/list'
	String VIEW_CREATE = '/doc/faq/create'
	String VIEW_EDIT = '/doc/faq/edit'
	String VIEW_SHOW = '/doc/faq/show'
	
	String SEARCH_COUNT = 'faq.count'
	String SEARCH_QUERY_STRING = 'faq.queryString'
	String SEARCH_QUERY_PARAMS = 'faq.queryParams'
	
	// the delete, save and update actions only accept POST requests
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"];

	String modelName = message(code:'faq')

	private void clearPageSession(){
		session.removeAttribute(SEARCH_COUNT)
		session.removeAttribute(SEARCH_QUERY_STRING)
		session.removeAttribute(SEARCH_QUERY_PARAMS)
	}
	
	def index = {
		clearPageSession()
		render(view:VIEW_LIST, model:[instance:new Faq(), instanceTotal:0])
	}
	
	def list = {
		if(session[SEARCH_QUERY_STRING]){
			params.retainCondition = true
			forward(action:'search',params:params)
		}else{
			params.max = CrudHelper.getMaxListSize(params)
			def faqCount = Faq.count();
			session[SEARCH_COUNT] = faqCount
			def instance = new Faq(params)
			render(view:VIEW_LIST,model:[instanceList: Faq.list(params), instanceTotal: faqCount, instance: instance])
		}
	}

	def create = {
		clearPageSession()
		def instance = new Faq()
		instance.properties = params
		render(view:VIEW_CREATE,model:[instance: instance])
	}
	
	def save = {
		def instance = new Faq(params)
		if(hasXss(instance)) return
		if (!instance.hasErrors() && instance.save()) {
			CrudMessageHelper.setCreatedMessage(flash, modelName , instance)
			redirect(action: "show", id: instance.id)
		}
		else {
			render(view: VIEW_CREATE, model: [instance: instance])
		}
	}
	
	def show = {
		def instance = Faq.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}
		else {
			render(view:VIEW_SHOW,model:[instance: instance])
		}
	}

	def edit = {
		def instance = Faq.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}
		else {
			render(view:VIEW_EDIT,model:[instance: instance])
		}
	}

	def update = {
		def instance = Faq.get(params.id)
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
			if(hasXss(instance)) return
			if (!instance.hasErrors() && instance.save()) {
				CrudMessageHelper.setUpdatedMessage(flash, modelName , instance)
				redirect(action: "show", id: instance.id)
			}
			else {
				render(view: VIEW_EDIT, model: [instance: instance])
			}
		}
		else {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "edit", id: params.id)
		}
	}

	def delete = {
		def instance = Faq.get(params.id)
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
				def instance = Faq.get(id)
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
		def queryString = 'from Faq as d where 1=1 '
		def queryParams = []
		def paginate = [max:params.max,offset:params.offset]
		if(params.retainCondition){
			queryString = session[SEARCH_QUERY_STRING]
			queryParams = session[SEARCH_QUERY_PARAMS]
		}else{
			try{
				def queryBean = CrudHelper.parseFindCondition(Faq, params)
				queryString += queryBean.queryString
				queryParams += queryBean.queryParams
				log.debug "queryString= $queryString"
				log.debug "queryParams= $queryParams"
			}catch(Exception e){
				MessageHelper.setErrorMessage(flash, e)
			}
		}
		def results = Faq.findAll(queryString,queryParams,paginate)
		def resultsCount
		if(session[SEARCH_QUERY_PARAMS] != queryParams){
			resultsCount = Faq.executeQuery('select count(*) '+queryString,queryParams)[0]
			session[SEARCH_COUNT] = resultsCount
			session[SEARCH_QUERY_STRING] = queryString
			session[SEARCH_QUERY_PARAMS] = queryParams
		}else{
			resultsCount = session[SEARCH_COUNT]
		}
		def instance = new Faq(params)
		render(view:VIEW_LIST,model:[instanceList:results,instanceTotal:resultsCount, instance: instance])
		
	}
	
	def export = {
		if(!Faq.metaClass.hasProperty(Faq,'exportFields')){
			forward(action:'search',params:params)
			return;
		}
		if(session[SEARCH_QUERY_STRING]){
			def writer = CrudHelper.exportDataToWriterStream(Faq, response, params,
					[subResultSize:100,fullListSize:session[SEARCH_COUNT],
					queryString:session[SEARCH_QUERY_STRING],queryParams:session[SEARCH_QUERY_PARAMS]])
			writer.flush()
			return writer
		}
		redirect(action: "search", params: params)
	}
	
	def display = {
		def catId
		if(params['category.id']){
			catId = params['category.id'] as long
			def pinnedFaq = Faq.findAll('from Faq where pinned=true and category.id=? order by displayOrder asc',[catId])
			def notPinnedFaq = Faq.findAll('from Faq where pinned=false and category.id=? order by readCount desc', [catId])
			render(view:'/doc/faq/display',model:[pinnedFaq:pinnedFaq, notPinnedFaq: notPinnedFaq])
		}else{
			render(view:'/doc/faq/display')
		}
	}

	def jsonGetFaq = {
		def instance = Faq.get(params.id)
		if(instance){
			instance.readCount++
			render instance as JSON
		}
		render {}
	}

	boolean hasXss(def instance){
		if(instance.answer){
			Matcher m = SCRIPT_PATTERN.matcher(instance.answer)
			while(m.find()){
				MessageHelper.setErrorMessage(flash, "_error.faq.xssDetect",
					"Cross-site scripting detect. Your account will be investigated",null)
				render(view:VIEW_CREATE,model:[instance: instance])
				return true
			}
		}
		return false
	}
}

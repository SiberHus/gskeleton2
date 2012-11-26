package com.siberhus.gskeleton.web

/**
 * Created by IntelliJ IDEA.
 * User: hussachai
 * Date: Sep 26, 2010
 * Time: 12:54:06 AM
 * To change this template use File | Settings | File Templates.
 */
class CrudMessageHelper {

	public static void setCreatedMessage(def flash, String modelName, Object instance){
		flash.messageType = 'info'
		flash.message = '_info.crud.created'
		flash.args = [modelName, instance.toString()]
	}

	public static void setUpdatedMessage(def flash, String modelName, Object instance){
		flash.messageType = 'info'
		flash.message = '_info.crud.updated'
		flash.args = [modelName, instance.toString()]
	}

	public static void setDeletedMessage(def flash, String modelName, Object instance){
		flash.messageType = 'info'
		flash.message = '_info.crud.deleted'
		flash.args = [modelName, instance.toString()]
	}

	public static void setBulkDeletedMessage(def flash, String modelName, def ids){
		flash.messageType = 'info'
		flash.message = '_info.crud.bulkDeleted'
		if(!(ids instanceof String)){
			ids = Arrays.toString(ids)
		}
		flash.args = [modelName, ids]
	}

	public static void setNotDeletedMessage(def flash, String modelName, Object instance){
		flash.messageType = 'error'
		flash.message = '_error.crud.not.deleted'
		flash.args = [modelName, instance.toString()]
	}

	public static void setNotFoundMessage(def flash, String modelName, def id){
		flash.messageType = 'error'
		flash.message = '_error.crud.not.found'
		flash.args = [modelName, id]
	}

	public static void setOldVersionUpdateMessage(def flash, String modelName, Object instance){
		instance.errors.rejectValue("version", "_error.optimistic.locking.failure",[modelName] as Object[],
			"Another user has updated this item while you were editing")
	}

}

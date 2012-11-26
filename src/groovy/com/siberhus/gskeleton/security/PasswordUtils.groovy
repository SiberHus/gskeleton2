package com.siberhus.gskeleton.security

import com.siberhus.gskeleton.config.SysConfig
import com.siberhus.gskeleton.web.MessageHelper
import org.apache.commons.lang.StringUtils
import java.util.regex.Pattern

/**
 * Created by IntelliJ IDEA.
 * User: hussachai
 * Date: Aug 13, 2010
 * Time: 9:35:14 AM
 * To change this template use File | Settings | File Templates.
 */
class PasswordUtils {
	
	public static boolean complyWithRules(def flash, String password){
		def minLength = SysConfig.get('security.password.minLength')
		def maxLength = SysConfig.get('security.password.maxLength')
		def rule = SysConfig.get('security.password.rule')
		def ruleRegex = SysConfig.get('security.password.ruleRegex')
		if(minLength){
			if(password.length()<minLength){
				MessageHelper.setErrorMessage(flash,'error.security.password.minLength',
					"Password must have a minimum length of ${minLength} characters",[minLength])
				return false
			}
		}
		if(maxLength){
			if(password.length()<minLength){
				MessageHelper.setErrorMessage(flash,'error.security.password.maxLength',
					"Password must have a maximum length of ${maxLength} characters",[maxLength])
				return false
			}
		}
		if(rule){
			if(rule==0){
				//custom regex
				if(!Pattern.matches(ruleRegex, password)){
					MessageHelper.setErrorMessage(flash,'error.security.password.rule',
						"Password must comply with ${ruleRegex}",[ruleRegex])
					return false
				}
			}else if(rule==1){
				//characters only
				if(!Pattern.matches('[a-zA-Z]*', password)){
					MessageHelper.setErrorMessage(flash,'error.security.password.rule',
						"Password must contain a-z,A-Z only",null)
					return false
				}
			}else if(rule==2){
				//numbers only
				if(!Pattern.matches('[0-9]*', password)){
					MessageHelper.setErrorMessage(flash,'error.security.password.rule',
						"Password must contain 0-9 only",null)
					return false
				}
			}else if(rule==3){
				//alphanumeric including _(underscore)
				if(!Pattern.matches('\\w*_?\\w*', password)){
					MessageHelper.setErrorMessage(flash,'error.security.password.rule',
						"Password must contain a-z,A-Z,0-9,_ only other special characters are not allowed",null)
					return false
				}
			}
			return true
		}
	}
}

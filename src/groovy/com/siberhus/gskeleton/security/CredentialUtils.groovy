package com.siberhus.gskeleton.security

import org.apache.shiro.authc.credential.CredentialsMatcher
import org.apache.shiro.authc.credential.Sha1CredentialsMatcher
import org.apache.shiro.authc.credential.Sha256CredentialsMatcher
import org.apache.shiro.authc.AuthenticationToken
import org.apache.shiro.authc.credential.Sha384CredentialsMatcher
import org.apache.shiro.authc.credential.Sha512CredentialsMatcher
import org.apache.shiro.authc.credential.Md2CredentialsMatcher
import org.apache.shiro.authc.credential.Md5CredentialsMatcher
import org.apache.shiro.authc.AuthenticationInfo
import org.apache.shiro.authc.credential.SimpleCredentialsMatcher
import org.apache.shiro.authc.credential.HashedCredentialsMatcher
import org.apache.shiro.crypto.hash.Sha1Hash
import org.apache.shiro.crypto.hash.Md2Hash
import org.apache.shiro.crypto.hash.Sha512Hash
import org.apache.shiro.crypto.hash.Sha384Hash
import org.apache.shiro.crypto.hash.Sha256Hash
import org.apache.shiro.crypto.hash.Md5Hash
import org.apache.shiro.crypto.hash.AbstractHash
import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH
/**
 * Created by IntelliJ IDEA.
 * User: hussachai
 * Date: Aug 12, 2010
 * Time: 9:39:29 AM
 * To change this template use File | Settings | File Templates.
 */
class CredentialUtils {

	//public static enum HASH_ALGO {NONE,SHA1,SHA256,SHA384,SHA512,MD2,MD5}

	public static String encodePassword(String password){

		String encodedPassword
		String hashAlgo = CH.config.gskeleton.security.password.hashAlgo
//		String hashSalt = CH.config.gskeleton.security.password.hashSalt
		String hashSalt = null
		Integer hashIteration = CH.config.gskeleton.security.password.hashIteration
		String hashEncoding = CH.config.gskeleton.security.password.hashEncoding
//		println "Hash Algo = $hashAlgo"
//		println "Hash Salt = $hashSalt"
//		println "Hash Iteration = $hashIteration"
//		println "Hash Encoding = $hashEncoding"

		if(hashAlgo=='NONE'){
			return password
		}else{
			AbstractHash hash
			if(hashAlgo=='SHA1'){
				hash = new Sha1Hash(password, hashSalt, hashIteration)
			}else if(hashAlgo=='SHA256'){
				hash = new Sha256Hash(password, hashSalt, hashIteration)
			}else if(hashAlgo=='SHA384'){
				hash = new Sha384Hash(password, hashSalt, hashIteration)
			}else if(hashAlgo=='SHA512'){
				hash = new Sha512Hash(password, hashSalt, hashIteration)
			}else if(hashAlgo=='MD2'){
				hash = new Md2Hash(password, hashSalt, hashIteration)
			}else{
				hash = new Md5Hash(password, hashSalt, hashIteration)
			}
			if(hashEncoding=='HEX'){
				encodedPassword = hash.toHex()
			}else{
				encodedPassword = hash.toBase64()
			}
		}
		return encodedPassword
	}

	public static boolean doCredentialsMatch(AuthenticationToken authToken, AuthenticationInfo account) {

		String hashAlgo = CH.config.gskeleton.security.password.hashAlgo
//		String hashSalt = CH.config.gskeleton.security.password.hashSalt
		String hashSalt = null
		Integer hashIteration = CH.config.gskeleton.security.password.hashIteration
		String hashEncoding = CH.config.gskeleton.security.password.hashEncoding
		
		CredentialsMatcher credentialsMatcher
		if(hashAlgo=='NONE'){
			credentialsMatcher = new SimpleCredentialsMatcher()
		}else{
			HashedCredentialsMatcher hashedCredentialsMatcher
			if(hashAlgo=='SHA1'){
				hashedCredentialsMatcher = new Sha1CredentialsMatcher()
			}else if(hashAlgo=='SHA256'){
				hashedCredentialsMatcher = new Sha256CredentialsMatcher()
			}else if(hashAlgo=='SHA384'){
				hashedCredentialsMatcher = new Sha384CredentialsMatcher()
			}else if(hashAlgo=='SHA512'){
				hashedCredentialsMatcher = new Sha512CredentialsMatcher()
			}else if(hashAlgo=='MD2'){
				hashedCredentialsMatcher = new Md2CredentialsMatcher()
			}else{
				hashedCredentialsMatcher = new Md5CredentialsMatcher()
			}
//			if(hashSalt){
//				hashedCredentialsMatcher.setHashSalted(true)
//			}
			if(hashIteration){
				hashedCredentialsMatcher.setHashIterations(hashIteration)
			}
			if(hashEncoding=='HEX'){
				hashedCredentialsMatcher.setStoredCredentialsHexEncoded(true)
			}else{
				hashedCredentialsMatcher.setStoredCredentialsHexEncoded(false)
			}
			credentialsMatcher = hashedCredentialsMatcher
		}
		
		return credentialsMatcher.doCredentialsMatch(authToken, account)
	}
}

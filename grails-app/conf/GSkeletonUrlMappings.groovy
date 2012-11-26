
/**
 * Created by IntelliJ IDEA.
 * User: hussachai
 * Date: Aug 30, 2010
 * Time: 11:16:29 PM
 * To change this template use File | Settings | File Templates.
 */
class GSkeletonUrlMappings {
	static mappings = {
		"/login"(controller:'auth',action:'login')
		"/welcome" (controller:'/dashboard')
		"/" (controller:'/dashboard')
		"500"(view:'error')
	}
}
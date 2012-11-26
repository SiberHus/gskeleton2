
/**
 * Created by IntelliJ IDEA.
 * User: hussachai
 * Date: Sep 13, 2010
 * Time: 1:09:12 PM
 * To change this template use File | Settings | File Templates.
 */
webPerformance{

	defaultTargetDir {
		scripts = '/min/js'
		styles = '/min/css'
		scriptBundles = '/min/js_bundle'
		styleBundles = '/min/css_bundle'
	}
	
	scripts = [
		'lang-en':[dir:'js/i18n', file:'lang-en.js',plugin:'gskeleton-two'],
		
		'jquery':[dir:'js',file:'jquery-1.4.2.js',plugin:'gskeleton-two'],
		'jquery.cookie':[dir:'js',file:'jquery.cookie.js',plugin:'gskeleton-two'],
		'jquery.inputValue':[dir:'js',file:'jquery.inputValue.js',plugin:'gskeleton-two'],
		'browser-detect':[dir:'js',file:'browser-detect.js',plugin:'gskeleton-two'],
		'siberhus':[dir:'js',file:'siberhus.js',plugin:'gskeleton-two'],
		'gskeleton-taglib':[dir:'js',file:'gskeleton-taglib.js',plugin:'gskeleton-two'],
		'dashboard':[dir:'js',file:'dashboard.js',plugin:'gskeleton-two'],
		'jquery.editinplace':[dir:'js',file:'jquery.editinplace.js',plugin:'gskeleton-two'],
		'jquery-ui':[dir:'ui/jquery-ui',file:'jquery-ui-1.8.4.full.min.js',plugin:'gskeleton-two'],
		'keyboard':[dir:'ui/keyboard',file:'keyboard.js',plugin:'gskeleton-two'],
		'jquery.contextmenu':[dir:'ui/contextMenu',file:'jquery.contextmenu.js',plugin:'gskeleton-two'],
		'jquery.multiselect':[dir:'ui/multiselect',file:'ui.multiselect.js',plugin:'gskeleton-two'],
		'jquery.localisation':[dir:'ui/multiselect/plugins/localisation',file:'jquery.localisation.js',plugin:'gskeleton-two'],
		'jquery.scrollTo':[dir:'ui/multiselect/plugins/scrollTo',file:'jquery.scrollTo.js',plugin:'gskeleton-two'],
		'jquery.sexyCombo':[dir:'ui/sexycombo',file:'jquery.sexy-combo.js',plugin:'gskeleton-two'],
		'jquery.treeview':[dir:'ui/treeview',file:'jquery.treeview.js',plugin:'gskeleton-two'],

	]
	styles = [
		'reset': [dir:'css', file:'reset.css', plugin:'gskeleton-two'],
		'typography': [dir:'css', file:'typography.css', plugin:'gskeleton-two'],
		'admin_layout': [dir:'css', file:'admin_layout.css', plugin:'gskeleton-two'],
		'admin_style': [dir:'css', file:'admin_style.css', plugin:'gskeleton-two'],
		'keyboard': [dir:'ui/keyboard/assets', file:'keyboard.css', plugin:'gskeleton-two'],
		'jquery.contextmenu': [dir:'ui/contextMenu/assets', file:'jquery.contextmenu.css', plugin:'gskeleton-two', targetDir: 'dir'],
		'jquery.multiselect': [dir:'ui/multiselect/assets', file:'ui.multiselect.css', plugin:'gskeleton-two', targetDir: 'dir'],
		'jquery.sexyCombo': [dir:'ui/sexycombo/assets', file:'sexy-combo.css', plugin:'gskeleton-two', targetDir: 'dir'],
		'jquery.sexyCombo.skin': [dir:'ui/sexycombo/assets/sexy', file:'sexy.css', plugin:'gskeleton-two', targetDir: 'dir'],
		'jquery.treeview': [dir:'ui/treeview/assets', file:'treeview.css', plugin:'gskeleton-two', targetDir: 'dir'],
		
		'jquery-ui-blitzer':[dir:'ui/jquery-ui/assets/themes/blitzer',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-cupertino':[dir:'ui/jquery-ui/assets/themes/cupertino',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-dark-hive':[dir:'ui/jquery-ui/assets/themes/dark-hive',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-dot-luv':[dir:'ui/jquery-ui/assets/themes/dot-luv',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-eggplant':[dir:'ui/jquery-ui/assets/themes/eggplant',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-flick':[dir:'ui/jquery-ui/assets/themes/flick',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-hot-sneaks':[dir:'ui/jquery-ui/assets/themes/hot-sneaks',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-humanity':[dir:'ui/jquery-ui/assets/themes/humanity',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-le-frog':[dir:'ui/jquery-ui/assets/themes/le-frog',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-mint-choc':[dir:'ui/jquery-ui/assets/themes/mint-choc',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-overcast':[dir:'ui/jquery-ui/assets/themes/overcast',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-pepper-grinder':[dir:'ui/jquery-ui/assets/themes/pepper-grinder',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-redmond':[dir:'ui/jquery-ui/assets/themes/redmond',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-smoothness':[dir:'ui/jquery-ui/assets/themes/smoothness',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-south-street':[dir:'ui/jquery-ui/assets/themes/south-street',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-start':[dir:'ui/jquery-ui/assets/themes/start',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-sunny':[dir:'ui/jquery-ui/assets/themes/sunny',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-swanky-purse':[dir:'ui/jquery-ui/assets/themes/swanky-purse',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-trontastic':[dir:'ui/jquery-ui/assets/themes/trontastic',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-ui-darkness':[dir:'ui/jquery-ui/assets/themes/ui-darkness',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-ui-lightness':[dir:'ui/jquery-ui/assets/themes/ui-lightness',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-vader':[dir:'ui/jquery-ui/assets/themes/vader',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
		'jquery-ui-black-tie':[dir:'ui/jquery-ui/assets/themes/black-tie',file:'jquery-ui.css',plugin:'gskeleton-two', targetDir:'dir'],
	]
	
	scriptBundles = [
		'baseScripts':[scripts:['jquery','jquery.cookie','jquery.inputValue','browser-detect','siberhus','gskeleton-taglib']],
		'multiselectScripts':[scripts:['jquery.scrollTo','jquery.multiselect']],
	]
	styleBundles = [
		'baseStyles':[styles:['reset','typography','admin_layout','admin_style'], targetDir:'/css'],
	]
}

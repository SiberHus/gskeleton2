
ant.sequential {
	echo('Copying icon files...')
	targetDir = 'web-app/images/icons'
	mkdir(dir:targetDir)
	ant.copy(todir: targetDir) {
		fileset(dir:"${gskeleton2PluginDir}/web-app/images/icons") {
			include(name:"**/*.png")
		}
	}
	echo('Done.')
}
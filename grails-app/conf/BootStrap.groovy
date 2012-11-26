import com.siberhus.gskeleton.sfm.DirectoryNode
import foo.bar.BreedType

class BootStrap {

	def init = { servletContext ->

		new DirectoryNode([name:'Test-1', directoryPath:'D:\\Tmp\\abc\\test1\\work',
				recycleBinPath:'D:\\Tmp\\abc\\test1\\recyclebin', description:'Test1 directory node']).save()
		new DirectoryNode([name:'Test-2', directoryPath:'D:\\Tmp\\abc\\test2\\work',
				recycleBinPath:'D:\\Tmp\\abc\\test2\\recyclebin', description:'Test2 directory node']).save()

		for(def i in 1..50){
			new BreedType([code:"BT-$i",name:"BreedType Name No. $i"]).save()
		}
	}


	def destroy = {
	}
} 
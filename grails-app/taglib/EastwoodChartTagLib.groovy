class EastwoodChartTagLib extends GoogleChartTagLib {

   static namespace = "chart"
   
   def baseChart(attrs, type) {
         this.setApiStringTo("${grailsAttributes.getApplicationUri(request)}/chart?");
         return super.baseChart(attrs, type)
   }
   
   def setApiStringTo(apiString)
   {
      this.apiString = apiString;
   }
   
   
}


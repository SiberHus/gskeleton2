package com.siberhus.gskeleton.job;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.JobListener;

class JobExecutionListener implements JobListener {

	@Override
	public String getName() {
		return 'JobExecutionListener';
	}
	
	@Override
	public void jobExecutionVetoed(JobExecutionContext context) {}

	@Override
	public void jobToBeExecuted(JobExecutionContext context) {}

	@Override
	public void jobWasExecuted(JobExecutionContext context,
			JobExecutionException e) {
//		context.getJobDetail().getJ
	}
	
}

<div id="cronBuilder" title="${message(code:'cron.cronBuilder',default:'Cron Builder')}">
	<table class="cron">
		<tr>
			<td class="label">
				<gs:message code="cron.category" default="Run this job:"/>
			</td>
			<td>
				<select id="category">
					<option value="d"><gs:message code="cron.daily" default="Daily"/></option>
					<option value="w"><gs:message code="cron.weekly" default="Weekly"/></option>
					<option value="m"><gs:message code="cron.monthly" default="Monthly"/></option>
					<option value="o"><gs:message code="cron.onetime" default="One Time Only"/></option>
					<option value="c"><gs:message code="cron.custom" default="Custom"/></option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="label">
				<label for="cron_startTime">
					<gs:message code="cron.startTime" default="Start Time:"/>
				</label>
			</td>
			<td>
				<input type="text" id="cron_startTime" value="00:00" class="time time24"/>&nbsp;
				<input type="checkbox" id="cron_noStartTime"/>
				<label for="cron_noStartTime">
					<gs:message code="cron.noStartTime" default="No start time"/>
				</label>
			</td>
		</tr>
	</table>
	<table id="dailyTbl" class="cron">
		<tr>
			<td>
				<input type="radio" id="cron_d_everyday" name="cron_d" value="everyday"/>
				<label for="cron_d_everyday">
					<gs:message code="cron.everyday" default="Everyday"/>
				</label>
			</td>
			<td>
				<input type="radio" id="cron_d_weekday" name="cron_d" value="weekday"/>
				<label for="cron_d_weekday">
					<gs:message code="cron.weekday" default="Weekday"/>
				</label>
			</td>
		</tr>
		<tr>
			<td>
				<input type="radio" id="cron_d_everyndays" name="cron_d" value="ndays" />
				<label for="cron_d_everyndays">
					<gs:message code="cron.every" default="Every"/>
				</label>
				<input type="text" id="cron_d_ndays" class="timeunit numeral" maxlength="2"/>
				<gs:message code="cron.days" default="Days"/>
			</td>
			<td>
				<input type="radio" id="cron_d_everynhours" name="cron_d" value="nhours"/>
				<label for="cron_d_everynhours">
					<gs:message code="cron.every" default="Every"/>
				</label>
				<input type="text" id="cron_d_nhours" class="timeunit numeral" maxlength="2"/>
				<gs:message code="cron.hours" default="Hours"/>
			</td>
		</tr>
		<tr>
			<td>
				<input type="radio" id="cron_d_everynminutes" name="cron_d" value="nminutes"/>
				<label for="cron_d_everynminutes">
					<gs:message code="cron.every" default="Every"/>
				</label>
				<input type="text" id="cron_d_nminutes" class="timeunit numeral" maxlength="2"/>
				<gs:message code="cron.minutes" default="Minutes"/>
			</td>
			<td>
				<input type="radio" id="cron_d_everynseconds" name="cron_d" value="nseconds"/>
				<label for="cron_d_everynseconds">
					<gs:message code="cron.every" default="Every"/>
				</label>
				<input type="text" id="cron_d_nseconds" class="timeunit numeral" maxlength="2"/>
				<gs:message code="cron.seconds" default="Seconds"/>
			</td>
		</tr>
	</table>
	<table id="weeklyTbl" class="cron">
		<tr>
			<td>
				<input type="checkbox" id="cron_w_mon" value="true"/>
				<label for="cron_w_mon">
					<gs:message code="Monday" default="Monday"/>
				</label>
			</td>
			<td>
				<input type="checkbox" id="cron_w_tue" value="true"/>
				<label for="cron_w_tue">
					<gs:message code="Tuesday" default="Tuesday"/>
				</label>
			</td>
			<td>
				<input type="checkbox" id="cron_w_wed" value="true"/>
				<label for="cron_w_wed">
					<gs:message code="Wednesday" default="Wednesday"/>
				</label>
			</td>
			<td>
				<input type="checkbox" id="cron_w_thu" value="true"/>
				<label for="cron_w_thu">
					<gs:message code="Thursday" default="Thursday"/>
				</label>
			</td>
		</tr>
		<tr>
			<td>
				<input type="checkbox" id="cron_w_fri" value="true"/>
				<label for="cron_w_fri">
					<gs:message code="Friday" default="Friday"/>
				</label>
			</td>
			<td>
				<input type="checkbox" id="cron_w_sat" value="true"/>
				<label for="cron_w_sat">
					<gs:message code="Saturday" default="Saturday"/>
				</label>
			</td>
			<td>
				<input type="checkbox" id="cron_w_sun" value="true"/>
				<label for="cron_w_sun">
					<gs:message code="Sunday" default="Sunday"/>
				</label>
			</td>
		</tr>
	</table>
	<table id="monthlyTbl" class="cron">
		<tr>
			<td colspan="4">
				<input type="checkbox" id="cron_m_day" value="true"/>
				<label for="cron_m_day">
					<gs:message code="cron.day" default="Day"/>
				</label>
				<input type="text" id="cron_m_dayValue" class="timeunit numeral" maxlength="2"/>
				<gs:message code="cron.ofEveryMonths" default="of every months"/>
			</td>
		</tr>
		<tr>
			<td>
				<input type="checkbox" id="cron_m_jan" value="true"/>
				<label for="cron_m_jan">
					<gs:message code="January" default="January"/>
				</label>
			</td>
			<td>
				<input type="checkbox" id="cron_m_feb" value="true"/>
				<label for="cron_m_feb">
					<gs:message code="February" default="February"/>
				</label>
			</td>
			<td>
				<input type="checkbox" id="cron_m_mar" value="true"/>
				<label for="cron_m_mar">
					<gs:message code="March" default="March"/>
				</label>
			</td>
			<td>
				<input type="checkbox" id="cron_m_apr" value="true"/>
				<label for="cron_m_apr">
					<gs:message code="April" default="April"/>
				</label>
			</td>
		</tr>
		<tr>
			<td>
				<input type="checkbox" id="cron_m_may" value="true"/>
				<label for="cron_m_may">
					<gs:message code="May" default="May"/>
				</label>
			</td>
			<td>
				<input type="checkbox" id="cron_m_jun" value="true"/>
				<label for="cron_m_jun">
					<gs:message code="June" default="June"/>
				</label>
			</td>
			<td>
				<input type="checkbox" id="cron_m_jul" value="true"/>
				<label for="cron_m_jul">
					<gs:message code="July" default="July"/>
				</label>
			</td>
			<td>
				<input type="checkbox" id="cron_m_aug" value="true"/>
				<label for="cron_m_aug">
					<gs:message code="August" default="August"/>
				</label>
			</td>
		</tr>
		<tr>
			<td>
				<input type="checkbox" id="cron_m_sep" value="true"/>
				<label for="cron_m_sep">
					<gs:message code="September" default="September"/>
				</label>
			</td>
			<td>
				<input type="checkbox" id="cron_m_oct" value="true"/>
				<label for="cron_m_oct">
					<gs:message code="October" default="October"/>
				</label>
			</td>
			<td>
				<input type="checkbox" id="cron_m_nov" value="true"/>
				<label for="cron_m_nov">
					<gs:message code="November" default="November"/>
				</label>
			</td>
			<td>
				<input type="checkbox" id="cron_m_dec" value="true"/>
				<label for="cron_m_dec">
					<gs:message code="December" default="December"/>
				</label>
			</td>
		</tr>
	</table>
	<table id="oneTimeOnlyTbl" class="cron">
		<tr>
			<td class="label">
				<label>
					<gs:message code="cron.specifiedDate" default="Specified Date: "/>
				</label>
			</td>
			<td>
				<gs:message code="cron.day" default="Day"/>&nbsp;
				<g:select id="cron_o_day" from="${1..31}" style="width:45px"/>&nbsp;
				<gs:message code="cron.month" default="Month"/>&nbsp;
				<g:select id="cron_o_month" from="${1..12}" style="width:45px"/>&nbsp;
				<gs:message code="cron.year" default="Year"/>&nbsp;
				<g:select id="cron_o_year" from="${2010..2099}" style="width:65px"/>&nbsp;
			</td>
		</tr>
	</table>
	<table id="customTbl" class="cron">
		<tr>
			<td class="label">
				<label>
					<gs:message code="cron.customExp" default="Custom: "/>
				</label>
			</td>
			<td>
				<input type="text" id="cron_c_value"/>
			</td>
		</tr>
	</table>
	<hr/>
	<table class="cron">
		<tr>
			<td style="text-align: center;">
				<strong><gs:message code="cron.result" default="Result"/></strong>
			</td>
		</tr>
		<tr>
			<td style="text-align: center;">
				<input type="hidden" id="cronResult" value="false"/>
				<input type="text" id="cronExpPreview" style="width: 300px;" readonly="readonly"/><br/>
				<input type="button" id="generateBtn" name="generate" value="${message(code:'btn.generate',default:'Generate')}"/>
			</td>
		</tr>
		<tr>
			<td style="text-align: center;">
				<strong id="nextFireTime" class="hidden"><gs:message code="cron.nextFireTime" default="Next Fire Time"/></strong>
				<strong id="errorMessage" class="hidden"><gs:message code="cron.errorMessage" default="Error Message"/></strong>
			</td>
		</tr>
		<tr>
			<td style="text-align: center;">
				<span id="cronMessage"></span>
			</td>
		</tr>
	</table>
</div>
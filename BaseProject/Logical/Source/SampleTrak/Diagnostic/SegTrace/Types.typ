
TYPE
	segTraceStateEnum : 
		( (*State of Execution*)
		SEG_TRACE_IDLE, (*Idle State*)
		SEG_TRACE_READ_SEG, (*Read segment state, FB is being executed*)
		SEG_TRACE_CALC_RESULTS, (*Calculate any results from the parID being read*)
		SEG_TRACE_ADD_FAILS, (*Check for any failed segments state*)
		SEG_TRACE_DONE, (*Read/Check completed state*)
		SEG_TRACE_EXPORT, (*Export Trace results state*)
		SEG_TRACE_ERROR (*Error State*)
		);
END_TYPE

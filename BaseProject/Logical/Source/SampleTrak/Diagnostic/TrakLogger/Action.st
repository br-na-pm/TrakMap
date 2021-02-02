
		
ACTION SetAlarmIDCode: 
		
		// EventIDCode add new alarms triggers at the end otherwise 
		// the AlarmCount has to be adjusted not just here but also for all the alarms in the MpAlarmX config

		CASE EventIDCode OF
		// every time the alarm is triggered it's counted so a total count can be displayed in the alarm message											
		1	 : MpAlarmXSet(gAlarmXCore,'EventIDCode.1	'); AlarmCount[0] := AlarmCount[0] + 1; 
		2	 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2	'); AlarmCount[1] := AlarmCount[1] + 1;
		7	 : MpAlarmXSet(gAlarmXCore,'EventIDCode.7	'); AlarmCount[2] := AlarmCount[2] + 1;
		2048 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2048'); AlarmCount[3] := AlarmCount[3] + 1;
		2049 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2049'); AlarmCount[4] := AlarmCount[4] + 1;
		2050 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2050'); AlarmCount[5] := AlarmCount[5] + 1;
		2051 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2051'); AlarmCount[6] := AlarmCount[6] + 1;
		2052 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2052'); AlarmCount[7] := AlarmCount[7] + 1;
		2053 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2053'); AlarmCount[8] := AlarmCount[8] + 1;
		2054 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2054'); AlarmCount[9] := AlarmCount[9] + 1;
		2055 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2055'); AlarmCount[10] := AlarmCount[10] + 1;
		2056 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2056'); AlarmCount[11] := AlarmCount[11] + 1;
		2057 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2057'); AlarmCount[12] := AlarmCount[12] + 1;
		2058 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2058'); AlarmCount[13] := AlarmCount[13] + 1;
		2060 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2060'); AlarmCount[14] := AlarmCount[14] + 1;
		2061 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2061'); AlarmCount[15] := AlarmCount[15] + 1;
		2063 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2063'); AlarmCount[16] := AlarmCount[16] + 1;
		2064 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2064'); AlarmCount[17] := AlarmCount[17] + 1;
		2066 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2066'); AlarmCount[18] := AlarmCount[18] + 1;
		2067 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2067'); AlarmCount[19] := AlarmCount[19] + 1;
		2068 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2068'); AlarmCount[20] := AlarmCount[20] + 1;
		2069 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2069'); AlarmCount[21] := AlarmCount[21] + 1;
		2070 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2070'); AlarmCount[22] := AlarmCount[22] + 1;
		2071 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2071'); AlarmCount[23] := AlarmCount[23] + 1;
		2074 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2074'); AlarmCount[24] := AlarmCount[24] + 1;
		2077 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2077'); AlarmCount[25] := AlarmCount[25] + 1;
		2080 : MpAlarmXSet(gAlarmXCore,'EventIDCode.7392'); AlarmCount[26] := AlarmCount[26] + 1;
		2082 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2080'); AlarmCount[27] := AlarmCount[27] + 1;
		2083 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2083'); AlarmCount[28] := AlarmCount[28] + 1;
		2084 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2084'); AlarmCount[29] := AlarmCount[29] + 1;
		2085 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2085'); AlarmCount[30] := AlarmCount[30] + 1;
		2090 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2090'); AlarmCount[31] := AlarmCount[31] + 1;
		2091 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2091'); AlarmCount[32] := AlarmCount[32] + 1;
		2092 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2092'); AlarmCount[33] := AlarmCount[33] + 1;
		2093 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2093'); AlarmCount[34] := AlarmCount[34] + 1;
		2094 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2094'); AlarmCount[35] := AlarmCount[35] + 1;
		2095 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2095'); AlarmCount[36] := AlarmCount[36] + 1;
		2097 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2097'); AlarmCount[37] := AlarmCount[37] + 1;
		2098 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2098'); AlarmCount[38] := AlarmCount[38] + 1;
		2099 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2099'); AlarmCount[39] := AlarmCount[39] + 1;
		2100 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2100'); AlarmCount[40] := AlarmCount[40] + 1;
		2101 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2101'); AlarmCount[41] := AlarmCount[41] + 1;
		2102 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2102'); AlarmCount[42] := AlarmCount[42] + 1;
		2103 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2103'); AlarmCount[43] := AlarmCount[43] + 1;
		2104 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2104'); AlarmCount[44] := AlarmCount[44] + 1;
		2105 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2105'); AlarmCount[45] := AlarmCount[45] + 1;
		2106 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2106'); AlarmCount[46] := AlarmCount[46] + 1;
		2107 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2107'); AlarmCount[47] := AlarmCount[47] + 1;
		2108 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2108'); AlarmCount[48] := AlarmCount[48] + 1;
		2109 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2109'); AlarmCount[49] := AlarmCount[49] + 1;
		2110 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2110'); AlarmCount[50] := AlarmCount[50] + 1;
		2111 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2111'); AlarmCount[51] := AlarmCount[51] + 1;
		2112 : MpAlarmXSet(gAlarmXCore,'EventIDCode.2112'); AlarmCount[52] := AlarmCount[52] + 1;
		4096 : MpAlarmXSet(gAlarmXCore,'EventIDCode.4096'); AlarmCount[53] := AlarmCount[53] + 1;
		4097 : MpAlarmXSet(gAlarmXCore,'EventIDCode.4097'); AlarmCount[54] := AlarmCount[54] + 1;
		4101 : MpAlarmXSet(gAlarmXCore,'EventIDCode.4101'); AlarmCount[55] := AlarmCount[55] + 1;
		4102 : MpAlarmXSet(gAlarmXCore,'EventIDCode.4102'); AlarmCount[56] := AlarmCount[56] + 1;
		6144 : MpAlarmXSet(gAlarmXCore,'EventIDCode.6144'); AlarmCount[57] := AlarmCount[57] + 1;
		6165 : MpAlarmXSet(gAlarmXCore,'EventIDCode.6165'); AlarmCount[58] := AlarmCount[58] + 1;
		6148 : MpAlarmXSet(gAlarmXCore,'EventIDCode.6148'); AlarmCount[59] := AlarmCount[59] + 1;
		6149 : MpAlarmXSet(gAlarmXCore,'EventIDCode.6149'); AlarmCount[60] := AlarmCount[60] + 1;
		6156 : MpAlarmXSet(gAlarmXCore,'EventIDCode.6156'); AlarmCount[61] := AlarmCount[61] + 1;
		6157 : MpAlarmXSet(gAlarmXCore,'EventIDCode.6157'); AlarmCount[62] := AlarmCount[62] + 1;
		6158 : MpAlarmXSet(gAlarmXCore,'EventIDCode.6158'); AlarmCount[63] := AlarmCount[63] + 1;
		12288: MpAlarmXSet(gAlarmXCore,'EventIDCode.12288'); AlarmCount[64] := AlarmCount[64] + 1;
		12291: MpAlarmXSet(gAlarmXCore,'EventIDCode.12291'); AlarmCount[65] := AlarmCount[65] + 1;
		12293: MpAlarmXSet(gAlarmXCore,'EventIDCode.12293'); AlarmCount[66] := AlarmCount[66] + 1;
		12294: MpAlarmXSet(gAlarmXCore,'EventIDCode.12294'); AlarmCount[67] := AlarmCount[67] + 1;
		12295: MpAlarmXSet(gAlarmXCore,'EventIDCode.12295'); AlarmCount[68] := AlarmCount[68] + 1;
		12296: MpAlarmXSet(gAlarmXCore,'EventIDCode.12296'); AlarmCount[69] := AlarmCount[69] + 1;
		12297: MpAlarmXSet(gAlarmXCore,'EventIDCode.12297'); AlarmCount[70] := AlarmCount[70] + 1;
		12298: MpAlarmXSet(gAlarmXCore,'EventIDCode.12298'); AlarmCount[71] := AlarmCount[71] + 1;
		12299: MpAlarmXSet(gAlarmXCore,'EventIDCode.12299'); AlarmCount[72] := AlarmCount[72] + 1;
		12300: MpAlarmXSet(gAlarmXCore,'EventIDCode.12300'); AlarmCount[73] := AlarmCount[73] + 1;
		12301: MpAlarmXSet(gAlarmXCore,'EventIDCode.12301'); AlarmCount[74] := AlarmCount[74] + 1;
		12302: MpAlarmXSet(gAlarmXCore,'EventIDCode.12302'); AlarmCount[75] := AlarmCount[75] + 1;
		12303: MpAlarmXSet(gAlarmXCore,'EventIDCode.12303'); AlarmCount[76] := AlarmCount[76] + 1;
		12304: MpAlarmXSet(gAlarmXCore,'EventIDCode.12304'); AlarmCount[77] := AlarmCount[77] + 1;
		12305: MpAlarmXSet(gAlarmXCore,'EventIDCode.12305'); AlarmCount[78] := AlarmCount[78] + 1;
		12307: MpAlarmXSet(gAlarmXCore,'EventIDCode.12307'); AlarmCount[79] := AlarmCount[79] + 1;
		12312: MpAlarmXSet(gAlarmXCore,'EventIDCode.12312'); AlarmCount[80] := AlarmCount[80] + 1;
		12313: MpAlarmXSet(gAlarmXCore,'EventIDCode.12313'); AlarmCount[81] := AlarmCount[81] + 1;
		12314: MpAlarmXSet(gAlarmXCore,'EventIDCode.12314'); AlarmCount[82] := AlarmCount[82] + 1;
		12315: MpAlarmXSet(gAlarmXCore,'EventIDCode.12315'); AlarmCount[83] := AlarmCount[83] + 1;
		12316: MpAlarmXSet(gAlarmXCore,'EventIDCode.12316'); AlarmCount[84] := AlarmCount[84] + 1;
		12317: MpAlarmXSet(gAlarmXCore,'EventIDCode.12317'); AlarmCount[85] := AlarmCount[85] + 1;
		12320: MpAlarmXSet(gAlarmXCore,'EventIDCode.12320'); AlarmCount[86] := AlarmCount[86] + 1;
		12322: MpAlarmXSet(gAlarmXCore,'EventIDCode.12322'); AlarmCount[87] := AlarmCount[87] + 1;
		12323: MpAlarmXSet(gAlarmXCore,'EventIDCode.12323'); AlarmCount[88] := AlarmCount[88] + 1;
		12328: MpAlarmXSet(gAlarmXCore,'EventIDCode.12328'); AlarmCount[89] := AlarmCount[89] + 1;
		12330: MpAlarmXSet(gAlarmXCore,'EventIDCode.12330'); AlarmCount[90] := AlarmCount[90] + 1;
		12331: MpAlarmXSet(gAlarmXCore,'EventIDCode.12331'); AlarmCount[91] := AlarmCount[91] + 1;
		12333: MpAlarmXSet(gAlarmXCore,'EventIDCode.12333'); AlarmCount[92] := AlarmCount[92] + 1;
		12334: MpAlarmXSet(gAlarmXCore,'EventIDCode.12334'); AlarmCount[93] := AlarmCount[93] + 1;
		12335: MpAlarmXSet(gAlarmXCore,'EventIDCode.12335'); AlarmCount[94] := AlarmCount[94] + 1;
		12336: MpAlarmXSet(gAlarmXCore,'EventIDCode.12336'); AlarmCount[95] := AlarmCount[95] + 1;
		12337: MpAlarmXSet(gAlarmXCore,'EventIDCode.12337'); AlarmCount[96] := AlarmCount[96] + 1;
		12338: MpAlarmXSet(gAlarmXCore,'EventIDCode.12338'); AlarmCount[97] := AlarmCount[97] + 1;
		12340: MpAlarmXSet(gAlarmXCore,'EventIDCode.12340'); AlarmCount[98] := AlarmCount[98] + 1;
		12341: MpAlarmXSet(gAlarmXCore,'EventIDCode.12341'); AlarmCount[99] := AlarmCount[99] + 1;
		12342: MpAlarmXSet(gAlarmXCore,'EventIDCode.12342'); AlarmCount[100] := AlarmCount[100] + 1;
		12343: MpAlarmXSet(gAlarmXCore,'EventIDCode.12343'); AlarmCount[101] := AlarmCount[101] + 1;
		12344: MpAlarmXSet(gAlarmXCore,'EventIDCode.12344'); AlarmCount[102] := AlarmCount[102] + 1;
		12345: MpAlarmXSet(gAlarmXCore,'EventIDCode.12345'); AlarmCount[103] := AlarmCount[103] + 1;
		12346: MpAlarmXSet(gAlarmXCore,'EventIDCode.12346'); AlarmCount[104] := AlarmCount[104] + 1;
		12347: MpAlarmXSet(gAlarmXCore,'EventIDCode.12347'); AlarmCount[105] := AlarmCount[105] + 1;
		12348: MpAlarmXSet(gAlarmXCore,'EventIDCode.12348'); AlarmCount[106] := AlarmCount[106] + 1;
		4007:  MpAlarmXSet(gAlarmXCore,'EventIDCode.4007');  AlarmCount[107] := AlarmCount[107] + 1;
		7230:  MpAlarmXSet(gAlarmXCore,'EventIDCode.7230');  AlarmCount[108] := AlarmCount[108] + 1;
		4005:  MpAlarmXSet(gAlarmXCore,'EventIDCode.4005');  AlarmCount[109] := AlarmCount[109] + 1;
		4098:  MpAlarmXSet(gAlarmXCore,'EventIDCode.4098');  AlarmCount[110] := AlarmCount[110] + 1;
		9106:  MpAlarmXSet(gAlarmXCore,'EventIDCode.9106');  AlarmCount[111] := AlarmCount[111] + 1;
		
		ELSE
			MpAlarmXSet(gAlarmXCore,'EventIDCode.xxxx');
		END_CASE

END_ACTION


ACTION SetAlarmEventID: 

		//not use just for reference
	
		CASE EventID OF
		
		-1066729471: MpAlarmXSet(gAlarmXCore,'EventID_9471'); AlarmCount[0] := AlarmCount[0] + 1; 
		-1066729470: MpAlarmXSet(gAlarmXCore,'EventID_9470'); AlarmCount[1] := AlarmCount[1] + 1;
		-1066729465: MpAlarmXSet(gAlarmXCore,'EventID_9465'); AlarmCount[2] := AlarmCount[2] + 1;
		-1066727424: MpAlarmXSet(gAlarmXCore,'EventID_7424'); AlarmCount[3] := AlarmCount[3] + 1;
		-1066727423: MpAlarmXSet(gAlarmXCore,'EventID_7423'); AlarmCount[4] := AlarmCount[4] + 1;
		-1066727422: MpAlarmXSet(gAlarmXCore,'EventID_7422'); AlarmCount[5] := AlarmCount[5] + 1;
		-1066727421: MpAlarmXSet(gAlarmXCore,'EventID_7421'); AlarmCount[6] := AlarmCount[6] + 1;
		-1066727420: MpAlarmXSet(gAlarmXCore,'EventID_7420'); AlarmCount[7] := AlarmCount[7] + 1;
		-1066727419: MpAlarmXSet(gAlarmXCore,'EventID_7419'); AlarmCount[8] := AlarmCount[8] + 1;
		-1066727418: MpAlarmXSet(gAlarmXCore,'EventID_7418'); AlarmCount[9] := AlarmCount[9] + 1;
		-1066727417: MpAlarmXSet(gAlarmXCore,'EventID_7417'); AlarmCount[10] := AlarmCount[10] + 1;
		-1066727416: MpAlarmXSet(gAlarmXCore,'EventID_7416'); AlarmCount[11] := AlarmCount[11] + 1;
		-1066727415: MpAlarmXSet(gAlarmXCore,'EventID_7415'); AlarmCount[12] := AlarmCount[12] + 1;
		-1066727414: MpAlarmXSet(gAlarmXCore,'EventID_7414'); AlarmCount[13] := AlarmCount[13] + 1;
		-1066727412: MpAlarmXSet(gAlarmXCore,'EventID_7412'); AlarmCount[14] := AlarmCount[14] + 1;
		-1066727411: MpAlarmXSet(gAlarmXCore,'EventID_7411'); AlarmCount[15] := AlarmCount[15] + 1;
		-1066727409: MpAlarmXSet(gAlarmXCore,'EventID_7409'); AlarmCount[16] := AlarmCount[16] + 1;
		-1066727408: MpAlarmXSet(gAlarmXCore,'EventID_7408'); AlarmCount[17] := AlarmCount[17] + 1;
		-1066727406: MpAlarmXSet(gAlarmXCore,'EventID_7406'); AlarmCount[18] := AlarmCount[18] + 1;
		-1066727405: MpAlarmXSet(gAlarmXCore,'EventID_7405'); AlarmCount[19] := AlarmCount[19] + 1;
		-1066727404: MpAlarmXSet(gAlarmXCore,'EventID_7404'); AlarmCount[20] := AlarmCount[20] + 1;
		-1066727403: MpAlarmXSet(gAlarmXCore,'EventID_7403'); AlarmCount[21] := AlarmCount[21] + 1;
		 1080756246: MpAlarmXSet(gAlarmXCore,'EventID_6246'); AlarmCount[22] := AlarmCount[22] + 1;
		-1066727401: MpAlarmXSet(gAlarmXCore,'EventID_7401'); AlarmCount[23] := AlarmCount[23] + 1;
		-1066727398: MpAlarmXSet(gAlarmXCore,'EventID_7398'); AlarmCount[24] := AlarmCount[24] + 1;
		-1066727395: MpAlarmXSet(gAlarmXCore,'EventID_7395'); AlarmCount[25] := AlarmCount[25] + 1;
		-1066727392: MpAlarmXSet(gAlarmXCore,'EventID_7392'); AlarmCount[26] := AlarmCount[26] + 1;
		-1066727390: MpAlarmXSet(gAlarmXCore,'EventID_7390'); AlarmCount[27] := AlarmCount[27] + 1;
		-1066727389: MpAlarmXSet(gAlarmXCore,'EventID_7389'); AlarmCount[28] := AlarmCount[28] + 1;
		-1066727388: MpAlarmXSet(gAlarmXCore,'EventID_7388'); AlarmCount[29] := AlarmCount[29] + 1;
		-1066727387: MpAlarmXSet(gAlarmXCore,'EventID_7387'); AlarmCount[30] := AlarmCount[30] + 1;
		-1066727382: MpAlarmXSet(gAlarmXCore,'EventID_7382'); AlarmCount[31] := AlarmCount[31] + 1;
		-1066727381: MpAlarmXSet(gAlarmXCore,'EventID_7381'); AlarmCount[32] := AlarmCount[32] + 1;
		-1066727380: MpAlarmXSet(gAlarmXCore,'EventID_7380'); AlarmCount[33] := AlarmCount[33] + 1;
		-1066727379: MpAlarmXSet(gAlarmXCore,'EventID_7379'); AlarmCount[34] := AlarmCount[34] + 1;
		-1066727378: MpAlarmXSet(gAlarmXCore,'EventID_7378'); AlarmCount[35] := AlarmCount[35] + 1;
		-1066727377: MpAlarmXSet(gAlarmXCore,'EventID_7377'); AlarmCount[36] := AlarmCount[36] + 1;
		-1066727375: MpAlarmXSet(gAlarmXCore,'EventID_7375'); AlarmCount[37] := AlarmCount[37] + 1;
		-1066727374: MpAlarmXSet(gAlarmXCore,'EventID_7374'); AlarmCount[38] := AlarmCount[38] + 1;
		-1066727373: MpAlarmXSet(gAlarmXCore,'EventID_7373'); AlarmCount[39] := AlarmCount[39] + 1;
		-1066727372: MpAlarmXSet(gAlarmXCore,'EventID_7372'); AlarmCount[40] := AlarmCount[40] + 1;
		-1066727371: MpAlarmXSet(gAlarmXCore,'EventID_7371'); AlarmCount[41] := AlarmCount[41] + 1;
		-1066727370: MpAlarmXSet(gAlarmXCore,'EventID_7370'); AlarmCount[42] := AlarmCount[42] + 1;
		-1066727369: MpAlarmXSet(gAlarmXCore,'EventID_7369'); AlarmCount[43] := AlarmCount[43] + 1;
		-1066727368: MpAlarmXSet(gAlarmXCore,'EventID_7368'); AlarmCount[44] := AlarmCount[44] + 1;
		-1066727367: MpAlarmXSet(gAlarmXCore,'EventID_7367'); AlarmCount[45] := AlarmCount[45] + 1;
		-1066727366: MpAlarmXSet(gAlarmXCore,'EventID_7366'); AlarmCount[46] := AlarmCount[46] + 1;
		-1066727365: MpAlarmXSet(gAlarmXCore,'EventID_7365'); AlarmCount[47] := AlarmCount[47] + 1;
		-1066727364: MpAlarmXSet(gAlarmXCore,'EventID_7364'); AlarmCount[48] := AlarmCount[48] + 1;
		-1066727363: MpAlarmXSet(gAlarmXCore,'EventID_7363'); AlarmCount[49] := AlarmCount[49] + 1;
		-1066727362: MpAlarmXSet(gAlarmXCore,'EventID_7362'); AlarmCount[50] := AlarmCount[50] + 1;
		-1066727361: MpAlarmXSet(gAlarmXCore,'EventID_7361'); AlarmCount[51] := AlarmCount[51] + 1;
		-1066727360: MpAlarmXSet(gAlarmXCore,'EventID_7360'); AlarmCount[52] := AlarmCount[52] + 1;
		-1066725376: MpAlarmXSet(gAlarmXCore,'EventID_5376'); AlarmCount[53] := AlarmCount[53] + 1;
		-1066725375: MpAlarmXSet(gAlarmXCore,'EventID_5375'); AlarmCount[54] := AlarmCount[54] + 1;
		-1066725371: MpAlarmXSet(gAlarmXCore,'EventID_5371'); AlarmCount[55] := AlarmCount[55] + 1;
		-1066725370: MpAlarmXSet(gAlarmXCore,'EventID_5370'); AlarmCount[56] := AlarmCount[56] + 1;
		-1066723328: MpAlarmXSet(gAlarmXCore,'EventID_3328'); AlarmCount[57] := AlarmCount[57] + 1;
		-1066723327: MpAlarmXSet(gAlarmXCore,'EventID_3327'); AlarmCount[58] := AlarmCount[58] + 1;
		-1066723324: MpAlarmXSet(gAlarmXCore,'EventID_3324'); AlarmCount[59] := AlarmCount[59] + 1;
		-1066723323: MpAlarmXSet(gAlarmXCore,'EventID_3323'); AlarmCount[60] := AlarmCount[60] + 1;
		-1066723316: MpAlarmXSet(gAlarmXCore,'EventID_3316'); AlarmCount[61] := AlarmCount[61] + 1;
		-1066723315: MpAlarmXSet(gAlarmXCore,'EventID_3315'); AlarmCount[62] := AlarmCount[62] + 1;
		-1066723314: MpAlarmXSet(gAlarmXCore,'EventID_3314'); AlarmCount[63] := AlarmCount[63] + 1;
		-1066717184: MpAlarmXSet(gAlarmXCore,'EventID_7184'); AlarmCount[64] := AlarmCount[64] + 1;
		-1066717181: MpAlarmXSet(gAlarmXCore,'EventID_7181'); AlarmCount[65] := AlarmCount[65] + 1;
		-1066717179: MpAlarmXSet(gAlarmXCore,'EventID_7179'); AlarmCount[66] := AlarmCount[66] + 1;
		 1080766470: MpAlarmXSet(gAlarmXCore,'EventID_6470'); AlarmCount[67] := AlarmCount[67] + 1;
		-1066717177: MpAlarmXSet(gAlarmXCore,'EventID_7177'); AlarmCount[68] := AlarmCount[68] + 1;
		-1066717176: MpAlarmXSet(gAlarmXCore,'EventID_7176'); AlarmCount[69] := AlarmCount[69] + 1;
		-1066717175: MpAlarmXSet(gAlarmXCore,'EventID_7175'); AlarmCount[70] := AlarmCount[70] + 1;
		-1066717174: MpAlarmXSet(gAlarmXCore,'EventID_7174'); AlarmCount[71] := AlarmCount[71] + 1;
		-1066717173: MpAlarmXSet(gAlarmXCore,'EventID_7173'); AlarmCount[72] := AlarmCount[72] + 1;
		-1066717172: MpAlarmXSet(gAlarmXCore,'EventID_7172'); AlarmCount[73] := AlarmCount[73] + 1;
		-1066717171: MpAlarmXSet(gAlarmXCore,'EventID_7171'); AlarmCount[74] := AlarmCount[74] + 1;
		-1066717170: MpAlarmXSet(gAlarmXCore,'EventID_7170'); AlarmCount[75] := AlarmCount[75] + 1;
		-1066717169: MpAlarmXSet(gAlarmXCore,'EventID_7169'); AlarmCount[76] := AlarmCount[76] + 1;
		-1066717168: MpAlarmXSet(gAlarmXCore,'EventID_7168'); AlarmCount[77] := AlarmCount[77] + 1;
		-1066717167: MpAlarmXSet(gAlarmXCore,'EventID_7167'); AlarmCount[78] := AlarmCount[78] + 1;
		-1066717165: MpAlarmXSet(gAlarmXCore,'EventID_7165'); AlarmCount[79] := AlarmCount[79] + 1;
		 1080766488: MpAlarmXSet(gAlarmXCore,'EventID_6488'); AlarmCount[80] := AlarmCount[80] + 1;
		-1066717159: MpAlarmXSet(gAlarmXCore,'EventID_7159'); AlarmCount[81] := AlarmCount[81] + 1;
		-1066717158: MpAlarmXSet(gAlarmXCore,'EventID_7158'); AlarmCount[82] := AlarmCount[82] + 1;
		-1066717157: MpAlarmXSet(gAlarmXCore,'EventID_7157'); AlarmCount[83] := AlarmCount[83] + 1;
		-1066717156: MpAlarmXSet(gAlarmXCore,'EventID_7156'); AlarmCount[84] := AlarmCount[84] + 1;
		-1066717155: MpAlarmXSet(gAlarmXCore,'EventID_7155'); AlarmCount[85] := AlarmCount[85] + 1;
		-1066717152: MpAlarmXSet(gAlarmXCore,'EventID_7152'); AlarmCount[86] := AlarmCount[86] + 1;
		-1066717150: MpAlarmXSet(gAlarmXCore,'EventID_7150'); AlarmCount[87] := AlarmCount[87] + 1;
		-2140458973: MpAlarmXSet(gAlarmXCore,'EventID_8973'); AlarmCount[88] := AlarmCount[88] + 1;
		-1066717144: MpAlarmXSet(gAlarmXCore,'EventID_7144'); AlarmCount[89] := AlarmCount[89] + 1;
		-1066717142: MpAlarmXSet(gAlarmXCore,'EventID_7142'); AlarmCount[90] := AlarmCount[90] + 1;
		-1066717141: MpAlarmXSet(gAlarmXCore,'EventID_7141'); AlarmCount[91] := AlarmCount[91] + 1;
		-1066717139: MpAlarmXSet(gAlarmXCore,'EventID_7139'); AlarmCount[92] := AlarmCount[92] + 1;
		-1066717138: MpAlarmXSet(gAlarmXCore,'EventID_7138'); AlarmCount[93] := AlarmCount[93] + 1;
		-1066717137: MpAlarmXSet(gAlarmXCore,'EventID_7137'); AlarmCount[94] := AlarmCount[94] + 1;
		-1066717136: MpAlarmXSet(gAlarmXCore,'EventID_7136'); AlarmCount[95] := AlarmCount[95] + 1;
		-1066717135: MpAlarmXSet(gAlarmXCore,'EventID_7135'); AlarmCount[96] := AlarmCount[96] + 1;
		-1066717134: MpAlarmXSet(gAlarmXCore,'EventID_7134'); AlarmCount[97] := AlarmCount[97] + 1;
		-1066717132: MpAlarmXSet(gAlarmXCore,'EventID_7132'); AlarmCount[98] := AlarmCount[98] + 1;
		-1066717131: MpAlarmXSet(gAlarmXCore,'EventID_7131'); AlarmCount[99] := AlarmCount[99] + 1;
		-1066717130: MpAlarmXSet(gAlarmXCore,'EventID_7130'); AlarmCount[100] := AlarmCount[100] + 1;
		-1066717129: MpAlarmXSet(gAlarmXCore,'EventID_7129'); AlarmCount[101] := AlarmCount[101] + 1;
		-1066717128: MpAlarmXSet(gAlarmXCore,'EventID_7128'); AlarmCount[102] := AlarmCount[102] + 1;
		-1066717127: MpAlarmXSet(gAlarmXCore,'EventID_7127'); AlarmCount[103] := AlarmCount[103] + 1;
		-1066717126: MpAlarmXSet(gAlarmXCore,'EventID_7126'); AlarmCount[104] := AlarmCount[104] + 1;
		-1066717125: MpAlarmXSet(gAlarmXCore,'EventID_7125'); AlarmCount[105] := AlarmCount[105] + 1;
		-1066717124: MpAlarmXSet(gAlarmXCore,'EventID_7124'); AlarmCount[106] := AlarmCount[106] + 1;
		
		END_CASE
END_ACTION
		

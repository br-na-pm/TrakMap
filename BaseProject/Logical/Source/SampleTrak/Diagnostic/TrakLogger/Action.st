
		
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


		

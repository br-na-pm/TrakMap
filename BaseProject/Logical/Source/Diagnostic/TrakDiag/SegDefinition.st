//This file was automatically generated using the TrakMapImporter program. Verify that the segment names and assembly name match your project values correctly
ACTION SegDefinition: 
	TrakDiag.Seg.SegList[0].Name  := 'gSeg_A_1';		TrakDiag.Seg.SegList[0].McType := gSeg_A_1;
	TrakDiag.Seg.SegList[1].Name  := 'gSeg_A_2';		TrakDiag.Seg.SegList[1].McType := gSeg_A_2;
	TrakDiag.Seg.SegList[2].Name  := 'gSeg_A_3';		TrakDiag.Seg.SegList[2].McType := gSeg_A_3;
	TrakDiag.Seg.SegList[3].Name  := 'gSeg_A_4';		TrakDiag.Seg.SegList[3].McType := gSeg_A_4;
	TrakDiag.Seg.SegList[4].Name  := 'gSeg_A_5';		TrakDiag.Seg.SegList[4].McType := gSeg_A_5;
	TrakDiag.Seg.SegList[5].Name  := 'gSeg_A_6';		TrakDiag.Seg.SegList[5].McType := gSeg_A_6;
	TrakDiag.Seg.SegList[6].Name  := 'gSeg_A_7';		TrakDiag.Seg.SegList[6].McType := gSeg_A_7;
	TrakDiag.Seg.SegList[7].Name  := 'gSeg_A_8';		TrakDiag.Seg.SegList[7].McType := gSeg_A_8;
	TrakDiag.Seg.SegList[8].Name  := 'gSeg_A_9';		TrakDiag.Seg.SegList[8].McType := gSeg_A_9;
	TrakDiag.Seg.SegList[9].Name  := 'gSeg_A_10';		TrakDiag.Seg.SegList[9].McType := gSeg_A_10;
	TrakDiag.Seg.SegList[10].Name  := 'gSeg_A_11';		TrakDiag.Seg.SegList[10].McType := gSeg_A_11;
	TrakDiag.Seg.SegList[11].Name  := 'gSeg_A_12';		TrakDiag.Seg.SegList[11].McType := gSeg_A_12;

	TrakDiag.Seg.SegCount := 12;

	TrakDiag.Seg.SegListAdr := ADR(TrakDiag.Seg.SegList);

	DiagFbs.Asm.ReadInfo.Assembly := ADR(gSampleTrak);
	DiagFbs.Asm.ReadStatus.Assembly := ADR(gSampleTrak);

	paperCore.ViewBoxCfg.MinX := -0.735577;
	paperCore.ViewBoxCfg.MinY := -0.765;
	paperCore.ViewBoxCfg.Width := 2.13115;
	paperCore.ViewBoxCfg.Height := 2.075;
END_ACTION 

MODULE MainModule
	CONST robtarget ServicePos:=[[397.6,-329.07,706.86],[0.707825,-0.000175422,0.706388,0.000219533],[-1,-1,0,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget RejectPos:=[[730.35,-302.72,610.67],[0.707791,-0.000151299,0.706421,0.000221762],[-1,-1,0,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget HomePos:=[[693.43,-49.91,620.56],[0.738981,-0.671372,-0.056067,0.00479581],[-1,1,-3,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget PickPos:=[[217.02,62.48,-13.77],[0.414456,-0.540745,-0.492484,-0.541553],[0,1,-1,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget PrePickPos:=[[815.00,-0.33,961.51],[0.707251,0.000163871,0.706963,-0.000132516],[-1,0,-1,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget PressPos:=[[588.36,-190.31,457.41],[0.647406,-0.761616,-0.027589,-0.00674116],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget PrePressPos:=[[586.30,-190.52,457.61],[0.447418,-0.89348,-0.0387976,-0.00217823],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
   	TASK PERS tooldata TCP:=[TRUE,[[31.6757,47.9713,171.021],[0.026506,-0.00739479,0.748508,0.662554]],[1,[0,0,25],[1,0,0,0],0,0,0]];
	PERS wobjdata fixture:=[FALSE,TRUE,"",[[0,0,0],[1,0,0,0]],[[0,0,0],[1,0,0,0]]];
	PERS wobjdata pickframe:=[FALSE,TRUE,"",[[0,0,0],[1,0,0,0]],[[645.804,84.8088,507.863],[0.633294,0.643339,0.306542,-0.301805]]];
	CONST robtarget PressPounce:=[[584.06,-177.87,539.73],[0.645122,-0.762935,-0.0404399,0.010631],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget PressPounce10:=[[589.37,-218.25,476.20],[0.45525,-0.889375,-0.0419212,0.000744896],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget prePressPos2:=[[587.36,-218.05,478.25],[0.447417,-0.893481,-0.0387968,-0.00217809],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget PickPounce:=[[127.86,43.80,-15.71],[0.414454,-0.540744,-0.492482,-0.541557],[0,1,-1,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget PickPounce10:=[[43.36,-30.84,-196.44],[0.00737059,0.0264566,-0.662564,0.748501],[0,0,-3,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget Pick1:=[[197.24,22.57,-12.54],[0.414453,-0.540748,-0.492484,-0.541552],[0,1,-1,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget Pick11:=[[210.17,64.57,-14.08],[0.414451,-0.54075,-0.492485,-0.541551],[0,1,-1,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget postPick:=[[115.54,93.55,-18.41],[0.414457,-0.540744,-0.492485,-0.541553],[0,1,-1,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget PressPounce20:=[[627.76,-269.62,800.69],[0.0526452,0.966201,0.119455,-0.222293],[-1,0,-3,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	PROC main()
		IF gI_ProgNum = 1 THEN
			RobotToHome;
		ELSEIF gI_ProgNum = 2 THEN
			RobotToPick;
		ELSEIF gI_ProgNum = 3 THEN
			RobotToPress;
		ELSEIF gI_ProgNum = 4 THEN
			RobotToReject;
		ELSEIF gI_ProgNum = 5 THEN
			RobotToService;
		ENDIF
	ENDPROC
	PROC RobotToHome()
		SetGO gO_ProgNumAck, 1;
		WaitGI gI_ProgNum, 0;
		SetGO gO_ProgNumAck, 0;
		MoveJ HomePos, v1000, z50, TCP;
		Set rO_AtHome_51;
		Reset rO_PartComp;
		!set outputs to default values
	ENDPROC
	PROC RobotToService()
		SetGO gO_ProgNumAck, 5;
		Reset rO_AtHome_51;
		WaitGI gI_ProgNum, 0;
		SetGO gO_ProgNumAck, 0;
		MoveJ ServicePos, v1000, z50, tool0;
		Set rO_AtRepair;
		WaitDI rI_RetFrRepair, 1;
		MoveJ HomePos, v1000, z50, tool0;
		Set rO_AtHome_51;
		main;
	ENDPROC
	PROC RobotToReject()
		SetGO gO_ProgNumAck, 4;
		Reset rO_AtHome_51;
		WaitGI gI_ProgNum, 0;
		SetGO gO_ProgNumAck, 0;
		MoveJ RejectPos, v1000, z50, tool0;
		Reset rO_GripperClose;
		Set rO_GripperOpen;
		WaitDI rI_GripperOpened, 1;
		Set rO_PartRejected;
		MoveJ HomePos, v1000, z50, tool0;
		Set rO_AtHome_51;
		main;
	ENDPROC
	PROC RobotToPick()
		SetGO gO_ProgNumAck, 2;
		Reset rO_AtHome_51;
		WaitGI gI_ProgNum, 0;
		SetGO gO_ProgNumAck, 0;
		MoveJ PickPounce, v1000, z10, TCP\WObj:=pickframe;
		WaitDI rI_Zn1ClrEnter, 1;
		Reset rO_ClrZn1;
		MoveL Pick1, v200, fine, TCP\WObj:=pickframe;
		MoveL Pick11, v100, fine, TCP\WObj:=pickframe;
		MoveL PickPos, v100, fine, TCP\WObj:=pickframe;
		Reset rO_GripperOpen;
		Set rO_GripperClose;
		WaitDI rI_GripperClosed, 1;
		Set rO_ClrZn1;
		MoveL postPick, v100, z10, TCP\WObj:=pickframe;
		MoveJ HomePos, v1000, z50, TCP;
		Set rO_AtHome_51;
		main;
	ENDPROC
	PROC RobotToPress()
		SetGO gO_ProgNumAck, 3;
		Reset rO_AtHome_51;
		WaitGI gI_ProgNum, 0;
		SetGO gO_ProgNumAck, 0;
		MoveJ PressPounce, v1000, z10, TCP\WObj:=fixture;
		WaitDI rI_Zn2ClrEnter, 1;
		Reset rO_ClrZn2;
		MoveJ prePressPos2, v200, z10, TCP\WObj:=fixture;
		MoveL PrePressPos, v50, fine, TCP\WObj:=fixture; ! initial
		MoveL PressPos, v20, fine, TCP\WObj:=fixture; ! insert
		 ! press
		Reset rO_GripperClose;
		Set rO_GripperOpen;
		WaitDI rI_GripperOpened, 1;
		MoveL PressPounce, v200, z20, TCP\WObj:=fixture;
		MoveJ PressPounce20, v200, z20, TCP\WObj:=fixture;
		Set rO_ClrZn2;
		Set rO_PartComp;
		WaitDI rI_PartCompAck, 1;
		Reset rO_PartComp;
		MoveJ HomePos, v1000, z50, TCP;
		Set rO_AtHome_51;
		WaitDI rI_CurrentSeq2, 1;
	ENDPROC
ENDMODULE

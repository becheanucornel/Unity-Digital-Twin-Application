MODULE MainModule
    
    !--------------------------------------------------------------
    !       Main Module - Motion Module
    !--------------------------------------------------------------
    !
    ! Institution: Universitatea Transilvania din Brasov
    ! Department: DTI
    ! Specialisation: Robotics
    !
    !--------------------------------------------------------------
    !
    ! Application developed by: Becheanu Cornel-Constantin
    !
    !--------------------------------------------------------------
    ! 
    ! This application is part of the Virtual Reality term project.
    ! The goal of the project is to create a DigitalTwin Application more easy to deploy and use.
    ! It is intended to work with Unity - 2020.3.11f1
    ! All project documentation can be found on github.
    !
    !---------------------------------------------------------------
    
    !Position declaration
    CONST robtarget PickTargetPosition:=[[381.59,451.18,455],[0.00163541,0.420854,-0.907127,0.000758734],[0,0,0,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
    CONST robtarget PlaceTargetPosition:=[[422.65,-412.96,455],[0.00166958,-0.377322,-0.926081,-0.000680252],[-1,0,0,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
    CONST robtarget HomePosition:=[[433.88,-13.50,805.56],[0.000517589,-0.0155568,-0.999879,-8.053E-6],[-1,-1,0,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
    
    !Variable delcaration
    PERS bool Gripper;
    PERS bool StartJob;
    PERS bool JobDone;
    
    PROC main()
        !Main program
        Init;
        WHILE TRUE DO
            !WaitUntil StartJob = TRUE; 
            PickPart;
            PlacePart;
            GoHome;
            JobDone:=TRUE;
            !WaitUntil StartJob = FALSE;
            JobDone:=FALSE;
        ENDWHILE
    ENDPROC
    
    PROC PickPart()
        !Movement for picking the part
        MoveJ Offs(PickTargetPosition, 0,0,150), v1000, fine, tool0;
        WaitTime 0.5;
        MoveL PickTargetPosition, v500, fine, tool0;
        WaitTime 0.5;
        Gripper:=TRUE;
        WaitTime 0.5;
        MoveL Offs(PickTargetPosition, 0,0,150), v500, fine, tool0;
        WaitTime 0.5;
    ENDPROC
    
    PROC PlacePart()
        !Movement for picking the part
        MoveJ Offs(PlaceTargetPosition, 0,0,100), v1000, fine, tool0;
        WaitTime 0.5;
        MoveL PlaceTargetPosition, v500, fine, tool0;
        WaitTime 0.5;
        Gripper:=FALSE;
        WaitTime 0.5;
        MoveL Offs(PlaceTargetPosition, 0,0,100), v500, fine, tool0;
        WaitTime 0.5;
    ENDPROC
    
    PROC GoHome()
        MoveJ HomePosition, v1000, fine, tool0;
    ENDPROC
    
    PROC Init()
        !Initialization of the robot (at start / at reset)
        StartJob := FALSE;
        JobDone := FALSE;
        Gripper := FALSE;
        GoHome;
    ENDPROC
ENDMODULE
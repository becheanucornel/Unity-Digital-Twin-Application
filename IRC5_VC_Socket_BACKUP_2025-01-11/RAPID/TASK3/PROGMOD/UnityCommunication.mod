MODULE UnityCommunication
    !--------------------------------------------------------------
    !       UnityCommunication Module - Communication Module
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
    
    ! Variable declaration
    VAR socketdev Socket1;                ! Robot Position Socket
    VAR socketdev Socket2;                ! Gripper Control Socket
    VAR socketdev Socket3;                ! Receiving Master/Slave Communication Socket
    VAR socketdev Socket4;                ! Sending Master/Slave Communication Socket
    CONST string LocalIP := "127.0.0.1";  ! Local IP
    CONST num posPort := 5000;            ! Port to send data to Unity for robot position
    CONST num gripperPort := 5001;        ! Port to send data to Unity for gripper commands
    CONST num msReceivePort := 5002;
    CONST num msSendPort := 5003;
    VAR jointtarget RobotJoints;
    VAR string joints:= "";
    VAR string gripperStatus:="";
    VAR string startJobStatus:="";
    VAR string jobDoneStatus:="";
    VAR num joint1;
    VAR num joint2;
    VAR num joint3;
    VAR num joint4;
    VAR num joint5;
    VAR num joint6;
    PERS bool Gripper;
    PERS bool StartJob;
    PERS bool JobDone;

    PROC main()
        !-------------------------------------------
        !   Continous running background task
        !-------------------------------------------
        StartJob:=FALSE;
        ! Sending value of current robot joints
            SocketCreate Socket1;
            SocketConnect Socket1, LocalIP, posPort;
        
            !Gripper Control
            SocketCreate Socket2;
            SocketConnect Socket2, LocalIP, gripperPort;
        
            !Master/Slave Communication
!            SocketCreate Socket3;
!            SocketConnect Socket3, LocalIP, msReceivePort;
        
!            SocketCreate Socket4;
!            SocketConnect Socket4, LocalIP, msSendPort;
        WHILE TRUE DO
        
            ! Receiving Master/Slave Communication
!            SocketReceive Socket3\Str:=startJobStatus;
!            IF startJobStatus = "true" THEN
!                StartJob:=TRUE;
!            ELSEIF startJobStatus = "false" THEN
!                StartJob:=FALSE;
!            ENDIF
            
!            ! Sending Master/Slave Communication
!            IF JobDone = TRUE THEN
!                jobDoneStatus := "true";
!                SocketSend Socket4\Str:=jobDoneStatus;
!            ELSEIF JobDone = FALSE THEN
!                jobDoneStatus := "false";
!                SocketSend Socket4\Str:=jobDoneStatus;
!            ENDIF
            
            ! Sending gripper command to Unity
            IF Gripper = TRUE THEN
                gripperStatus:="true";
                SocketSend Socket2\Str:=gripperStatus;
            ELSEIF Gripper = FALSE THEN
                gripperStatus:="false";
                SocketSend Socket2\Str:=gripperStatus;
            ENDIF
                
            ! Sending robot joint positions to Unity
            RobotJoints:=CJointT();
            
            joint1:=RobotJoints.robax.rax_1;
            joint2:=RobotJoints.robax.rax_2;
            joint3:=RobotJoints.robax.rax_3;
            joint4:=RobotJoints.robax.rax_4;
            joint5:=RobotJoints.robax.rax_5;
            joint6:=RobotJoints.robax.rax_6;
            joints:= "";
            
            joints := NumToStr(joint1, 3) + "," + NumToStr(joint2, 3) + "," + NumToStr(joint3, 3) + "," + NumToStr(joint4, 3) + "," + NumToStr (joint5, 3) + "," + NumToStr(joint6, 3);
            
            SocketSend Socket1\Str:= joints;
            WaitTime 0.05;
        ENDWHILE
        SocketClose Socket1;
        SocketClose Socket2;
    ENDPROC
ENDMODULE
      **-- Header Specification:  ---------------------------------------------*
     H*================================================================
     H*  C R E A T I O N     P A R A M E T E R S                      *
     H*CRT: CRTBNDRPG                DFTACTGRP(*NO) ACTGRP(chkoutq) +:*
     H*CRT:  dbgview(*all) option(*nodebugio)                        :*
     H*================================================================
     H Option( *SrcStmt )

     d  main           pr                  extpgm('RTVOUTQSZ')
     d    outq                       10a
     d    lib                        10a
     d    nbrSpools                  10i 0
      **-- Retrieve output queue information:  --------------------------------*
     D RtvOutqInf      Pr                  ExtPgm( 'QSPROUTQ' )
     D  RqRcvVar                  32767a          Options( *VarSize )
     D  RqRcvVarLen                  10i 0 Const
     D  RqFmtNam                      8a   Const
     D  RqOutQ                       20a   Const
     D  RqError                   32767a          Options( *VarSize )
      **-- API error data Structure:  -----------------------------------------*
     D ApiError        Ds
     D  AeBytPrv                     10i 0 Inz( %Size( ApiError ))
     D  AeBytAvl                     10i 0
     D  AeExcpId                      7a
     D                                1a
     D  AeExcpDta                   128a
      **-- Output queue information Structure:  -------------------------------*
     D OUTQ0200        Ds
     D  O2BytRtn                     10i 0
     D  O2BytAvl                     10i 0
     D  O2OutQnam                    10a
     D  O2OutQlib                    10a
     D  O2FilOrd                     10a
     D  O2DspAnyF                    10a
     D  O2JobSep                     10i 0
     D  O2OprCtl                     10a
     D  O2DtaQnam                    10a
     D  O2DtaQlib                    10a
     D  O2AutChk                     10a
     D  O2NbrF                       10i 0
     D  O2OutQsts                    10a
     D  O2OutQtxt                    50a
     D  O2NbrSplFpag                 10i 0
     D  O2NbrWtrStr                  10i 0
     D  O2AutWtrStr                  10i 0
     D  O2RmtSysNamTp                 1a
     D  O2RmtSysNam                 255a
     D  O2RmtPrtQ                   128a
     D  O2MsgQnam                    10a
     D  O2MsgQlib                    10a
     D  O2ConTyp                     10i 0
     D  O2DesTyp                     10i 0
     D  O2VmMvsCls                    1a
     D  O2FrmCtlBuf                   8a
     D  O2HstPrtTfr                   1a
     D  O2MnfTypMod                  17a
     D  O2WscObjNam                  10a
     D  O2WscObjLib                  10a
     D  O2SplFaspA                    1a
     D  O2OfsMxSpfPge                10i 0
     D  O2NbrPgeRtn                  10i 0
     D  O2LenPgeRtn                  10i 0
     D  O2OfsWtrE                    10i 0
     D  O2NbrWtrRtn                  10i 0
     D  O2LenWtrRtn                  10i 0
     D  O2DesOpt                    128a
     D  O2WtrTypStr                   1a
     D  O2PrtSepPag                   1a
     D  O2RmtPrtQLong               255a
     D                                3a
     D  O2OthFlds                   120a
     D  O2Data                     1024a
      **
     D outQDS          ds                  qualified
     d   outq                        10a
     d   lib                         10a
      **
     D upper           C                   CONST('ABCDEFGHIJKLMNOPQRST+
     D                                     UVWXYZ')
     D lower           C                   CONST('abcdefghijklmnopqrst+
     D                                     uvwxyz')
     d  main           pI
     d    outq                       10a
     d    lib                        10a
     d    nbrSpools                  10i 0
      **
      **-- Mainline:  ---------------------------------------------------------*
      **
      /free
          outQDS.lib = %xlate(lower:upper:lib);
          outQDS.outq= %xlate(lower:upper:outq);
          nbrSpools   = *zeros;
          RtvOutqInf( OUTQ0200 : %Size( OUTQ0200 )
                   : 'OUTQ0200': outQDS: ApiError);
          nbrSpools  = O2NbrF;
          return;
      /end-free

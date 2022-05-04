* Modele dla projektów Kask3
.model DZ6V8 D(Is=176.09E-18 N=1.0196 Rs=.26014 Ikf=.94002 Cjo=19.100E-12 M=.36585 Vj=.76843
+ Isr=670.60E-15 Nr=3.2 Bv=6.7900 Ibv=5.0000E-3 tt=85n Nbv=0.1 Tbv1=0.00046 Nbvl=11 Ibvl=100n Vpk=6.8 mfg=Rohm type=Zener)
***
* Tranzystory NPN (Q1, Q2): BFR93A
.SUBCKT BJTN C B E
CBEPAR 2 3 3.716E-013
CBCPAR 2 1 1.70719E-013
CCEPAR 1 3 2.083E-013
LEI    3 30 1E-009
LBI    2 20 1E-009
CBEPCK 20 30  1.304E-014
CBCPCK 1 20  1.5E-013
CCEPCK 1 30  1.5E-013
LB   20 B 3E-010
LE   30 E 3E-010
LC    1 C  6.2E-010
*
Q1 1 2 3 M_BJTN
*
.ENDS BJTN

.MODEL 	M_BJTN	NPN(
+	TNOM = 25
+	IS	=	6.872E-016
+	BF	=	134
+	NF	=	0.9872
+	VAF	=	30.8
+	IKF	=	0.3501
+	ISE	=	6.927E-016
+	NE	=	1.61
+	BR	=	22.18
+	NR	=	0.987
+	VAR	=	2.847
+	IKR	=	0.1135
+	ISC	=	1.465E-014
+	NC	=	2.001
+	RB	=	9.292
+	IRB	=	0.0001166
+	RBM	=	0.85
+	RE	=	0.34281
+	RC	=	1.266
+	XTB	=	1.303
+	EG	=	1.11
+	XTI	=	6.548
+	CJE	=	2.029E-012
+	VJE	=	0.9052
+	MJE	=	0.4406
+	TF	=	2.248E-011
+	XTF	=	146.1
+	VTF	=	8
+	ITF	=	2.097
+	PTF	=	1E-015
+	CJC	=	5.99092E-013
+	VJC	=	0.554562
+	MJC	=	0.359703
+	XCJC	=	0.1048
+	TR	=	5.53E-009
+	CJS	=	0
+	MJS	=	0
+         VJS       =         0.75
+	FC	=	0.9999
+	KF	=	0
+	AF	=	1)
***************************************************************
*
* Tranzystor PNP (Q3): BFT93
*
.SUBCKT BJTP C B E
*
CBEPAR 2 3 3.716E-013
CBCPAR 2 1 1.70719E-013
CCEPAR 1 3 2.083E-013
LEI    3 30 1E-009
LBI    2 20 1E-009
CBEPCK 20 30  1.304E-014
CBCPCK 1 20  1.5E-013
CCEPCK 1 30  1.5E-013
LB   20 B 3E-010
LE   30 E 3E-010
LC    1 C  6.2E-010
*
Q1 1 2 3 M_BJTP
.ENDS BJTP
*
.MODEL  M_BJTP   PNP
+              IS = 8.35127E-016
+              BF = 4.85648E+001
+              NF = 1.00043E+000
+             VAF = 1.90118E+001
+             IKF = 1.46824E-001
+             ISE = 9.09455E-014
+              NE = 1.74928E+000
+              BR = 1.21832E+001
+              NR = 9.97694E-001
+             VAR = 3.37492E+000
+             IKR = 6.74270E-003
+             ISC = 2.34297E-014
+              NC = 1.44993E+000
+              RB = 1.00000E+001
+             IRB = 1.00000E-006
+             RBM = 1.00000E+001
+              RE = 2.00000E-001
+              RC = 3.80000E+000
+              EG = 1.11000E+000
+             XTI = 3.00000E+000
+             CJE = 1.57034E-012
+             VJE = 6.00000E-001
+             MJE = 3.82204E-001
+              TF = 1.48531E-011
+             XTF = 2.20970E+000
+             VTF = 2.98987E+000
+             ITF = 1.43721E-002
+             CJC = 1.99525E-012
+             VJC = 5.84499E-001
+             MJC = 2.81320E-001
+            XCJC = 1.20000E-001
+              TR = 3.00000E-009
+             VJS = 7.50000E-001
+              FC = 8.11678E-001
* Parameters with default value:
* XTB, EG, XTI, CJS, VJS and MJS.
*



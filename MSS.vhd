LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY MSS IS
PORT(IGUAL3,ING4,IGUAL1,MY30,IGUAL10,VERIFICACION,START,Sensor,OR_10,CLOCK,RESETN: IN STD_LOGIC;
	EnCont_error,EnCont_ingreso,EnCont_1,EnCont_30,EnCont_10,RST_CONT_E,RST_ALL: OUT STD_LOGIC;
	En_Reg_n1,En_Reg_n2,En_Reg_n3,En_Reg_n4,LLAMADA,PUERTA,ERROR,Habilitacion,ALARMA: OUT STD_LOGIC);
END MSS;

ARCHITECTURE SOL OF MSS IS
TYPE ESTADOS IS (A,B,C,D,E,F,G,H,I,J,K);
SIGNAL Y : ESTADOS;
BEGIN
	PROCESS(CLOCK, RESETN)
	BEGIN
		IF RESETN='0' THEN Y<=A;
		ELSIF (CLOCK'EVENT AND CLOCK='1') THEN 
			CASE Y IS
				WHEN A => IF START='1' THEN Y<=B;
					ELSE Y<=A; END IF;
				WHEN B => IF OR_10='1' THEN Y<=C;
					ELSE Y<=B; END IF;
				WHEN C => IF OR_10='1' THEN Y<=D;
					ELSE Y<=C; END IF;
				WHEN D => IF OR_10='1' THEN Y<=E;
					ELSE Y<=D; END IF;
				WHEN E => IF OR_10='1' THEN Y<=F;
					ELSE Y<=E; END IF;
				WHEN F => IF (VERIFICACION='0' AND ING4='1') THEN Y<=G;
					ELSIF (VERIFICACION='0' AND ING4='0') THEN Y<=F;
					ELSE Y<=I; END IF;
				WHEN G => IF IGUAL3='1' THEN Y<=H;
					ELSE Y<=B; END IF;
				WHEN H => IF IGUAL1='1' THEN Y<=B;
					ELSE Y<=H; END IF;
				WHEN I => IF Sensor='1' THEN Y<=J;
					ELSE Y<=B; END IF;
				WHEN J => IF MY30='1' THEN Y<=K;
					ELSE Y<=I; END IF;
				WHEN K => IF IGUAL10='1' THEN Y<=B;
					ELSE Y<=K; END IF;
			END CASE;
		END IF;
	END PROCESS;
	PROCESS(Y)
	BEGIN
	En_Reg_n1<='0';En_Reg_n2<='0';En_Reg_n3<='0';En_Reg_n4<='0';LLAMADA<='0';PUERTA<='0';ERROR<='0';Habilitacion<='0';ALARMA<='0';EnCont_error<='0';EnCont_ingreso<='0';EnCont_1<='0';EnCont_30<='0';EnCont_10<='0';RST_CONT_E<='0';RST_ALL<='0';
		CASE Y IS
			WHEN A =>
			WHEN B => RST_ALL<='1'; IF OR_10='1' THEN En_Reg_n1<='1'; EnCont_ingreso<='1'; END IF;
			WHEN C => IF OR_10='1' THEN En_Reg_n2<='1'; EnCont_ingreso<='1'; END IF;
			WHEN D => IF OR_10='1' THEN En_Reg_n3<='1'; EnCont_ingreso<='1'; END IF;
			WHEN E => IF OR_10='1' THEN En_Reg_n4<='1'; EnCont_ingreso<='1'; END IF;
			WHEN F => IF VERIFICACION='1' THEN PUERTA<='1'; RST_CONT_E<='1'; END IF;
			WHEN G => ERROR<='1'; EnCont_error<='1';
			WHEN H => ALARMA<='1';EnCont_1<='1';IF IGUAL1='1' THEN RST_CONT_E<='1'; END IF;
			WHEN I =>
			WHEN J => EnCont_30<='1'; IF MY30='1' THEN LLAMADA<='1'; END IF;
			WHEN K => ALARMA<='1'; HABILITACION<='1';EnCont_10<='1';
		END CASE;
	END PROCESS;
END SOL;


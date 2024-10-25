library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REGISTER_FILE is
    Port ( Adr1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Adr2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Data_Out1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Data_Out2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Data_In : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC);
end REGISTER_FILE;

architecture Behavioral of REGISTER_FILE is

component REGISTER_MODULE is
    Port ( Data_In : in  STD_LOGIC_VECTOR (31 downto 0);
           Data_Out : out  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC);
end component;

component MUX32 is
	Port ( R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15,R16,R17,
			 R18,R19,R20,R21,R22,R23,R24,R25,R26,R27,R28,R29,R30,R31 : in  STD_LOGIC_VECTOR (31 downto 0);
          Sel : in  STD_LOGIC_VECTOR (4 downto 0);
          Output_Mux : out  STD_LOGIC_VECTOR(31 downto 0));
end component;

component DECODER_5_32 is
    Port ( Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Decoder_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal DecOut_Signal, RegistWrEn, RegistOut0,RegistOut1, RegistOut2,RegistOut3, RegistOut4, RegistOut5, RegistOut6, RegistOut7,RegistOut8, 
RegistOut9, RegistOut10, RegistOut11, RegistOut12, RegistOut13,RegistOut14, RegistOut15, RegistOut16, RegistOut17, RegistOut18, RegistOut19, RegistOut20, 
RegistOut21, RegistOut22, RegistOut23, RegistOut24, RegistOut25,RegistOut26, RegistOut27, RegistOut28, RegistOut29, RegistOut30, RegistOut31,
WrEn_Signal : std_logic_vector(31 downto 0);

begin

DECODER: DECODER_5_32 port map ( Awr =>Awr,
											Decoder_Out => DecOut_Signal);
							
WrEn_Signal <= WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn
& WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn;
	
RegistWrEn <= (WrEn_Signal  and DecOut_Signal) after 2ns;
							
REGISTER0: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => '0',
											Data_In => Data_In,
											Data_Out => RegistOut0);

REGISTER1: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(1),
											Data_In => Data_In,
											Data_Out => RegistOut1);

REGISTER2: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(2),
											Data_In => Data_In,
											Data_Out => RegistOut2);

REGISTER3: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(3),
											Data_In => Data_In,
											Data_Out => RegistOut3);
											
REGISTER4: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(4),
											Data_In => Data_In,
											Data_Out => RegistOut4);
											
REGISTER5: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(5),
											Data_In => Data_In,
											Data_Out => RegistOut5);
											
REGISTER6: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(6),
											Data_In => Data_In,
											Data_Out => RegistOut6);
											
REGISTER7: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(7),
											Data_In => Data_In,
											Data_Out => RegistOut7);
											
REGISTER8: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(8),
											Data_In => Data_In,
											Data_Out => RegistOut8);
											
REGISTER9: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(9),
											Data_In => Data_In,
											Data_Out => RegistOut9);
											
REGISTER10: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(10),
											Data_In => Data_In,
											Data_Out => RegistOut10);

REGISTER11: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(11),
											Data_In => Data_In,
											Data_Out => RegistOut11);

REGISTER12: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(12),
											Data_In => Data_In,
											Data_Out => RegistOut12);

REGISTER13: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(13),
											Data_In => Data_In,
											Data_Out => RegistOut13);

REGISTER14: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(14),
											Data_In => Data_In,
											Data_Out => RegistOut14);
											
REGISTER15: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(15),
											Data_In => Data_In,
											Data_Out => RegistOut15);
											
REGISTER16: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(16),
											Data_In => Data_In,
											Data_Out => RegistOut16);
											
REGISTER17: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(17),
											Data_In => Data_In,
											Data_Out => RegistOut17);
											
REGISTER18: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(18),
											Data_In => Data_In,
											Data_Out => RegistOut18);
											
REGISTER19: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(19),
											Data_In => Data_In,
											Data_Out => RegistOut19);
											
REGISTER20: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(20),
											Data_In => Data_In,
											Data_Out => RegistOut20);
											
REGISTER21: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(21),
											Data_In => Data_In,
											Data_Out => RegistOut21);

REGISTER22: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(22),
											Data_In => Data_In,
											Data_Out => RegistOut22);

REGISTER23: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(23),
											Data_In => Data_In,
											Data_Out => RegistOut23);

REGISTER24: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(24),
											Data_In => Data_In,
											Data_Out => RegistOut24);

REGISTER25: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(25),
											Data_In => Data_In,
											Data_Out => RegistOut25);
											
REGISTER26: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(26),
											Data_In => Data_In,
											Data_Out => RegistOut26);
											
REGISTER27: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(27),
											Data_In => Data_In,
											Data_Out => RegistOut27);
											
REGISTER28: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(28),
											Data_In => Data_In,
											Data_Out => RegistOut28);
											
REGISTER29: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(29),
											Data_In => Data_In,
											Data_Out => RegistOut29);
											
REGISTER30: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(30),
											Data_In => Data_In,
											Data_Out => RegistOut30);
											
REGISTER31: REGISTER_MODULE PORT MAP ( Clk => Clk,
											Rst => Rst,
											WrEn => RegistWrEn(31),
											Data_In => Data_In,
											Data_Out => RegistOut31);


MUX1: MUX32 port map(Sel => Adr1,
							Output_Mux => Data_Out1,
							R0 => RegistOut0,
							R1 => RegistOut1,
							R2 => RegistOut2,
							R3 => RegistOut3,
							R4 => RegistOut4,
							R5 => RegistOut5,
							R6 => RegistOut6,
							R7 => RegistOut7,
							R8 => RegistOut8,
							R9 => RegistOut9,
							R10 => RegistOut10,
							R11 => RegistOut11,
							R12 => RegistOut12,
							R13 => RegistOut13,
							R14 => RegistOut14,
							R15 => RegistOut15,
							R16 => RegistOut16,
							R17 => RegistOut17,
							R18 => RegistOut18,
							R19 => RegistOut19,
							R20 => RegistOut20,
							R21 => RegistOut21,
							R22 => RegistOut22,
							R23 => RegistOut23,
							R24 => RegistOut24,
							R25 => RegistOut25,
							R26 => RegistOut26,
							R27 => RegistOut27,
							R28 => RegistOut28,
							R29 => RegistOut29,
							R30 => RegistOut30,
							R31 => RegistOut31);
								
MUX2: MUX32 port map(Sel => Adr2,
							Output_Mux => Data_Out2,
							R0 => RegistOut0,
							R1 => RegistOut1,
							R2 => RegistOut2,
							R3 => RegistOut3,
							R4 => RegistOut4,
							R5 => RegistOut5,
							R6 => RegistOut6,
							R7 => RegistOut7,
							R8 => RegistOut8,
							R9 => RegistOut9,
							R10 => RegistOut10,
							R11 => RegistOut11,
							R12 => RegistOut12,
							R13 => RegistOut13,
							R14 => RegistOut14,
							R15 => RegistOut15,
							R16 => RegistOut16,
							R17 => RegistOut17,
							R18 => RegistOut18,
							R19 => RegistOut19,
							R20 => RegistOut20,
							R21 => RegistOut21,
							R22 => RegistOut22,
							R23 => RegistOut23,
							R24 => RegistOut24,
							R25 => RegistOut25,
							R26 => RegistOut26,
							R27 => RegistOut27,
							R28 => RegistOut28,
							R29 => RegistOut29,
							R30 => RegistOut30,
							R31 => RegistOut31);											
											
											

end Behavioral;


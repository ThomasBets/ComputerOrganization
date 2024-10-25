library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DECSTAGE is
		Port (Instr : in  STD_LOGIC_VECTOR (31 downto 0);
            RF_WrEn : in  STD_LOGIC;
            ALU_Out : in  STD_LOGIC_VECTOR (31 downto 0);
            MEM_Out : in  STD_LOGIC_VECTOR (31 downto 0);
            RF_WrData_Sel : in  STD_LOGIC;
            RF_B_Sel : in  STD_LOGIC;
            ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
            Clk : in  STD_LOGIC;
            Immed : out  STD_LOGIC_VECTOR (31 downto 0);
            RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
            RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;

architecture Behavioral of DECSTAGE is

component REGISTER_FILE is
		Port (Adr1 : in  STD_LOGIC_VECTOR (4 downto 0);
            Adr2 : in  STD_LOGIC_VECTOR (4 downto 0);
            Awr : in  STD_LOGIC_VECTOR (4 downto 0);
            Data_Out1 : out  STD_LOGIC_VECTOR (31 downto 0);
            Data_Out2 : out  STD_LOGIC_VECTOR (31 downto 0);
            Data_In : in  STD_LOGIC_VECTOR (31 downto 0);
            WrEn : in  STD_LOGIC;
            Clk : in  STD_LOGIC;
            Rst : in  STD_LOGIC);
end component;

component MUX_2X1 is
		Port (Ctrl : in  STD_LOGIC;
				Input_A : in  STD_LOGIC_VECTOR (31 downto 0);
				Input_B : in  STD_LOGIC_VECTOR (31 downto 0);
				Mux_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MUX_2X1_5BITS is
		Port (Ctrl : in  STD_LOGIC;
				Input_A : in  STD_LOGIC_VECTOR (4 downto 0);
				Input_B : in  STD_LOGIC_VECTOR (4 downto 0);
				Mux_Out : out  STD_LOGIC_VECTOR (4 downto 0));
end component;

component EXTENDER is
		Port (Instr : in  STD_LOGIC_VECTOR (15 downto 0);
				Op : in  STD_LOGIC_VECTOR (1 downto 0);
				Immed : out  STD_LOGIC_VECTOR (31 downto 0));
end component;


signal Mux_Out_5bit: STD_LOGIC_VECTOR (4 downto 0);
signal Mux_Out_32bit: STD_LOGIC_VECTOR (31 downto 0);

begin

MUX1:  MUX_2X1 port map(Ctrl => RF_WrData_Sel,
							   Input_A => ALU_Out,
							   Input_B => MEM_Out,
							   Mux_Out => Mux_Out_32bit);
							  
MUX2: MUX_2X1_5BITS port map (Ctrl => RF_B_Sel,
										Input_A => Instr(15 downto 11),
										Input_B => Instr(20 downto 16),
										Mux_Out => Mux_Out_5bit);

REG_FILE: REGISTER_FILE port map (Adr1 => Instr(25 downto 21),
											 Adr2 => Mux_Out_5bit,
											 Awr => Instr(20 downto 16),
											 Data_Out1 => RF_A,
											 Data_Out2 => RF_B,
											 Data_In => Mux_Out_32bit,
											 WrEn => RF_WrEn,
											 Clk => Clk,
											 Rst => '0');

EXTENDER16TO32: EXTENDER port map (Instr => Instr(15 downto 0),
											  Op => ImmExt,
											  Immed => Immed);									 

end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EXSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_Sel  : in  STD_LOGIC;
           ALU_Func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_Out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Zero  : out  STD_LOGIC);
end EXSTAGE;

architecture Behavioral of EXSTAGE is

component ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Carry_Out : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end component;

component MUX_2X1 is
    Port ( Ctrl : in  STD_LOGIC;
           Input_A : in  STD_LOGIC_VECTOR (31 downto 0);
           Input_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Mux_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;


signal Mux_Out_Signal : STD_LOGIC_VECTOR (31 downto 0);

begin

ALU_INSTANCE: ALU port map (A => RF_A ,
									 B => Mux_Out_Signal,
									 Op => ALU_Func,
									 Output => ALU_Out,
									 Zero => ALU_Zero);
									 
									 
MUX: MUX_2X1 port map (Ctrl => ALU_Bin_Sel,
							  Input_A => RF_B,
							  Input_B => Immed,
							  Mux_Out => Mux_Out_Signal);
end Behavioral;


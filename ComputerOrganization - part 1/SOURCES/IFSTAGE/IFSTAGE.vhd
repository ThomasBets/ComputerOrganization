library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (15 downto 0);
           PC_Sel  : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PC_Output : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is

component PROGRAM_COUNTER is
    Port ( PC_LdEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Data_In : in  STD_LOGIC_VECTOR (31 downto 0);
           Data_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MUX_2X1 is
    Port ( Ctrl : in  STD_LOGIC;
           Input_A : in  STD_LOGIC_VECTOR (31 downto 0);
           Input_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Mux_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component SIGN_EXTENDER16TO32 is
    Port ( Immed : in  STD_LOGIC_VECTOR (15 downto 0);
           SignExt_Output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal Mux_Out_Signal, Incr4_Out_Signal, AddImm_Out_Signal, PC_Out_Signal, SignExt_Immed_Signal :STD_LOGIC_VECTOR (31 downto 0);

begin

PC:PROGRAM_COUNTER port map ( PC_LdEn=>PC_LdEn,
										Clk=>Clk,
										Reset=>Reset,
										Data_In=>Mux_Out_Signal,
										Data_Out=>PC_Out_Signal);
			
MUX: MUX_2X1 		 port map ( Ctrl =>PC_Sel,
										Input_A=>Incr4_Out_Signal, 
										Input_B=>AddImm_Out_Signal, 
										Mux_Out=> Mux_Out_Signal);	
										
SIGN_EXT: SIGN_EXTENDER16TO32 port map (Immed => PC_Immed,
															SignExt_Output => SignExt_Immed_Signal);
																					
		
Incr4_Out_Signal <= PC_Out_Signal + 4;
AddImm_Out_Signal <= Incr4_Out_Signal + (SignExt_Immed_Signal(29 downto 0) & "00");

PC_Output <= PC_Out_Signal;


end Behavioral;


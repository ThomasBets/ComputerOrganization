library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EXTENDER is
    Port ( Instr : in  STD_LOGIC_VECTOR (15 downto 0);
           Op : in  STD_LOGIC_VECTOR (1 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0));
end EXTENDER;

architecture Behavioral of EXTENDER is

signal Temp:STD_LOGIC_VECTOR (31 downto 0);

begin

Temp <= Instr(15) & Instr(15) & Instr(15) & Instr(15) & Instr(15) & Instr(15) & Instr(15) & Instr(15) & Instr(15) & Instr(15) 
			& Instr(15) & Instr(15) & Instr(15) & Instr(15) & Instr(15) & Instr(15) & Instr(15 downto 0)
        when Op = "00" else
		 
		  "0000000000000000" & Instr 
		  when Op="01" else
		 
		  Instr & "0000000000000000" 
		  when Op="10" else
		  
		  Temp;

Immed <= Temp;

end Behavioral;
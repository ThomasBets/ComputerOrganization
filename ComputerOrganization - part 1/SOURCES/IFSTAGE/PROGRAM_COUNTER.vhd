library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PROGRAM_COUNTER is
    Port ( PC_LdEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Data_In : in  STD_LOGIC_VECTOR (31 downto 0);
           Data_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end PROGRAM_COUNTER;

architecture Behavioral of PROGRAM_COUNTER is

signal Temp : STD_LOGIC_VECTOR (31 downto 0);

begin
	
	process(Clk,Reset)
	
	begin
		
		if Reset = '1' then
			Temp <= "00000000000000000000000000000000";
			
		elsif Clk'EVENT AND Clk = '1' then
		
			if PC_LdEn = '1' then
				Temp <= Data_In;
			else 
				Temp <= Temp;
			end if;
		end if;	
	
	end process;
	
	Data_Out <= Temp;

end Behavioral;


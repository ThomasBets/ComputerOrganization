library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REGISTER_MODULE is
    Port ( Data_In : in  STD_LOGIC_VECTOR (31 downto 0);
           Data_Out : out  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC);
end REGISTER_MODULE;

architecture Behavioral of REGISTER_MODULE is

signal Result: STD_LOGIC_VECTOR(31 downto 0);

begin

	process
		begin
		
		wait until Clk'event and Clk='1';
		if (Rst = '1') then 
			Result <= "00000000000000000000000000000000";
		else
			if (WrEn = '1') then
			Result <= Data_In;
			else
			Result <= Result;
			end if;
		end if;
	end process;
	
Data_Out <= Result after 10ns;

end Behavioral;
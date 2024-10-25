library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SIGN_EXTENDER16TO32 is
    Port ( Immed : in  STD_LOGIC_VECTOR (15 downto 0);
           SignExt_Output : out  STD_LOGIC_VECTOR (31 downto 0));
end SIGN_EXTENDER16TO32;

architecture Behavioral of SIGN_EXTENDER16TO32 is

begin

	SignExt_Output	 <= Immed(15) & Immed(15) & Immed(15) & Immed(15) & Immed(15) & Immed(15) & Immed(15) & Immed(15) 
	& Immed(15) & Immed(15) & Immed(15) & Immed(15) & Immed(15) & Immed(15) & Immed(15) & Immed(15) & Immed(15 downto 0);

end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.all;
use IEEE.numeric_std.all;

entity INCREMENTX400 is
    Port ( Input : in  STD_LOGIC_VECTOR (31 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end INCREMENTX400;

architecture Behavioral of INCREMENTX400 is

begin

	Output <= Input + "10000000000";

end Behavioral;


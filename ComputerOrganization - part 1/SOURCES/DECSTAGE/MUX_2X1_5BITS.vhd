library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_2X1_5BITS is
		Port (Ctrl : in  STD_LOGIC;
				Input_A : in  STD_LOGIC_VECTOR (4 downto 0);
				Input_B : in  STD_LOGIC_VECTOR (4 downto 0);
				Mux_Out : out  STD_LOGIC_VECTOR (4 downto 0));
end MUX_2X1_5BITS;

architecture Behavioral of MUX_2X1_5BITS is

begin
		
		Mux_Out <= Input_A when Ctrl='0' else Input_B;

end Behavioral;

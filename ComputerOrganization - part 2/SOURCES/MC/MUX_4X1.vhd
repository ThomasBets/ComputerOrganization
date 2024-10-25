library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_4X1 is
    Port ( Ctrl : in  STD_LOGIC_VECTOR (1 downto 0);
           Input_A : in  STD_LOGIC_VECTOR (31 downto 0);
           Input_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Input_C : in  STD_LOGIC_VECTOR (31 downto 0);
           Input_D : in  STD_LOGIC_VECTOR(31 downto 0);
           Mux_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX_4X1;

architecture Behavioral of MUX_4X1 is

signal Mux_Out_Signal : std_logic_VECTOR (31 downto 0);

begin
process (Ctrl, Input_A, Input_B, Input_C, Input_D)
begin
	
	if (Ctrl="00") then Mux_Out_Signal<= Input_A;
	elsif (Ctrl="01") then Mux_Out_Signal<= Input_B;
	elsif (Ctrl="10") then Mux_Out_Signal<= Input_C;
 	else Mux_Out_Signal<= Input_D;
	end if;
	
end process;	
	  
Mux_Out <= Mux_Out_Signal;		
  
end Behavioral;
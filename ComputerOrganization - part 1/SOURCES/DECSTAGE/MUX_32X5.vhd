library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX32 is
	Port ( R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15,R16,R17,
			 R18,R19,R20,R21,R22,R23,R24,R25,R26,R27,R28,R29,R30,R31 : in  STD_LOGIC_VECTOR (31 downto 0);
          Sel : in  STD_LOGIC_VECTOR (4 downto 0);
          Output_Mux : out  STD_LOGIC_VECTOR(31 downto 0));
end MUX32;

architecture Behavioral of MUX32 is

signal Result_Signal: STD_LOGIC_VECTOR(31 downto 0);

begin

with Sel select
Result_Signal <=  R0	when "00000",
						R1	when "00001",
						R2 when "00010",
						R3 when "00011",
						R4 when "00100",
						R5 when "00101",
						R6 when "00110",
						R7 when "00111",
						R8 when "01000",
						R9 when "01001",
						R10 when "01010",
						R11 when "01011",
						R12 when "01100",
						R13 when "01101",
						R14 when "01110",
						R15 when "01111",
						R16 when "10000",
						R17 when "10001",
						R18 when "10010",
						R19 when "10011",
						R20 when "10100",
						R21 when "10101",
						R22 when "10110",
						R23 when "10111",
						R24 when "11000",
						R25 when "11001",
						R26 when "11010",
						R27 when "11011",
						R28 when "11100",
						R29 when "11101",
						R30 when "11110",
						R31 when others;
						
Output_Mux <= Result_Signal after 10 ns;

end Behavioral;


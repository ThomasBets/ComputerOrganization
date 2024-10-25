library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.all;
use IEEE.numeric_std.all;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Carry_Out : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

signal Out_Signal : STD_LOGIC_VECTOR(31 downto 0);
signal Tmp_Signal: STD_LOGIC_VECTOR (32 downto 0);

begin

Op_Process: process(A,B,Op)

begin

if (Op = "0000") then Out_Signal <= (A + B) ;
elsif (Op = "0001") then Out_Signal <= (A - B);
elsif (Op = "0010") then Out_Signal <= (A and B);
elsif (Op = "0011") then Out_Signal <= (A or B);
elsif (Op = "0100") then Out_Signal <= (not A);
elsif (Op = "0101") then Out_Signal <= not(A and B);
elsif (Op = "0110") then Out_Signal <= not(A or B);
elsif (Op = "1000") then Out_Signal <= A(31) & A(31 downto 1);
elsif (Op = "1001") then Out_Signal <= '0' & A(31 downto 1);
elsif (Op = "1010") then Out_Signal <= A(30 downto 0) & '0';
elsif (Op = "1100") then Out_Signal <= A(30 downto 0) & A(31);
elsif (Op = "1101") then Out_Signal <= A(0) & A(31 downto 1);
else Out_Signal <= "00000000000000000000000000000000";
end if;
end process;

with Op select		
			Tmp_Signal	<=	('0'& A)+('0'& B) 	when "0000" ,
								('0'& A)-('0'& B)		when "0001" ,
								Tmp_Signal 				when others;
						
						
with Op select	
			Carry_Out	<=	Tmp_Signal(32) 			when "0000" ,
								Tmp_Signal(32) 			when "0001" ,
								'0'					when others;
						
						
with Op select	
			Ovf		<=	Out_Signal(31) xor A(31) xor B(31) xor Tmp_Signal(32) 		when "0000" ,
							Out_Signal(31) xor A(31) xor B(31) xor Tmp_Signal(32) 		when "0001" ,
							'0'													when others;
							
Output <= Out_Signal after 10ns;
Zero <= '1' when Out_Signal = "00000000000000000000000000000000" else '0';

end Behavioral;


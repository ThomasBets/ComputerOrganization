library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DECODER_5_32 is
    Port ( Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Decoder_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end DECODER_5_32;

architecture Behavioral of DECODER_5_32 is

signal Result : STD_LOGIC_VECTOR(31 downto 0);

begin

Result(0) <= (not Awr(2)) and (not Awr(1)) and (not Awr(0)) and (not Awr(3)) and (not Awr(4));
Result(1) <= (not Awr(2)) and (not Awr(1)) and Awr(0) and (not Awr(3)) and (not Awr(4));
Result(2) <= (not Awr(2)) and Awr(1) and (not Awr(0)) and (not Awr(3)) and (not Awr(4));
Result(3) <= (not Awr(2)) and Awr(1) and Awr(0) and (not Awr(3)) and (not Awr(4));
Result(4) <= Awr(2) and (not Awr(1)) and (not Awr(0)) and (not Awr(3)) and (not Awr(4));
Result(5) <= Awr(2) and (not Awr(1)) and Awr(0) and (not Awr(3)) and (not Awr(4));
Result(6) <= Awr(2) and Awr(1) and (not Awr(0)) and (not Awr(3)) and (not Awr(4));
Result(7) <= Awr(2) and Awr(1) and Awr(0) and (not Awr(3)) and (not Awr(4));

Result(8) <= (not Awr(2)) and (not Awr(1)) and (not Awr(0)) and (not Awr(3)) and Awr(4);
Result(9) <= (not Awr(2)) and (not Awr(1)) and Awr(0) and (not Awr(3))and Awr(4);
Result(10) <= (not Awr(2)) and Awr(1) and (not Awr(0)) and (not Awr(3)) and Awr(4);
Result(11) <= (not Awr(2)) and Awr(1) and Awr(0) and (not Awr(3)) and Awr(4);
Result(12) <= Awr(2) and (not Awr(1)) and (not Awr(0)) and (not Awr(3)) and Awr(4);
Result(13) <= Awr(2) and (not Awr(1)) and Awr(0) and (not Awr(3)) and Awr(4);
Result(14) <= Awr(2) and Awr(1) and (not Awr(0)) and (not Awr(3)) and Awr(4);
Result(15) <= Awr(2) and Awr(1) and Awr(0) and (not Awr(3)) and Awr(4);

Result(16) <= (not Awr(2)) and (not Awr(1)) and (not Awr(0)) and Awr(3) and (not Awr(4));
Result(17) <= (not Awr(2)) and (not Awr(1)) and Awr(0)and Awr(3) and (not Awr(4));
Result(18) <= (not Awr(2)) and Awr(1) and (not Awr(0))and Awr(3)and (not Awr(4));
Result(19) <= (not Awr(2)) and Awr(1) and Awr(0) and Awr(3) and (not Awr(4));
Result(20) <= Awr(2) and (not Awr(1)) and (not Awr(0)) and Awr(3) and (not Awr(4));
Result(21) <= Awr(2) and (not Awr(1)) and Awr(0) and Awr(3) and (not Awr(4));
Result(22) <= Awr(2) and Awr(1) and (not Awr(0)) and Awr(3) and (not Awr(4));
Result(23) <= Awr(2) and Awr(1) and Awr(0) and Awr(3) and (not Awr(4));

Result(24) <= (not Awr(2)) and (not Awr(1)) and (not Awr(0)) and Awr(3) and Awr(4);
Result(25) <= (not Awr(2)) and (not Awr(1)) and Awr(0) and Awr(3) and Awr(4);
Result(26) <= (not Awr(2)) and Awr(1) and (not Awr(0)) and Awr(3) and Awr(4);
Result(27) <= (not Awr(2)) and Awr(1) and Awr(0) and Awr(3) and Awr(4);
Result(28) <= Awr(2) and (not Awr(1)) and (not Awr(0)) and Awr(3) and Awr(4);
Result(29) <= Awr(2) and (not Awr(1)) and Awr(0)and Awr(3) and Awr(4);
Result(30) <= Awr(2) and Awr(1) and (not Awr(0)) and Awr(3) and Awr(4);
Result(31) <= Awr(2) and Awr(1) and Awr(0) and Awr(3) and Awr(4);

Decoder_Out <= Result after 10 ns;
end Behavioral;


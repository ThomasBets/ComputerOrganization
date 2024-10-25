library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity RAM is
    Port ( Clk  : in  STD_LOGIC;
           Inst_Addr : in  STD_LOGIC_VECTOR (10 downto 0);
           Inst_Data_Out : out  STD_LOGIC_VECTOR (31 downto 0);
           Data_WrEn  : in  STD_LOGIC;
           Data_Addr : in  STD_LOGIC_VECTOR (10 downto 0);
           Data_In : in  STD_LOGIC_VECTOR (31 downto 0);
           Data_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end RAM;

architecture syn of RAM is
	
type ram_type is array (2047 downto 0) of STD_LOGIC_VECTOR (31 downto 0);

 impure function InitRamFromFile (RamFileName : in string) return ram_type is
 file ramfile : text is in RamFileName;
 variable RamFileLine : line;
 variable ram : ram_type;
 
 begin
	for i in 0 to 1023 loop
		readline(ramfile, RamFileLine);
		read (RamFileLine, ram(i));
	end loop;
	
	for i in 1024 to 2047 loop
		ram(i) := x"00000000";
	end loop;
 return ram;
 end function;
 
 signal RAM: ram_type := InitRamFromFile("rom.data");

 begin
	process (Clk)
		begin
			if Clk'event and Clk = '1' then
				if Data_WrEn = '1' then
					RAM(conv_integer(Data_Addr)) <= Data_In;
				end if;
			end if;
 end process;
 
 Data_Out <= RAM(conv_integer(Data_Addr)) after 12ns;
 Inst_Data_Out <= RAM(conv_integer(Inst_Addr)) after 12ns;
end syn;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MEMSTAGE is
    Port ( Clk : in  STD_LOGIC;
           ByteOp  : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_Data_In : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_Addr : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEn : out  STD_LOGIC;
           MM_WrData  : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData  : in  STD_LOGIC_VECTOR (31 downto 0));
end MEMSTAGE;

architecture Behavioral of MEMSTAGE is

component INCREMENTX400 is
    Port ( Input : in  STD_LOGIC_VECTOR (31 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal IncrX400_Signal, MM_WrData_Siganl, MEM_DataOut_Signal : STD_LOGIC_VECTOR (31 downto 0); 


begin
	
INCRX400: INCREMENTX400 port map (Input => ALU_MEM_Addr,
											 Output => IncrX400_Signal);	
	
	MM_WrEn <= Mem_WrEn;
	MM_Addr <= IncrX400_Signal;
	
ByteOp_Process: process(ByteOp)

begin	
	if (ByteOp = '0') then		
			MM_WrData_Siganl <=  MEM_Data_In;
			MEM_DataOut_Signal <= MM_RdData;
	 else 
			MM_WrData_Siganl <= "000000000000000000000000"  & MEM_Data_In(7 downto 0);
			MEM_DataOut_Signal <= "000000000000000000000000" & MM_RdData(7 downto 0);
	end if;
	
end process;	

	MM_WrData <= MM_WrData_Siganl;
	MEM_DataOut <= MEM_DataOut_Signal;
	
end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DATAPATH is
		Port (Instr : in  STD_LOGIC_VECTOR (31 downto 0);
            RF_WrEn : in  STD_LOGIC;
				RF_WrData_Sel : in  STD_LOGIC;
            RF_B_Sel : in  STD_LOGIC;
				ImmExt : in  STD_LOGIC_VECTOR (1 downto 0); 			-- From DECSTAGE
				
				ALU_Bin_Sel  : in  STD_LOGIC;
            ALU_Func : in  STD_LOGIC_VECTOR (3 downto 0);
				ALU_Zero  : out  STD_LOGIC; 								-- From EXSTAGE
				
				PC_Sel  : in  STD_LOGIC;
            PC_LdEn : in  STD_LOGIC;
            Reset : in  STD_LOGIC;
            PC_Output : out  STD_LOGIC_VECTOR (31 downto 0);	-- From IFSTAGE
				
				ByteOp  : in  STD_LOGIC;
				Mem_WrEn : in  STD_LOGIC;
            MM_Addr : out  STD_LOGIC_VECTOR (31 downto 0);
            MM_WrEn : out  STD_LOGIC;
            MM_WrData  : out  STD_LOGIC_VECTOR (31 downto 0);
            MM_RdData  : in  STD_LOGIC_VECTOR (31 downto 0);	-- From MEMSTAGE
				
				Clk : in  STD_LOGIC);	
end DATAPATH;

architecture Behavioral of DATAPATH is

component DECSTAGE is
		Port (Instr : in  STD_LOGIC_VECTOR (31 downto 0);
            RF_WrEn : in  STD_LOGIC;
            ALU_Out : in  STD_LOGIC_VECTOR (31 downto 0);
            MEM_Out : in  STD_LOGIC_VECTOR (31 downto 0);
            RF_WrData_Sel : in  STD_LOGIC;
            RF_B_Sel : in  STD_LOGIC;
            ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
            Clk : in  STD_LOGIC;
            Immed : out  STD_LOGIC_VECTOR (31 downto 0);
            RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
            RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (15 downto 0);
           PC_Sel  : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PC_Output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component EXSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_Sel  : in  STD_LOGIC;
           ALU_Func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_Out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Zero  : out  STD_LOGIC);
end component;

component MEMSTAGE is
    Port ( ByteOp  : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_Data_In : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_Addr : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEn : out  STD_LOGIC;
           MM_WrData  : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData  : in  STD_LOGIC_VECTOR (31 downto 0);
			  Clk : in  STD_LOGIC);
end component;

signal RFA_Signal, RFB_Signal, Immed_Signal, ALU_Out_Signal, MEM_DataOut_Signal  : STD_LOGIC_VECTOR (31 downto 0);

begin

DECSTG: DECSTAGE port map (Instr => Instr,
									RF_WrEn => RF_WrEn,
									ALU_Out => ALU_Out_Signal,
									MEM_Out => MEM_DataOut_Signal,
									RF_WrData_Sel => RF_WrData_Sel,
									RF_B_Sel => RF_B_Sel,
									ImmExt => ImmExt,
									Clk => Clk,
									Immed => Immed_Signal,
									RF_A => RFA_Signal,
									RF_B => RFB_Signal);
									
IFSTG: IFSTAGE port map (PC_Immed => Instr(15 downto 0),
								 PC_Sel => PC_Sel,
								 PC_LdEn => PC_LdEn,
								 Reset => Reset,
								 Clk => Clk,
								 PC_Output => PC_Output);									

EXSTG: EXSTAGE port map (RF_A => RFA_Signal,
								 RF_B =>	RFB_Signal,
								 Immed => Immed_Signal,
								 ALU_Bin_Sel => ALU_Bin_Sel,
								 ALU_Func => ALU_Func,
								 ALU_Out => ALU_Out_Signal,
								 ALU_Zero => ALU_Zero);
								 
MEMSTG: MEMSTAGE	port map (ByteOp => ByteOp,
									 Mem_WrEn => Mem_WrEn,
									 ALU_MEM_Addr => ALU_Out_Signal,
									 MEM_Data_In => RFB_Signal,
									 MEM_DataOut => MEM_DataOut_Signal,
									 MM_Addr => MM_Addr,
									 MM_WrEn => MM_WrEn,
									 MM_WrData => MM_WrData,
									 MM_RdData => MM_RdData,
									 Clk => Clk);							 
end Behavioral;
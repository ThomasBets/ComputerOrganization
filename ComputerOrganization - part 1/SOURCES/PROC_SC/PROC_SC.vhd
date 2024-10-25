library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PROC_SC is
		Port (Reset : in  STD_LOGIC;
				Clk  : in  STD_LOGIC);
end PROC_SC;

architecture Behavioral of PROC_SC is

component DATAPATH is
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
end component;

component RAM is
    Port ( Clk  : in  STD_LOGIC;
           Inst_Addr : in  STD_LOGIC_VECTOR (10 downto 0);
           Inst_Data_Out : out  STD_LOGIC_VECTOR (31 downto 0);
           Data_WrEn  : in  STD_LOGIC;
           Data_Addr : in  STD_LOGIC_VECTOR (10 downto 0);
           Data_In : in  STD_LOGIC_VECTOR (31 downto 0);
           Data_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component CONTROL is
		Port (Instr : in  STD_LOGIC_VECTOR (31 downto 0);
				ALU_Zero  : in  STD_LOGIC;
				Reset : in  STD_LOGIC;
				Clk : in  STD_LOGIC;				
            RF_WrEn : out  STD_LOGIC;
				RF_WrData_Sel : out  STD_LOGIC;
            RF_B_Sel : out  STD_LOGIC;
				ImmExt : out  STD_LOGIC_VECTOR (1 downto 0);
				ALU_Bin_Sel  : out  STD_LOGIC;
            ALU_Func : out  STD_LOGIC_VECTOR (3 downto 0);				
				PC_Sel  : out  STD_LOGIC;
            PC_LdEn : out  STD_LOGIC;           					
				ByteOp  : out  STD_LOGIC;
				Mem_WrEn : out  STD_LOGIC);
end component;

signal Instr_Signal, PC_Output_Signal, MM_WrData_Signal, MM_RdData_Signal, Mem_Data_Addr_Signal : STD_LOGIC_VECTOR (31 downto 0);
signal ALU_Func_Signal : STD_LOGIC_VECTOR (3 downto 0);
signal ImmExt_Signal : STD_LOGIC_VECTOR (1 downto 0);
signal ALU_Zero_Signal, RF_WrEn_Signal, RF_WrData_Sel_Signal, RF_B_Sel_Signal, ALU_Bin_Sel_Signal, PC_Sel_Signal, PC_LdEn_Signal, ByteOp_Signal, Mem_WrEn_Signal, MM_WrEn_Signal : STD_LOGIC;


begin

DATAPATH_INST: DATAPATH port map(Instr => Instr_Signal,
											RF_WrEn => RF_WrEn_Signal,
											RF_WrData_Sel => RF_WrData_Sel_Signal,
											RF_B_Sel => RF_B_Sel_Signal,
											ImmExt => ImmExt_Signal,
											ALU_Bin_Sel => ALU_Bin_Sel_Signal,
											ALU_Func => ALU_Func_Signal,
											ALU_Zero => ALU_Zero_Signal,
											PC_Sel => PC_Sel_Signal,
											PC_LdEn =>PC_LdEn_Signal,
											Reset => Reset,
											PC_Output => PC_Output_Signal,
											ByteOp => ByteOp_Signal,
											Mem_WrEn => Mem_WrEn_Signal,
											MM_Addr => Mem_Data_Addr_Signal,
											MM_WrEn => MM_WrEn_Signal,
											MM_WrData => MM_WrData_Signal,
											MM_RdData => MM_RdData_Signal,
											Clk => Clk);
	

RAM_INST: RAM port map(Clk => Clk,
							  Inst_Addr => PC_Output_Signal(12 downto 2),
							  Inst_Data_Out => Instr_Signal,
							  Data_WrEn => MM_WrEn_Signal,
							  Data_Addr => Mem_Data_Addr_Signal(12 downto 2),
							  Data_In => MM_WrData_Signal,
							  Data_Out => MM_RdData_Signal);


CONTROL_INST: CONTROL port map(Instr => Instr_Signal,
										 ALU_Zero => ALU_Zero_Signal,
										 Reset => Reset,
										 Clk => Clk,
										 RF_WrEn => RF_WrEn_Signal,
										 RF_WrData_Sel => RF_WrData_Sel_Signal,
										 RF_B_Sel => RF_B_Sel_Signal,
										 ImmExt => ImmExt_Signal,
										 ALU_Bin_Sel => ALU_Bin_Sel_Signal,
										 ALU_Func => ALU_Func_Signal,
										 PC_Sel => PC_Sel_Signal,
										 PC_LdEn => PC_LdEn_Signal,
										 ByteOp => ByteOp_Signal,
										 Mem_WrEn => Mem_WrEn_Signal);

end Behavioral;


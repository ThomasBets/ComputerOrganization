library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DATAPATH is
		Port (Instr : in  STD_LOGIC_VECTOR (31 downto 0);
            RF_WrEn : in  STD_LOGIC;
				RF_WrData_Sel : in  STD_LOGIC;
            RF_B_Sel : in  STD_LOGIC;
				ImmExt : in  STD_LOGIC_VECTOR (1 downto 0); 			-- From DECSTAGE
				
				ALU_Bin_Sel  : in  STD_LOGIC_VECTOR (1 downto 0);
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
				
				IorD : in  STD_LOGIC;
				IRWrite : in  STD_LOGIC;
				ALU_Ain_Sel : in  STD_LOGIC;
				PcSource : in  STD_LOGIC_VECTOR (1 downto 0);
				
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
           ALU_Bin_Sel  : in  STD_LOGIC_VECTOR (1 downto 0);
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

component REGISTER_MODULE
	Port(
		Data_In : in std_logic_vector(31 downto 0);
		WrEn :in std_logic;
		Clk : in std_logic;
		Rst : in std_logic;          
		Data_Out : out std_logic_vector(31 downto 0)
		);
end component;

component MUX_2X1
	Port(
		Ctrl : in std_logic;
		Input_A : in std_logic_vector(31 downto 0);
		Input_B : in std_logic_vector(31 downto 0);          
		Mux_Out :  out std_logic_vector(31 downto 0)
		);
end component;

component MUX_4X1 is
    Port ( Ctrl : in  STD_LOGIC_VECTOR (1 downto 0);
           Input_A : in  STD_LOGIC_VECTOR (31 downto 0);
           Input_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Input_C : in  STD_LOGIC_VECTOR (31 downto 0);
           Input_D : in  STD_LOGIC_VECTOR(31 downto 0);
           Mux_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal RFA_Signal, RFB_Signal, Immed_Signal, ALU_Out_Signal, MEM_DataOut_Signal, Instr_Signal, Mem_RegOut_Signal, Alu_RegOut_Signal, 
PC_Output_Signal, IorD_Out_Signal, RegA_Out_Signal, RegB_Out_Signal, Mux_A_Out_Signal, Pc_Source_Signal, Pc_Src_In_Signal  : STD_LOGIC_VECTOR (31 downto 0);
signal AlwaysEn : std_logic;
begin

AlwaysEn <= '1';
Pc_Src_In_Signal <= PC_Output_Signal(31 downto 28)& Instr_Signal(25 downto 0) & "00";


DECSTG: DECSTAGE port map (Instr => Instr_Signal,
									RF_WrEn => RF_WrEn,
									ALU_Out => Alu_RegOut_Signal,
									MEM_Out => Mem_RegOut_Signal,
									RF_WrData_Sel => RF_WrData_Sel,
									RF_B_Sel => RF_B_Sel,
									ImmExt => ImmExt,
									Clk => Clk,
									Immed => Immed_Signal,
									RF_A => RFA_Signal,
									RF_B => RFB_Signal);
									
IFSTG: IFSTAGE port map (PC_Immed => Instr_Signal(15 downto 0),
								 PC_Sel => PC_Sel,
								 PC_LdEn => PC_LdEn,
								 Reset => Reset,
								 Clk => Clk,
								 PC_Output => PC_Output_Signal);									

EXSTG: EXSTAGE port map (RF_A => Mux_A_Out_Signal,
								 RF_B =>	RegB_Out_Signal,
								 Immed => Immed_Signal,
								 ALU_Bin_Sel => ALU_Bin_Sel,
								 ALU_Func => ALU_Func,
								 ALU_Out => ALU_Out_Signal,
								 ALU_Zero => ALU_Zero);
								 
MEMSTG: MEMSTAGE	port map (ByteOp => ByteOp,
									 Mem_WrEn => Mem_WrEn,
									 ALU_MEM_Addr => IorD_Out_Signal,
									 MEM_Data_In => RFB_Signal,
									 MEM_DataOut => MEM_DataOut_Signal,
									 MM_Addr => MM_Addr,
									 MM_WrEn => MM_WrEn,
									 MM_WrData => MM_WrData,
									 MM_RdData => MM_RdData,
									 Clk => Clk);	


IORD_MUX_2X1: MUX_2X1 port map(Ctrl => IorD,
										 Input_A => PC_Output_Signal,
										 Input_B => Alu_RegOut_Signal,
										 Mux_Out => IorD_Out_Signal);


IR_REGISTER : REGISTER_MODULE port map(Data_In => MEM_DataOut_Signal,
													Data_Out => Instr_Signal,
													WrEn => IRWrite,
													Clk => Clk,
													Rst => Reset);
													
MEM_DATA_REGISTER : REGISTER_MODULE port map(Data_In => MEM_DataOut_Signal,
													Data_Out => Mem_RegOut_Signal,
													WrEn => AlwaysEn,
													Clk => Clk,
													Rst => Reset);	
													
REG_A : REGISTER_MODULE port map(Data_In => RFA_Signal,
											Data_Out => RegA_Out_Signal,
											WrEn => AlwaysEn,
											Clk => Clk,
											Rst => Reset);
											
REG_B : REGISTER_MODULE port map(Data_In => RFB_Signal,
											Data_Out => RegB_Out_Signal,
											WrEn => AlwaysEn,
											Clk => Clk,
											Rst => Reset);	

REG_A_SEP_MUX_2X1: MUX_2X1 port map(Ctrl => ALU_Ain_Sel,
										 Input_A => PC_Output_Signal,
										 Input_B => RegA_Out_Signal,
										 Mux_Out => Mux_A_Out_Signal);	

ALU_OUT_REG : REGISTER_MODULE port map(Data_In => ALU_Out_Signal,
											Data_Out => Alu_RegOut_Signal,
											WrEn => AlwaysEn,
											Clk => Clk,
											Rst => Reset);
											
PC_SOURCE_MUX_4X1: MUX_4X1 PORT MAP(Ctrl => PcSource,
												Input_A => ALU_Out_Signal,
												Input_B => Alu_RegOut_Signal,
												Input_C => Pc_Src_In_Signal ,
												Input_D => "00000000000000000000000000000000" ,
												Mux_Out => Pc_Source_Signal );										
												
end Behavioral;
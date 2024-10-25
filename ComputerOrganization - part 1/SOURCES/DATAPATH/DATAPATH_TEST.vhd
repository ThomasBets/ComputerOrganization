LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY DATAPATH_TEST IS
END DATAPATH_TEST;
 
ARCHITECTURE behavior OF DATAPATH_TEST IS 
 
    COMPONENT DATAPATH
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         RF_WrData_Sel : IN  std_logic;
         RF_B_Sel : IN  std_logic;
         ImmExt : IN  std_logic_vector(1 downto 0);
         ALU_Bin_Sel : IN  std_logic;
         ALU_Func : IN  std_logic_vector(3 downto 0);
         ALU_Zero : OUT  std_logic;
         PC_Sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         PC_Output : OUT  std_logic_vector(31 downto 0);
         ByteOp : IN  std_logic;
         Mem_WrEn : IN  std_logic;
         MM_Addr : OUT  std_logic_vector(31 downto 0);
         MM_WrEn : OUT  std_logic;
         MM_WrData : OUT  std_logic_vector(31 downto 0);
         MM_RdData : IN  std_logic_vector(31 downto 0);
         Clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal RF_WrData_Sel : std_logic := '0';
   signal RF_B_Sel : std_logic := '0';
   signal ImmExt : std_logic_vector(1 downto 0) := (others => '0');
   signal ALU_Bin_Sel : std_logic := '0';
   signal ALU_Func : std_logic_vector(3 downto 0) := (others => '0');
   signal PC_Sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal ByteOp : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';
   signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');
   signal Clk : std_logic := '0';

 	--Outputs
   signal ALU_Zero : std_logic;
   signal PC_Output : std_logic_vector(31 downto 0);
   signal MM_Addr : std_logic_vector(31 downto 0);
   signal MM_WrEn : std_logic;
   signal MM_WrData : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          RF_WrData_Sel => RF_WrData_Sel,
          RF_B_Sel => RF_B_Sel,
          ImmExt => ImmExt,
          ALU_Bin_Sel => ALU_Bin_Sel,
          ALU_Func => ALU_Func,
          ALU_Zero => ALU_Zero,
          PC_Sel => PC_Sel,
          PC_LdEn => PC_LdEn,
          Reset => Reset,
          PC_Output => PC_Output,
          ByteOp => ByteOp,
          Mem_WrEn => Mem_WrEn,
          MM_Addr => MM_Addr,
          MM_WrEn => MM_WrEn,
          MM_WrData => MM_WrData,
          MM_RdData => MM_RdData,
          Clk => Clk
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      
		Reset <= '1';
      wait for 100 ns;
		
		Reset <='0';
		Instr <= "00000001000100010000000000000000";
		PC_Sel <='0';
		PC_LdEn <='1';
		RF_WrEn <='1';
		RF_WrData_Sel <='1';
		RF_B_Sel <='1';
		ImmExt <="10";
		ALU_Bin_Sel <='1';
		ALU_Func <="0000";
		Mem_WrEn <='0';
		ByteOp <='0';
		wait for 100 ns;
		
		Instr <= "00000000010101010000000000000000";
		PC_Sel <='0';
		PC_LdEn <='1';
		RF_WrEn <='1';
		RF_WrData_Sel <='1';
		RF_B_Sel <='1';
		ImmExt <="00";
		ALU_Bin_Sel <='1';
		ALU_Func <="0011";
		Mem_WrEn <='0';
		ByteOp <='0';
		wait for 100 ns;
		
		Instr <= "00000000010101110000000000000000";
		PC_Sel <='0';
		PC_LdEn <='1';
		RF_WrEn <='1';
		RF_WrData_Sel <='0';
		RF_B_Sel <='1';
		ImmExt <="00";
		ALU_Bin_Sel <='1';
		ALU_Func <="0000";
		Mem_WrEn <='1';
		ByteOp <='0';
		wait for 100 ns;
		
		
      wait;
   end process;

END;

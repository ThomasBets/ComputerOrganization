LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY MEMSTAGE_TEST IS
END MEMSTAGE_TEST;
 
ARCHITECTURE behavior OF MEMSTAGE_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMSTAGE
    PORT(
         Clk : IN  std_logic;
         ByteOp : IN  std_logic;
         Mem_WrEn : IN  std_logic;
         ALU_MEM_Addr : IN  std_logic_vector(31 downto 0);
         MEM_Data_In : IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0);
         MM_Addr : OUT  std_logic_vector(31 downto 0);
         MM_WrEn : OUT  std_logic;
         MM_WrData : OUT  std_logic_vector(31 downto 0);
         MM_RdData : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal ByteOp : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_Data_In : std_logic_vector(31 downto 0) := (others => '0');
   signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);
   signal MM_Addr : std_logic_vector(31 downto 0);
   signal MM_WrEn : std_logic;
   signal MM_WrData : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGE PORT MAP (
          Clk => Clk,
          ByteOp => ByteOp,
          Mem_WrEn => Mem_WrEn,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_Data_In => MEM_Data_In,
          MEM_DataOut => MEM_DataOut,
          MM_Addr => MM_Addr,
          MM_WrEn => MM_WrEn,
          MM_WrData => MM_WrData,
          MM_RdData => MM_RdData
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
		
		ByteOp<='0';
		ALU_MEM_Addr <="00000000000000000000000000000110";
		MEM_Data_In <= "11111111110000000000000111111111";
		MM_RdData<= "11111111100000000000000000001111";

		Mem_WrEn <='1';
		wait for 100 ns;
		
		ByteOp<='1';
		ALU_MEM_Addr <="00000000000000000000000000000110";
		MEM_Data_In <= "11111111110000000001000001111111";
		MM_RdData<= "11111111100000000000000000001111";

		Mem_WrEn <='1';
		wait for 100 ns;
		
		ALU_MEM_Addr <="00000000000000000000000000000110";
		MEM_Data_In <= "00000000000000000000001000011111";
		Mem_WrEn <='1';
		MM_RdData<= "11111111100000001000000000001111";
		wait for 100 ns;
		
		ALU_MEM_Addr <="00000000000000001000000000000110";
		MEM_Data_In <= "00000000000000010000001000011111";
		Mem_WrEn <='1';
		MM_RdData<= "11111111100000001000000000001111";
		

      wait for Clk_period*10;


      wait;
   end process;

END;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY DECSTAGE_TEST IS
END DECSTAGE_TEST;
 
ARCHITECTURE behavior OF DECSTAGE_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         ALU_Out : IN  std_logic_vector(31 downto 0);
         MEM_Out : IN  std_logic_vector(31 downto 0);
         RF_WrData_Sel : IN  std_logic;
         RF_B_Sel : IN  std_logic;
         ImmExt : IN  std_logic_vector(1 downto 0);
         Clk : IN  std_logic;
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal ALU_Out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_Out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_Sel : std_logic := '0';
   signal RF_B_Sel : std_logic := '0';
   signal ImmExt : std_logic_vector(1 downto 0) := (others => '0');
   signal Clk : std_logic := '0';

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          ALU_Out => ALU_Out,
          MEM_Out => MEM_Out,
          RF_WrData_Sel => RF_WrData_Sel,
          RF_B_Sel => RF_B_Sel,
          ImmExt => ImmExt,
          Clk => Clk,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B
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
    -- wait for Clk_period*5;	
	 
		wait for 100 ns;
         Instr   <="00000000000000000000000000000000";       
         ALU_out <="00000000000000000000000000000000";
         MEM_out <="00000000000000000000000000000000";
         RF_WrData_sel <='0';
         RF_B_sel <='0';
			ImmExt <= "00";
    --  wait for Clk_period*2;
		wait for 100 ns;
		
         Instr   <="00000000110001100000000000000000";        
         ALU_out <="00000000000000100000010000000000";		    
         MEM_out <="00000100000000000000000000000001";
         RF_WrData_sel <='1';
         RF_B_sel <='0';
			ImmExt <= "01";
			
		wait for 100 ns;
    --  wait for Clk_period*2;	
         Instr   <="00000000110001100000000000000000";        
         RF_WrEn <='1';
         ALU_out <="00000000010000000001000000000111";
         MEM_out <="00000100001000100010000000000001";
         RF_WrData_sel <='0';
         RF_B_sel <='0';
			ImmExt <= "10";
wait for 100 ns;
		--wait for Clk_period*2;	
         Instr   <="00000000110001100011000000110000";     
         RF_WrEn <='1';
         ALU_out <="00000000010001000010000000001000";
         MEM_out <="00000000010000000010000100000001";
         RF_WrData_sel <='0';
         RF_B_sel <='0';
			ImmExt <= "11";
			
      wait;
   end process;

END;

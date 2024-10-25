LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY EXSTAGE_TEST IS
END EXSTAGE_TEST;
 
ARCHITECTURE behavior OF EXSTAGE_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EXSTAGE
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_Sel : IN  std_logic;
         ALU_Func : IN  std_logic_vector(3 downto 0);
         ALU_Out : OUT  std_logic_vector(31 downto 0);
         ALU_Zero : OUT  std_logic
			);
    END COMPONENT;
    

   --Inputs
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_Sel : std_logic := '0';
   signal ALU_Func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_Out : std_logic_vector(31 downto 0);
   signal ALU_Zero : std_logic;
	
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 --  constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EXSTAGE PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_Sel => ALU_Bin_Sel,
          ALU_Func => ALU_Func,
          ALU_Out => ALU_Out,
          ALU_Zero => ALU_Zero
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		
			RF_A <="00000000000000000000000000001000";
         RF_B <="00000000000000000000000000000100";
         Immed <="00000000000000000000000000000011";
         ALU_Bin_Sel <='0';
         ALU_Func <="0100";
      wait for 100 ns;	
		
			RF_A <="00000000000000000000000000001000";
         RF_B <="00000000000000000000000000000100";
         Immed <="00000000000000000000000000000011";
         ALU_Bin_Sel <='1';
         ALU_Func <="0001";
      wait for 100 ns;
		
			RF_A <="00000000000000000000000001001000";
         RF_B <="00000000000000000000000010000100";
         Immed <="00000000000000000000100000000011";
         ALU_Bin_Sel <='0';
         ALU_Func <="0010";	 
		wait for 100 ns;
			
			RF_A <="00000000000000000000000001001000";
         RF_B <="00000000000000000000000010000100";
         Immed <="00000000000000000000100000000011";
         ALU_Bin_Sel <='1';
         ALU_Func <="0101";	 
		wait for 100 ns;
		
			RF_A <="00000000000000000000000001001000";
         RF_B <="00000000000000000000000010000100";
         Immed <="00000000000000000000100000000011";
         ALU_Bin_Sel <='1';
         ALU_Func <="0100";	 
		wait for 100 ns;
		


      wait;
   end process;

END;

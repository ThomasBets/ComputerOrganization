LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY PROC_SC_TEST IS
END PROC_SC_TEST;
 
ARCHITECTURE behavior OF PROC_SC_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PROC_SC
    PORT(
         Reset : IN  std_logic;
         Clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PROC_SC PORT MAP (
          Reset => Reset,
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
		
		Reset <= '0';
       
   end process;

END;

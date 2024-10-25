LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY DECODER_TEST IS
END DECODER_TEST;
 
ARCHITECTURE behavior OF DECODER_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECODER_5_32
    PORT(
         Awr : IN  std_logic_vector(4 downto 0);
         Decoder_Out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal Decoder_Out : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECODER_5_32 PORT MAP (
          Awr => Awr,
          Decoder_Out => Decoder_Out
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
      
		Awr <= "00010";
      wait for 100 ns;	
		
		Awr <= "01110";
      wait for 100 ns;
		
		Awr <= "10010";
      wait for 100 ns;
		
		Awr <= "11010";
      wait for 100 ns;
		
		Awr <= "01000";
      wait for 100 ns;
     

      wait;
   end process;

END;

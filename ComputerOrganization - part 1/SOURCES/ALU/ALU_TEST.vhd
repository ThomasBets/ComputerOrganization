LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY ALU_TEST IS
END ALU_TEST;
 
ARCHITECTURE behavior OF ALU_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Carry_Out : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Carry_Out : std_logic;
   signal Ovf : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Output => Output,
          Zero => Zero,
          Carry_Out => Carry_Out,
          Ovf => Ovf
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
	
      A <= "00000000000000000000000000000011";
		B <= "00000000000000000000110001000100";
		Op <= "0000";
      wait for 100 ns;	
		
		A <= "00000000000000000000000000000011";
		B <= "00000000000000000000110001000100";
		Op <= "0001";
      wait for 100 ns;	
		
		A <= "00000000000000000000000000000011";
		B <= "00000000000000000000110001000100";
		Op <= "0011";
      wait for 100 ns;	
		
		A <= "00000000000000000000000000000011";
		B <= "00000000000000000000110001000100";
		Op <= "1000";
      wait for 100 ns;	
		
		A <= "11000000000000000000000000000011";
		B <= "00000000000000000000110001000100";
		Op <= "1100";
      wait for 100 ns;	
		
		A <= "11000000000000000000000000000011";
		B <= "11000000000000000000110001000100";
		Op <= "1000";
      wait for 100 ns;	
		
		A <= "00000000000000000000000000000011";
		B <= "00000000000000000000110001000100";
		Op <= "0000";
      wait for 100 ns;	
		
		A <= "00000000000000000000000000000000";
		B <= "00000000000000000000000000000000";
		Op <= "0000";
      wait for 100 ns;	
		
		A <= "11000000000000000000000000000011";
		B <= "11000000000000000000110001000100";
		Op <= "0000";
      wait for 100 ns;	
		
		A <= "01111111111111111111111111111111";
		B <= "00000000000000000000000000010110";
		Op <= "0000";
      wait for 100 ns;

      wait;
   end process;

END;

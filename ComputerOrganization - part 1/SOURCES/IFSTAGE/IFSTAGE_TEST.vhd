LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY IFSTAGE_TEST IS
END IFSTAGE_TEST;
 
ARCHITECTURE behavior OF IFSTAGE_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IFSTAGE
    PORT(
         PC_Immed : IN  std_logic_vector(15 downto 0);
         PC_Sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         PC_Output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_Immed : std_logic_vector(15 downto 0) := (others => '0');
   signal PC_Sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal PC_Output : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IFSTAGE PORT MAP (
          PC_Immed => PC_Immed,
          PC_Sel => PC_Sel,
          PC_LdEn => PC_LdEn,
          Reset => Reset,
          Clk => Clk,
          PC_Output => PC_Output
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
       wait for 100 ns;	
     
			PC_Immed <= "0000000000001000";
         PC_sel <='0';
         PC_LdEn <= '1' ;
         Reset <= '1';
        
      wait for Clk_period;	

			PC_Immed <= "0000000000000010";
         PC_sel <='0';
         PC_LdEn <= '1' ;
         Reset <= '0';
        
      wait for Clk_period;	
		   PC_Immed <= "0000000000001001";
         PC_sel <='1';
         PC_LdEn <= '1' ;
         Reset <= '0';
        
      wait for Clk_period;	
			PC_Immed <= "0000000100010000";
         PC_sel <='0';
         PC_LdEn <= '1' ;
         Reset <= '0';
        
      wait for Clk_period;	
			PC_Immed <= "0000000000001000";
         PC_sel <='0';
         PC_LdEn <= '0' ;
         Reset <= '0';
      wait;
   end process;

END;

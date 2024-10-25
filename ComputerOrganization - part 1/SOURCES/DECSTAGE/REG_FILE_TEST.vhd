LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY REG_FILE_TEST IS
END REG_FILE_TEST;
 
ARCHITECTURE behavior OF REG_FILE_TEST IS 
 
 
    COMPONENT REGISTER_FILE
    PORT(
         Adr1 : IN  std_logic_vector(4 downto 0);
         Adr2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Data_Out1 : OUT  std_logic_vector(31 downto 0);
         Data_Out2 : OUT  std_logic_vector(31 downto 0);
         Data_In : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         Clk : IN  std_logic;
         Rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Adr1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Adr2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Data_In : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';

 	--Outputs
   signal Data_Out1 : std_logic_vector(31 downto 0);
   signal Data_Out2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: REGISTER_FILE PORT MAP (
          Adr1 => Adr1,
          Adr2 => Adr2,
          Awr => Awr,
          Data_Out1 => Data_Out1,
          Data_Out2 => Data_Out2,
          Data_In => Data_In,
          WrEn => WrEn,
          Clk => Clk,
          Rst => Rst
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
	
      Adr1 <= "00000";
      Adr2 <= "11100";
      Awr <= "00000";
      Data_In <= "00000000000000000001111110000111";
      WrEn <= '1';
      Rst <= '1';
      wait for 100 ns;	
		
		Adr1 <= "00000";
      Adr2 <= "11100";
      Awr <= "00000";
      Data_In <= "00000000000000000001111110000111";
      WrEn <= '1';
      Rst <= '0';
      wait for 100 ns;
		
		Adr1 <= "01110";
      Adr2 <= "10000";
      Awr <= "01001";
      Data_In <= "00000000000000000001111110000111";
      WrEn <= '0';
      Rst <= '0';
      wait for 100 ns;	
		
		Adr1 <= "00001";
      Adr2 <= "00001";
      Awr <= "00001";
      Data_In <= "00000000000000000001111110100111";
      WrEn <= '1';
      Rst <= '0';
      wait for 100 ns;	
		
			
		Adr1 <= "00010";
      Adr2 <= "11100";
      Awr <= "11111";
      Data_In <= "00000000000000000001111110000111";
      WrEn <= '1';
      Rst <= '0';
      wait for 100 ns;	
		
			
		Adr1 <= "00010";
      Adr2 <= "11100";
      Awr <= "11111";
      Data_In <= "00000000000000000001111110000111";
      WrEn <= '1';
      Rst <= '0';
      wait for 100 ns;	
		
			
	   Adr1 <= "01110";
      Adr2 <= "11100";
      Awr <= "11100";
      Data_In <= "00000000000000000001111110000111";
      WrEn <= '1';
      Rst <= '0';
      wait for 100 ns;	
		
			
		Adr1 <= "00010";
      Adr2 <= "11100";
      Awr <= "11000";
      Data_In <= "00000000000000000001111110000111";
      WrEn <= '1';
      Rst <= '0';
      wait for 100 ns;	
		
			
		Adr1 <= "00010";
      Adr2 <= "11100";
      Awr <= "00111";
      Data_In <= "00000000000000000001111110000111";
      WrEn <= '1';
      Rst <= '0';
      wait for 100 ns;	
		
				
		Adr1 <= "00010";
      Adr2 <= "11100";
      Awr <= "00000";
      Data_In <= "00000000000000000001111110000111";
      WrEn <= '1';
      Rst <= '0';
      wait for 100 ns;	
     
	  -- wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;

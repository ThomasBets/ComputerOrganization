LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_signed.all;
use IEEE.numeric_std.all;
 
ENTITY RAM_TEST IS
END RAM_TEST;
 
ARCHITECTURE behavior OF RAM_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RAM
    PORT(
         Clk : IN  std_logic;
         Inst_Addr : IN  std_logic_vector(10 downto 0);
         Inst_Data_Out : OUT  std_logic_vector(31 downto 0);
         Data_WrEn : IN  std_logic;
         Data_Addr : IN  std_logic_vector(10 downto 0);
         Data_In : IN  std_logic_vector(31 downto 0);
         Data_Out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Inst_Addr : std_logic_vector(10 downto 0) := (others => '0');
   signal Data_WrEn : std_logic := '0';
   signal Data_Addr : std_logic_vector(10 downto 0) := (others => '0');
   signal Data_In : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Inst_Data_Out : std_logic_vector(31 downto 0);
   signal Data_Out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RAM PORT MAP (
          Clk => Clk,
          Inst_Addr => Inst_Addr,
          Inst_Data_Out => Inst_Data_Out,
          Data_WrEn => Data_WrEn,
          Data_Addr => Data_Addr,
          Data_In => Data_In,
          Data_Out => Data_Out
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
	
			Inst_Addr <= "00000000000";
			Data_In <= "00000000010000000001000000000100";
			Data_Addr <= "00000000000";
			
			for i in 0 to 2 loop
			
         Data_WrEn <= '1';
			
         Data_Addr <= (Data_Addr + 4);  
         Data_In <= Data_In + 3;
			
			Inst_Addr <= Inst_Addr + 4;
		
			wait for 100 ns;	
			end loop;
			
			Inst_Addr <= "00000000000";
			Data_In <= "00000000010000000001000000000100";
			Data_Addr <= "10000000000";
			
			for j in 0 to 2 loop
			
         Data_WrEn <= '1';
			
         Data_Addr <= (Data_Addr + 4);  
         Data_In <= Data_In + 3;
			
			Inst_Addr <= Inst_Addr + 4;
		
			wait for 100 ns;	
			end loop;



      wait;
   end process;

END;

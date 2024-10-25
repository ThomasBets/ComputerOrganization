LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY CONTROL_TEST IS
END CONTROL_TEST;
 
ARCHITECTURE behavior OF CONTROL_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONTROL
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         ALU_Zero : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         RF_WrEn : OUT  std_logic;
         RF_WrData_Sel : OUT  std_logic;
         RF_B_Sel : OUT  std_logic;
         ImmExt : OUT  std_logic_vector(1 downto 0);
         ALU_Bin_Sel : OUT  std_logic;
         ALU_Func : OUT  std_logic_vector(3 downto 0);
         PC_Sel : OUT  std_logic;
         PC_LdEn : OUT  std_logic;
         ByteOp : OUT  std_logic;
         Mem_WrEn : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Zero : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal RF_WrEn : std_logic;
   signal RF_WrData_Sel : std_logic;
   signal RF_B_Sel : std_logic;
   signal ImmExt : std_logic_vector(1 downto 0);
   signal ALU_Bin_Sel : std_logic;
   signal ALU_Func : std_logic_vector(3 downto 0);
   signal PC_Sel : std_logic;
   signal PC_LdEn : std_logic;
   signal ByteOp : std_logic;
   signal Mem_WrEn : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONTROL PORT MAP (
          Instr => Instr,
          ALU_Zero => ALU_Zero,
          Reset => Reset,
          Clk => Clk,
          RF_WrEn => RF_WrEn,
          RF_WrData_Sel => RF_WrData_Sel,
          RF_B_Sel => RF_B_Sel,
          ImmExt => ImmExt,
          ALU_Bin_Sel => ALU_Bin_Sel,
          ALU_Func => ALU_Func,
          PC_Sel => PC_Sel,
          PC_LdEn => PC_LdEn,
          ByteOp => ByteOp,
          Mem_WrEn => Mem_WrEn
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
      wait for 10 ns;	
		         
		Instr <= "10000000000000000000000000110000";
      ALU_Zero <= '0';
		Reset <= '0';		
		wait for 10 ns;	
	
		Instr <= "10000000000000000000000000110001";
      ALU_Zero <= '0'; 
		wait for 10 ns;

		Instr <= "10000000000000000000000000110010";
      ALU_Zero <= '0'; 
		wait for 10 ns;			
		
		Instr <= "10000000000000000000000000110011";
      ALU_Zero <= '0'; 
		wait for 10 ns;

		Instr <= "10000000000000000000000000110100";
      ALU_Zero <= '0'; 
		wait for 10 ns;

		Instr <= "10000000000000000000000000110101";
      ALU_Zero <= '0'; 
		wait for 10 ns;

		Instr <= "10000000000000000000000000110110";
      ALU_Zero <= '0'; 
		wait for 10 ns;	

		Instr <= "10000000000000000000000000110000";
      ALU_Zero <= '0'; 
		wait for 10 ns;

		Instr <= "10000000000000000000000000111000";
      ALU_Zero <= '0'; 
		wait for 10 ns;

		Instr <= "10000000000000000000000000111001";
      ALU_Zero <= '0'; 
		wait for 10 ns;	

		Instr <= "10000000000000000000000000111010";
      ALU_Zero <= '0'; 
		wait for 10 ns;

		Instr <= "10000000000000000000000000111100";
      ALU_Zero <= '0'; 
		wait for 10 ns;

		Instr <= "10000000000000000000000000111101";
      ALU_Zero <= '0'; 
		wait for 10 ns;
	
		Instr <= "11100000000000000000000000000000";
      ALU_Zero <= '0'; 
		wait for 10 ns;
		
		Instr <= "11100100000000000000000000000000";
      ALU_Zero <= '0'; 
		wait for 10 ns;

		Instr <= "11000000000000000000000000000000";
      ALU_Zero <= '0'; 
		wait for 10 ns;

		Instr <= "11001000000000000000000000000000";
      ALU_Zero <= '0'; 
		wait for 10 ns;
		
		Instr <= "11001100000000000000000000000000";
      ALU_Zero <= '0'; 
		wait for 10 ns;
		
		Instr <= "11111100000000000000000000000000";
      ALU_Zero <= '0'; 
		wait for 10 ns;
		
		Instr <= "00000000000000000000000000000000";
      ALU_Zero <= '1'; 
		wait for 10 ns;
		
		Instr <= "00000000000000000000000000000000";
      ALU_Zero <= '0'; 
		wait for 10 ns;
		
		Instr <= "00000100000000000000000000000000";
      ALU_Zero <= '0'; 
		wait for 10 ns;
		
		Instr <= "00000100000000000000000000000000";
      ALU_Zero <= '1'; 
		wait for 10 ns;
		
		Instr <= "00001100000000000000000000000000";
      ALU_Zero <= '0'; 
		wait for 10 ns;
		
		Instr <= "00011100000000000000000000000000";
      ALU_Zero <= '0'; 
		wait for 10 ns;
		
		Instr <= "00111100000000000000000000000000";
      ALU_Zero <= '0'; 
		wait for 10 ns;
		
		Instr <= "01111100000000000000000000000000";
      ALU_Zero <= '0'; 
		wait for 10 ns;
	
      -- insert stimulus here 

      wait;
   end process;

END;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CONTROL is
		Port (Instr : in  STD_LOGIC_VECTOR (31 downto 0);
				ALU_Zero  : in  STD_LOGIC;
				Reset : in  STD_LOGIC;
				Clk : in  STD_LOGIC;				
            RF_WrEn : out  STD_LOGIC;
				RF_WrData_Sel : out  STD_LOGIC;
            RF_B_Sel : out  STD_LOGIC;
				ImmExt : out  STD_LOGIC_VECTOR (1 downto 0); 			-- From DECSTAGE
				ALU_Bin_Sel  : out  STD_LOGIC;
            ALU_Func : out  STD_LOGIC_VECTOR (3 downto 0);				-- From EXSTAGE
				PC_Sel  : out  STD_LOGIC;
            PC_LdEn : out  STD_LOGIC;           		-- From IFSTAGE
				ByteOp  : out  STD_LOGIC;
				Mem_WrEn : out  STD_LOGIC);
end CONTROL;

architecture Behavioral of CONTROL is

type State_type is (Reset_State, Rtype_State, Illegal_State, Start_State, Nothing_State, LI_State, LUI_State, ADDI_State, 
NANDI_State, ORI_State, BRANCH_State, BEQ_State, BNE_State, BRANCH_Sel_State, LB_State, LW_State, SB_State, SW_State);

signal State : State_type;

begin
process(Clk,Reset)
	begin
		
		if Reset = '1' then 
			State <= Reset_State;
		elsif rising_edge(Clk)then  
			case State is
				when Reset_State =>
					State <= Start_State;
				when Start_State =>
					if Instr(31 downto 26) = "100000"    then State <= Rtype_State; 
					elsif Instr(31 downto 26) = "111000" then State <= LI_State;
					elsif Instr(31 downto 26) = "111001" then State <= LUI_State;
					elsif Instr(31 downto 26) = "110000" then State <= ADDI_State;
					elsif Instr(31 downto 26) = "110010" then State <= NANDI_State;
					elsif Instr(31 downto 26) = "110011" then State <= ORI_State;
					elsif Instr(31 downto 26) = "111111" then State <= BRANCH_State;
					elsif Instr(31 downto 26) = "000000" then State <= BEQ_State;
					elsif Instr(31 downto 26) = "000001" then State <= BNE_State;
					elsif Instr(31 downto 26) = "000011" then State <= LB_State;
					elsif Instr(31 downto 26) = "000111" then State <= SB_State;
					elsif Instr(31 downto 26) = "001111" then State <= LW_State;
					elsif Instr(31 downto 26) = "011111" then State <= SW_State;
					else State <= Illegal_State;
					end if;
				when Rtype_State =>
					State <= Start_State;
				when LI_State =>
					State <= Start_State;						
				when LUI_State =>
					State <= Start_State;					
				when ADDI_State =>
					State <= Start_State;												
				when NANDI_State =>
					State <= Start_State;				
				when ORI_State =>
					State <= Start_State;						
				when BRANCH_State => 
					State <= Start_State;																		
				when BEQ_State => 
					if ALU_Zero = '1' then 
						State <= BRANCH_Sel_State;
					else
						State <= Nothing_State;
					end if;												
				when BNE_State =>
					if ALU_Zero = '1' then
						State <= Nothing_State;
					else
						State <= BRANCH_Sel_State;
					end if;						
				when Nothing_State =>
					State <= Start_State;
				when BRANCH_Sel_State =>
					State <= Start_State;				
				when LB_State =>
					State <= Start_State;
				when LW_State =>
					State <= Start_State;						
				when SB_State =>
					State <= Start_State;
				when SW_State =>
					State <= Start_State;
				when Illegal_State =>
					State <= Start_State;
			end case;
		end if;				
	end process;		

---------------------------------------------------------------------------
--									CONTROL SIGNALS					
---------------------------------------------------------------------------

RF_WrEn 		<= '1' when State = Rtype_State else
				   '1' when State = ADDI_State  else
				   '1' when State = ORI_State else
				   '1' when State = NANDI_State else
				   '1' when State = LUI_State else
				   '1' when State = LI_State else
				   '1' when State = LW_State else
				   '1' when State = LB_State else
				   '0';
					
RF_WrData_Sel <= '1' when State = LW_State else 
					  '1' when State = LB_State else
					  '0' when State = Rtype_State else
				     '0';

RF_B_Sel 	<= '1' when State = SB_State else
					'1' when State = SW_State else
					'1' when State = BEQ_State else
					'1' when State = BNE_State else
					'0';

ImmExt		<=	"00" when State = LI_State else
					"00" when State = ADDI_State else
					"00" when State = SW_State else 
					"00" when State = LW_State else 
					"00" when State = SB_State else
					"00" when State = LB_State else
					"01" when State = NANDI_State else
					"01" when State = ORI_State else
					"10" when State = LUI_State else
					"11";

ALU_Bin_Sel <= '1' when State = ORI_State else 
					'1' when State = ADDI_State else
					'1' when State = NANDI_State else
					'1' when State = LB_State else
					'1' when State = LW_State else
				   '1' when State = SW_State else
					'1' when State = SB_State else
					'1' when State = LUI_State else
					'1' when State = LI_State else 
					'0';		

ALU_Func    <= Instr(3 downto 0) when  State = Rtype_State AND Instr(5 downto 4)= "11" else
					"0011" when  State = ORI_State else 
					"0000" when  State = ADDI_State else
					"0010" when  State = NANDI_State else
					"0000" when  State = LB_State else
					"0000" when  State = LW_State else
					"0000" when  State = SB_State else 
					"0000" when  State = SW_State else
					"0001" when  State = BEQ_State else
					"0001" when  State = BNE_State else
					"0000";
					
PC_Sel 	   <= '1' when State = BRANCH_State else 
				   '1' when State = BRANCH_Sel_State else
				   '0';					

PC_LdEn 	   <= '1' when State = Illegal_State else
				   '1' when State = Rtype_State else
				   '1' when State = ORI_State else
				   '1' when State = ADDI_State else
				   '1' when State = NANDI_State else
				   '1' when State = LI_State else
				   '1' when State = LUI_State else
				   '1' when State = BRANCH_State else
				   '1' when State = BRANCH_Sel_State else
				   '1' when State = Nothing_State else
				   '1' when State = LB_State else
				   '1' when State = LW_State else
				   '1' when State = SB_State else
				   '1' when State = SW_State else
				   '0' when State = Start_State else
				   '0';
				  
ByteOp		<= '0' when State = SW_State else 
					'0' when State = LW_State else 
					'1' when State = SB_State else
					'1' when State = LB_State else
					'0';
						  

Mem_WrEn 	<= '1' when State = SW_State else 
					'1' when State = SB_State else
					'0';
					
end Behavioral;


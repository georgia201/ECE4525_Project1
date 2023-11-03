----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/01/2023 02:14:04 PM
-- Design Name: 
-- Module Name: SDPM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SDPM is

    port(START, RESET, CLK, Q71, Q72: in std_logic;
         DONE, OVF, OP_LD, RES_LD, OE1, OE2, DS0: out std_logic;
         SRC2, SRC1: out std_logic_vector(1 downto 0);
         RES: out std_logic_vector(7 downto 0));
   
end SDPM;

architecture Behavioral of SDPM is

component serialadder
    port(A, B, CLK, RESET: in std_logic;
         sum, CY: out std_logic);   
end component;

    type state_type is (idle, S1, S2, S3, S4);
    signal present_state, next_state: state_type:= idle;
    signal A, B, sum, shift_out, Q7: std_logic;
    signal OP1, OP2: std_logic_vector(7 downto 0);

begin
    
    adder: SerialBitAdder port map(A => A, B => B, CLK => CLK, RESET => RESET, sum => sum, CY => OVF);

    SDPM_process: process(START, RESET, CLK, OP1, OP2)
    
        variable cntr: integer := 7;
        constant shift: integer := 0;
        
        begin
        case present_state is
            when idle =>
                DONE <= '1';
                next_state <= S1;
                
            when S1 =>                  -- parallel load mode
                if START = '1' then
                    DONE <= '0';
                    OP_LD <= '1';
                    SRC2 <= "11";
                    SRC1 <= "11"; 
                    OP1(7) <= Q71;      -- loads Q7 from reg 1 into bit 7 of OP1 when first loaded
                    OP2(7) <= Q72;      -- loads Q7 from reg 2 into bit 7 of OP2 when first loaded
                    next_state <= S2;
                else
                    next_state <= idle;
                end if;
                    
                
                next_state <= S2;
                
            when S2 =>                  -- right shift mode
                OP_LD <= '1';
                SRC2 <= "01";
                SRC1 <= "01";
                if cntr = shift then
                    cntr := 7;
                    SRC2 <= "00";       -- enters hold mode
                    SRC1 <= "00";
                    next_state <= S3;
                else 
                    cntr:= cntr - 1;
                    OP1(cntr) <= Q71;
                    OP2(cntr) <= Q72;
                    next_state <= S2;
                end if;        
                
            when S3 => 
                OP_LD <= '0';           -- OP_LD is deasserted, Operands are both done loading in the board
                serialadder: serialadder port map(A => OP1, B => OP2, 
            
            when others =>
            
        end case;
    end process;
            
    clk_process: process (CLK, RESET)
       begin
       if RESET = '1' then
           if rising_edge(CLK) then
                present_state <= next_state;
           else
               present_state <= present_state;
           end if;
       else
           present_state <= idle;
       end if;

    end process clk_process;
                
                

end Behavioral;

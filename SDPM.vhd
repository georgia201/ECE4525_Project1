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
         SRC2, SRC1: out std_logic_vector(1 downto 0));
   
end SDPM;

architecture Behavioral of SDPM is

    type state_type is (idle, S2, S4, S5);
    signal present_state, next_state: state_type:= idle;

component serialadder
  port(A, B: in std_logic_vector (7 downto 0); 
       reset, clk : in std_logic;
       Cin : in std_logic;
       OVF : out std_logic;
       RES : out std_logic_vector (7 downto 0));
end component;

    signal OP1, OP2, RES: std_logic_vector(7 downto 0);
    signal cntr1: integer := 7;
    signal cntr2: integer := 7;
    signal shift: integer := 0;

begin

    adder: serialadder port map(A => OP1, B => OP2, reset => RESET, clk => CLK, Cin => '0', OVF => OVF, RES => RES);

    SDPM_process: process(START, RESET, CLK, OP1, OP2, Q71, Q72)
        
      begin
        case present_state is
            when idle =>
                DONE <= '1';
                OP_LD <= '0';
                RES_LD <= '0';
                SRC2 <= "00";
                SRC1 <= "00";
                next_state <= S2;
            
            if START = '1' then
                --OP2 <= "00000000";
                --OP1 <= "00000000";
                DONE <= '0';
                OP_LD <= '1';
                RES_LD <= '0';
                SRC2 <= "11";
                SRC1 <= "11";
                OE1 <= '0';         -- enable buffers for parallel load
                OE2 <= '0'; 
                OP1(7) <= Q71;      -- loads Q7 from reg 1 into bit 7 of OP1 when first loaded
                OP2(7) <= Q72;      -- loads Q7 from reg 2 into bit 7 of OP2 when first loaded
                next_state <= S2;
            else
                next_state <= idle;
            end if;
                
            when S2 =>                  -- right shift mode
                OP_LD <= '1';
                SRC2 <= "01";
                SRC1 <= "01";
                OE1 <= '1';             -- disable buffers
                OE2 <= '1';
            if (cntr1 = shift) then
                SRC2 <= "00";       -- enters hold mode
                SRC1 <= "00";
                next_state <= S4;
            elsif (cntr1 > shift) then
                if (CLK'event and CLK = '1') then
                    cntr1 <= cntr1 - 1;
                    OP1(cntr1) <= Q71;
                    OP2(cntr1) <= Q72;
                    next_state <= S2;
                end if;
            else next_state <= S4;
            end if; 
            
            when S4 =>
                cntr1 <= 7;
                OP_LD <= '0';
                RES_LD <= '1';
                SRC1 <= "01";
                OE1 <= '1';            -- keep buffers disabled
                OE2 <= '1';
            if cntr2 = shift then
                cntr2 <= 7;
                next_state <= S5;
            elsif (cntr2 > shift) then
                if (CLK'event and CLK = '1') then
                    cntr2 <= cntr2 - 1;
                    DS0 <= RES(cntr2);
                    next_state <= S4;
                end if;
            else next_state <= S5;
            end if;

            when S5 => 
                cntr2 <= 7;
                SRC1 <= "00";
                RES_LD <= '0';
                DONE <= '1';
                OE1 <= '0';
                OE2 <= '0';
                next_state <= idle;
                
            when others => next_state <= idle;
            
        end case;
    end process SDPM_process;
            
    clk_process: process (CLK, RESET)
     begin
       if RESET = '1' then
           present_state <= idle;
       elsif (CLK'event and CLK = '1') then
            present_state <= next_state;
       else
           present_state <= present_state;
       end if;

    end process clk_process;
 
end Behavioral;
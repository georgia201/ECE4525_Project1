----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2023 08:42:38 AM
-- Design Name: 
-- Module Name: SerialBitAdder - Behavioral
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

entity SerialBitAdder is

 Port (A, B, CLOCK, RESET: in std_logic;
        sum, CY: out std_logic);
       
end SerialBitAdder;

architecture Behavioral of SerialBitAdder is

    type state_type is (state1, state2, state3, state4);
    signal present_state, next_state: state_type := state1;

begin
 
    state_process: process(present_state, A, B)
        begin
            case present_state is
                when state1 =>
                    sum <= '0';
                    CY <= '0';
                   
                if (A = '1' and B = '1') then
                    next_state <= state3;
                elsif ( A = '1' and B = '0') then
                    next_state <= state2;
                elsif (A = '0' and B = '1') then
                    next_state <= state2;
                else
                    next_state <= state1;
                end if;
                   
                   
                when state2 =>
                    sum <= '1';
                    CY <= '0';
                   
                if (A = '1' and B = '1') then
                    next_state <= state3;
                elsif (A = '1' and B = '0') then
                    next_state <= state2;
                elsif ( A = '0' and B = '1') then
                    next_state <= state2;
                else
                    next_state <= state1;
                end if;
                   
                   
                when state3 =>
                    sum <= '0';
                    CY <= '1';
                   
                if (A = '1' and B = '1') then
                    next_state <= state4;
                elsif (A = '1' and B = '0') then
                    next_state <= state3;
                elsif (A = '0' and B = '1') then
                    next_state <= state3;
                else
                    next_state <= state2;
                end if;
                   
                   
                when state4 =>
                    sum <= '1';
                    CY <= '1';
                   
                if (A = '1' and B = '1') then
                    next_state <= state4;
                elsif (A = '1' and B = '0') then
                    next_state <= state3;
                elsif (A = '0' and B = '1') then
                    next_state <= state3;
                else
                    next_state <= state2;
                end if;


                when others => next_state <= state1;
               
            end case;
               
    end process state_process;

    clk_process: process (CLOCK, RESET)
       begin
       if RESET = '1' then
           if rising_edge(CLOCK) then
                present_state <= next_state;
           else
               present_state <= present_state;
           end if;
       else
           present_state <= state1;
       end if;

    end process clk_process;

end Behavioral;
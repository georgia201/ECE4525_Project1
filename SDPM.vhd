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

    port(START, RESET, CLK: in std_logic;
         OP1, OP2: in std_logic_vector(7 downto 0);
         DONE, OVF, OP_LD, RES_LD, BUFEN1, BUFEN2: out std_logic;
         SRC2, SRC1: out std_logic_vector(1 downto 0);
         RES: out std_logic_vector(7 downto 0));
   
end SDPM;

architecture Behavioral of SDPM is

component SerialBitAdder
    port(A, B, CLK, RESET: in std_logic;
         sum, CY: out std_logic);   
end component;

component CD74HC299
    port(CLK, MR: in std_logic;
         S: in std_logic_vector(1 downto 0);
         So: out std_logic_vector(1 downto 0);
         DS0, MRo: out std_logic);
end component;

    type state_type is (idle, S1, S2, S3, S4);
    signal present_state, next_state: state_type:= idle;
    signal A, B, sum, shift_out, Q7: std_logic;

begin

    adder: SerialBitAdder port map(A => A, B => B, CLK => CLK, RESET => RESET, sum => sum, CY => OVF);
    shift_reg: CD74HC299 port map(CLK => CLK, MR => RESET, S => S, So => SRC2, DS0 => shift_out, MRo => 

    SDPM_process: process(START, RESET, CLK, OP1, OP2, SRC2, SRC1)
      begin
        case present_state is
            when idle =>
                DONE <= '1';
                next_state <= S1;
                
            when S1 =>
                if START = '1' then
                    DONE <= '0';
                    OP_LD <= '1';
                end if;
                
                next_state <= S2;
                
            when S2 =>                  -- parallel load mode
                OP_LD <= '1';
                SRC2 <= "11";
                SRC1 <= "11";
                next_state <= S3;
                
            when S3 =>                  -- right shift mode
                OP_LD <= '0';
                SRC2 <= "01";
                SRC1 <= "01";
                
                temp0 <= 
                
                next_state <= S4;
                
            when S4 => 
                
                

end Behavioral;
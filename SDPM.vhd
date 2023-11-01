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
         SRC2_1, SRC2_0, SRC1_1, SRC1_0: out std_logic;
         RES: out std_logic_vector(7 downto 0));
   
end SDPM;

architecture Behavioral of SDPM is

component SerialBitAdder
    port(A, B, CLK, RESET: in std_logic;
         sum, CY: out std_logic);   
end component;

component CD74HC299
    port(A, B, CLK, RESET, MR: in std_logic;
         S: in std_logic_vector(1 downto 0);
         So: out std_logic_vector(1 downto 0);
         DS0, MRo: out std_logic);  
end component;

    type state_type is (idle, S1, S2, S3, S4);
    signal present_state, next_state: state_type:= idle;

begin

    adder: SerialBitAdder port map(A => A, B => B, CLK => CLK, RESET => RESET, sum => DS0, CY => open);

    SDPM_process: process(START, RESET, CLK, OP1, OP2, SRC2_1, SRC2_0, SRC1_1, SRC1_0)
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
                
            when S2 => 
                OP_LD <= '1';
                SRC2_1 <= '1';
                SRC2_0 <= '1';
                SRC1_1 <= '1';
                SRC1_0 <= '1';
                next_state <= S3;
                
            when S3 =>
                OP_LD <= '0';
                SRC2_1 <= '0';
                SRC2_0 <= '1';
                SRC1_1 <= '0';
                SRC1_0 <= '1';
                

end Behavioral;
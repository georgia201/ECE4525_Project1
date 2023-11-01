----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2023 09:10:53 AM
-- Design Name: 
-- Module Name: CD74HC299 - Behavioral
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

entity CD74HC299 is

    Port(CLK, MR: in std_logic;
         S: in std_logic_vector(1 downto 0);
         So: out std_logic_vector(1 downto 0);
         DS0, MRo: out std_logic);
         
end CD74HC299;

architecture Behavioral of CD74HC299 is

begin
                
    shift_process: process(MR, S)
        begin
            if MR = '1' then
                MRo <= '0';
            else
                MRo <= '1';
            end if;
            if (S = "11" or S = "00" or S <= "10") then
                So <= S;
            else
                So <= "00";
            end if;
    end process shift_process;              

end Behavioral;

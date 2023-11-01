----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/01/2023 05:20:32 PM
-- Design Name: 
-- Module Name: serialadder - Behavioral
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
use IEEE.std_logic_1164.all;

entity serialadder is
  port(A, B: in std_logic_vector (7 downto 0);
        clk, zero, reset: in std_logic;
       Cin : out std_logic;    --inputs
       Cout : out std_logic;
       Sum : out std_logic_vector (7 downto 0));   --outputs
end serialadder;

architecture behavioral of serialadder is
    signal temp_c : std_logic;
    signal temp_c2 : std_logic;
begin 
  process(A,B)
  begin    
      temp_c <= '0';
           
      for i in 0 to 7 loop
          Sum(i)  <= A(i) xor B(i) xor temp_c;
          temp_c2 <= temp_c;          
          temp_c <= (A(i) and B(i)) or (A(i) and temp_c2) or (B(i) and temp_c2);
      end loop;
  end process;
  
  

end behavioral;

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
       reset, clk : in std_logic;    --inputs
       Cin : in std_logic;
       OVF : out std_logic;
       RES : out std_logic_vector (7 downto 0));   --outputs
end serialadder;

architecture behavioral of serialadder is
    signal temp_c, temp_c2, temp_c3, zero : std_logic;
    signal temp_c_reset_done : boolean := false;
    signal B2C, Sum, one, B1C, c, c2 : std_logic_vector(7 downto 0);
    signal Cout : std_logic := '0';
begin	
  process(clk, temp_c_reset_done, Cin, A, B)
  begin
    one <= "00000001";
    B1C <= not B;
    zero <= '0';
    B2C(0) <= B1C(0) xor one(0) xor zero;         
    c2(0) <= (B1C(0) and one(0)) or (zero and (B1C(0) xor one(0)));
    B2C(1) <= B1C(1) xor one(1) xor c2(0);         
    c2(1) <= (B1C(1) and one(1)) or (c2(0) and (B1C(1) xor one(1)));
    B2C(2) <= B1C(2) xor one(2) xor c2(1);         
    c2(2) <= (B1C(2) and one(2)) or (c2(1) and (B1C(2) xor one(2)));
    B2C(3) <= B1C(3) xor one(3) xor c2(2);         
    c2(3) <= (B1C(3) and one(3)) or (c2(2) and (B1C(3) xor one(3)));
    B2C(4) <= B1C(4) xor one(4) xor c2(3);         
    c2(4) <= (B1C(4) and one(4)) or (c2(3) and (B1C(4) xor one(4)));
    B2C(5) <= B1C(5) xor one(5) xor c2(4);         
    c2(5) <= (B1C(5) and one(5)) or (c2(4) and (B1C(5) xor one(5)));
    B2C(6) <= B1C(6) xor one(6) xor c2(5);         
    c2(6) <= (B1C(6) and one(6)) or (c2(5) and (B1C(6) xor one(6)));
    B2C(7) <= B1C(7) xor one(7) xor c2(6);         
    c2(7) <= (B1C(7) and one(7)) or (c2(6) and (B1C(7) xor one(7)));
      --elsif rising_edge(clk) then
     Sum(0) <= A(0) xor B2C(0) xor Cin;         
     c(0) <= (A(0) and B2C(0)) or (Cin and (A(0) xor B2C(0)));
     Sum(1) <= A(1) xor B2C(1) xor c(0);         
     c(1) <= (A(1) and B2C(1)) or (c(0) and (A(1) xor B2C(1)));
     Sum(2) <= A(2) xor B2C(2) xor c(1);         
     c(2) <= (A(2) and B2C(2)) or (c(1) and (A(2) xor B2C(2)));
     Sum(3) <= A(3) xor B2C(3) xor c(2);         
     c(3) <= (A(3) and B2C(3)) or (c(2) and (A(3) xor B2C(3)));
     Sum(4) <= A(4) xor B2C(4) xor c(3);         
     c(4) <= (A(4) and B2C(4)) or (c(3) and (A(4) xor B2C(4)));
     Sum(5) <= A(5) xor B2C(5) xor c(4);         
     c(5) <= (A(5) and B2C(5)) or (c(4) and (A(5) xor B2C(5)));
     Sum(6) <= A(6) xor B2C(6) xor c(5);         
     c(6) <= (A(6) and B2C(6)) or (c(5) and (A(6) xor B2C(6)));
     Sum(7) <= A(7) xor B2C(7) xor c(6);         
     c(7) <= (A(7) and B2C(7)) or (c(6) and (A(7) xor B2C(7)));
  end process;
  
  process(Sum)
    begin
        RES <= (others => '0');  -- Initialize result to zero
        RES(7 downto 0) <= Sum(5 downto 0) & "00"; -- Left shift by two positions
        if Sum(6) = '1' then
            OVF <= '1';
        else
            if Sum(7) = '1' then
                OVF <= '1';
            else
                OVF <= '0';
            end if;
        end if;
  end process;
  
end behavioral;

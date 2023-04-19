----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.02.2023 14:54:21
-- Design Name: 
-- Module Name: deco2ent - Behavioral
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

entity deco2ent is
  Port( e: in std_logic_vector(1 downto 0);
           z: out std_logic_vector(3 downto 0);
           en: in std_logic);
end deco2ent;

architecture dos of deco2ent is
---- concurrentes con enable
begin
z <= "0001" when (e="00" and en='1') else
"0010" when (e="01" and en='1') else
"0100" when (e="10" and en='1') else
"1000" when (e="11" and en='1') else
"0000" when en='0' else
"1111";
end dos;

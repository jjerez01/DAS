----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.03.2023 13:32:11
-- Design Name: 
-- Module Name: p6 - Behavioral
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

entity p6 is
  Port (
       PS2CLK: in std_logic;
       PS2DATA: in std_logic;
       rst: in std_logic;
       leds: out std_logic_vector (7 downto 0);
       special: out std_logic
   );
end p6;

architecture Behavioral of p6 is

signal tr: std_logic;
signal save: std_logic_vector(21 downto 0);

begin

reg: process(PS2CLK,rst,PS2DATA)
begin
    if (rst = '1') then
        save <= (others => '0');
    elsif(PS2CLK'event and PS2CLK = '0') then
        save <= PS2DATA & save(21 downto 1);
    end if;  
end process;

special <= '1' when save(8 downto 1) = "11110000" else
            '0';

leds <= save(19 downto 12);


end Behavioral;

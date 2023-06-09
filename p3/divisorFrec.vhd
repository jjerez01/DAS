----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2023 13:35:49
-- Design Name: 
-- Module Name: divisorFrec - Behavioral
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
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divisorFrec is
  Port (
    rst, clk: in std_logic;
    clkOUT: out std_logic
   );
end divisorFrec;

architecture Behavioral of divisorFrec is
    -- valorMax <= x"60000000"
    signal cuenta: std_logic_vector(25 downto 0);
    signal enciende: std_logic;
begin

    divisor: process (rst,clk) begin
        if(rst = '1') then
            cuenta <= (others => '0');
        elsif (rising_edge(clk)) then
            if(cuenta = "10111110101111000010000000") then
                enciende <= '1';
                cuenta <= (others => '0');
            else
                enciende <= '0';
                cuenta <= cuenta + 1;
            end if;
        end if;
     end process;
            
     clkOUT <= enciende;

end Behavioral;

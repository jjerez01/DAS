----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.02.2023 16:38:05
-- Design Name: 
-- Module Name: contadorMod8 - Behavioral
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

entity contadorMod8 is
  Port (
    clk : in std_logic;
    en: in std_logic;
    rst : in std_logic;
    salida: out std_logic_vector(2 downto 0));
    
end contadorMod8;

architecture Behavioral of contadorMod8 is

signal out_aux: std_logic_vector(2 downto 0);

begin

    cont: process(rst, clk)
        begin
            if(rst = '1') then
                out_aux <= "000";
            elsif(rising_edge(clk)) then
                if(en = '1') then
                    out_aux <= out_aux + 1;
                end if;
            end if;
   end process;
   
   salida <= out_aux;

end Behavioral;

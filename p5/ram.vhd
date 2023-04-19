----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.02.2023 14:26:30
-- Design Name: 
-- Module Name: ram - Behavioral
-- Project Name: Practica 5
-- Target Devices: Basys 3
-- Tool Versions: 
-- Description: en este apartado se hara una Single-port-ram con Syncronous read
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

--Single-Port RAM with Synchronous Read (Dedicated Block RAM)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



entity ram is
port(
    clk : in std_logic;
    we : in std_logic;
    a : in std_logic_vector(13 downto 0);
    di : in std_logic_vector(4 downto 0);
    do : out std_logic_vector(4 downto 0)
);
end ram;

architecture Behavioral of ram is

    type ram_type is array (13 downto 0) of std_logic_vector(4 downto 0);
    signal RAM : ram_type := (others => (others => '0'));
begin
    process(clk)
    begin
        if(we = '1') then
            RAM(to_integer(unsigned(a))) <= di;
        
        elsif (clk'event and clk = '1') then
            do <= RAM(to_integer(unsigned(a)));
            
        end if;
    end process;
    


end Behavioral;

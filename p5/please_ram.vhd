----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.03.2023 13:52:34
-- Design Name: 
-- Module Name: please_ram - Behavioral
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
    di : in std_logic_vector(31 downto 0);
    do : out std_logic_vector(31 downto 0)
);
end ram;

architecture Behavioral of ram is

    type ram_type is array (20 downto 0) of std_logic_vector(31 downto 0);
    signal RAM : ram_type := (others => (others => '0'));
    
        attribute ram_style : string;
        attribute ram_style of RAM : signal is "distributed";

begin
    process(clk)
    begin
       
        if clk'event and clk = '1' then
            if we = '1' then
                RAM(to_integer(unsigned(a))) <= di;
            end if;
            do <= RAM(to_integer(unsigned(a)));        
        end if;
    end process;

end Behavioral;

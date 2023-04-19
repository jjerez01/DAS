----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.02.2023 13:12:04
-- Design Name: 
-- Module Name: comb_sencillo - Behavioral
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

entity comb_sencillo is
    port (entrada : in std_logic_vector (2 downto 0);
        enable: in std_logic;
        salida: out std_logic_vector(7 downto 0));
    
end comb_sencillo;

architecture Behavioral of comb_sencillo is

component deco2ent
    Port( e: in std_logic_vector(1 downto 0);
           z: out std_logic_vector(3 downto 0);
           en: in std_logic);
end component;
    signal aux_enable : std_logic_vector(3 downto 0);
    signal aux1,aux2 : std_logic_vector(1 downto 0);
    signal aux3,aux4 : std_logic_vector( 3 downto 0);
    signal aux5, aux6: std_logic;
begin

    aux1 <= '0'& entrada(2);
    aux2 <= entrada(1) & entrada(0);
    aux5 <= aux_enable(0);
    aux6 <= aux_enable(1);
    
    dec00: deco2ent port map (aux1,aux_enable,enable);
    dec10: deco2ent port map (aux2,aux3,aux5);
    dec11: deco2ent port map (aux2,aux4,aux6);
    
    salida <= aux4 & aux3;


end Behavioral;

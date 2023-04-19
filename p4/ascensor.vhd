----------------------------------------------------------------------------------
-- Company: 
-- Engineer: juanj
-- 
-- Create Date: 13.02.2023 14:38:15
-- Design Name: 
-- Module Name: ascensor - Behavioral
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

entity ascensor is
  Port (
        clk: in std_logic;
        rst: in std_logic;
        piso_ir: in std_logic_vector(3 downto 0);
        mover: in std_logic;
        piso_actual: out std_logic_vector(3 downto 0)
   );
end ascensor;



architecture Behavioral of ascensor is

type ESTADOS is (S0, S1, S2,S3);
signal ESTADO, SIG_ESTADO: ESTADOS;
signal frec: std_logic;
signal piso_ir_cod: std_logic_vector(1 downto 0);
signal piso_ir_aux: std_logic_vector(1 downto 0);

begin

div : entity work.divisorFrec port map (
 valorMax => x"6000000",
 rst => rst,
 clk => clk,
 clkOUT => frec
 ); --div frec
 
 piso_ir_cod <=  "00" when piso_ir = "0001" else 
                    "01" when piso_ir = "001-" else
                    "10" when piso_ir = "01--" else
                    "11"; 
 
reg: process(rst,clk,mover)
begin
    if rst ='1' then
        piso_ir_aux <= (others => '0'); --piso inicial
    elsif clk'event and clk='1' then
        if mover = '1' then
            piso_ir_aux<= piso_ir_cod; --siguiente piso
        end if;
    end if;
end process reg;

SINCRONO: process(frec,rst)
    begin
    if rst ='1' then
        ESTADO<=S0; -- Estado inicial
    elsif frec'event and frec='1' then
        ESTADO<= SIG_ESTADO;
    end if;
end process SINCRONO;


CAMBIOEST: process(ESTADO) -- combinacional que calcula el siguiente estado
  begin
    case ESTADO is
        when S0 =>
            if("00" < piso_ir_aux) then
                SIG_ESTADO<=S1;
            else
                SIG_ESTADO<=S0;
            end if;
        when S1 =>
            if("01" < piso_ir_aux) then
                SIG_ESTADO<=S2;
            elsif("01" > piso_ir_aux) then
                SIG_ESTADO<=S0;
            else
                SIG_ESTADO <= S1;            
            end if;
        when S2 =>
            if("10" < piso_ir_aux) then
                SIG_ESTADO<=S3;
            elsif ("10" > piso_ir_aux) then
                SIG_ESTADO<=S1;
            else
                SIG_ESTADO <= S2;
            end if;
        when S3 =>
            if("11" > piso_ir_aux) then
                SIG_ESTADO<=S2;
            else
                SIG_ESTADO<=S3;
            end if;
        end case;
   end process CAMBIOEST;
   
 


        
SAL: process(ESTADO) -- Moore
    begin
    case ESTADO is
    when S0 =>
    piso_actual <= "0001";
    when S1 =>
    piso_actual <= "0010";
    when S2 =>
    piso_actual <= "0100";
    when S3 =>
    piso_actual <= "1000";
    end case;
    end process SAL;
  
end Behavioral;

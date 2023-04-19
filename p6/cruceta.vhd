library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity vgacore is
	port
	(
		reset: in std_logic;	-- reset
		clk_in: in std_logic;
		hsyncb: buffer std_logic;	-- horizontal (line) sync
		vsyncb: out std_logic;	-- vertical (frame) sync
		rgb: out std_logic_vector(11 downto 0) -- 4 red, 4 green,4 blue colors
	);
end vgacore;

architecture vgacore_arch of vgacore is


signal hcnt: std_logic_vector(11 downto 0);	
signal vcnt: std_logic_vector(11 downto 0);
signal muestraColor: std_logic;
				
begin


A: process(clk_in,reset)
begin
	-- reset asynchronously clears pixel counter
	if reset='1' then
		hcnt <= "000000000000";
	-- horiz. pixel counter increments on rising edge of dot clock
	elsif (clk_in'event and clk_in='1') then
		-- horiz. pixel counter rolls-over after 381 pixels
		if hcnt<1687 then
			hcnt <= hcnt + 1;
		else
			hcnt <= "000000000000";
		end if;
	end if;
end process;


B: process(hsyncb,reset)
begin
	-- reset asynchronously clears line counter
	if reset='1' then
		vcnt <= "000000000000";
	-- vert. line counter increments after every horiz. line
	elsif (hsyncb'event and hsyncb='1') then
		-- vert. line counter rolls-over after 528 lines
		if vcnt<1065 then
			vcnt <= vcnt + 1;
		else
			vcnt <= "000000000000";
		end if;
	end if;
end process;

C: process(clk_in,reset)
begin
	-- reset asynchronously sets horizontal sync to inactive
	if reset='1' then
		hsyncb <= '1';
	-- horizontal sync is recomputed on the rising edge of every dot clock
	elsif (clk_in'event and clk_in='1') then
		-- horiz. sync is low in this interval to signal start of a new line
		if (hcnt>=1327 and hcnt<1439) then
			hsyncb <= '0';
		else
			hsyncb <= '1';
		end if;
	end if;
end process;

D: process(hsyncb,reset)
begin
	-- reset asynchronously sets vertical sync to inactive
	if reset='1' then
		vsyncb <= '1';
	-- vertical sync is recomputed at the end of every line of pixels
	elsif (hsyncb'event and hsyncb='1') then
		-- vert. sync is low in this interval to signal start of a new frame
		if (vcnt>=1024 and vcnt<1027) then
			vsyncb <= '0';
		else
			vsyncb <= '1';
		end if;
	end if;
end process;
-- A partir de aqui escribir la parte de dibujar en la pantalla

-- Este es un process que hace del tercer comparador que hay en el block diagram. Este
-- si esta dentro del recuadro del display, al tiempo al que se actualiza un pixel es decir el contador
--vertical pues ahi manda una señal para mostrar un color o no
E: process(hsyncb,reset)
begin
    if (hcnt>=1327 and hcnt<1439) then
        if (vcnt>=1024 and vcnt<1027) then
            muestraColor<= '1';
        else
            muestraColor <= '0';
        end if;
    else
            muestraColor <= '0';
    end if;
end process;

F: process(hsyncb,reset)
begin
	-- reset asynchronously sets vertical sync to inactive
	if(muestraColor = '1') then
	   rgb <= "111100000000";
	else
	   rgb <= "000000000000";
	end if;
end process;

--
--
--
-----------------------------------------------------------------

end vgacore_arch;



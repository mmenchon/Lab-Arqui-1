-- Realizado por Mart�n V�zquez. 1/4/2010

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity reg is
    Port ( clk, reset, ce : in  std_logic;
           d : in  std_logic_vector (31 downto 0);
           q : out std_logic_vector (31 downto 0));
end reg;

architecture Behavioral of reg is
	
	signal r: std_logic_vector(31 downto 0);
	
begin


	-- proceso que describe registro con reset s�ncrono y se�al de carga
	process (clk)
	begin
		if (rising_edge(clk)) then
			
			if (reset = '1') then
				r <= (others => '0');
			elsif (ce='1') then
				r <= d;
			end if;	
			
		end if;
	end process;

	q <= r;
	
end Behavioral;


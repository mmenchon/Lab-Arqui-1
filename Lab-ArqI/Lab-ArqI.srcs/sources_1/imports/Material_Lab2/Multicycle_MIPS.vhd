---------------------------------------------------------------------------------------------------
--
-- Title       : Multicycle_MIPS.vhd
-- Design      : Empty design file for multicycle MIPS
-- Author      : L. Leiva
-- Company     : UNICEN
--
--
---------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Multicycle_MIPS is
port(
	Clk         : in  std_logic;
	Reset       : in  std_logic;
	Addr      : out std_logic_vector(31 downto 0);
	RdStb     : out std_logic;
	WrStb     : out std_logic;
	DataOut   : out std_logic_vector(31 downto 0);
	DataIn    : in  std_logic_vector(31 downto 0));
end Multicycle_MIPS; 

architecture Multicycle_MIPS_arch of Multicycle_MIPS is 
-- declaracion de señales y componentes
begin 
-- procesos explicitos, implicitos e instanciacion de componentes 

end Multicycle_MIPS_arch;
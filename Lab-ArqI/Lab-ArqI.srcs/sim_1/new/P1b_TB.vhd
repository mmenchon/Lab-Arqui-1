----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.04.2019 15:25:17
-- Design Name: 
-- Module Name: Mux_TB - Behavioral
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

entity Mux_TB is
--  Port ( );
end Mux_TB;

architecture Behavioral of Mux_TB is
component Mux
    port( a: in std_logic_vector(31 downto 0);
          b: in std_logic_vector(31 downto 0);
          sel: in std_logic;
          o: out std_logic_vector(31 downto 0));
end component;
signal a: std_logic_vector(31 downto 0);
signal b: std_logic_vector(31 downto 0);
signal sel: std_logic;
signal o: std_logic_vector(31 downto 0);
begin
    uut: Mux
        port map(a => a,
            b => b,
            sel => sel,
            o => o);
           
   tbProcess: process
   begin
    a <= x"12345678";
    b <= x"87654321";
    sel <= '0';
    assert o = a    report "No Anda"    severity FAILURE;
    wait for 50 ns;
    sel <= '1';
    wait for 50 ns;
    wait;
    end process;
end Behavioral;

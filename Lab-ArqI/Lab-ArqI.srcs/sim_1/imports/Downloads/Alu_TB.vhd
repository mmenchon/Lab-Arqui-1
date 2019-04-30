----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2019 15:15:32
-- Design Name: 
-- Module Name: Alu_TB - Behavioral
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

entity Alu_TB is
--  Port ( );
end Alu_TB;

architecture Behavioral of Alu_TB is
component Alu
     Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
          b : in STD_LOGIC_VECTOR (31 downto 0);
          control : in STD_LOGIC_VECTOR (2 downto 0);
          result : out STD_LOGIC_VECTOR (31 downto 0);
          zero : out STD_LOGIC);
end component;
signal a: std_logic_vector(31 downto 0);
signal b: std_logic_vector(31 downto 0);
signal control: std_logic_vector(2 downto 0);
signal result: std_logic_vector(31 downto 0);
signal zero: std_logic;

begin

    uut: Alu
        port map( a => a,
            b => b,
            control => control,
            result => result,
            zero => zero);

    tbProcess: process
    begin
        a <= x"fff04567";
        b <= x"00123456";
        control <= b"110";
        wait for 400 ns;
        -- assert o = a    report "No Anda"    severity FAILURE;
    end process;

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2018 14:18:16
-- Design Name: 
-- Module Name: Registers_TB - Behavioral
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
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
use IEEE.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Registers_TB is
--  Port ( );
end Registers_TB;

architecture Behavioral of Registers_TB is

	COMPONENT Registers
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		wr : IN std_logic;
        reg1_rd : in STD_LOGIC_VECTOR (4 downto 0);
        reg2_rd : in STD_LOGIC_VECTOR (4 downto 0);
        reg_wr : in STD_LOGIC_VECTOR (4 downto 0);
        data_wr : in STD_LOGIC_VECTOR (31 downto 0);
        data1_rd : out STD_LOGIC_VECTOR (31 downto 0);
        data2_rd : out STD_LOGIC_VECTOR (31 downto 0)
		);
	END COMPONENT;

	--Inputs
	SIGNAL clk :  std_logic := '0';
	SIGNAL reset :  std_logic := '0';
	SIGNAL wr :  std_logic := '0';
	SIGNAL reg1_rd :  std_logic_vector(4 downto 0) := (others=>'0');
    SIGNAL reg2_rd :  std_logic_vector(4 downto 0) := (others=>'0');
    SIGNAL reg_wr :  std_logic_vector(4 downto 0) := (others=>'0');
    SIGNAL data_wr :  std_logic_vector(31 downto 0) := (others=>'0');
				

	--Outputs
    SIGNAL data1_rd :  std_logic_vector(31 downto 0);
    SIGNAL data2_rd :  std_logic_vector(31 downto 0);

begin

    uut: Registers PORT MAP(
		clk => clk,
		reset => reset,
		wr => wr,
		reg1_rd => reg1_rd,
		reg2_rd => reg2_rd,
		reg_wr => reg_wr,
		data_wr => data_wr,
		data1_rd => data1_rd,
		data2_rd => data2_rd
	);
	
    tclk : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    trst : process
    begin
        reset <= '0';
        wait for 210 ns;
        reset <= '1';
        wait for 50 ns;
        reset <= '0';
        wait;
    end process;
    
    twr : process
    begin
        wr <= '0';
        wait for 30 ns;
        wr <= '1';
        wait for 30 ns;
    end process;
    
    tdata : process
    begin
        reg_wr <= CONV_STD_LOGIC_VECTOR(0,5);
        data_wr <= x"67663412";
        wait for 50 ns;
        reg2_rd <= CONV_STD_LOGIC_VECTOR(0,5);
        for index in 0 to 31 loop
            --wait for 30 ns;
            reg_wr <= CONV_STD_LOGIC_VECTOR(index,5);
            data_wr <= CONV_STD_LOGIC_VECTOR(index+1,32);
            wait for 50 ns;
            reg1_rd <= CONV_STD_LOGIC_VECTOR(index,5);
            wait for 50 ns;
        end loop;
        
        for index in 0 to 31 loop
            reg1_rd <= CONV_STD_LOGIC_VECTOR(index,5);
            wait for 50 ns;
        end loop;
        wait;
    end process;


end Behavioral;

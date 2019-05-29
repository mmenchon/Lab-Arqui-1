----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2019 15:08:15
-- Design Name: 
-- Module Name: ControlUnit_TB - Behavioral
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

entity ControlUnit_TB is
--  Port ( );
end ControlUnit_TB;

architecture Behavioral of ControlUnit_TB is
component ControlUnit
    port ( clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           OpCode:  in STD_LOGIC_VECTOR(5 downto 0);
           PCSource: out STD_LOGIC;
           TargetWrite: out STD_LOGIC;
           AluOp: out STD_LOGIC_VECTOR(1 downto 0);
           AluSelA: out STD_LOGIC;
           AluSelB: out STD_LOGIC_VECTOR(1 downto 0);
           RegWrite: out STD_LOGIC;
           RegDst: out STD_LOGIC;
           PCWrite: out STD_LOGIC;
           PCWriteCond: out STD_LOGIC;
           IorD: out STD_LOGIC;
           MemRead: out STD_LOGIC;
           MemWrite: out STD_LOGIC;
           IRWrite: out STD_LOGIC;
           MemToReg: out STD_LOGIC);
end component;

signal clk: STD_LOGIC;
signal Reset: STD_LOGIC;
signal OpCode: STD_LOGIC_VECTOR(5 downto 0);
signal PCSource: STD_LOGIC;
signal TargetWrite: STD_LOGIC;
signal AluOp: STD_LOGIC_VECTOR(1 downto 0);
signal AluSelA: STD_LOGIC;
signal AluSelB: STD_LOGIC_VECTOR(1 downto 0);
signal RegWrite: STD_LOGIC;
signal RegDst: STD_LOGIC;
signal PCWrite: STD_LOGIC;
signal PCWriteCond: STD_LOGIC;
signal IorD: STD_LOGIC;
signal MemRead: STD_LOGIC;
signal MemWrite: STD_LOGIC;
signal IRWrite: STD_LOGIC;
signal MemToReg: STD_LOGIC;

begin
    uut: ControlUnit
        port map( PCSource => PCSource,
            TargetWrite => TargetWrite,
            AluOp => AluOp,
            AluselA => AluselA,
            AluselB => AluselB,
            RegWrite => RegWrite,
            RegDst => RegDst,
            PCWrite => PCWrite,
            PCWriteCond => PCWriteCond,
            IorD => IorD,
            MemRead => MemRead,
            MemWrite => MemWrite,
            IRWrite => IRWrite,
            MemToReg => MemToReg,
            clk => clk,
            Reset => Reset,
            OpCode => OpCode);
            
    tclk : process
    begin
        clk <= '0';
        wait for 20 ns;
        clk <= '1';
        wait for 20 ns;
    end process;
    
    tdata: process
    begin
        OpCode <= "100011";
        wait for 100 ns;
    end process;

end Behavioral;

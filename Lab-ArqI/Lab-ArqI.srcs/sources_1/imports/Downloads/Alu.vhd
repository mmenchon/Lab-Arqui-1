----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2019 14:14:25
-- Design Name: 
-- Module Name: Alu - Behavioral
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
use IEEE.STD_LOGIC_SIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Alu is
    Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (31 downto 0);
           control : in STD_LOGIC_VECTOR (2 downto 0);
           result : out STD_LOGIC_VECTOR (31 downto 0);
           zero : out STD_LOGIC);
end Alu;

architecture Behavioral of Alu is
    signal r: std_logic_vector(31 downto 0);
    signal z:std_logic;
begin

 process (a, b, control)
 begin
    case control is 
     when "000" =>
        r <= (a and b);
     when "001" =>
        r <= (a or b);
     when "010" =>
        r <= (a + b);
     when "100" =>
        r <= b(15 downto 0) & (x"0000");
     when "110" =>
        r <= (a - b);
     when "111" =>
        if a < b then
            r <= x"00000001";
        else 
            r <= x"00000000";
        end if;
     when others =>
        r <= x"00000000";
  end case;
    end process;
    
  process(r)
  begin
      if(r = x"00000000") then 
        z <= '1';
      else
        z <= '0';
      end if;
  end process;
  
  result <= r;
  zero <= z;

end Behavioral;

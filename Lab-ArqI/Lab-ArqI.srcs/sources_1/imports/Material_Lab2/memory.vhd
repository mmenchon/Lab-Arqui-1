---------------------------------------------------------------------------------------------------
--
-- Title       : ControlUnit.vhd
-- Design      : Memory Description for MIPS Simulation
-- Author      : L. Pantaleone, M. Vazquez, L. Leiva
-- Company     : UNICEN
--
--
---------------------------------------------------------------------------------------------------

library STD;
use STD.textio.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_textio.all;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory is
    generic(
        C_ELF_FILENAME_LOW    : string := "";
        C_ELF_FILENAME_HIGH    : string := "";
        C_MEM_SIZE        : integer := 2048;
        C_MEM_HIGH_OFFSET    : integer := 1024
	 );
    Port ( Addr : in std_logic_vector(31 downto 0);
           DataIn : in std_logic_vector(31 downto 0);
           RdStb : in std_logic ;
           WrStb : in std_logic ;
           Clk : in std_logic ;						  
           DataOut : out std_logic_vector(31 downto 0));
end memory;

architecture mem_arq of memory is 
	
type matriz is array(0 to C_MEM_SIZE-1) of STD_LOGIC_VECTOR(7 downto 0);
signal memo: matriz;
signal aux : STD_LOGIC_VECTOR (31 downto 0):= (others=>'0'); 


begin

process (clk)
		variable cargar : boolean := true;
		variable address : STD_LOGIC_VECTOR(31 downto 0);
		variable datum : STD_LOGIC_VECTOR(31 downto 0);
        file f : text;
		variable status : file_open_status;
		variable  current_line : line;

begin
	
	if cargar then 
		-- primero iniciamos la memoria con ceros
			for i in 0 to C_MEM_SIZE-1 loop
				memo(i) <= (others => '0');
			end loop; 
			address:= (others => '0');
		-- luego cargamos el archivo en la misma
		
		file_open(status,f,C_ELF_FILENAME_LOW,read_mode);
	      
	     while (not endfile (f)) loop
           readline (f, current_line);                    
           --hread(current_line, address);
           hread(current_line, datum);
           assert CONV_INTEGER(address(30 downto 0))<C_MEM_SIZE 
               report "Direccion fuera de rango en el fichero de la memoria"
               severity failure;
           memo(CONV_INTEGER(address(30 downto 0))) <= datum(31 downto 24);
           memo(CONV_INTEGER(address(30 downto 0)+'1')) <= datum(23 downto 16);
           memo(CONV_INTEGER(address(30 downto 0)+"10")) <= datum(15 downto 8);
           memo(CONV_INTEGER(address(30 downto 0)+"11")) <= datum(7 downto 0);
           address := address + 4;
         end loop;        
         file_close(f);
         
         address:= (others => '0'); 
         file_open(status,f,C_ELF_FILENAME_HIGH,read_mode);
          if (status=open_ok) then   
            while (not endfile (f)) loop
                readline (f, current_line);                    
                --hread(current_line, address);
                hread(current_line, datum);
                assert CONV_INTEGER(address(30 downto 0))<C_MEM_SIZE 
                    report "Direccion fuera de rango en el fichero de la memoria"
                severity failure;
                memo(CONV_INTEGER(C_MEM_HIGH_OFFSET+address(30 downto 0))) <= datum(31 downto 24);
                memo(CONV_INTEGER(C_MEM_HIGH_OFFSET+address(30 downto 0)+'1')) <= datum(23 downto 16);
                memo(CONV_INTEGER(C_MEM_HIGH_OFFSET+address(30 downto 0)+"10")) <= datum(15 downto 8);
                memo(CONV_INTEGER(C_MEM_HIGH_OFFSET+address(30 downto 0)+"11")) <= datum(7 downto 0);
                address := address + 4;
            end loop;        
            file_close(f);
         end if; 
         
		cargar := false;
	
	
   elsif (Clk'event and Clk = '0') then
         if (WrStb = '1') then
			memo(CONV_INTEGER(Addr(30 downto 0))) <= DataIn(31 downto 24);
			memo(CONV_INTEGER(Addr(30 downto 0)+'1')) <= DataIn(23 downto 16);
			memo(CONV_INTEGER(Addr(30 downto 0)+"10")) <= DataIn(15 downto 8);
			memo(CONV_INTEGER(Addr(30 downto 0)+"11")) <= DataIn(7 downto 0);
			
         elsif (RdStb = '1')then
			aux(31 downto 24) <= memo(conv_integer(Addr(30 downto 0)));   
			aux(23 downto 16) <= memo(conv_integer(Addr(30 downto 0)+'1'));
			aux(15 downto 8) <= memo(conv_integer(Addr(30 downto 0)+"10"));
			aux(7 downto 0) <= memo(conv_integer(Addr(30 downto 0)+"11"));
         end if;
   end if;
end process;

DataOut <= aux;	 


end mem_arq;

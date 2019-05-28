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
--------------componentes---------------
--------------Unidad de Control------------
component ControlUnit is
    Port ( clk : in STD_LOGIC;
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
---------------ALU-------------------------
component alu is
--  Port ( );
    Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (31 downto 0);
           control : in STD_LOGIC_VECTOR (2 downto 0);
           result : out STD_LOGIC_VECTOR (31 downto 0);
           zero : out STD_LOGIC);
end component;
-----------------Banco de Registros--------------
component registers is
--  Port ( );
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           wr : in STD_LOGIC;
           reg1_rd : in STD_LOGIC_VECTOR (4 downto 0);
           reg2_rd : in STD_LOGIC_VECTOR (4 downto 0);
           reg_wr : in STD_LOGIC_vector(4 downto 0);
           data_wr : in STD_LOGIC_VECTOR (31 downto 0);
           data1_rd : out STD_LOGIC_VECTOR (31 downto 0);
           data2_rd : out STD_LOGIC_VECTOR (31 downto 0));
end component;
----------------------señales memoria---------------------------------
signal Pc_Out : std_logic_vector(31 downto 0);
signal PcWrite_OR_PCWriteCond_AND_Zero : std_logic;
signal Pc_In : std_logic_vector(31 downto 0);
signal MemData : std_logic_vector(31 downto 0);

-----------------------señales unidad de control--------------------
signal OpCode : std_logic_vector(5 downto 0);
signal PCSource : std_logic;
signal TargetWrite : std_logic;
signal AluOp : std_logic_vector(1 downto 0);
signal AluSelA : std_logic;
signal AluSelB : std_logic_vector(1 downto 0);
signal RegWrite : std_logic;
signal RegDst : std_logic;
signal PCWrite : std_logic;
signal PCWriteCond : std_logic;
signal IorD : std_logic;
signal MemWrite : std_logic;
signal MemRead : std_logic;
signal IRWrite : std_logic;
signal MemtoReg : std_logic;
signal PCWriteCond_AND_Zero : std_logic;
---------------------señales de instruccion-----------------------
signal Instruction : std_logic_vector(31 downto 0);
signal Instruction_Inmediato : std_logic_vector(15 downto 0);
signal Instruction_Rs : std_logic_vector(4 downto 0);
signal Instruction_Rd : std_logic_vector(4 downto 0);
signal Instruction_Rt : std_logic_vector(4 downto 0);

---------------------señales de ejecucion-------------------------
signal AluOut : std_logic_vector(31 downto 0);
signal Zero : std_logic;
signal AluIn1 : std_logic_vector(31 downto 0);
signal AluIn2 : std_logic_vector(31 downto 0);
signal AluControl : std_logic_vector(2 downto 0);
---------------------señales banco de registros-------------------
signal WriteRegister : std_logic_vector(4 downto 0);
signal WriteData : std_logic_vector(31 downto 0);
signal ReadRegister1 : std_logic_vector(4 downto 0);
signal ReadRegister2 : std_logic_vector(4 downto 0);
signal ReadData1 : std_logic_vector(31 downto 0);
signal ReadData2 : std_logic_vector(31 downto 0);
signal SignExtend : std_logic_vector(31 downto 0);



begin 
-- procesos explicitos, implicitos e instanciacion de componentes 
------------------------------------------ETAPA IF-------------------------------------------------
PCWriteCond_AND_Zero <= PCWriteCond AND Zero;
PcWrite_OR_PCWriteCond_AND_Zero <= PCWrite OR PCWriteCond_AND_Zero;
------registro PC------
Reg_PC : process (Clk, Reset)
begin
    if (Reset = '1') then
        Pc_Out <= (others => '0');
    else if (rising_edge(Clk)) then
            if (PcWrite_OR_PCWriteCond_AND_Zero = '1') then
                Pc_Out <= Pc_In;
             end if;  
         end if;
    end if;
end process; 
-----multiplexor etapa IF------

Addr <= PC_Out when (IorD = '0') else AluOut;  
DataOut <= ReadData2;
MemData <= DataIn;
RdStb <= MemRead;
WrStb <= MemWrite;        
-------------------------------------------ETAPA ID----------------------------------------------------
UC: ControlUnit port map(
           clk => Clk,
           Reset => Reset,
           OpCode => OpCode,
           PCSource => PCSource,
           TargetWrite => TargetWrite,
           AluOp => AluOp,
           AluSelA => AluSelA,
           AluSelB => AluSelB,
           RegWrite => RegWrite,
           RegDst => RegDst,
           PCWrite => PCWrite,
           PCWriteCond => PCWriteCond,
           IorD => IorD,
           MemRead => MemRead,
           MemWrite => MemWrite,
           IRWrite => IRWrite,
           MemToReg => MemtoReg
);

IFID_Reg : process(Clk, Reset)
begin
    if (Reset = '1') then
     Instruction <= (others => '0');
    else if (rising_edge(Clk)) then
            if (IRWrite = '1') then
                Instruction <= MemData;
             end if;  
         end if;
    end if;
end process; 

OpCode <= Instruction(31 downto 26);
Instruction_Rs <= Instruction(25 downto 21);
Instruction_Rt <= Instruction(20 downto 16);
Instruction_Rd <= Instruction(15 downto 11);
Instruction_Inmediato <= Instruction(15 downto 0);

WriteRegister <= Instruction_Rt when (RegDst = '0') else Instruction_Rd;
WriteData <= AluOut when (MemtoReg = '0') else MemData;

SignExtend <= x"0000" & Instruction_Inmediato when (Instruction_Inmediato(15) = '0') else (x"FFFF" & Instruction_Inmediato);

Regs : registers port map(
        clk => Clk,
        reset => Reset,
        wr => RegWrite,
        reg1_rd => Instruction_Rs,
        reg2_rd => Instruction_Rt,
        reg_wr => WriteRegister,
        data_wr => WriteData,
        data1_rd => ReadData1,
        data2_rd => ReadData2
        );

AluIn1 <= PC_Out when (AluSelA = '0') else ReadData1;

process (AluSelB)
begin
    case (AluSelB) is
        when "00" =>
          AluIn2 <= ReadData2;
        when "01" =>
          AluIn2 <= x"00000004";  
        when "10" =>
          AluIn2 <= SignExtend;
        when "11" =>
          AluIn2 <= SignExtend(29 downto 0) + "00"; 
        when others => AluIn2 <= x"00000000"; 
     end case;
end process;

AluEx : alu port map(
           a => AluIn1,
           b => AluIn2,
           control => AluControl,
           result => AluOut,
           zero => Zero
           );


end Multicycle_MIPS_arch;
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity ALU is
port( 
	input_vectorf1 : in std_logic_vector(15 downto 0);
	input_vectorf2 : in std_logic_vector(15 downto 0);
	Op_select : in std_logic; --0-Add 1-Nand
	output_vectorf : out std_logic_vector(15 downto 0);
	Carry_flag : out std_logic;
	Zero_flag : out std_logic
		);

end entity ALU;

architecture FinalWork of ALU is

component Bit_adder is
   port( input_vector1: in std_logic_vector(15 downto 0);
	      input_vector2 :in std_logic_vector(15 downto 0);
       	output_vector: out std_logic_vector(16 downto 0));
end component;

component BitwiseNand is
	port(
			Inp1 : in std_logic_vector(15 downto 0);
	      Inp2 : in std_logic_vector(15 downto 0);
	      Outp : out std_logic_vector(15 downto 0)
	    );

end component;

signal Amp1 : std_logic_vector(16 downto 0);
signal Amp2, Amp3 : std_logic_vector(15 downto 0);

begin
	
B1 : Bit_adder
	port map(input_vector1 =>  input_vectorf1 , input_vector2 => input_vectorf2 , output_vector => Amp1);

B2 : BitwiseNand
	port map(Inp1 => input_vectorf1 , Inp2 => input_vectorf2, outp => Amp2);

Amp3 <= Amp1(15 downto 0) when Op_select='0' else Amp2;
							
carry_flag <= Amp1(16);
zero_flag <= '1' when Amp3 = "0000000000000000" else '0';
output_vectorf <= Amp3;
			

end FinalWork;



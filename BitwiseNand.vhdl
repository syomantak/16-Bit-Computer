library ieee;
use ieee.std_logic_1164.all;

entity BitwiseNand is
port(Inp1 : in std_logic_vector(15 downto 0);
	  Inp2 : in std_logic_vector(15 downto 0);
	  Outp : out std_logic_vector(15 downto 0)
	  );
end entity;

architecture fn1 of BitwiseNand is

begin

Outp <= Inp1 nand Inp2;

end fn1;
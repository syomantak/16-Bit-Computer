-- A DUT entity is used to wrap your design.
--  This example shows how you can do this for the
--  Full-adder.

library ieee;
use ieee.std_logic_1164.all;
entity DUT is
   port(input_vector: in std_logic_vector(17 downto 0);
       	output_vector: out std_logic_vector(7 downto 0));
end entity;

architecture DutWrap of DUT is
   component ALU is
     port (sel: in std_logic_vector(1 downto 0); I1: in std_logic_vector(7 downto 0); I2: in std_logic_vector(7 downto 0); OP2: out std_logic_vector(7 downto 0));
   end component;
begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   add_instance: ALU
			port map (
					-- order of inputs Cin B A
					sel(1) => input_vector(17),
					sel(0) => input_vector(16),
					I2(7)   => input_vector(15),
					I2(6)   => input_vector(14),
					I2(5)   => input_vector(13),
					I2(4)   => input_vector(12),
					I2(3)   => input_vector(11),
					I2(2)   => input_vector(10),
					I2(1)   => input_vector(9),
					I2(0)   => input_vector(8),
					I1(7)   => input_vector(7),
					I1(6)   => input_vector(6),
					I1(5)   => input_vector(5),
					I1(4)   => input_vector(4),
					I1(3)   => input_vector(3),
					I1(2)   => input_vector(2),
					I1(1)   => input_vector(1),
					I1(0)   => input_vector(0),
                                        -- order of outputs S Cout
					OP2(7)  => output_vector(7),
					OP2(6)  => output_vector(6),
					OP2(5)  => output_vector(5),
					OP2(4)  => output_vector(4),
					OP2(3) => output_vector(3),
					OP2(2) => output_vector(2),
					OP2(1) => output_vector(1),
					OP2(0) => output_vector(0));

end DutWrap;


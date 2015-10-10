library ieee;
use ieee.std_logic_1164.all;

library ieee;
use ieee.numeric_std.all;

entity add_2 is
	port (
		output : out std_logic_vector(7 downto 0);
		in_a : in  std_logic_vector(7 downto 0);
		in_b : in  std_logic_vector(7 downto 0)
	);
end add_2;

architecture augh of add_2 is

	signal carry_inA : std_logic_vector(9 downto 0);
	signal carry_inB : std_logic_vector(9 downto 0);
	signal carry_res : std_logic_vector(9 downto 0);

begin

	-- To handle the CI input, the operation is '1' + CI
	-- If CI is not present, the operation is '1' + '0'
	carry_inA <= '0' & in_a & '1';
	carry_inB <= '0' & in_b & '0';
	-- Compute the result
	carry_res <= std_logic_vector(unsigned(carry_inA) + unsigned(carry_inB));

	-- Set the outputs
	output <= carry_res(8 downto 1);

end architecture;

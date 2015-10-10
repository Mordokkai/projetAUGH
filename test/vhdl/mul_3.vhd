library ieee;
use ieee.std_logic_1164.all;

library ieee;
use ieee.numeric_std.all;

entity mul_3 is
	port (
		output : out std_logic_vector(7 downto 0);
		in_b : in  std_logic_vector(7 downto 0);
		in_a : in  std_logic_vector(7 downto 0)
	);
end mul_3;

architecture augh of mul_3 is

	signal tmp_res : signed(15 downto 0);

begin

	-- The actual multiplication
	tmp_res <= signed(in_a) * signed(in_b);

	-- Set the output
	output <= std_logic_vector(tmp_res(7 downto 0));

end architecture;

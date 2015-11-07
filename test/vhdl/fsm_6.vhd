library ieee;
use ieee.std_logic_1164.all;

library ieee;
use ieee.numeric_std.all;

entity fsm_6 is
	port (
		clock : in  std_logic;
		reset : in  std_logic;
		out9 : out std_logic;
		out10 : out std_logic;
		in0 : in  std_logic;
		out0 : out std_logic;
		out3 : out std_logic;
		in1 : in  std_logic;
		out16 : out std_logic;
		out18 : out std_logic;
		out20 : out std_logic;
		out21 : out std_logic;
		in2 : in  std_logic;
		out23 : out std_logic;
		out25 : out std_logic;
		in3 : in  std_logic;
		out26 : out std_logic;
		in4 : in  std_logic;
		in5 : in  std_logic
	);
end fsm_6;

architecture augh of fsm_6 is

	signal state_cur  : std_logic_vector(0 to 11) := (11 => '1', others => '0');
	signal state_next : std_logic_vector(0 to 11) := (11 => '1', others => '0');

	-- Buffers for outputs
	signal out21_buf : std_logic := '0';
	signal out21_bufn : std_logic;

	-- A utility function to convert bool to std_logic
	function to_stdl (b: boolean) return std_logic is
	begin
		if b = true then
			return '1';
		end if;
		return '0';
	end function;

begin

	-- Sequential process
	-- Set the current state

	process (clock)
	begin
		if rising_edge(clock) then

			-- Next state
			state_cur <= state_next;
			-- Buffers for outputs
			out21_buf <= out21_bufn;

		end if;
	end process;

	-- Combinatorial process
	-- Compute the next state
	-- Compute the outputs

	process (
		-- Inputs of the FSM
		reset, in0, in1, in2, in3, in4, in5,
		-- Current state
		state_cur
	)
	begin

		-- Reset the next state value

		state_next <= (others => '0');

		-- Default value to the outputs or output buffers

		out0 <= '0';
		out3 <= '0';
		out9 <= '0';
		out10 <= '0';
		out16 <= '0';
		out18 <= '0';
		out20 <= '0';
		out21_bufn <= '0';
		out23 <= '0';
		out25 <= '0';
		out26 <= '0';

		-- For all states, compute the next state bits
		--   And the outputs, and the next value for buffered outputs

		if state_cur(0) = '1' then
			-- Next state
			if (not (in0)) = '1' then
				state_next(0) <= '1';
				-- Next values for buffered outputs
			else
				state_next(4) <= '1';
				-- Next values for buffered outputs
			end if;
			-- Assignment of non-buffered outputs
			out0 <= '1';
		end if;

		if state_cur(1) = '1' then
			-- Next state
			if (not (in1)) = '1' then
				state_next(1) <= '1';
				-- Next values for buffered outputs
			else
				state_next(2) <= '1';
				-- Next values for buffered outputs
			end if;
			-- Assignment of non-buffered outputs
			out3 <= '1';
		end if;

		if state_cur(2) = '1' then
			-- Next state
			state_next(3) <= '1';
			-- Next values for buffered outputs
			-- Assignment of non-buffered outputs
			out10 <= '1';
			out9 <= '1';
		end if;

		if state_cur(3) = '1' then
			-- Next state
			if (in2) = '1' then
				state_next(1) <= '1';
				-- Next values for buffered outputs
			else
				state_next(10) <= '1';
				-- Next values for buffered outputs
				out21_bufn <= '1';
			end if;
			-- Assignment of non-buffered outputs
		end if;

		if state_cur(4) = '1' then
			-- Next state
			state_next(3) <= '1';
			-- Next values for buffered outputs
			-- Assignment of non-buffered outputs
			out10 <= '1';
		end if;

		if state_cur(5) = '1' then
			-- Next state
			state_next(0) <= '1';
			-- Next values for buffered outputs
			-- Assignment of non-buffered outputs
			out18 <= '1';
			out16 <= '1';
		end if;

		if state_cur(6) = '1' then
			-- Next state
			state_next(0) <= '1';
			-- Next values for buffered outputs
			-- Assignment of non-buffered outputs
			out20 <= '1';
			out18 <= '1';
		end if;

		if state_cur(7) = '1' then
			-- Next state
			if (in3) = '1' then
				state_next(6) <= '1';
				-- Next values for buffered outputs
			else
				state_next(5) <= '1';
				-- Next values for buffered outputs
			end if;
			-- Assignment of non-buffered outputs
		end if;

		if state_cur(8) = '1' then
			-- Next state
			state_next(7) <= '1';
			-- Next values for buffered outputs
			out21_bufn <= '1';
			-- Assignment of non-buffered outputs
			out25 <= '1';
			out23 <= '1';
		end if;

		if state_cur(9) = '1' then
			-- Next state
			state_next(7) <= '1';
			-- Next values for buffered outputs
			out21_bufn <= '1';
			-- Assignment of non-buffered outputs
			out25 <= '1';
			out26 <= '1';
		end if;

		if state_cur(10) = '1' then
			-- Next state
			if (in4) = '1' then
				state_next(9) <= '1';
				-- Next values for buffered outputs
			else
				state_next(8) <= '1';
				-- Next values for buffered outputs
			end if;
			-- Assignment of non-buffered outputs
		end if;

		-- Info: This is the init/reset state
		if state_cur(11) = '1' then
			-- Next state
			if (not (in5)) = '1' then
				state_next(11) <= '1';
				-- Next values for buffered outputs
			else
				state_next(4) <= '1';
				-- Next values for buffered outputs
			end if;
			-- Assignment of non-buffered outputs
		end if;

		-- Reset input
		if reset = '1' then
			-- Set the reset state
			state_next <= (11 => '1', others => '0');
			-- Note: Resetting all buffers for outputs here is not necessary.
			-- It would cost hardware. They will be reset at the next clock front.
			-- Reset state: set the buffered outputs
		end if;

	end process;

	-- Assignment of buffered outputs

	out21 <= out21_buf;

end architecture;


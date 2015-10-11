library ieee;
use ieee.std_logic_1164.all;

library ieee;
use ieee.numeric_std.all;

entity fsm_4 is
	port (
		clock : in  std_logic;
		reset : in  std_logic;
		in1 : in  std_logic;
		in2 : in  std_logic;
		in0 : in  std_logic;
		out0 : out std_logic;
		out3 : out std_logic;
		out4 : out std_logic;
		out8 : out std_logic;
		out9 : out std_logic;
		out11 : out std_logic;
		out13 : out std_logic;
		out17 : out std_logic;
		out19 : out std_logic;
		out21 : out std_logic;
		out22 : out std_logic;
		out23 : out std_logic;
		out25 : out std_logic;
		out27 : out std_logic;
		out30 : out std_logic;
		in3 : in  std_logic;
		in4 : in  std_logic
	);
end fsm_4;

architecture augh of fsm_4 is

	signal state_cur  : std_logic_vector(0 to 14) := (14 => '1', others => '0');
	signal state_next : std_logic_vector(0 to 14) := (14 => '1', others => '0');

	-- Buffers for outputs
	signal out17_buf : std_logic := '0';
	signal out17_bufn : std_logic;

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
			out17_buf <= out17_bufn;

		end if;
	end process;

	-- Combinatorial process
	-- Compute the next state
	-- Compute the outputs

	process (
		-- Inputs of the FSM
		reset, in1, in2, in0, in3, in4,
		-- Current state
		state_cur
	)
	begin

		-- Reset the next state value

		state_next <= (others => '0');

		-- Default value to the outputs or output buffers

		out0 <= '0';
		out3 <= '0';
		out4 <= '0';
		out8 <= '0';
		out9 <= '0';
		out11 <= '0';
		out13 <= '0';
		out17_bufn <= '0';
		out19 <= '0';
		out21 <= '0';
		out22 <= '0';
		out23 <= '0';
		out25 <= '0';
		out27 <= '0';
		out30 <= '0';

		-- For all states, compute the next state bits
		--   And the outputs, and the next value for buffered outputs

		if state_cur(0) = '1' then
			-- Next state
			if (not (in0)) = '1' then
				state_next(0) <= '1';
				-- Next values for buffered outputs
			else
				state_next(1) <= '1';
				-- Next values for buffered outputs
			end if;
			-- Assignment of non-buffered outputs
			out0 <= '1';
		end if;

		if state_cur(1) = '1' then
			-- Next state
			if (not (in0)) = '1' then
				state_next(1) <= '1';
				-- Next values for buffered outputs
			else
				state_next(2) <= '1';
				-- Next values for buffered outputs
			end if;
			-- Assignment of non-buffered outputs
			out3 <= '1';
			out0 <= '1';
		end if;

		if state_cur(2) = '1' then
			-- Next state
			if (not (in1)) = '1' then
				state_next(2) <= '1';
				-- Next values for buffered outputs
			else
				state_next(3) <= '1';
				-- Next values for buffered outputs
			end if;
			-- Assignment of non-buffered outputs
			out4 <= '1';
		end if;

		if state_cur(3) = '1' then
			-- Next state
			if (not (in1)) = '1' then
				state_next(3) <= '1';
				-- Next values for buffered outputs
			else
				state_next(13) <= '1';
				-- Next values for buffered outputs
			end if;
			-- Assignment of non-buffered outputs
			out8 <= '1';
			out4 <= '1';
		end if;

		if state_cur(4) = '1' then
			-- Next state
			state_next(0) <= '1';
			-- Next values for buffered outputs
			-- Assignment of non-buffered outputs
			out11 <= '1';
			out9 <= '1';
		end if;

		if state_cur(5) = '1' then
			-- Next state
			state_next(4) <= '1';
			-- Next values for buffered outputs
			-- Assignment of non-buffered outputs
			out11 <= '1';
			out13 <= '1';
		end if;

		if state_cur(6) = '1' then
			-- Next state
			state_next(4) <= '1';
			-- Next values for buffered outputs
			-- Assignment of non-buffered outputs
			out11 <= '1';
		end if;

		if state_cur(7) = '1' then
			-- Next state
			if (in2) = '1' then
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
			out17_bufn <= '1';
			-- Assignment of non-buffered outputs
			out21 <= '1';
			out19 <= '1';
		end if;

		if state_cur(9) = '1' then
			-- Next state
			state_next(8) <= '1';
			-- Next values for buffered outputs
			-- Assignment of non-buffered outputs
			out22 <= '1';
			out21 <= '1';
		end if;

		if state_cur(10) = '1' then
			-- Next state
			state_next(8) <= '1';
			-- Next values for buffered outputs
			-- Assignment of non-buffered outputs
			out23 <= '1';
			out21 <= '1';
		end if;

		if state_cur(11) = '1' then
			-- Next state
			if (in3) = '1' then
				state_next(10) <= '1';
				-- Next values for buffered outputs
			else
				state_next(9) <= '1';
				-- Next values for buffered outputs
			end if;
			-- Assignment of non-buffered outputs
		end if;

		if state_cur(12) = '1' then
			-- Next state
			state_next(11) <= '1';
			-- Next values for buffered outputs
			out17_bufn <= '1';
			-- Assignment of non-buffered outputs
			out27 <= '1';
			out25 <= '1';
		end if;

		if state_cur(13) = '1' then
			-- Next state
			state_next(12) <= '1';
			-- Next values for buffered outputs
			-- Assignment of non-buffered outputs
			out30 <= '1';
		end if;

		-- Info: This is the init/reset state
		if state_cur(14) = '1' then
			-- Next state
			if (not (in4)) = '1' then
				state_next(14) <= '1';
				-- Next values for buffered outputs
			else
				state_next(2) <= '1';
				-- Next values for buffered outputs
			end if;
			-- Assignment of non-buffered outputs
		end if;

		-- Reset input
		if reset = '0' then
			-- Set the reset state
			state_next <= (14 => '1', others => '0');
			-- Note: Resetting all buffers for outputs here is not necessary.
			-- It would cost hardware. They will be reset at the next clock front.
			-- Reset state: set the buffered outputs
		end if;

	end process;

	-- Assignment of buffered outputs

	out17 <= out17_buf;

end architecture;


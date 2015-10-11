library ieee;
use ieee.std_logic_1164.all;

entity top is
	port (
		clock : in  std_logic;
		reset : in  std_logic;
		start : in  std_logic;
		stdout_ack : in  std_logic;
		stdin_ack : in  std_logic;
		stdout_data : out std_logic_vector(7 downto 0);
		stdout_rdy : out std_logic;
		stdin_data : in  std_logic_vector(7 downto 0);
		stdin_rdy : out std_logic
	);
end top;

architecture augh of top is

	-- Declaration of components

	component output is
		port (
			ra0_data : out std_logic_vector(7 downto 0);
			wa0_addr : in  std_logic;
			wa0_en : in  std_logic;
			ra0_addr : in  std_logic;
			wa0_data : in  std_logic_vector(7 downto 0);
			clk : in  std_logic
		);
	end component;

	component input is
		port (
			ra0_data : out std_logic_vector(7 downto 0);
			wa0_addr : in  std_logic_vector(1 downto 0);
			wa0_en : in  std_logic;
			ra0_addr : in  std_logic_vector(1 downto 0);
			wa0_data : in  std_logic_vector(7 downto 0);
			clk : in  std_logic
		);
	end component;

	component cmp_22 is
		port (
			eq : out std_logic;
			in1 : in  std_logic_vector(7 downto 0);
			in0 : in  std_logic_vector(7 downto 0)
		);
	end component;

	component fsm_4 is
		port (
			clock : in  std_logic;
			reset : in  std_logic;
			out11 : out std_logic;
			out13 : out std_logic;
			in2 : in  std_logic;
			out17 : out std_logic;
			out19 : out std_logic;
			out21 : out std_logic;
			out23 : out std_logic;
			out24 : out std_logic;
			in3 : in  std_logic;
			in4 : in  std_logic;
			in1 : in  std_logic;
			out3 : out std_logic;
			out4 : out std_logic;
			out8 : out std_logic;
			out9 : out std_logic;
			in0 : in  std_logic;
			out0 : out std_logic
		);
	end component;

	component add_3 is
		port (
			output : out std_logic_vector(7 downto 0);
			in_a : in  std_logic_vector(7 downto 0);
			in_b : in  std_logic_vector(7 downto 0)
		);
	end component;

	-- Declaration of signals

	signal sig_clock : std_logic;
	signal sig_reset : std_logic;
	signal augh_test_0 : std_logic;
	signal augh_test_1 : std_logic;
	signal sig_23 : std_logic_vector(7 downto 0);
	signal sig_24 : std_logic;
	signal sig_25 : std_logic;
	signal sig_26 : std_logic;
	signal sig_27 : std_logic;
	signal sig_28 : std_logic;
	signal sig_29 : std_logic;
	signal sig_30 : std_logic;
	signal sig_31 : std_logic;
	signal sig_32 : std_logic;
	signal sig_33 : std_logic;
	signal sig_34 : std_logic;
	signal sig_35 : std_logic;
	signal sig_36 : std_logic_vector(7 downto 0);
	signal sig_37 : std_logic_vector(7 downto 0);
	signal sig_38 : std_logic_vector(1 downto 0);
	signal sig_start : std_logic;

	-- Other inlined components

	signal mux_6 : std_logic_vector(2 downto 0);
	signal mux_9 : std_logic_vector(7 downto 0);
	signal mux_13 : std_logic_vector(1 downto 0);
	signal bidon_inter : std_logic_vector(7 downto 0) := (others => '0');
	signal mux_18 : std_logic_vector(7 downto 0);

	-- This utility function is used for inlining MUX behaviour

	-- Little utility function to ease concatenation of an std_logic
	-- and explicitely return an std_logic_vector
	function repeat(N: natural; B: std_logic) return std_logic_vector is
		variable result: std_logic_vector(N-1 downto 0);
	begin
		result := (others => B);
		return result;
	end;

begin

	-- Instantiation of components

	output_i : output port map (
		ra0_data => stdout_data,
		wa0_addr => sig_24,
		wa0_en => sig_34,
		ra0_addr => sig_27,
		wa0_data => mux_18,
		clk => sig_clock
	);

	input_i : input port map (
		ra0_data => sig_36,
		wa0_addr => sig_38,
		wa0_en => sig_26,
		ra0_addr => mux_13,
		wa0_data => stdin_data,
		clk => sig_clock
	);

	cmp_22_i : cmp_22 port map (
		eq => sig_35,
		in1 => sig_36,
		in0 => "00000001"
	);

	fsm_4_i : fsm_4 port map (
		clock => sig_clock,
		reset => sig_reset,
		out11 => sig_34,
		out13 => sig_33,
		in2 => augh_test_1,
		out17 => sig_32,
		out19 => sig_31,
		out21 => sig_30,
		out23 => sig_29,
		out24 => sig_28,
		in3 => augh_test_0,
		in4 => sig_start,
		in1 => stdin_ack,
		out3 => sig_27,
		out4 => sig_26,
		out8 => sig_25,
		out9 => sig_24,
		in0 => stdout_ack,
		out0 => stdout_rdy
	);

	add_3_i : add_3 port map (
		output => sig_23,
		in_a => bidon_inter,
		in_b => sig_37
	);

	-- Behaviour of component 'mux_6' model 'mux'
	mux_6 <=
		(repeat(3, sig_31) and "101") or
		(repeat(3, sig_33) and "001");

	-- Behaviour of component 'mux_9' model 'mux'
	mux_9 <=
		(repeat(8, sig_29) and sig_36) or
		(repeat(8, sig_31) and sig_23);

	-- Behaviour of component 'mux_13' model 'mux'
	mux_13 <=
		(repeat(2, sig_28) and "01") or
		(repeat(2, sig_32) and "11");

	-- Behaviour of component 'mux_18' model 'mux'
	mux_18 <=
		(repeat(8, sig_33) and sig_23) or
		(repeat(8, sig_24) and "10011010");

	-- Behaviour of all components of model 'reg'
	-- Registers with clock = sig_clock and no reset
	process(sig_clock)
	begin
		if rising_edge(sig_clock) then
			if sig_30 = '1' then
				bidon_inter <= mux_9;
			end if;
		end if;
	end process;

	-- Remaining signal assignments
	-- Those who are not assigned by component instantiation

	sig_clock <= clock;
	sig_reset <= reset;
	augh_test_0 <= sig_35;
	augh_test_1 <= sig_35;
	sig_37 <= "00000" & mux_6;
	sig_38 <= '0' & sig_25;
	sig_start <= start;

	-- Remaining top-level ports assignments
	-- Those who are not assigned by component instantiation

	stdin_rdy <= sig_26;

end architecture;

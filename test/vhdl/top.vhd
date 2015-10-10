library ieee;
use ieee.std_logic_1164.all;

entity top is
	port (
		clock : in  std_logic;
		reset : in  std_logic;
		start : in  std_logic;
		stdin_data : in  std_logic_vector(7 downto 0);
		stdout_data : out std_logic_vector(7 downto 0);
		stdout_rdy : out std_logic;
		stdout_ack : in  std_logic;
		stdin_rdy : out std_logic;
		stdin_ack : in  std_logic
	);
end top;

architecture augh of top is

	-- Declaration of components

	component output is
		port (
			wa0_en : in  std_logic;
			ra0_data : out std_logic_vector(7 downto 0);
			ra0_addr : in  std_logic;
			wa0_data : in  std_logic_vector(7 downto 0);
			wa0_addr : in  std_logic;
			clk : in  std_logic
		);
	end component;

	component input is
		port (
			wa0_en : in  std_logic;
			ra0_data : out std_logic_vector(7 downto 0);
			ra0_addr : in  std_logic;
			wa0_data : in  std_logic_vector(7 downto 0);
			wa0_addr : in  std_logic;
			clk : in  std_logic
		);
	end component;

	component mul_4 is
		port (
			output : out std_logic_vector(7 downto 0);
			in_b : in  std_logic_vector(7 downto 0);
			in_a : in  std_logic_vector(7 downto 0)
		);
	end component;

	component mul_5 is
		port (
			output : out std_logic_vector(7 downto 0);
			in_b : in  std_logic_vector(7 downto 0);
			in_a : in  std_logic_vector(7 downto 0)
		);
	end component;

	component add_2 is
		port (
			output : out std_logic_vector(7 downto 0);
			in_b : in  std_logic_vector(7 downto 0);
			in_a : in  std_logic_vector(7 downto 0)
		);
	end component;

	component add_3 is
		port (
			output : out std_logic_vector(7 downto 0);
			in_b : in  std_logic_vector(7 downto 0);
			in_a : in  std_logic_vector(7 downto 0)
		);
	end component;

	component add_1 is
		port (
			output : out std_logic_vector(7 downto 0);
			in_b : in  std_logic_vector(7 downto 0);
			in_a : in  std_logic_vector(7 downto 0)
		);
	end component;

	component fsm_6 is
		port (
			clock : in  std_logic;
			reset : in  std_logic;
			out3 : out std_logic;
			out8 : out std_logic;
			out18 : out std_logic;
			in1 : in  std_logic;
			out19 : out std_logic;
			in2 : in  std_logic;
			in0 : in  std_logic;
			out0 : out std_logic
		);
	end component;

	-- Declaration of signals

	signal sig_clock : std_logic;
	signal sig_reset : std_logic;
	signal sig_28 : std_logic;
	signal sig_29 : std_logic;
	signal sig_30 : std_logic;
	signal sig_31 : std_logic;
	signal sig_32 : std_logic_vector(7 downto 0);
	signal sig_33 : std_logic_vector(7 downto 0);
	signal sig_34 : std_logic_vector(7 downto 0);
	signal sig_35 : std_logic_vector(7 downto 0);
	signal sig_36 : std_logic_vector(7 downto 0);
	signal sig_37 : std_logic_vector(7 downto 0);
	signal sig_38 : std_logic_vector(7 downto 0);
	signal sig_39 : std_logic_vector(7 downto 0);
	signal sig_start : std_logic;

	-- Other inlined components

	signal mux_11 : std_logic_vector(7 downto 0);
	signal mux_12 : std_logic_vector(7 downto 0);
	signal mux_15 : std_logic_vector(7 downto 0);
	signal mux_16 : std_logic_vector(7 downto 0);
	signal mux_23 : std_logic_vector(7 downto 0);

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
		wa0_en => sig_29,
		ra0_data => sig_38,
		ra0_addr => '0',
		wa0_data => mux_23,
		wa0_addr => '0',
		clk => sig_clock
	);

	input_i : input port map (
		wa0_en => sig_31,
		ra0_data => sig_37,
		ra0_addr => '0',
		wa0_data => stdin_data,
		wa0_addr => '0',
		clk => sig_clock
	);

	mul_4_i : mul_4 port map (
		output => sig_36,
		in_b => mux_15,
		in_a => mux_16
	);

	mul_5_i : mul_5 port map (
		output => sig_35,
		in_b => "00000111",
		in_a => sig_39
	);

	add_2_i : add_2 port map (
		output => sig_34,
		in_b => mux_11,
		in_a => mux_12
	);

	add_3_i : add_3 port map (
		output => sig_33,
		in_b => sig_36,
		in_a => sig_38
	);

	add_1_i : add_1 port map (
		output => sig_32,
		in_b => sig_34,
		in_a => sig_37
	);

	fsm_6_i : fsm_6 port map (
		clock => sig_clock,
		reset => sig_reset,
		out3 => sig_31,
		out8 => sig_30,
		out18 => sig_29,
		in1 => stdin_ack,
		out19 => sig_28,
		in2 => sig_start,
		in0 => stdout_ack,
		out0 => stdout_rdy
	);

	-- Behaviour of component 'mux_11' model 'mux'
	mux_11 <=
		(repeat(8, sig_28) and "000" & sig_37(4 downto 0)) or
		(repeat(8, sig_30) and "11111101");

	-- Behaviour of component 'mux_12' model 'mux'
	mux_12 <=
		(repeat(8, sig_28) and "000" & sig_36(4 downto 0)) or
		(repeat(8, sig_30) and sig_37);

	-- Behaviour of component 'mux_15' model 'mux'
	mux_15 <=
		(repeat(8, sig_28) and "00000011") or
		(repeat(8, sig_30) and sig_37);

	-- Behaviour of component 'mux_16' model 'mux'
	mux_16 <=
		(repeat(8, sig_28) and "000" & sig_37(4 downto 0)) or
		(repeat(8, sig_30) and sig_32);

	-- Behaviour of component 'mux_23' model 'mux'
	mux_23 <=
		(repeat(8, sig_28) and sig_35(4 downto 0) & "000") or
		(repeat(8, sig_30) and sig_33);

	-- Remaining signal assignments
	-- Those who are not assigned by component instantiation

	sig_clock <= clock;
	sig_reset <= reset;
	sig_39 <= "000" & sig_34(4 downto 0);
	sig_start <= start;

	-- Remaining top-level ports assignments
	-- Those who are not assigned by component instantiation

	stdout_data <= sig_38;
	stdin_rdy <= sig_31;

end architecture;

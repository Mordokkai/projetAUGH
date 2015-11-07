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
			wa0_addr : in  std_logic;
			wa0_en : in  std_logic;
			ra0_addr : in  std_logic;
			wa0_data : in  std_logic_vector(7 downto 0);
			ra0_data : out std_logic_vector(7 downto 0);
			clk : in  std_logic
		);
	end component;

	component input is
		port (
			ra1_data : out std_logic_vector(7 downto 0);
			ra1_addr : in  std_logic_vector(1 downto 0);
			wa0_addr : in  std_logic_vector(1 downto 0);
			wa0_en : in  std_logic;
			ra0_addr : in  std_logic_vector(1 downto 0);
			wa0_data : in  std_logic_vector(7 downto 0);
			ra0_data : out std_logic_vector(7 downto 0);
			ra2_data : out std_logic_vector(7 downto 0);
			ra2_addr : in  std_logic_vector(1 downto 0);
			clk : in  std_logic
		);
	end component;

	component add_1 is
		port (
			output : out std_logic_vector(7 downto 0);
			in_a : in  std_logic_vector(7 downto 0);
			in_b : in  std_logic_vector(7 downto 0)
		);
	end component;

	component sub_2 is
		port (
			output : out std_logic_vector(7 downto 0);
			in_a : in  std_logic_vector(7 downto 0);
			in_b : in  std_logic_vector(7 downto 0)
		);
	end component;

	component mul_3 is
		port (
			output : out std_logic_vector(7 downto 0);
			in_a : in  std_logic_vector(7 downto 0);
			in_b : in  std_logic_vector(7 downto 0)
		);
	end component;

	component fsm_4 is
		port (
			clock : in  std_logic;
			reset : in  std_logic;
			out0 : out std_logic;
			in1 : in  std_logic;
			out3 : out std_logic;
			out4 : out std_logic;
			out8 : out std_logic;
			in2 : in  std_logic;
			out9 : out std_logic;
			out13 : out std_logic;
			out19 : out std_logic;
			out22 : out std_logic;
			in0 : in  std_logic
		);
	end component;

	-- Declaration of signals

	signal sig_clock : std_logic;
	signal sig_reset : std_logic;
	signal sig_25 : std_logic;
	signal sig_26 : std_logic;
	signal sig_27 : std_logic;
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
	signal sig_start : std_logic;

	-- Other inlined components

	signal mux_21 : std_logic_vector(7 downto 0);
	signal mux_13 : std_logic_vector(1 downto 0);
	signal mux_5 : std_logic_vector(7 downto 0);

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
		wa0_addr => sig_27,
		wa0_en => sig_26,
		ra0_addr => sig_31,
		wa0_data => mux_21,
		ra0_data => stdout_data,
		clk => sig_clock
	);

	input_i : input port map (
		ra1_data => sig_37,
		ra1_addr => "01",
		wa0_addr => mux_13,
		wa0_en => sig_30,
		ra0_addr => "10",
		wa0_data => stdin_data,
		ra0_data => sig_36,
		ra2_data => sig_35,
		ra2_addr => "00",
		clk => sig_clock
	);

	add_1_i : add_1 port map (
		output => sig_34,
		in_a => sig_35,
		in_b => sig_37
	);

	sub_2_i : sub_2 port map (
		output => sig_33,
		in_a => sig_35,
		in_b => sig_32
	);

	mul_3_i : mul_3 port map (
		output => sig_32,
		in_a => mux_5,
		in_b => sig_36
	);

	fsm_4_i : fsm_4 port map (
		clock => sig_clock,
		reset => sig_reset,
		out0 => stdout_rdy,
		in1 => stdin_ack,
		out3 => sig_31,
		out4 => sig_30,
		out8 => sig_29,
		in2 => sig_start,
		out9 => sig_28,
		out13 => sig_27,
		out19 => sig_26,
		out22 => sig_25,
		in0 => stdout_ack
	);

	-- Behaviour of component 'mux_21' model 'mux'
	mux_21 <=
		(repeat(8, sig_25) and sig_32) or
		(repeat(8, sig_27) and sig_33);

	-- Behaviour of component 'mux_13' model 'mux'
	mux_13 <=
		(repeat(2, sig_29) and "01") or
		(repeat(2, sig_28) and "10");

	-- Behaviour of component 'mux_5' model 'mux'
	mux_5 <=
		(repeat(8, sig_25) and sig_34) or
		(repeat(8, sig_27) and sig_37);

	-- Remaining signal assignments
	-- Those who are not assigned by component instantiation

	sig_clock <= clock;
	sig_reset <= reset;
	sig_start <= start;

	-- Remaining top-level ports assignments
	-- Those who are not assigned by component instantiation

	stdin_rdy <= sig_30;

end architecture;

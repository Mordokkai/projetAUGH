library ieee;
use ieee.std_logic_1164.all;

entity top is
	port (
		clock : in  std_logic;
		reset : in  std_logic;
		start : in  std_logic;
		stdout_data : out std_logic_vector(7 downto 0);
		stdout_rdy : out std_logic;
		stdout_ack : in  std_logic;
		stdin_data : in  std_logic_vector(7 downto 0);
		stdin_rdy : out std_logic;
		stdin_ack : in  std_logic
	);
end top;

architecture augh of top is

	-- Declaration of components

	component output is
		port (
			wa0_en : in  std_logic;
			wa0_data : in  std_logic_vector(7 downto 0);
			wa0_addr : in  std_logic;
			ra0_data : out std_logic_vector(7 downto 0);
			ra0_addr : in  std_logic;
			clk : in  std_logic
		);
	end component;

	component input is
		port (
			wa0_en : in  std_logic;
			wa0_data : in  std_logic_vector(7 downto 0);
			wa0_addr : in  std_logic;
			ra0_data : out std_logic_vector(7 downto 0);
			ra0_addr : in  std_logic;
			clk : in  std_logic
		);
	end component;

	component mul_2 is
		port (
			output : out std_logic_vector(7 downto 0);
			in_b : in  std_logic_vector(7 downto 0);
			in_a : in  std_logic_vector(7 downto 0)
		);
	end component;

	component mul_3 is
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

	component fsm_4 is
		port (
			clock : in  std_logic;
			reset : in  std_logic;
			out8 : out std_logic;
			out14 : out std_logic;
			in1 : in  std_logic;
			out15 : out std_logic;
			in2 : in  std_logic;
			in0 : in  std_logic;
			out0 : out std_logic;
			out3 : out std_logic
		);
	end component;

	-- Declaration of signals

	signal sig_clock : std_logic;
	signal sig_reset : std_logic;
	signal sig_22 : std_logic;
	signal sig_23 : std_logic;
	signal sig_24 : std_logic;
	signal sig_25 : std_logic;
	signal sig_26 : std_logic_vector(7 downto 0);
	signal sig_27 : std_logic_vector(7 downto 0);
	signal sig_28 : std_logic_vector(7 downto 0);
	signal sig_29 : std_logic_vector(7 downto 0);
	signal sig_30 : std_logic_vector(7 downto 0);
	signal sig_31 : std_logic_vector(7 downto 0);
	signal sig_start : std_logic;

	-- Other inlined components

	signal mux_6 : std_logic_vector(7 downto 0);
	signal mux_9 : std_logic_vector(7 downto 0);
	signal mux_10 : std_logic_vector(7 downto 0);
	signal mux_5 : std_logic_vector(7 downto 0);
	signal mux_16 : std_logic_vector(7 downto 0);

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
		wa0_en => sig_24,
		wa0_data => mux_16,
		wa0_addr => '0',
		ra0_data => sig_30,
		ra0_addr => '0',
		clk => sig_clock
	);

	input_i : input port map (
		wa0_en => sig_22,
		wa0_data => stdin_data,
		wa0_addr => '0',
		ra0_data => sig_29,
		ra0_addr => '0',
		clk => sig_clock
	);

	mul_2_i : mul_2 port map (
		output => sig_28,
		in_b => mux_9,
		in_a => mux_10
	);

	mul_3_i : mul_3 port map (
		output => sig_27,
		in_b => "00000111",
		in_a => sig_31
	);

	add_1_i : add_1 port map (
		output => sig_26,
		in_b => mux_5,
		in_a => mux_6
	);

	fsm_4_i : fsm_4 port map (
		clock => sig_clock,
		reset => sig_reset,
		out8 => sig_25,
		out14 => sig_24,
		in1 => stdin_ack,
		out15 => sig_23,
		in2 => sig_start,
		in0 => stdout_ack,
		out0 => stdout_rdy,
		out3 => sig_22
	);

	-- Behaviour of component 'mux_6' model 'mux'
	mux_6 <=
		(repeat(8, sig_23) and "000" & sig_28(4 downto 0)) or
		(repeat(8, sig_25) and sig_30);

	-- Behaviour of component 'mux_9' model 'mux'
	mux_9 <=
		(repeat(8, sig_23) and "00000011") or
		(repeat(8, sig_25) and sig_29);

	-- Behaviour of component 'mux_10' model 'mux'
	mux_10 <=
		(repeat(8, sig_23) and "000" & sig_29(4 downto 0)) or
		(repeat(8, sig_25) and sig_29);

	-- Behaviour of component 'mux_5' model 'mux'
	mux_5 <=
		(repeat(8, sig_23) and "000" & sig_29(4 downto 0)) or
		(repeat(8, sig_25) and sig_28);

	-- Behaviour of component 'mux_16' model 'mux'
	mux_16 <=
		(repeat(8, sig_23) and sig_27(4 downto 0) & "000") or
		(repeat(8, sig_25) and sig_26);

	-- Remaining signal assignments
	-- Those who are not assigned by component instantiation

	sig_clock <= clock;
	sig_reset <= reset;
	sig_31 <= "000" & sig_26(4 downto 0);
	sig_start <= start;

	-- Remaining top-level ports assignments
	-- Those who are not assigned by component instantiation

	stdout_data <= sig_30;
	stdin_rdy <= sig_22;

end architecture;

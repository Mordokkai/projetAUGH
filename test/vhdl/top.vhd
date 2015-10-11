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

	component fsm_4 is
		port (
			clock : in  std_logic;
			reset : in  std_logic;
			in1 : in  std_logic;
			out3 : out std_logic;
			out4 : out std_logic;
			out8 : out std_logic;
			out9 : out std_logic;
			out11 : out std_logic;
			out12 : out std_logic;
			in2 : in  std_logic;
			in3 : in  std_logic;
			in0 : in  std_logic;
			out0 : out std_logic
		);
	end component;

	component cmp_17 is
		port (
			eq : out std_logic;
			in1 : in  std_logic_vector(7 downto 0);
			in0 : in  std_logic_vector(7 downto 0)
		);
	end component;

	-- Declaration of signals

	signal sig_clock : std_logic;
	signal sig_reset : std_logic;
	signal augh_test_1 : std_logic;
	signal sig_20 : std_logic;
	signal sig_21 : std_logic;
	signal sig_22 : std_logic;
	signal sig_23 : std_logic;
	signal sig_24 : std_logic_vector(7 downto 0);
	signal sig_25 : std_logic_vector(1 downto 0);
	signal sig_18 : std_logic;
	signal sig_19 : std_logic;
	signal sig_start : std_logic;

	-- Other inlined components

	signal mux_13 : std_logic_vector(7 downto 0);

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
		wa0_addr => sig_20,
		wa0_en => sig_19,
		ra0_addr => sig_23,
		wa0_data => mux_13,
		clk => sig_clock
	);

	input_i : input port map (
		ra0_data => sig_24,
		wa0_addr => sig_25,
		wa0_en => sig_22,
		ra0_addr => "11",
		wa0_data => stdin_data,
		clk => sig_clock
	);

	fsm_4_i : fsm_4 port map (
		clock => sig_clock,
		reset => sig_reset,
		in1 => stdin_ack,
		out3 => sig_23,
		out4 => sig_22,
		out8 => sig_21,
		out9 => sig_20,
		out11 => sig_19,
		out12 => sig_18,
		in2 => augh_test_1,
		in3 => sig_start,
		in0 => stdout_ack,
		out0 => stdout_rdy
	);

	cmp_17_i : cmp_17 port map (
		eq => augh_test_1,
		in1 => sig_24,
		in0 => "00000001"
	);

	-- Behaviour of component 'mux_13' model 'mux'
	mux_13 <=
		(repeat(8, sig_18) and "00000001") or
		(repeat(8, sig_20) and "10011010");

	-- Remaining signal assignments
	-- Those who are not assigned by component instantiation

	sig_clock <= clock;
	sig_reset <= reset;
	sig_25 <= '0' & sig_21;
	sig_start <= start;

	-- Remaining top-level ports assignments
	-- Those who are not assigned by component instantiation

	stdin_rdy <= sig_22;

end architecture;

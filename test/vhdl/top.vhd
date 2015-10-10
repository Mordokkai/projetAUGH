library ieee;
use ieee.std_logic_1164.all;

entity top is
	port (
		clock : in  std_logic;
		reset : in  std_logic;
		start : in  std_logic;
		stdin_ack : in  std_logic;
		stdout_data : out std_logic_vector(7 downto 0);
		stdout_rdy : out std_logic;
		stdout_ack : in  std_logic;
		stdin_data : in  std_logic_vector(7 downto 0);
		stdin_rdy : out std_logic
	);
end top;

architecture augh of top is

	-- Declaration of components

	component output is
		port (
			ra0_addr : in  std_logic;
			wa0_data : in  std_logic_vector(7 downto 0);
			wa0_addr : in  std_logic;
			wa0_en : in  std_logic;
			ra0_data : out std_logic_vector(7 downto 0);
			clk : in  std_logic
		);
	end component;

	component input is
		port (
			ra0_addr : in  std_logic;
			wa0_data : in  std_logic_vector(7 downto 0);
			wa0_addr : in  std_logic;
			wa0_en : in  std_logic;
			ra0_data : out std_logic_vector(7 downto 0);
			clk : in  std_logic
		);
	end component;

	component mul_4 is
		port (
			output : out std_logic_vector(11 downto 0);
			in_a : in  std_logic_vector(9 downto 0);
			in_b : in  std_logic_vector(3 downto 0)
		);
	end component;

	component add_2 is
		port (
			output : out std_logic_vector(7 downto 0);
			in_a : in  std_logic_vector(7 downto 0);
			in_b : in  std_logic_vector(7 downto 0)
		);
	end component;

	component add_1 is
		port (
			output : out std_logic_vector(7 downto 0);
			in_a : in  std_logic_vector(7 downto 0);
			in_b : in  std_logic_vector(7 downto 0)
		);
	end component;

	component fsm_5 is
		port (
			clock : in  std_logic;
			reset : in  std_logic;
			in0 : in  std_logic;
			out0 : out std_logic;
			in1 : in  std_logic;
			out3 : out std_logic;
			out4 : out std_logic;
			out8 : out std_logic;
			out9 : out std_logic;
			out18 : out std_logic;
			out20 : out std_logic;
			in2 : in  std_logic
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
	signal sig_31 : std_logic_vector(7 downto 0);
	signal sig_32 : std_logic_vector(7 downto 0);
	signal sig_33 : std_logic_vector(11 downto 0);
	signal sig_34 : std_logic_vector(7 downto 0);
	signal sig_35 : std_logic_vector(7 downto 0);
	signal sig_36 : std_logic_vector(7 downto 0);
	signal sig_37 : std_logic_vector(9 downto 0);
	signal sig_start : std_logic;

	-- Other inlined components

	signal mux_6 : std_logic_vector(7 downto 0);
	signal mux_7 : std_logic_vector(2 downto 0);
	signal mux_8 : std_logic_vector(7 downto 0);
	signal mux_9 : std_logic_vector(1 downto 0);
	signal mux_10 : std_logic_vector(7 downto 0);
	signal mux_19 : std_logic_vector(7 downto 0);

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
		ra0_addr => sig_30,
		wa0_data => mux_19,
		wa0_addr => sig_27,
		wa0_en => sig_26,
		ra0_data => stdout_data,
		clk => sig_clock
	);

	input_i : input port map (
		ra0_addr => sig_27,
		wa0_data => stdin_data,
		wa0_addr => sig_28,
		wa0_en => sig_29,
		ra0_data => sig_34,
		clk => sig_clock
	);

	mul_4_i : mul_4 port map (
		output => sig_33,
		in_a => sig_37,
		in_b => "0101"
	);

	add_2_i : add_2 port map (
		output => sig_32,
		in_a => mux_8,
		in_b => sig_36
	);

	add_1_i : add_1 port map (
		output => sig_31,
		in_a => mux_6,
		in_b => sig_35
	);

	fsm_5_i : fsm_5 port map (
		clock => sig_clock,
		reset => sig_reset,
		in0 => stdout_ack,
		out0 => stdout_rdy,
		in1 => stdin_ack,
		out3 => sig_30,
		out4 => sig_29,
		out8 => sig_28,
		out9 => sig_27,
		out18 => sig_26,
		out20 => sig_25,
		in2 => sig_start
	);

	-- Behaviour of component 'mux_6' model 'mux'
	mux_6 <=
		(repeat(8, sig_27) and sig_33(7 downto 0)) or
		(repeat(8, sig_25) and '0' & sig_33(7 downto 1));

	-- Behaviour of component 'mux_7' model 'mux'
	mux_7 <=
		(repeat(3, sig_27) and "111") or
		(repeat(3, sig_25) and "001");

	-- Behaviour of component 'mux_8' model 'mux'
	mux_8 <=
		(repeat(8, sig_27) and "00" & sig_34(7 downto 2)) or
		(repeat(8, sig_25) and sig_34);

	-- Behaviour of component 'mux_9' model 'mux'
	mux_9 <=
		(repeat(2, sig_27) and "01") or
		(repeat(2, sig_25) and "11");

	-- Behaviour of component 'mux_10' model 'mux'
	mux_10 <=
		(repeat(8, sig_27) and sig_32(5 downto 0) & sig_34(1 downto 0)) or
		(repeat(8, sig_25) and sig_32);

	-- Behaviour of component 'mux_19' model 'mux'
	mux_19 <=
		(repeat(8, sig_27) and sig_31) or
		(repeat(8, sig_25) and sig_31(6 downto 0) & sig_32(0));

	-- Remaining signal assignments
	-- Those who are not assigned by component instantiation

	sig_clock <= clock;
	sig_reset <= reset;
	sig_35 <= "00000" & mux_7;
	sig_36 <= "000000" & mux_9;
	sig_37 <= "00" & mux_10;
	sig_start <= start;

	-- Remaining top-level ports assignments
	-- Those who are not assigned by component instantiation

	stdin_rdy <= sig_29;

end architecture;

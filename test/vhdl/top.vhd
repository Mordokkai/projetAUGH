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
			wa0_addr : in  std_logic_vector(1 downto 0);
			wa0_en : in  std_logic;
			ra0_addr : in  std_logic_vector(1 downto 0);
			wa0_data : in  std_logic_vector(7 downto 0);
			ra0_data : out std_logic_vector(7 downto 0);
			clk : in  std_logic
		);
	end component;

	component add_4 is
		port (
			output : out std_logic_vector(31 downto 0);
			in_a : in  std_logic_vector(31 downto 0);
			in_b : in  std_logic_vector(31 downto 0)
		);
	end component;

	component cmp_30 is
		port (
			eq : out std_logic;
			in0 : in  std_logic_vector(7 downto 0);
			in1 : in  std_logic_vector(7 downto 0)
		);
	end component;

	component sub_5 is
		port (
			le : out std_logic;
			output : out std_logic_vector(31 downto 0);
			in_a : in  std_logic_vector(31 downto 0);
			in_b : in  std_logic_vector(31 downto 0);
			sign : in  std_logic
		);
	end component;

	component fsm_6 is
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
	end component;

	-- Declaration of signals

	signal sig_clock : std_logic;
	signal sig_reset : std_logic;
	signal sig_31 : std_logic;
	signal sig_32 : std_logic;
	signal sig_33 : std_logic;
	signal sig_34 : std_logic;
	signal sig_35 : std_logic;
	signal sig_36 : std_logic;
	signal sig_37 : std_logic;
	signal sig_38 : std_logic;
	signal sig_39 : std_logic;
	signal sig_40 : std_logic;
	signal sig_41 : std_logic_vector(31 downto 0);
	signal sig_42 : std_logic;
	signal sig_43 : std_logic_vector(31 downto 0);
	signal sig_44 : std_logic_vector(7 downto 0);
	signal augh_test_0 : std_logic;
	signal augh_test_1 : std_logic;
	signal augh_test_2 : std_logic;
	signal sig_start : std_logic;

	-- Other inlined components

	signal mux_11 : std_logic_vector(31 downto 0);
	signal bidon_inter : std_logic_vector(7 downto 0) := (others => '0');
	signal mux_21 : std_logic_vector(1 downto 0);
	signal mux_26 : std_logic_vector(7 downto 0);
	signal augh_main_k : std_logic_vector(31 downto 0) := (others => '0');

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
		wa0_addr => '0',
		wa0_en => sig_36,
		ra0_addr => '0',
		wa0_data => mux_26,
		ra0_data => stdout_data,
		clk => sig_clock
	);

	input_i : input port map (
		wa0_addr => augh_main_k(1 downto 0),
		wa0_en => sig_38,
		ra0_addr => mux_21,
		wa0_data => stdin_data,
		ra0_data => sig_44,
		clk => sig_clock
	);

	add_4_i : add_4 port map (
		output => sig_43,
		in_a => augh_main_k,
		in_b => "00000000000000000000000000000001"
	);

	cmp_30_i : cmp_30 port map (
		eq => sig_42,
		in0 => "00000000",
		in1 => sig_44
	);

	sub_5_i : sub_5 port map (
		le => augh_test_2,
		output => sig_41,
		in_a => augh_main_k,
		in_b => "00000000000000000000000000000011",
		sign => '0'
	);

	fsm_6_i : fsm_6 port map (
		clock => sig_clock,
		reset => sig_reset,
		out9 => sig_40,
		out10 => sig_39,
		in0 => stdout_ack,
		out0 => stdout_rdy,
		out3 => sig_38,
		in1 => stdin_ack,
		out16 => sig_37,
		out18 => sig_36,
		out20 => sig_35,
		out21 => sig_34,
		in2 => augh_test_2,
		out23 => sig_33,
		out25 => sig_32,
		in3 => augh_test_1,
		out26 => sig_31,
		in4 => augh_test_0,
		in5 => sig_start
	);

	-- Behaviour of component 'mux_11' model 'mux'
	mux_11 <=
		(repeat(32, sig_40) and sig_43);

	-- Behaviour of component 'mux_21' model 'mux'
	mux_21 <=
		(repeat(2, sig_34) and "11") or
		(repeat(2, sig_33) and "10") or
		(repeat(2, sig_31) and "01");

	-- Behaviour of component 'mux_26' model 'mux'
	mux_26 <=
		(repeat(8, sig_37) and bidon_inter) or
		(repeat(8, sig_35) and sig_44);

	-- Behaviour of all components of model 'reg'
	-- Registers with clock = sig_clock and no reset
	process(sig_clock)
	begin
		if rising_edge(sig_clock) then
			if sig_32 = '1' then
				bidon_inter <= sig_44;
			end if;
			if sig_39 = '1' then
				augh_main_k <= mux_11;
			end if;
		end if;
	end process;

	-- Remaining signal assignments
	-- Those who are not assigned by component instantiation

	sig_clock <= clock;
	sig_reset <= reset;
	augh_test_0 <= sig_42;
	augh_test_1 <= sig_42;
	sig_start <= start;

	-- Remaining top-level ports assignments
	-- Those who are not assigned by component instantiation

	stdin_rdy <= sig_38;

end architecture;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:24:24 06/29/2019 
-- Design Name: 
-- Module Name:    Parallel_FFT - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;
use std.textio.all;
use work.fft_package.all;
library ieee_proposed;
use ieee_proposed.float_pkg.all; 


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Parallel_FFT is
port ( x: in signed_vector;
		 debug1 : out comp_array;
		 debug2 : out comp_array;
		 debug3 : out comp_array;
		 debug4 : out comp_array;
		 debug5 : out comp_array;
		 y : out comp_array);

end Parallel_FFT;

architecture Behavioral of Parallel_FFT is

component real_input_to_complex is

port ( input_real : in signed_vector;
		 input_comp : out comp_array);

end component;		


component butterfly is

port(
		c1,c2 : complex; --inputs
		w : complex;		--phase factor
		g1,g2 : out complex --outputs
		);
 
end component;

signal tmp : float (8 downto -23);

signal w : comp_array2 :=(

(1.0,0.0),
(0.7071,-0.7071),
(0.0,-1.0),
(-0.7071,-0.7071)
);


signal s, g1, g2, g3, g4, g5: comp_array := ( others => ((0.0),(0.0)));

begin

--Real input value transformed in complex value

sixteen_bits_complex_transform : real_input_to_complex port map(x, s);

--first stage of butterfly's.
bf11 : butterfly port map(s(0),s(4),w(0),g1(0),g1(1));
bf12 : butterfly port map(s(2),s(6),w(0),g1(2),g1(3));
bf13 : butterfly port map(s(1),s(5),w(0),g1(4),g1(5));
bf14 : butterfly port map(s(3),s(7),w(0),g1(6),g1(7));


debug1<=g1;

--second stage of butterfly's.

bf21 : butterfly port map(g1(0),g1(2),w(0),g2(0),g2(2));
bf22 : butterfly port map(g1(1),g1(3),w(2),g2(1),g2(3));
bf23 : butterfly port map(g1(4),g1(6),w(0),g2(4),g2(6));
bf24 : butterfly port map(g1(5),g1(7),w(2),g2(5),g2(7));

debug2<=g2;

--third stage of butterfly's.

bf31 : butterfly port map(g2(0),g2(4),w(0),y(0),y(4));
bf32 : butterfly port map(g2(1),g2(5),w(1),y(1),y(5));
bf33 : butterfly port map(g2(2),g2(6),w(2),y(2),y(6));
bf34 : butterfly port map(g2(3),g2(7),w(3),y(3),y(7));

debug3<=g3;


end Behavioral;


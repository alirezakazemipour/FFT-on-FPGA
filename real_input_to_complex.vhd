----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:24:48 06/29/2019 
-- Design Name: 
-- Module Name:    real_input_to_complex - Behavioral 
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
--use IEEE.STD_LOGIC_SIGNED.all;
--use IEEE.STD_LOGIC_ARITH.all;
use work.fft_package.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
library ieee_proposed;
use ieee_proposed.float_pkg.all; 

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity real_input_to_complex is

port ( input_real : in signed_vector;
		 input_comp : out comp_array);

end real_input_to_complex;

architecture Behavioral of real_input_to_complex is

component sig_ext_8_to_16_bits is 
port ( sig_in : in real;
		 sig_out : out complex);
		 
end component;

begin

--input0 : sig_ext_8_to_16_bits port map ( input_real(0), input_comp(0));
--input1 : sig_ext_8_to_16_bits port map ( input_real(1), input_comp(1));
--input2 : sig_ext_8_to_16_bits port map ( input_real(2), input_comp(2));
--input3 : sig_ext_8_to_16_bits port map ( input_real(3), input_comp(3));
--input4 : sig_ext_8_to_16_bits port map ( input_real(4), input_comp(4));
--input5 : sig_ext_8_to_16_bits port map ( input_real(5), input_comp(5));
--input6 : sig_ext_8_to_16_bits port map ( input_real(6), input_comp(6));
--input7 : sig_ext_8_to_16_bits port map ( input_real(7), input_comp(7));
--input8 : sig_ext_8_to_16_bits port map ( input_real(8), input_comp(8));
--input9 : sig_ext_8_to_16_bits port map ( input_real(9), input_comp(9));
--input10 : sig_ext_8_to_16_bits port map ( input_real(10), input_comp(10));
--input11 : sig_ext_8_to_16_bits port map ( input_real(11), input_comp(11));
--input12 : sig_ext_8_to_16_bits port map ( input_real(12), input_comp(12));
--input13 : sig_ext_8_to_16_bits port map ( input_real(13), input_comp(13));
--input14 : sig_ext_8_to_16_bits port map ( input_real(14), input_comp(14));
--input15 : sig_ext_8_to_16_bits port map ( input_real(15), input_comp(15));

toComplex: for i in 0 to 7 generate

inputi:sig_ext_8_to_16_bits port map ( input_real(i), input_comp(i));
end generate;

--







end Behavioral;


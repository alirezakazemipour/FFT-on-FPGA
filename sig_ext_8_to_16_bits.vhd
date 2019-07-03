----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:34:26 06/29/2019 
-- Design Name: 
-- Module Name:    sig_ext_8_to_16_bits - Behavioral 
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
use work.fft_package.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sig_ext_8_to_16_bits is

port ( sig_in : in signed(7 downto 0);
		 sig_out : out complex );

end sig_ext_8_to_16_bits;

architecture Behavioral of sig_ext_8_to_16_bits is

signal sig_out_real : signed(15 downto 0);


begin


sig_out_real <= X"00" & sig_in when sig_in(7) = '0' else
X"FF" & sig_in ;

sig_out <= (conv_std_logic_vector(sig_out_real,16) , X"0000");

end Behavioral;


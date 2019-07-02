--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;
--use IEEE.numeric_std.all;

package fft_package is

 type complex is
  record
    r        : std_logic_vector( 15 downto 0);
    i        : std_logic_vector( 15 downto 0);
 end record;

type signed_vector is array ( 0 to 15) of signed(7 downto 0);

type comp_array is array ( 0 to 15 ) of complex ;


function add (signal n1,n2 : in complex) return complex;
function sub (signal n1,n2 : in complex) return complex;
function mult (signal n1,n2 : in complex) return complex;

end fft_package;

package body fft_package is

-- Addition of complex numbers 
  function add (signal n1,n2 : in complex ) return complex is
    variable sum : complex;
  begin
  
  sum.r := n1.r + n2.r;
  sum.i := n1.i + n2.i;

    return sum; 
  end add;

---- Substraction of complex numbers
function sub (signal n1,n2 : in complex ) return complex is
    variable diff : complex;
  begin
  
  diff.r := n1.r - n2.r;
  diff.i := n1.i - n2.i;

    return diff; 
  end sub;

---- Multiplication of complex numbers
function mult (signal n1,n2 : in complex ) return complex is
    variable prod : complex;
	 variable prod_aux_r1 : signed(31 downto 0);
	 variable prod_aux_i1 : signed(31 downto 0);
	 variable prod_aux_r2 : signed(31 downto 0);
	 variable prod_aux_i2 : signed(31 downto 0);
	 variable prod_aux_r : signed(31 downto 0);
	 variable prod_aux_i : signed(31 downto 0);
	 
	 
  begin
  
  
   -- prod_aux_r1 :=	signed(n1.r * n2.r);
	-- prod_aux_r2 :=	signed(n1.i * n2.i);
	-- prod_aux_r := 	(prod_aux_r1 - prod_aux_r2);
	 prod_aux_r := (signed(n1.r * n2.r) - signed(n1.i * n2.i));
	 prod.r := conv_std_logic_vector(prod_aux_r(29 downto 14),16);
	 
	 prod_aux_i1 :=	signed(n1.r * n2.i);
	 prod_aux_i2 :=	signed(n1.i * n2.r);
	 prod_aux_i := (prod_aux_i1 + prod_aux_i2) ;
	 prod.i := conv_std_logic_vector(prod_aux_i(29 downto 14),16);


    return prod; 
  end mult;

 
end fft_package;

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
use std.textio.all;
use ieee.std_logic_textio.all;
--use IEEE.numeric_std.all;

package fft_package is

 type complex is
  record
    r        : std_logic_vector( 31 downto 0);
    i        : std_logic_vector( 31 downto 0);
 end record;

type signed_vector is array ( 0 to 63) of signed(7 downto 0); --TODO make 63 generic
type comp_array is array ( 0 to 63 ) of complex ;
type comp_array2 is array ( 0 to 31 ) of complex ;
--type Ram_Type is array(0 to 31) of complex;


function add (signal n1,n2 : in complex) return complex;
function sub (signal n1,n2 : in complex) return complex;
function mult (signal n1,n2 : in complex) return complex;
--function Init_TFs(FileName : in string) return Ram_Type ;

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
	 variable prod_aux_i1 : signed(63 downto 0);
	 variable prod_aux_i2 : signed(63 downto 0);
	 variable prod_aux_r : signed(63 downto 0);
	 variable prod_aux_i : signed(63 downto 0);
	 
	 
  begin
  
	 prod_aux_r := (signed(n1.r * n2.r) - signed(n1.i * n2.i));
	 prod.r := conv_std_logic_vector(prod_aux_r(61 downto 31),32);
	 
	 prod_aux_i1 :=	signed(n1.r * n2.i);
	 prod_aux_i2 :=	signed(n1.i * n2.r);
	 prod_aux_i := (prod_aux_i1 + prod_aux_i2) ;
	 prod.i := conv_std_logic_vector(prod_aux_i(61 downto 31),32);


    return prod; 
  end mult;
  
--function Init_TFs(FileName : in string) return Ram_Type is
--
--	File file1 : text is in FileName; 
--	
--	variable line1 : line; 
--	variable RAM1 : Ram_Type; 
--	
--	begin
--	for i in Ram_Type'range loop
--	readline (file1, line1); 
--	read (line1, RAM1(i));
--	
--	end loop; 
--	return RAM1; 
--	end function;
  

 
end fft_package;

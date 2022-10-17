with System;

package Kernel is

   Elaborated_Value : Float := 0.0;

   type Float_Array is array (Integer range <>) of Float;

   type Access_Host_Float_Array is access all Float_Array;

   procedure Vector_Add
     (A_Addr : System.Address;
      B_Addr : System.Address;
      C_Addr : System.Address;
      Num_Elements : Integer)
     with CUDA_Global;

end Kernel;

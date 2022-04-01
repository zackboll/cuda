------------------------------------------------------------------------------
--                       Copyright (C) 2017, AdaCore                        --
-- This is free software;  you can redistribute it  and/or modify it  under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  This software is distributed in the hope  that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public --
-- License for  more details.  You should have  received  a copy of the GNU --
-- General  Public  License  distributed  with  this  software;   see  file --
-- COPYING3.  If not, go to http://www.gnu.org/licenses for a complete copy --
-- of the license.                                                          --
------------------------------------------------------------------------------

With System;

Package Bilateral_Kernel Is

    Procedure Bilateral (Img_Addr          : System.Address; 
                         Filtered_Img_Addr : System.Address;
                         Width             : Integer;
                         Height            : Integer;
                         Spatial_Stdev     : Float;
                         Color_Dist_Stdev  : Float;
                         I                 : Integer;
                         J                 : Integer);


    Procedure Bilateral_Cuda (Device_Img          : System.Address; 
                              Device_Filtered_Img : System.Address;
                              Width               : Integer;
                              Height              : Integer;
                              Spatial_Stdev       : Float;
                              Color_Dist_Stdev    : Float) With Cuda_Global;

End Bilateral_Kernel;

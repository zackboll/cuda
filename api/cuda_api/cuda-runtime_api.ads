with Interfaces.C; use Interfaces.C;
with CUDA.Driver_Types;
with driver_types_h;
with CUDA.Corecrt;
with corecrt_h;
with Interfaces.C.Strings;
with System;
with Interfaces.C.Extensions;
with CUDA.Vector_Types;
with vector_types_h;
with CUDA.Texture_Types;
with texture_types_h;
with CUDA.Surface_Types;
with surface_types_h;
with Ada.Exceptions;
with CUDA;

package CUDA.Runtime_Api is
   function Grid_Dim return CUDA.Vector_Types.Dim3 with
      Inline;
   function Block_Idx return CUDA.Vector_Types.Uint3 with
      Inline;
   function Block_Dim return CUDA.Vector_Types.Dim3 with
      Inline;
   function Thread_Idx return CUDA.Vector_Types.Uint3 with
      Inline;
   function Wrap_Size return Interfaces.C.int with
      Inline;
   procedure Device_Reset;
   procedure Device_Synchronize;
   procedure Device_Set_Limit
     (Limit : CUDA.Driver_Types.Limit; Value : CUDA.Corecrt.Size_T);
   function Device_Get_Limit
     (Limit : CUDA.Driver_Types.Limit) return CUDA.Corecrt.Size_T;
   function Device_Get_Cache_Config return CUDA.Driver_Types.Func_Cache;
   function Device_Get_Stream_Priority_Range
     (Greatest_Priority : out int) return int;
   procedure Device_Set_Cache_Config
     (Cache_Config : CUDA.Driver_Types.Func_Cache);
   function Device_Get_Shared_Mem_Config
      return CUDA.Driver_Types.Shared_Mem_Config;
   procedure Device_Set_Shared_Mem_Config
     (Config : CUDA.Driver_Types.Shared_Mem_Config);
   function Device_Get_By_PCIBus_Id (Pci_Bus_Id : String) return int;
   procedure Device_Get_PCIBus_Id
     (Pci_Bus_Id : String; Len : int; Device : int);
   function Ipc_Get_Event_Handle
     (Event : CUDA.Driver_Types.Event_T)
      return CUDA.Driver_Types.Ipc_Event_Handle_T;
   function Ipc_Open_Event_Handle
     (Handle : CUDA.Driver_Types.Ipc_Event_Handle_T)
      return CUDA.Driver_Types.Event_T;
   function Ipc_Get_Mem_Handle
     (Dev_Ptr : System.Address) return CUDA.Driver_Types.Ipc_Mem_Handle_T;
   procedure Ipc_Open_Mem_Handle
     (Dev_Ptr : System.Address; Handle : CUDA.Driver_Types.Ipc_Mem_Handle_T;
      Flags   : unsigned);
   procedure Ipc_Close_Mem_Handle (Dev_Ptr : System.Address);
   procedure Thread_Exit;
   procedure Thread_Synchronize;
   procedure Thread_Set_Limit
     (Limit : CUDA.Driver_Types.Limit; Value : CUDA.Corecrt.Size_T);
   function Thread_Get_Limit
     (Limit : CUDA.Driver_Types.Limit) return CUDA.Corecrt.Size_T;
   function Thread_Get_Cache_Config return CUDA.Driver_Types.Func_Cache;
   procedure Thread_Set_Cache_Config
     (Cache_Config : CUDA.Driver_Types.Func_Cache);
   function Get_Last_Error return CUDA.Driver_Types.Error_T;
   function Peek_At_Last_Error return CUDA.Driver_Types.Error_T;
   function Get_Error_Name (Arg1 : CUDA.Driver_Types.Error_T) return String;
   function Get_Error_String (Arg1 : CUDA.Driver_Types.Error_T) return String;
   function Get_Device_Count return int;
   function Get_Device_Properties
     (Device : int) return CUDA.Driver_Types.Device_Prop;
   function Device_Get_Attribute
     (Attr : CUDA.Driver_Types.Device_Attr; Device : int) return int;
   procedure Device_Get_Nv_Sci_Sync_Attributes
     (Nv_Sci_Sync_Attr_List : System.Address; Device : int; Flags : int);
   function Device_Get_P2_PAttribute
     (Attr       : CUDA.Driver_Types.Device_P2_PAttr; Src_Device : int;
      Dst_Device : int) return int;
   procedure Choose_Device
     (Device : out int; Prop : out CUDA.Driver_Types.Device_Prop);
   procedure Set_Device (Device : int);
   function Get_Device return int;
   procedure Set_Valid_Devices (Device_Arr : out int; Len : int);
   procedure Set_Device_Flags (Flags : unsigned);
   function Get_Device_Flags return unsigned;
   procedure Stream_Create (P_Stream : System.Address);
   procedure Stream_Create_With_Flags
     (P_Stream : System.Address; Flags : unsigned);
   procedure Stream_Create_With_Priority
     (P_Stream : System.Address; Flags : unsigned; Priority : int);
   procedure Stream_Get_Priority
     (H_Stream : CUDA.Driver_Types.Stream_T; Priority : out int);
   procedure Stream_Get_Flags
     (H_Stream : CUDA.Driver_Types.Stream_T; Flags : out unsigned);
   procedure Stream_Destroy (Stream : CUDA.Driver_Types.Stream_T);
   procedure Stream_Wait_Event
     (Stream : CUDA.Driver_Types.Stream_T; Event : CUDA.Driver_Types.Event_T;
      Flags  : unsigned);

   type Stream_Callback_T is access procedure
     (arg1 : driver_types_h.cudaStream_t; arg2 : driver_types_h.cudaError_t;
      arg3 : System.Address);

   generic
      with procedure Temp_1
        (Arg1 : CUDA.Driver_Types.Stream_T; Arg2 : CUDA.Driver_Types.Error_T;
         Arg3 : System.Address);
   procedure Stream_Callback_T_Gen
     (Arg1 : driver_types_h.cudaStream_t; Arg2 : driver_types_h.cudaError_t;
      Arg3 : System.Address);
   procedure Stream_Add_Callback
     (Stream    : CUDA.Driver_Types.Stream_T; Callback : Stream_Callback_T;
      User_Data : System.Address; Flags : unsigned);
   procedure Stream_Synchronize (Stream : CUDA.Driver_Types.Stream_T);
   procedure Stream_Query (Stream : CUDA.Driver_Types.Stream_T);
   procedure Stream_Attach_Mem_Async
     (Stream : CUDA.Driver_Types.Stream_T; Dev_Ptr : System.Address;
      Length : CUDA.Corecrt.Size_T; Flags : unsigned);
   procedure Stream_Begin_Capture
     (Stream : CUDA.Driver_Types.Stream_T;
      Mode   : CUDA.Driver_Types.Stream_Capture_Mode);
   procedure Thread_Exchange_Stream_Capture_Mode
     (Mode : out CUDA.Driver_Types.Stream_Capture_Mode);
   procedure Stream_End_Capture
     (Stream : CUDA.Driver_Types.Stream_T; P_Graph : System.Address);
   procedure Stream_Is_Capturing
     (Stream           :     CUDA.Driver_Types.Stream_T;
      P_Capture_Status : out CUDA.Driver_Types.Stream_Capture_Status);
   procedure Stream_Get_Capture_Info
     (Stream           :     CUDA.Driver_Types.Stream_T;
      P_Capture_Status : out CUDA.Driver_Types.Stream_Capture_Status;
      P_Id             : out Extensions.unsigned_long_long);
   function Event_Create return CUDA.Driver_Types.Event_T;
   function Event_Create_With_Flags
     (Flags : unsigned) return CUDA.Driver_Types.Event_T;
   procedure Event_Record
     (Event : CUDA.Driver_Types.Event_T; Stream : CUDA.Driver_Types.Stream_T);
   procedure Event_Query (Event : CUDA.Driver_Types.Event_T);
   procedure Event_Synchronize (Event : CUDA.Driver_Types.Event_T);
   procedure Event_Destroy (Event : CUDA.Driver_Types.Event_T);
   procedure Event_Elapsed_Time
     (Ms    : out Float; Start : CUDA.Driver_Types.Event_T;
      C_End :     CUDA.Driver_Types.Event_T);
   procedure Import_External_Memory
     (Ext_Mem_Out     :     System.Address;
      Mem_Handle_Desc : out CUDA.Driver_Types.External_Memory_Handle_Desc);
   procedure External_Memory_Get_Mapped_Buffer
     (Dev_Ptr : System.Address; Ext_Mem : CUDA.Driver_Types.External_Memory_T;
      Buffer_Desc : out CUDA.Driver_Types.External_Memory_Buffer_Desc);
   procedure External_Memory_Get_Mapped_Mipmapped_Array
     (Mipmap : System.Address; Ext_Mem : CUDA.Driver_Types.External_Memory_T;
      Mipmap_Desc : out CUDA.Driver_Types.External_Memory_Mipmapped_Array_Desc);
   procedure Destroy_External_Memory
     (Ext_Mem : CUDA.Driver_Types.External_Memory_T);
   procedure Import_External_Semaphore
     (Ext_Sem_Out     :     System.Address;
      Sem_Handle_Desc : out CUDA.Driver_Types.External_Semaphore_Handle_Desc);
   procedure Signal_External_Semaphores_Async
     (Ext_Sem_Array :     System.Address;
      Params_Array  : out CUDA.Driver_Types.External_Semaphore_Signal_Params;
      Num_Ext_Sems  :     unsigned; Stream : CUDA.Driver_Types.Stream_T);
   procedure Wait_External_Semaphores_Async
     (Ext_Sem_Array :     System.Address;
      Params_Array  : out CUDA.Driver_Types.External_Semaphore_Wait_Params;
      Num_Ext_Sems  :     unsigned; Stream : CUDA.Driver_Types.Stream_T);
   procedure Destroy_External_Semaphore
     (Ext_Sem : CUDA.Driver_Types.External_Semaphore_T);
   procedure Launch_Kernel
     (Func       : System.Address; Grid_Dim : CUDA.Vector_Types.Dim3;
      Block_Dim  : CUDA.Vector_Types.Dim3; Args : System.Address;
      Shared_Mem : CUDA.Corecrt.Size_T; Stream : CUDA.Driver_Types.Stream_T);
   procedure Launch_Cooperative_Kernel
     (Func       : System.Address; Grid_Dim : CUDA.Vector_Types.Dim3;
      Block_Dim  : CUDA.Vector_Types.Dim3; Args : System.Address;
      Shared_Mem : CUDA.Corecrt.Size_T; Stream : CUDA.Driver_Types.Stream_T);
   procedure Launch_Cooperative_Kernel_Multi_Device
     (Launch_Params_List : out CUDA.Driver_Types.Launch_Params;
      Num_Devices        :     unsigned; Flags : unsigned);
   procedure Func_Set_Cache_Config
     (Func : System.Address; Cache_Config : CUDA.Driver_Types.Func_Cache);
   procedure Func_Set_Shared_Mem_Config
     (Func : System.Address; Config : CUDA.Driver_Types.Shared_Mem_Config);
   function Func_Get_Attributes
     (Func : System.Address) return CUDA.Driver_Types.Func_Attributes;
   procedure Func_Set_Attribute
     (Func  : System.Address; Attr : CUDA.Driver_Types.Func_Attribute;
      Value : int);
   procedure Set_Double_For_Device (D : out double);
   procedure Set_Double_For_Host (D : out double);
   procedure Launch_Host_Func
     (Stream    : CUDA.Driver_Types.Stream_T; Fn : CUDA.Driver_Types.Host_Fn_T;
      User_Data : System.Address);
   procedure Occupancy_Max_Active_Blocks_Per_Multiprocessor
     (Num_Blocks        : out int; Func : System.Address; Block_Size : int;
      Dynamic_SMem_Size :     CUDA.Corecrt.Size_T);
   procedure Occupancy_Max_Active_Blocks_Per_Multiprocessor_With_Flags
     (Num_Blocks        : out int; Func : System.Address; Block_Size : int;
      Dynamic_SMem_Size :     CUDA.Corecrt.Size_T; Flags : unsigned);
   procedure Malloc_Managed
     (Dev_Ptr : System.Address; Size : CUDA.Corecrt.Size_T; Flags : unsigned);
   procedure Malloc (Dev_Ptr : System.Address; Size : CUDA.Corecrt.Size_T);
   procedure Malloc_Host (Ptr : System.Address; Size : CUDA.Corecrt.Size_T);
   procedure Malloc_Pitch
     (Dev_Ptr : System.Address; Pitch : out CUDA.Corecrt.Size_T;
      Width   : CUDA.Corecrt.Size_T; Height : CUDA.Corecrt.Size_T);
   procedure Malloc_Array
     (C_Array :     System.Address;
      Desc    : out CUDA.Driver_Types.Channel_Format_Desc;
      Width   :     CUDA.Corecrt.Size_T; Height : CUDA.Corecrt.Size_T;
      Flags   :     unsigned);
   procedure Free (Dev_Ptr : System.Address);
   procedure Free_Host (Ptr : System.Address);
   procedure Free_Array (C_Array : CUDA.Driver_Types.CUDA_Array_t);
   procedure Free_Mipmapped_Array
     (Mipmapped_Array : CUDA.Driver_Types.Mipmapped_Array_T);
   procedure Host_Alloc
     (P_Host : System.Address; Size : CUDA.Corecrt.Size_T; Flags : unsigned);
   procedure Host_Register
     (Ptr : System.Address; Size : CUDA.Corecrt.Size_T; Flags : unsigned);
   procedure Host_Unregister (Ptr : System.Address);
   procedure Host_Get_Device_Pointer
     (P_Device : System.Address; P_Host : System.Address; Flags : unsigned);
   function Host_Get_Flags (P_Host : System.Address) return unsigned;
   procedure Malloc3_D
     (Pitched_Dev_Ptr : out CUDA.Driver_Types.Pitched_Ptr;
      Extent          :     CUDA.Driver_Types.Extent_T);
   procedure Malloc3_DArray
     (C_Array :     System.Address;
      Desc    : out CUDA.Driver_Types.Channel_Format_Desc;
      Extent  :     CUDA.Driver_Types.Extent_T; Flags : unsigned);
   procedure Malloc_Mipmapped_Array
     (Mipmapped_Array :     System.Address;
      Desc            : out CUDA.Driver_Types.Channel_Format_Desc;
      Extent          :     CUDA.Driver_Types.Extent_T; Num_Levels : unsigned;
      Flags           :     unsigned);
   procedure Get_Mipmapped_Array_Level
     (Level_Array     : System.Address;
      Mipmapped_Array : CUDA.Driver_Types.Mipmapped_Array_Const_T;
      Level           : unsigned);
   procedure Memcpy3_D (P : out CUDA.Driver_Types.Memcpy3_DParms);
   procedure Memcpy3_DPeer (P : out CUDA.Driver_Types.Memcpy3_DPeer_Parms);
   procedure Memcpy3_DAsync
     (P      : out CUDA.Driver_Types.Memcpy3_DParms;
      Stream :     CUDA.Driver_Types.Stream_T);
   procedure Memcpy3_DPeer_Async
     (P      : out CUDA.Driver_Types.Memcpy3_DPeer_Parms;
      Stream :     CUDA.Driver_Types.Stream_T);
   function Mem_Get_Info
     (Total : out CUDA.Corecrt.Size_T) return CUDA.Corecrt.Size_T;
   function CUDA_ArrayGetInfo
     (Extent  : out CUDA.Driver_Types.Extent_T; Flags : out unsigned;
      C_Array :     CUDA.Driver_Types.CUDA_Array_t)
      return CUDA.Driver_Types.Channel_Format_Desc;
   procedure Memcpy
     (Dst  : System.Address; Src : System.Address; Count : CUDA.Corecrt.Size_T;
      Kind : CUDA.Driver_Types.Memcpy_Kind);
   procedure Memcpy_Peer
     (Dst        : System.Address; Dst_Device : int; Src : System.Address;
      Src_Device : int; Count : CUDA.Corecrt.Size_T);
   procedure Memcpy2_D
     (Dst : System.Address; Dpitch : CUDA.Corecrt.Size_T; Src : System.Address;
      Spitch : CUDA.Corecrt.Size_T; Width : CUDA.Corecrt.Size_T;
      Height : CUDA.Corecrt.Size_T; Kind : CUDA.Driver_Types.Memcpy_Kind);
   procedure Memcpy2_DTo_Array
     (Dst      : CUDA.Driver_Types.CUDA_Array_t; W_Offset : CUDA.Corecrt.Size_T;
      H_Offset : CUDA.Corecrt.Size_T; Src : System.Address;
      Spitch   : CUDA.Corecrt.Size_T; Width : CUDA.Corecrt.Size_T;
      Height   : CUDA.Corecrt.Size_T; Kind : CUDA.Driver_Types.Memcpy_Kind);
   procedure Memcpy2_DFrom_Array
     (Dst      : System.Address; Dpitch : CUDA.Corecrt.Size_T;
      Src      : CUDA.Driver_Types.CUDA_Array_const_t;
      W_Offset : CUDA.Corecrt.Size_T; H_Offset : CUDA.Corecrt.Size_T;
      Width    : CUDA.Corecrt.Size_T; Height : CUDA.Corecrt.Size_T;
      Kind     : CUDA.Driver_Types.Memcpy_Kind);
   procedure Memcpy2_DArray_To_Array
     (Dst : CUDA.Driver_Types.CUDA_Array_t; W_Offset_Dst : CUDA.Corecrt.Size_T;
      H_Offset_Dst : CUDA.Corecrt.Size_T;
      Src          : CUDA.Driver_Types.CUDA_Array_const_t;
      W_Offset_Src : CUDA.Corecrt.Size_T; H_Offset_Src : CUDA.Corecrt.Size_T;
      Width        : CUDA.Corecrt.Size_T; Height : CUDA.Corecrt.Size_T;
      Kind         : CUDA.Driver_Types.Memcpy_Kind);
   procedure Memcpy_To_Symbol
     (Symbol : System.Address; Src : System.Address;
      Count  : CUDA.Corecrt.Size_T; Offset : CUDA.Corecrt.Size_T;
      Kind   : CUDA.Driver_Types.Memcpy_Kind);
   procedure Memcpy_From_Symbol
     (Dst   : System.Address; Symbol : System.Address;
      Count : CUDA.Corecrt.Size_T; Offset : CUDA.Corecrt.Size_T;
      Kind  : CUDA.Driver_Types.Memcpy_Kind);
   procedure Memcpy_Async
     (Dst : System.Address; Src : System.Address; Count : CUDA.Corecrt.Size_T;
      Kind   : CUDA.Driver_Types.Memcpy_Kind;
      Stream : CUDA.Driver_Types.Stream_T);
   procedure Memcpy_Peer_Async
     (Dst        : System.Address; Dst_Device : int; Src : System.Address;
      Src_Device : int; Count : CUDA.Corecrt.Size_T;
      Stream     : CUDA.Driver_Types.Stream_T);
   procedure Memcpy2_DAsync
     (Dst : System.Address; Dpitch : CUDA.Corecrt.Size_T; Src : System.Address;
      Spitch : CUDA.Corecrt.Size_T; Width : CUDA.Corecrt.Size_T;
      Height : CUDA.Corecrt.Size_T; Kind : CUDA.Driver_Types.Memcpy_Kind;
      Stream : CUDA.Driver_Types.Stream_T);
   procedure Memcpy2_DTo_Array_Async
     (Dst      : CUDA.Driver_Types.CUDA_Array_t; W_Offset : CUDA.Corecrt.Size_T;
      H_Offset : CUDA.Corecrt.Size_T; Src : System.Address;
      Spitch   : CUDA.Corecrt.Size_T; Width : CUDA.Corecrt.Size_T;
      Height   : CUDA.Corecrt.Size_T; Kind : CUDA.Driver_Types.Memcpy_Kind;
      Stream   : CUDA.Driver_Types.Stream_T);
   procedure Memcpy2_DFrom_Array_Async
     (Dst      : System.Address; Dpitch : CUDA.Corecrt.Size_T;
      Src      : CUDA.Driver_Types.CUDA_Array_const_t;
      W_Offset : CUDA.Corecrt.Size_T; H_Offset : CUDA.Corecrt.Size_T;
      Width    : CUDA.Corecrt.Size_T; Height : CUDA.Corecrt.Size_T;
      Kind     : CUDA.Driver_Types.Memcpy_Kind;
      Stream   : CUDA.Driver_Types.Stream_T);
   procedure Memcpy_To_Symbol_Async
     (Symbol : System.Address; Src : System.Address;
      Count  : CUDA.Corecrt.Size_T; Offset : CUDA.Corecrt.Size_T;
      Kind   : CUDA.Driver_Types.Memcpy_Kind;
      Stream : CUDA.Driver_Types.Stream_T);
   procedure Memcpy_From_Symbol_Async
     (Dst    : System.Address; Symbol : System.Address;
      Count  : CUDA.Corecrt.Size_T; Offset : CUDA.Corecrt.Size_T;
      Kind   : CUDA.Driver_Types.Memcpy_Kind;
      Stream : CUDA.Driver_Types.Stream_T);
   procedure Memset
     (Dev_Ptr : System.Address; Value : int; Count : CUDA.Corecrt.Size_T);
   procedure Memset2_D
     (Dev_Ptr : System.Address; Pitch : CUDA.Corecrt.Size_T; Value : int;
      Width   : CUDA.Corecrt.Size_T; Height : CUDA.Corecrt.Size_T);
   procedure Memset3_D
     (Pitched_Dev_Ptr : CUDA.Driver_Types.Pitched_Ptr; Value : int;
      Extent          : CUDA.Driver_Types.Extent_T);
   procedure Memset_Async
     (Dev_Ptr : System.Address; Value : int; Count : CUDA.Corecrt.Size_T;
      Stream  : CUDA.Driver_Types.Stream_T);
   procedure Memset2_DAsync
     (Dev_Ptr : System.Address; Pitch : CUDA.Corecrt.Size_T; Value : int;
      Width   : CUDA.Corecrt.Size_T; Height : CUDA.Corecrt.Size_T;
      Stream  : CUDA.Driver_Types.Stream_T);
   procedure Memset3_DAsync
     (Pitched_Dev_Ptr : CUDA.Driver_Types.Pitched_Ptr; Value : int;
      Extent : CUDA.Driver_Types.Extent_T; Stream : CUDA.Driver_Types.Stream_T);
   procedure Get_Symbol_Address
     (Dev_Ptr : System.Address; Symbol : System.Address);
   function Get_Symbol_Size
     (Symbol : System.Address) return CUDA.Corecrt.Size_T;
   procedure Mem_Prefetch_Async
     (Dev_Ptr : System.Address; Count : CUDA.Corecrt.Size_T; Dst_Device : int;
      Stream  : CUDA.Driver_Types.Stream_T);
   procedure Mem_Advise
     (Dev_Ptr : System.Address; Count : CUDA.Corecrt.Size_T;
      Advice  : CUDA.Driver_Types.Memory_Advise; Device : int);
   procedure Mem_Range_Get_Attribute
     (Data      : System.Address; Data_Size : CUDA.Corecrt.Size_T;
      Attribute : CUDA.Driver_Types.Mem_Range_Attribute;
      Dev_Ptr   : System.Address; Count : CUDA.Corecrt.Size_T);
   procedure Mem_Range_Get_Attributes
     (Data           :     System.Address; Data_Sizes : out CUDA.Corecrt.Size_T;
      Attributes     : out CUDA.Driver_Types.Mem_Range_Attribute;
      Num_Attributes :     CUDA.Corecrt.Size_T; Dev_Ptr : System.Address;
      Count          :     CUDA.Corecrt.Size_T);
   procedure Memcpy_To_Array
     (Dst      : CUDA.Driver_Types.CUDA_Array_t; W_Offset : CUDA.Corecrt.Size_T;
      H_Offset : CUDA.Corecrt.Size_T; Src : System.Address;
      Count    : CUDA.Corecrt.Size_T; Kind : CUDA.Driver_Types.Memcpy_Kind);
   procedure Memcpy_From_Array
     (Dst      : System.Address; Src : CUDA.Driver_Types.CUDA_Array_const_t;
      W_Offset : CUDA.Corecrt.Size_T; H_Offset : CUDA.Corecrt.Size_T;
      Count    : CUDA.Corecrt.Size_T; Kind : CUDA.Driver_Types.Memcpy_Kind);
   procedure Memcpy_Array_To_Array
     (Dst : CUDA.Driver_Types.CUDA_Array_t; W_Offset_Dst : CUDA.Corecrt.Size_T;
      H_Offset_Dst : CUDA.Corecrt.Size_T;
      Src          : CUDA.Driver_Types.CUDA_Array_const_t;
      W_Offset_Src : CUDA.Corecrt.Size_T; H_Offset_Src : CUDA.Corecrt.Size_T;
      Count        : CUDA.Corecrt.Size_T; Kind : CUDA.Driver_Types.Memcpy_Kind);
   procedure Memcpy_To_Array_Async
     (Dst      : CUDA.Driver_Types.CUDA_Array_t; W_Offset : CUDA.Corecrt.Size_T;
      H_Offset : CUDA.Corecrt.Size_T; Src : System.Address;
      Count    : CUDA.Corecrt.Size_T; Kind : CUDA.Driver_Types.Memcpy_Kind;
      Stream   : CUDA.Driver_Types.Stream_T);
   procedure Memcpy_From_Array_Async
     (Dst      : System.Address; Src : CUDA.Driver_Types.CUDA_Array_const_t;
      W_Offset : CUDA.Corecrt.Size_T; H_Offset : CUDA.Corecrt.Size_T;
      Count    : CUDA.Corecrt.Size_T; Kind : CUDA.Driver_Types.Memcpy_Kind;
      Stream   : CUDA.Driver_Types.Stream_T);
   function Pointer_Get_Attributes
     (Ptr : System.Address) return CUDA.Driver_Types.Pointer_Attributes;
   procedure Device_Can_Access_Peer
     (Can_Access_Peer : out int; Device : int; Peer_Device : int);
   procedure Device_Enable_Peer_Access (Peer_Device : int; Flags : unsigned);
   procedure Device_Disable_Peer_Access (Peer_Device : int);
   procedure Graphics_Unregister_Resource
     (Resource : CUDA.Driver_Types.Graphics_Resource_T);
   procedure Graphics_Resource_Set_Map_Flags
     (Resource : CUDA.Driver_Types.Graphics_Resource_T; Flags : unsigned);
   procedure Graphics_Map_Resources
     (Count  : int; Resources : System.Address;
      Stream : CUDA.Driver_Types.Stream_T);
   procedure Graphics_Unmap_Resources
     (Count  : int; Resources : System.Address;
      Stream : CUDA.Driver_Types.Stream_T);
   procedure Graphics_Resource_Get_Mapped_Pointer
     (Dev_Ptr  : System.Address; Size : out CUDA.Corecrt.Size_T;
      Resource : CUDA.Driver_Types.Graphics_Resource_T);
   procedure Graphics_Sub_Resource_Get_Mapped_Array
     (C_Array   : System.Address;
      Resource  : CUDA.Driver_Types.Graphics_Resource_T; Array_Index : unsigned;
      Mip_Level : unsigned);
   procedure Graphics_Resource_Get_Mapped_Mipmapped_Array
     (Mipmapped_Array : System.Address;
      Resource        : CUDA.Driver_Types.Graphics_Resource_T);
   procedure Bind_Texture
     (Offset  : out CUDA.Corecrt.Size_T;
      Texref  : out CUDA.Texture_Types.Texture_Reference;
      Dev_Ptr :     System.Address;
      Desc    : out CUDA.Driver_Types.Channel_Format_Desc;
      Size    :     CUDA.Corecrt.Size_T);
   procedure Bind_Texture2_D
     (Offset  : out CUDA.Corecrt.Size_T;
      Texref  : out CUDA.Texture_Types.Texture_Reference;
      Dev_Ptr :     System.Address;
      Desc    : out CUDA.Driver_Types.Channel_Format_Desc;
      Width   :     CUDA.Corecrt.Size_T; Height : CUDA.Corecrt.Size_T;
      Pitch   :     CUDA.Corecrt.Size_T);
   procedure Bind_Texture_To_Array
     (Texref  : out CUDA.Texture_Types.Texture_Reference;
      C_Array :     CUDA.Driver_Types.CUDA_Array_const_t;
      Desc    : out CUDA.Driver_Types.Channel_Format_Desc);
   procedure Bind_Texture_To_Mipmapped_Array
     (Texref          : out CUDA.Texture_Types.Texture_Reference;
      Mipmapped_Array :     CUDA.Driver_Types.Mipmapped_Array_Const_T;
      Desc            : out CUDA.Driver_Types.Channel_Format_Desc);
   procedure Unbind_Texture (Texref : out CUDA.Texture_Types.Texture_Reference);
   function Get_Texture_Alignment_Offset
     (Texref : out CUDA.Texture_Types.Texture_Reference)
      return CUDA.Corecrt.Size_T;
   procedure Get_Texture_Reference
     (Texref : System.Address; Symbol : System.Address);
   procedure Bind_Surface_To_Array
     (Surfref : out CUDA.Surface_Types.Surface_Reference;
      C_Array :     CUDA.Driver_Types.CUDA_Array_const_t;
      Desc    : out CUDA.Driver_Types.Channel_Format_Desc);
   procedure Get_Surface_Reference
     (Surfref : System.Address; Symbol : System.Address);
   function Get_Channel_Desc
     (C_Array : CUDA.Driver_Types.CUDA_Array_const_t)
      return CUDA.Driver_Types.Channel_Format_Desc;
   function Create_Channel_Desc
     (X : int; Y : int; Z : int; W : int;
      F : CUDA.Driver_Types.Channel_Format_Kind)
      return CUDA.Driver_Types.Channel_Format_Desc;
   procedure Create_Texture_Object
     (P_Tex_Object    : out CUDA.Texture_Types.Texture_Object_T;
      P_Res_Desc      : out CUDA.Driver_Types.Resource_Desc;
      P_Tex_Desc      : out CUDA.Texture_Types.Texture_Desc;
      P_Res_View_Desc : out CUDA.Driver_Types.Resource_View_Desc);
   procedure Destroy_Texture_Object
     (Tex_Object : CUDA.Texture_Types.Texture_Object_T);
   function Get_Texture_Object_Resource_Desc
     (Tex_Object : CUDA.Texture_Types.Texture_Object_T)
      return CUDA.Driver_Types.Resource_Desc;
   function Get_Texture_Object_Texture_Desc
     (Tex_Object : CUDA.Texture_Types.Texture_Object_T)
      return CUDA.Texture_Types.Texture_Desc;
   function Get_Texture_Object_Resource_View_Desc
     (Tex_Object : CUDA.Texture_Types.Texture_Object_T)
      return CUDA.Driver_Types.Resource_View_Desc;
   procedure Create_Surface_Object
     (P_Surf_Object : out CUDA.Surface_Types.Surface_Object_T;
      P_Res_Desc    : out CUDA.Driver_Types.Resource_Desc);
   procedure Destroy_Surface_Object
     (Surf_Object : CUDA.Surface_Types.Surface_Object_T);
   function Get_Surface_Object_Resource_Desc
     (Surf_Object : CUDA.Surface_Types.Surface_Object_T)
      return CUDA.Driver_Types.Resource_Desc;
   function Driver_Get_Version return int;
   function Runtime_Get_Version return int;
   procedure Graph_Create (P_Graph : System.Address; Flags : unsigned);
   procedure Graph_Add_Kernel_Node
     (P_Graph_Node   :     System.Address; Graph : CUDA.Driver_Types.Graph_T;
      P_Dependencies : System.Address; Num_Dependencies : CUDA.Corecrt.Size_T;
      P_Node_Params  : out CUDA.Driver_Types.Kernel_Node_Params);
   procedure Graph_Kernel_Node_Get_Params
     (Node          :     CUDA.Driver_Types.Graph_Node_T;
      P_Node_Params : out CUDA.Driver_Types.Kernel_Node_Params);
   procedure Graph_Kernel_Node_Set_Params
     (Node          :     CUDA.Driver_Types.Graph_Node_T;
      P_Node_Params : out CUDA.Driver_Types.Kernel_Node_Params);
   procedure Graph_Add_Memcpy_Node
     (P_Graph_Node   :     System.Address; Graph : CUDA.Driver_Types.Graph_T;
      P_Dependencies : System.Address; Num_Dependencies : CUDA.Corecrt.Size_T;
      P_Copy_Params  : out CUDA.Driver_Types.Memcpy3_DParms);
   procedure Graph_Memcpy_Node_Get_Params
     (Node          :     CUDA.Driver_Types.Graph_Node_T;
      P_Node_Params : out CUDA.Driver_Types.Memcpy3_DParms);
   procedure Graph_Memcpy_Node_Set_Params
     (Node          :     CUDA.Driver_Types.Graph_Node_T;
      P_Node_Params : out CUDA.Driver_Types.Memcpy3_DParms);
   procedure Graph_Add_Memset_Node
     (P_Graph_Node    :     System.Address; Graph : CUDA.Driver_Types.Graph_T;
      P_Dependencies  : System.Address; Num_Dependencies : CUDA.Corecrt.Size_T;
      P_Memset_Params : out CUDA.Driver_Types.Memset_Params);
   procedure Graph_Memset_Node_Get_Params
     (Node          :     CUDA.Driver_Types.Graph_Node_T;
      P_Node_Params : out CUDA.Driver_Types.Memset_Params);
   procedure Graph_Memset_Node_Set_Params
     (Node          :     CUDA.Driver_Types.Graph_Node_T;
      P_Node_Params : out CUDA.Driver_Types.Memset_Params);
   procedure Graph_Add_Host_Node
     (P_Graph_Node   :     System.Address; Graph : CUDA.Driver_Types.Graph_T;
      P_Dependencies : System.Address; Num_Dependencies : CUDA.Corecrt.Size_T;
      P_Node_Params  : out CUDA.Driver_Types.Host_Node_Params);
   procedure Graph_Host_Node_Get_Params
     (Node          :     CUDA.Driver_Types.Graph_Node_T;
      P_Node_Params : out CUDA.Driver_Types.Host_Node_Params);
   procedure Graph_Host_Node_Set_Params
     (Node          :     CUDA.Driver_Types.Graph_Node_T;
      P_Node_Params : out CUDA.Driver_Types.Host_Node_Params);
   procedure Graph_Add_Child_Graph_Node
     (P_Graph_Node   : System.Address; Graph : CUDA.Driver_Types.Graph_T;
      P_Dependencies : System.Address; Num_Dependencies : CUDA.Corecrt.Size_T;
      Child_Graph    : CUDA.Driver_Types.Graph_T);
   procedure Graph_Child_Graph_Node_Get_Graph
     (Node : CUDA.Driver_Types.Graph_Node_T; P_Graph : System.Address);
   procedure Graph_Add_Empty_Node
     (P_Graph_Node   : System.Address; Graph : CUDA.Driver_Types.Graph_T;
      P_Dependencies : System.Address; Num_Dependencies : CUDA.Corecrt.Size_T);
   procedure Graph_Clone
     (P_Graph_Clone  : System.Address;
      Original_Graph : CUDA.Driver_Types.Graph_T);
   procedure Graph_Node_Find_In_Clone
     (P_Node : System.Address; Original_Node : CUDA.Driver_Types.Graph_Node_T;
      Cloned_Graph : CUDA.Driver_Types.Graph_T);
   procedure Graph_Node_Get_Type
     (Node   :     CUDA.Driver_Types.Graph_Node_T;
      P_Type : out CUDA.Driver_Types.Graph_Node_Type);
   procedure Graph_Get_Nodes
     (Graph     :     CUDA.Driver_Types.Graph_T; Nodes : System.Address;
      Num_Nodes : out CUDA.Corecrt.Size_T);
   procedure Graph_Get_Root_Nodes
     (Graph :     CUDA.Driver_Types.Graph_T; P_Root_Nodes : System.Address;
      P_Num_Root_Nodes : out CUDA.Corecrt.Size_T);
   procedure Graph_Get_Edges
     (Graph : CUDA.Driver_Types.Graph_T; From : System.Address;
      To    : System.Address; Num_Edges : out CUDA.Corecrt.Size_T);
   procedure Graph_Node_Get_Dependencies
     (Node : CUDA.Driver_Types.Graph_Node_T; P_Dependencies : System.Address;
      P_Num_Dependencies : out CUDA.Corecrt.Size_T);
   procedure Graph_Node_Get_Dependent_Nodes
     (Node : CUDA.Driver_Types.Graph_Node_T; P_Dependent_Nodes : System.Address;
      P_Num_Dependent_Nodes : out CUDA.Corecrt.Size_T);
   procedure Graph_Add_Dependencies
     (Graph : CUDA.Driver_Types.Graph_T; From : System.Address;
      To    : System.Address; Num_Dependencies : CUDA.Corecrt.Size_T);
   procedure Graph_Remove_Dependencies
     (Graph : CUDA.Driver_Types.Graph_T; From : System.Address;
      To    : System.Address; Num_Dependencies : CUDA.Corecrt.Size_T);
   procedure Graph_Destroy_Node (Node : CUDA.Driver_Types.Graph_Node_T);
   procedure Graph_Instantiate
     (P_Graph_Exec : System.Address; Graph : CUDA.Driver_Types.Graph_T;
      P_Error_Node : System.Address; P_Log_Buffer : String;
      Buffer_Size  : CUDA.Corecrt.Size_T);
   procedure Graph_Exec_Kernel_Node_Set_Params
     (H_Graph_Exec  :     CUDA.Driver_Types.Graph_Exec_T;
      Node          :     CUDA.Driver_Types.Graph_Node_T;
      P_Node_Params : out CUDA.Driver_Types.Kernel_Node_Params);
   procedure Graph_Exec_Memcpy_Node_Set_Params
     (H_Graph_Exec  :     CUDA.Driver_Types.Graph_Exec_T;
      Node          :     CUDA.Driver_Types.Graph_Node_T;
      P_Node_Params : out CUDA.Driver_Types.Memcpy3_DParms);
   procedure Graph_Exec_Memset_Node_Set_Params
     (H_Graph_Exec  :     CUDA.Driver_Types.Graph_Exec_T;
      Node          :     CUDA.Driver_Types.Graph_Node_T;
      P_Node_Params : out CUDA.Driver_Types.Memset_Params);
   procedure Graph_Exec_Host_Node_Set_Params
     (H_Graph_Exec  :     CUDA.Driver_Types.Graph_Exec_T;
      Node          :     CUDA.Driver_Types.Graph_Node_T;
      P_Node_Params : out CUDA.Driver_Types.Host_Node_Params);
   procedure Graph_Exec_Update
     (H_Graph_Exec      :     CUDA.Driver_Types.Graph_Exec_T;
      H_Graph : CUDA.Driver_Types.Graph_T; H_Error_Node_Out : System.Address;
      Update_Result_Out : out CUDA.Driver_Types.Graph_Exec_Update_Result);
   procedure Graph_Launch
     (Graph_Exec : CUDA.Driver_Types.Graph_Exec_T;
      Stream     : CUDA.Driver_Types.Stream_T);
   procedure Graph_Exec_Destroy (Graph_Exec : CUDA.Driver_Types.Graph_Exec_T);
   procedure Graph_Destroy (Graph : CUDA.Driver_Types.Graph_T);
   procedure Get_Export_Table
     (Pp_Export_Table   :     System.Address;
      P_Export_Table_Id : out CUDA.Driver_Types.UUID_T);
end CUDA.Runtime_Api;

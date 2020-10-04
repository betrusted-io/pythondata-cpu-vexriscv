// Generator : SpinalHDL v1.3.6    git head : 9bf01e7f360e003fac1dd5ca8b8f4bffec0e52b8
// Date      : 04/10/2020, 23:22:46
// Component : VexRiscv


`define Src1CtrlEnum_defaultEncoding_type [1:0]
`define Src1CtrlEnum_defaultEncoding_RS 2'b00
`define Src1CtrlEnum_defaultEncoding_IMU 2'b01
`define Src1CtrlEnum_defaultEncoding_PC_INCREMENT 2'b10
`define Src1CtrlEnum_defaultEncoding_URS1 2'b11

`define EnvCtrlEnum_defaultEncoding_type [2:0]
`define EnvCtrlEnum_defaultEncoding_NONE 3'b000
`define EnvCtrlEnum_defaultEncoding_XRET 3'b001
`define EnvCtrlEnum_defaultEncoding_WFI 3'b010
`define EnvCtrlEnum_defaultEncoding_ECALL 3'b011
`define EnvCtrlEnum_defaultEncoding_EBREAK 3'b100

`define BranchCtrlEnum_defaultEncoding_type [1:0]
`define BranchCtrlEnum_defaultEncoding_INC 2'b00
`define BranchCtrlEnum_defaultEncoding_B 2'b01
`define BranchCtrlEnum_defaultEncoding_JAL 2'b10
`define BranchCtrlEnum_defaultEncoding_JALR 2'b11

`define ShiftCtrlEnum_defaultEncoding_type [1:0]
`define ShiftCtrlEnum_defaultEncoding_DISABLE_1 2'b00
`define ShiftCtrlEnum_defaultEncoding_SLL_1 2'b01
`define ShiftCtrlEnum_defaultEncoding_SRL_1 2'b10
`define ShiftCtrlEnum_defaultEncoding_SRA_1 2'b11

`define AluCtrlEnum_defaultEncoding_type [1:0]
`define AluCtrlEnum_defaultEncoding_ADD_SUB 2'b00
`define AluCtrlEnum_defaultEncoding_SLT_SLTU 2'b01
`define AluCtrlEnum_defaultEncoding_BITWISE 2'b10

`define AluBitwiseCtrlEnum_defaultEncoding_type [1:0]
`define AluBitwiseCtrlEnum_defaultEncoding_XOR_1 2'b00
`define AluBitwiseCtrlEnum_defaultEncoding_OR_1 2'b01
`define AluBitwiseCtrlEnum_defaultEncoding_AND_1 2'b10

`define Src2CtrlEnum_defaultEncoding_type [1:0]
`define Src2CtrlEnum_defaultEncoding_RS 2'b00
`define Src2CtrlEnum_defaultEncoding_IMI 2'b01
`define Src2CtrlEnum_defaultEncoding_IMS 2'b10
`define Src2CtrlEnum_defaultEncoding_PC 2'b11

`define MmuPlugin_shared_State_defaultEncoding_type [2:0]
`define MmuPlugin_shared_State_defaultEncoding_IDLE 3'b000
`define MmuPlugin_shared_State_defaultEncoding_L1_CMD 3'b001
`define MmuPlugin_shared_State_defaultEncoding_L1_RSP 3'b010
`define MmuPlugin_shared_State_defaultEncoding_L0_CMD 3'b011
`define MmuPlugin_shared_State_defaultEncoding_L0_RSP 3'b100

module InstructionCache (
      input   io_flush,
      input   io_cpu_prefetch_isValid,
      output reg  io_cpu_prefetch_haltIt,
      input  [31:0] io_cpu_prefetch_pc,
      input   io_cpu_fetch_isValid,
      input   io_cpu_fetch_isStuck,
      input   io_cpu_fetch_isRemoved,
      input  [31:0] io_cpu_fetch_pc,
      output [31:0] io_cpu_fetch_data,
      input   io_cpu_fetch_dataBypassValid,
      input  [31:0] io_cpu_fetch_dataBypass,
      output  io_cpu_fetch_mmuBus_cmd_isValid,
      output [31:0] io_cpu_fetch_mmuBus_cmd_virtualAddress,
      output  io_cpu_fetch_mmuBus_cmd_bypassTranslation,
      input  [31:0] io_cpu_fetch_mmuBus_rsp_physicalAddress,
      input   io_cpu_fetch_mmuBus_rsp_isIoAccess,
      input   io_cpu_fetch_mmuBus_rsp_allowRead,
      input   io_cpu_fetch_mmuBus_rsp_allowWrite,
      input   io_cpu_fetch_mmuBus_rsp_allowExecute,
      input   io_cpu_fetch_mmuBus_rsp_exception,
      input   io_cpu_fetch_mmuBus_rsp_refilling,
      output  io_cpu_fetch_mmuBus_end,
      input   io_cpu_fetch_mmuBus_busy,
      output [31:0] io_cpu_fetch_physicalAddress,
      output  io_cpu_fetch_haltIt,
      input   io_cpu_decode_isValid,
      input   io_cpu_decode_isStuck,
      input  [31:0] io_cpu_decode_pc,
      output [31:0] io_cpu_decode_physicalAddress,
      output [31:0] io_cpu_decode_data,
      output  io_cpu_decode_cacheMiss,
      output  io_cpu_decode_error,
      output  io_cpu_decode_mmuRefilling,
      output  io_cpu_decode_mmuException,
      input   io_cpu_decode_isUser,
      input   io_cpu_fill_valid,
      input  [31:0] io_cpu_fill_payload,
      output  io_mem_cmd_valid,
      input   io_mem_cmd_ready,
      output [31:0] io_mem_cmd_payload_address,
      output [2:0] io_mem_cmd_payload_size,
      input   io_mem_rsp_valid,
      input  [31:0] io_mem_rsp_payload_data,
      input   io_mem_rsp_payload_error,
      input   clk,
      input   reset);
  reg [21:0] _zz_20_;
  reg [31:0] _zz_21_;
  reg [21:0] _zz_22_;
  reg [31:0] _zz_23_;
  reg  _zz_24_;
  reg [31:0] _zz_25_;
  wire  _zz_26_;
  wire  _zz_27_;
  wire [0:0] _zz_28_;
  wire [0:0] _zz_29_;
  wire [0:0] _zz_30_;
  wire [0:0] _zz_31_;
  wire [21:0] _zz_32_;
  wire [21:0] _zz_33_;
  reg  _zz_1_;
  reg  _zz_2_;
  reg  _zz_3_;
  reg  _zz_4_;
  reg  lineLoader_fire;
  reg  lineLoader_valid;
  reg [31:0] lineLoader_address;
  reg  lineLoader_hadError;
  reg  lineLoader_flushPending;
  reg [7:0] lineLoader_flushCounter;
  reg  _zz_5_;
  reg  lineLoader_cmdSent;
  reg  lineLoader_wayToAllocate_willIncrement;
  wire  lineLoader_wayToAllocate_willClear;
  reg [0:0] lineLoader_wayToAllocate_valueNext;
  reg [0:0] lineLoader_wayToAllocate_value;
  wire  lineLoader_wayToAllocate_willOverflowIfInc;
  wire  lineLoader_wayToAllocate_willOverflow;
  reg [2:0] lineLoader_wordIndex;
  wire  lineLoader_write_tag_0_valid;
  wire [6:0] lineLoader_write_tag_0_payload_address;
  wire  lineLoader_write_tag_0_payload_data_valid;
  wire  lineLoader_write_tag_0_payload_data_error;
  wire [19:0] lineLoader_write_tag_0_payload_data_address;
  wire  lineLoader_write_tag_1_valid;
  wire [6:0] lineLoader_write_tag_1_payload_address;
  wire  lineLoader_write_tag_1_payload_data_valid;
  wire  lineLoader_write_tag_1_payload_data_error;
  wire [19:0] lineLoader_write_tag_1_payload_data_address;
  wire  lineLoader_write_data_0_valid;
  wire [9:0] lineLoader_write_data_0_payload_address;
  wire [31:0] lineLoader_write_data_0_payload_data;
  wire  lineLoader_write_data_1_valid;
  wire [9:0] lineLoader_write_data_1_payload_address;
  wire [31:0] lineLoader_write_data_1_payload_data;
  wire  _zz_6_;
  wire  _zz_7_;
  wire [6:0] _zz_8_;
  wire  _zz_9_;
  wire  fetchStage_read_waysValues_0_tag_valid;
  wire  fetchStage_read_waysValues_0_tag_error;
  wire [19:0] fetchStage_read_waysValues_0_tag_address;
  wire [21:0] _zz_10_;
  wire [9:0] _zz_11_;
  wire  _zz_12_;
  wire [31:0] fetchStage_read_waysValues_0_data;
  wire [6:0] _zz_13_;
  wire  _zz_14_;
  wire  fetchStage_read_waysValues_1_tag_valid;
  wire  fetchStage_read_waysValues_1_tag_error;
  wire [19:0] fetchStage_read_waysValues_1_tag_address;
  wire [21:0] _zz_15_;
  wire [9:0] _zz_16_;
  wire  _zz_17_;
  wire [31:0] fetchStage_read_waysValues_1_data;
  reg [31:0] decodeStage_mmuRsp_physicalAddress;
  reg  decodeStage_mmuRsp_isIoAccess;
  reg  decodeStage_mmuRsp_allowRead;
  reg  decodeStage_mmuRsp_allowWrite;
  reg  decodeStage_mmuRsp_allowExecute;
  reg  decodeStage_mmuRsp_exception;
  reg  decodeStage_mmuRsp_refilling;
  reg  decodeStage_hit_tags_0_valid;
  reg  decodeStage_hit_tags_0_error;
  reg [19:0] decodeStage_hit_tags_0_address;
  reg  decodeStage_hit_tags_1_valid;
  reg  decodeStage_hit_tags_1_error;
  reg [19:0] decodeStage_hit_tags_1_address;
  wire  decodeStage_hit_hits_0;
  wire  decodeStage_hit_hits_1;
  wire  decodeStage_hit_valid;
  wire [0:0] decodeStage_hit_id;
  wire  decodeStage_hit_error;
  reg [31:0] _zz_18_;
  reg [31:0] _zz_19_;
  wire [31:0] decodeStage_hit_data;
  reg [31:0] decodeStage_hit_word;
  reg  io_cpu_fetch_dataBypassValid_regNextWhen;
  reg [31:0] io_cpu_fetch_dataBypass_regNextWhen;
  (* ram_style = "block" *) reg [21:0] ways_0_tags [0:127];
  (* ram_style = "block" *) reg [31:0] ways_0_datas [0:1023];
  (* ram_style = "block" *) reg [21:0] ways_1_tags [0:127];
  (* ram_style = "block" *) reg [31:0] ways_1_datas [0:1023];
  assign _zz_26_ = (! lineLoader_flushCounter[7]);
  assign _zz_27_ = (lineLoader_flushPending && (! (lineLoader_valid || io_cpu_fetch_isValid)));
  assign _zz_28_ = _zz_10_[0 : 0];
  assign _zz_29_ = _zz_10_[1 : 1];
  assign _zz_30_ = _zz_15_[0 : 0];
  assign _zz_31_ = _zz_15_[1 : 1];
  assign _zz_32_ = {lineLoader_write_tag_0_payload_data_address,{lineLoader_write_tag_0_payload_data_error,lineLoader_write_tag_0_payload_data_valid}};
  assign _zz_33_ = {lineLoader_write_tag_1_payload_data_address,{lineLoader_write_tag_1_payload_data_error,lineLoader_write_tag_1_payload_data_valid}};
  always @ (posedge clk) begin
    if(_zz_4_) begin
      ways_0_tags[lineLoader_write_tag_0_payload_address] <= _zz_32_;
    end
  end

  always @ (posedge clk) begin
    if(_zz_9_) begin
      _zz_20_ <= ways_0_tags[_zz_8_];
    end
  end

  always @ (posedge clk) begin
    if(_zz_2_) begin
      ways_0_datas[lineLoader_write_data_0_payload_address] <= lineLoader_write_data_0_payload_data;
    end
  end

  always @ (posedge clk) begin
    if(_zz_12_) begin
      _zz_21_ <= ways_0_datas[_zz_11_];
    end
  end

  always @ (posedge clk) begin
    if(_zz_3_) begin
      ways_1_tags[lineLoader_write_tag_1_payload_address] <= _zz_33_;
    end
  end

  always @ (posedge clk) begin
    if(_zz_14_) begin
      _zz_22_ <= ways_1_tags[_zz_13_];
    end
  end

  always @ (posedge clk) begin
    if(_zz_1_) begin
      ways_1_datas[lineLoader_write_data_1_payload_address] <= lineLoader_write_data_1_payload_data;
    end
  end

  always @ (posedge clk) begin
    if(_zz_17_) begin
      _zz_23_ <= ways_1_datas[_zz_16_];
    end
  end

  always @(*) begin
    case(decodeStage_hit_id)
      1'b0 : begin
        _zz_24_ = decodeStage_hit_tags_0_error;
        _zz_25_ = _zz_18_;
      end
      default : begin
        _zz_24_ = decodeStage_hit_tags_1_error;
        _zz_25_ = _zz_19_;
      end
    endcase
  end

  always @ (*) begin
    _zz_1_ = 1'b0;
    if(lineLoader_write_data_1_valid)begin
      _zz_1_ = 1'b1;
    end
  end

  always @ (*) begin
    _zz_2_ = 1'b0;
    if(lineLoader_write_data_0_valid)begin
      _zz_2_ = 1'b1;
    end
  end

  always @ (*) begin
    _zz_3_ = 1'b0;
    if(lineLoader_write_tag_1_valid)begin
      _zz_3_ = 1'b1;
    end
  end

  always @ (*) begin
    _zz_4_ = 1'b0;
    if(lineLoader_write_tag_0_valid)begin
      _zz_4_ = 1'b1;
    end
  end

  assign io_cpu_fetch_haltIt = io_cpu_fetch_mmuBus_busy;
  always @ (*) begin
    lineLoader_fire = 1'b0;
    if(io_mem_rsp_valid)begin
      if((lineLoader_wordIndex == (3'b111)))begin
        lineLoader_fire = 1'b1;
      end
    end
  end

  always @ (*) begin
    io_cpu_prefetch_haltIt = (lineLoader_valid || lineLoader_flushPending);
    if(_zz_26_)begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
    if((! _zz_5_))begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
    if(io_flush)begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
  end

  assign io_mem_cmd_valid = (lineLoader_valid && (! lineLoader_cmdSent));
  assign io_mem_cmd_payload_address = {lineLoader_address[31 : 5],(5'b00000)};
  assign io_mem_cmd_payload_size = (3'b101);
  always @ (*) begin
    lineLoader_wayToAllocate_willIncrement = 1'b0;
    if((! lineLoader_valid))begin
      lineLoader_wayToAllocate_willIncrement = 1'b1;
    end
  end

  assign lineLoader_wayToAllocate_willClear = 1'b0;
  assign lineLoader_wayToAllocate_willOverflowIfInc = (lineLoader_wayToAllocate_value == (1'b1));
  assign lineLoader_wayToAllocate_willOverflow = (lineLoader_wayToAllocate_willOverflowIfInc && lineLoader_wayToAllocate_willIncrement);
  always @ (*) begin
    lineLoader_wayToAllocate_valueNext = (lineLoader_wayToAllocate_value + lineLoader_wayToAllocate_willIncrement);
    if(lineLoader_wayToAllocate_willClear)begin
      lineLoader_wayToAllocate_valueNext = (1'b0);
    end
  end

  assign _zz_6_ = (lineLoader_wayToAllocate_value == (1'b0));
  assign lineLoader_write_tag_0_valid = ((_zz_6_ && lineLoader_fire) || (! lineLoader_flushCounter[7]));
  assign lineLoader_write_tag_0_payload_address = (lineLoader_flushCounter[7] ? lineLoader_address[11 : 5] : lineLoader_flushCounter[6 : 0]);
  assign lineLoader_write_tag_0_payload_data_valid = lineLoader_flushCounter[7];
  assign lineLoader_write_tag_0_payload_data_error = (lineLoader_hadError || io_mem_rsp_payload_error);
  assign lineLoader_write_tag_0_payload_data_address = lineLoader_address[31 : 12];
  assign lineLoader_write_data_0_valid = (io_mem_rsp_valid && _zz_6_);
  assign lineLoader_write_data_0_payload_address = {lineLoader_address[11 : 5],lineLoader_wordIndex};
  assign lineLoader_write_data_0_payload_data = io_mem_rsp_payload_data;
  assign _zz_7_ = (lineLoader_wayToAllocate_value == (1'b1));
  assign lineLoader_write_tag_1_valid = ((_zz_7_ && lineLoader_fire) || (! lineLoader_flushCounter[7]));
  assign lineLoader_write_tag_1_payload_address = (lineLoader_flushCounter[7] ? lineLoader_address[11 : 5] : lineLoader_flushCounter[6 : 0]);
  assign lineLoader_write_tag_1_payload_data_valid = lineLoader_flushCounter[7];
  assign lineLoader_write_tag_1_payload_data_error = (lineLoader_hadError || io_mem_rsp_payload_error);
  assign lineLoader_write_tag_1_payload_data_address = lineLoader_address[31 : 12];
  assign lineLoader_write_data_1_valid = (io_mem_rsp_valid && _zz_7_);
  assign lineLoader_write_data_1_payload_address = {lineLoader_address[11 : 5],lineLoader_wordIndex};
  assign lineLoader_write_data_1_payload_data = io_mem_rsp_payload_data;
  assign _zz_8_ = io_cpu_prefetch_pc[11 : 5];
  assign _zz_9_ = (! io_cpu_fetch_isStuck);
  assign _zz_10_ = _zz_20_;
  assign fetchStage_read_waysValues_0_tag_valid = _zz_28_[0];
  assign fetchStage_read_waysValues_0_tag_error = _zz_29_[0];
  assign fetchStage_read_waysValues_0_tag_address = _zz_10_[21 : 2];
  assign _zz_11_ = io_cpu_prefetch_pc[11 : 2];
  assign _zz_12_ = (! io_cpu_fetch_isStuck);
  assign fetchStage_read_waysValues_0_data = _zz_21_;
  assign _zz_13_ = io_cpu_prefetch_pc[11 : 5];
  assign _zz_14_ = (! io_cpu_fetch_isStuck);
  assign _zz_15_ = _zz_22_;
  assign fetchStage_read_waysValues_1_tag_valid = _zz_30_[0];
  assign fetchStage_read_waysValues_1_tag_error = _zz_31_[0];
  assign fetchStage_read_waysValues_1_tag_address = _zz_15_[21 : 2];
  assign _zz_16_ = io_cpu_prefetch_pc[11 : 2];
  assign _zz_17_ = (! io_cpu_fetch_isStuck);
  assign fetchStage_read_waysValues_1_data = _zz_23_;
  assign io_cpu_fetch_mmuBus_cmd_isValid = io_cpu_fetch_isValid;
  assign io_cpu_fetch_mmuBus_cmd_virtualAddress = io_cpu_fetch_pc;
  assign io_cpu_fetch_mmuBus_cmd_bypassTranslation = 1'b0;
  assign io_cpu_fetch_mmuBus_end = ((! io_cpu_fetch_isStuck) || io_cpu_fetch_isRemoved);
  assign io_cpu_fetch_physicalAddress = io_cpu_fetch_mmuBus_rsp_physicalAddress;
  assign decodeStage_hit_hits_0 = (decodeStage_hit_tags_0_valid && (decodeStage_hit_tags_0_address == decodeStage_mmuRsp_physicalAddress[31 : 12]));
  assign decodeStage_hit_hits_1 = (decodeStage_hit_tags_1_valid && (decodeStage_hit_tags_1_address == decodeStage_mmuRsp_physicalAddress[31 : 12]));
  assign decodeStage_hit_valid = ({decodeStage_hit_hits_1,decodeStage_hit_hits_0} != (2'b00));
  assign decodeStage_hit_id = decodeStage_hit_hits_1;
  assign decodeStage_hit_error = _zz_24_;
  assign decodeStage_hit_data = _zz_25_;
  always @ (*) begin
    decodeStage_hit_word = decodeStage_hit_data[31 : 0];
    if(io_cpu_fetch_dataBypassValid_regNextWhen)begin
      decodeStage_hit_word = io_cpu_fetch_dataBypass_regNextWhen;
    end
  end

  assign io_cpu_decode_data = decodeStage_hit_word;
  assign io_cpu_decode_cacheMiss = (! decodeStage_hit_valid);
  assign io_cpu_decode_error = decodeStage_hit_error;
  assign io_cpu_decode_mmuRefilling = decodeStage_mmuRsp_refilling;
  assign io_cpu_decode_mmuException = ((! decodeStage_mmuRsp_refilling) && (decodeStage_mmuRsp_exception || (! decodeStage_mmuRsp_allowExecute)));
  assign io_cpu_decode_physicalAddress = decodeStage_mmuRsp_physicalAddress;
  always @ (posedge clk) begin
    if(reset) begin
      lineLoader_valid <= 1'b0;
      lineLoader_hadError <= 1'b0;
      lineLoader_flushPending <= 1'b1;
      lineLoader_cmdSent <= 1'b0;
      lineLoader_wayToAllocate_value <= (1'b0);
      lineLoader_wordIndex <= (3'b000);
    end else begin
      if(lineLoader_fire)begin
        lineLoader_valid <= 1'b0;
      end
      if(lineLoader_fire)begin
        lineLoader_hadError <= 1'b0;
      end
      if(io_cpu_fill_valid)begin
        lineLoader_valid <= 1'b1;
      end
      if(io_flush)begin
        lineLoader_flushPending <= 1'b1;
      end
      if(_zz_27_)begin
        lineLoader_flushPending <= 1'b0;
      end
      if((io_mem_cmd_valid && io_mem_cmd_ready))begin
        lineLoader_cmdSent <= 1'b1;
      end
      if(lineLoader_fire)begin
        lineLoader_cmdSent <= 1'b0;
      end
      lineLoader_wayToAllocate_value <= lineLoader_wayToAllocate_valueNext;
      if(io_mem_rsp_valid)begin
        lineLoader_wordIndex <= (lineLoader_wordIndex + (3'b001));
        if(io_mem_rsp_payload_error)begin
          lineLoader_hadError <= 1'b1;
        end
      end
    end
  end

  always @ (posedge clk) begin
    if(io_cpu_fill_valid)begin
      lineLoader_address <= io_cpu_fill_payload;
    end
    if(_zz_26_)begin
      lineLoader_flushCounter <= (lineLoader_flushCounter + (8'b00000001));
    end
    _zz_5_ <= lineLoader_flushCounter[7];
    if(_zz_27_)begin
      lineLoader_flushCounter <= (8'b00000000);
    end
    if((! io_cpu_decode_isStuck))begin
      decodeStage_mmuRsp_physicalAddress <= io_cpu_fetch_mmuBus_rsp_physicalAddress;
      decodeStage_mmuRsp_isIoAccess <= io_cpu_fetch_mmuBus_rsp_isIoAccess;
      decodeStage_mmuRsp_allowRead <= io_cpu_fetch_mmuBus_rsp_allowRead;
      decodeStage_mmuRsp_allowWrite <= io_cpu_fetch_mmuBus_rsp_allowWrite;
      decodeStage_mmuRsp_allowExecute <= io_cpu_fetch_mmuBus_rsp_allowExecute;
      decodeStage_mmuRsp_exception <= io_cpu_fetch_mmuBus_rsp_exception;
      decodeStage_mmuRsp_refilling <= io_cpu_fetch_mmuBus_rsp_refilling;
    end
    if((! io_cpu_decode_isStuck))begin
      decodeStage_hit_tags_0_valid <= fetchStage_read_waysValues_0_tag_valid;
      decodeStage_hit_tags_0_error <= fetchStage_read_waysValues_0_tag_error;
      decodeStage_hit_tags_0_address <= fetchStage_read_waysValues_0_tag_address;
    end
    if((! io_cpu_decode_isStuck))begin
      decodeStage_hit_tags_1_valid <= fetchStage_read_waysValues_1_tag_valid;
      decodeStage_hit_tags_1_error <= fetchStage_read_waysValues_1_tag_error;
      decodeStage_hit_tags_1_address <= fetchStage_read_waysValues_1_tag_address;
    end
    if((! io_cpu_decode_isStuck))begin
      _zz_18_ <= fetchStage_read_waysValues_0_data;
    end
    if((! io_cpu_decode_isStuck))begin
      _zz_19_ <= fetchStage_read_waysValues_1_data;
    end
    if((! io_cpu_decode_isStuck))begin
      io_cpu_fetch_dataBypassValid_regNextWhen <= io_cpu_fetch_dataBypassValid;
    end
  end

  always @ (posedge clk) begin
    if((! io_cpu_decode_isStuck))begin
      io_cpu_fetch_dataBypass_regNextWhen <= io_cpu_fetch_dataBypass;
    end
  end

endmodule

module DataCache (
      input   io_cpu_execute_isValid,
      input  [31:0] io_cpu_execute_address,
      input   io_cpu_execute_args_wr,
      input  [31:0] io_cpu_execute_args_data,
      input  [1:0] io_cpu_execute_args_size,
      input   io_cpu_execute_args_isLrsc,
      input   io_cpu_execute_args_isAmo,
      input   io_cpu_execute_args_amoCtrl_swap,
      input  [2:0] io_cpu_execute_args_amoCtrl_alu,
      input   io_cpu_memory_isValid,
      input   io_cpu_memory_isStuck,
      input   io_cpu_memory_isRemoved,
      output  io_cpu_memory_isWrite,
      input  [31:0] io_cpu_memory_address,
      output  io_cpu_memory_mmuBus_cmd_isValid,
      output [31:0] io_cpu_memory_mmuBus_cmd_virtualAddress,
      output  io_cpu_memory_mmuBus_cmd_bypassTranslation,
      input  [31:0] io_cpu_memory_mmuBus_rsp_physicalAddress,
      input   io_cpu_memory_mmuBus_rsp_isIoAccess,
      input   io_cpu_memory_mmuBus_rsp_allowRead,
      input   io_cpu_memory_mmuBus_rsp_allowWrite,
      input   io_cpu_memory_mmuBus_rsp_allowExecute,
      input   io_cpu_memory_mmuBus_rsp_exception,
      input   io_cpu_memory_mmuBus_rsp_refilling,
      output  io_cpu_memory_mmuBus_end,
      input   io_cpu_memory_mmuBus_busy,
      input   io_cpu_writeBack_isValid,
      input   io_cpu_writeBack_isStuck,
      input   io_cpu_writeBack_isUser,
      output reg  io_cpu_writeBack_haltIt,
      output  io_cpu_writeBack_isWrite,
      output reg [31:0] io_cpu_writeBack_data,
      input  [31:0] io_cpu_writeBack_address,
      output  io_cpu_writeBack_mmuException,
      output  io_cpu_writeBack_unalignedAccess,
      output reg  io_cpu_writeBack_accessError,
      input   io_cpu_writeBack_clearLrsc,
      output reg  io_cpu_redo,
      input   io_cpu_flush_valid,
      output reg  io_cpu_flush_ready,
      output reg  io_mem_cmd_valid,
      input   io_mem_cmd_ready,
      output reg  io_mem_cmd_payload_wr,
      output reg [31:0] io_mem_cmd_payload_address,
      output [31:0] io_mem_cmd_payload_data,
      output [3:0] io_mem_cmd_payload_mask,
      output reg [2:0] io_mem_cmd_payload_length,
      output reg  io_mem_cmd_payload_last,
      input   io_mem_rsp_valid,
      input  [31:0] io_mem_rsp_payload_data,
      input   io_mem_rsp_payload_error,
      input   clk,
      input   reset);
  reg [21:0] _zz_17_;
  reg [31:0] _zz_18_;
  reg [21:0] _zz_19_;
  reg [31:0] _zz_20_;
  wire  _zz_21_;
  wire  _zz_22_;
  wire  _zz_23_;
  wire  _zz_24_;
  wire  _zz_25_;
  wire  _zz_26_;
  wire  _zz_27_;
  wire  _zz_28_;
  wire  _zz_29_;
  wire  _zz_30_;
  wire [2:0] _zz_31_;
  wire [0:0] _zz_32_;
  wire [0:0] _zz_33_;
  wire [0:0] _zz_34_;
  wire [0:0] _zz_35_;
  wire [31:0] _zz_36_;
  wire [31:0] _zz_37_;
  wire [31:0] _zz_38_;
  wire [31:0] _zz_39_;
  wire [1:0] _zz_40_;
  wire [31:0] _zz_41_;
  wire [1:0] _zz_42_;
  wire [1:0] _zz_43_;
  wire [0:0] _zz_44_;
  wire [0:0] _zz_45_;
  wire [2:0] _zz_46_;
  wire [2:0] _zz_47_;
  wire [21:0] _zz_48_;
  wire [21:0] _zz_49_;
  reg  _zz_1_;
  reg  _zz_2_;
  reg  _zz_3_;
  reg  _zz_4_;
  wire  haltCpu;
  reg  tagsReadCmd_valid;
  reg [6:0] tagsReadCmd_payload;
  reg  tagsWriteCmd_valid;
  reg [1:0] tagsWriteCmd_payload_way;
  reg [6:0] tagsWriteCmd_payload_address;
  reg  tagsWriteCmd_payload_data_valid;
  reg  tagsWriteCmd_payload_data_error;
  reg [19:0] tagsWriteCmd_payload_data_address;
  reg  tagsWriteLastCmd_valid;
  reg [1:0] tagsWriteLastCmd_payload_way;
  reg [6:0] tagsWriteLastCmd_payload_address;
  reg  tagsWriteLastCmd_payload_data_valid;
  reg  tagsWriteLastCmd_payload_data_error;
  reg [19:0] tagsWriteLastCmd_payload_data_address;
  reg  dataReadCmd_valid;
  reg [9:0] dataReadCmd_payload;
  reg  dataWriteCmd_valid;
  reg [1:0] dataWriteCmd_payload_way;
  reg [9:0] dataWriteCmd_payload_address;
  reg [31:0] dataWriteCmd_payload_data;
  reg [3:0] dataWriteCmd_payload_mask;
  wire  _zz_5_;
  wire  ways_0_tagsReadRsp_valid;
  wire  ways_0_tagsReadRsp_error;
  wire [19:0] ways_0_tagsReadRsp_address;
  wire [21:0] _zz_6_;
  wire  _zz_7_;
  wire [31:0] ways_0_dataReadRsp;
  wire  _zz_8_;
  wire  ways_1_tagsReadRsp_valid;
  wire  ways_1_tagsReadRsp_error;
  wire [19:0] ways_1_tagsReadRsp_address;
  wire [21:0] _zz_9_;
  wire  _zz_10_;
  wire [31:0] ways_1_dataReadRsp;
  reg [3:0] _zz_11_;
  wire [3:0] stage0_mask;
  wire [9:0] _zz_12_;
  reg [1:0] stage0_colisions;
  reg  stageA_request_wr;
  reg [31:0] stageA_request_data;
  reg [1:0] stageA_request_size;
  reg  stageA_request_isLrsc;
  reg  stageA_request_isAmo;
  reg  stageA_request_amoCtrl_swap;
  reg [2:0] stageA_request_amoCtrl_alu;
  reg [3:0] stageA_mask;
  wire  stageA_wayHits_0;
  wire  stageA_wayHits_1;
  reg [1:0] stage0_colisions_regNextWhen;
  wire [9:0] _zz_13_;
  reg [1:0] _zz_14_;
  wire [1:0] stageA_colisions;
  reg  stageB_request_wr;
  reg [31:0] stageB_request_data;
  reg [1:0] stageB_request_size;
  reg  stageB_request_isLrsc;
  reg  stageB_isAmo;
  reg  stageB_request_amoCtrl_swap;
  reg [2:0] stageB_request_amoCtrl_alu;
  reg  stageB_mmuRspFreeze;
  reg [31:0] stageB_mmuRsp_physicalAddress;
  reg  stageB_mmuRsp_isIoAccess;
  reg  stageB_mmuRsp_allowRead;
  reg  stageB_mmuRsp_allowWrite;
  reg  stageB_mmuRsp_allowExecute;
  reg  stageB_mmuRsp_exception;
  reg  stageB_mmuRsp_refilling;
  reg  stageB_tagsReadRsp_0_valid;
  reg  stageB_tagsReadRsp_0_error;
  reg [19:0] stageB_tagsReadRsp_0_address;
  reg  stageB_tagsReadRsp_1_valid;
  reg  stageB_tagsReadRsp_1_error;
  reg [19:0] stageB_tagsReadRsp_1_address;
  reg [31:0] stageB_dataReadRsp_0;
  reg [31:0] stageB_dataReadRsp_1;
  reg [1:0] _zz_15_;
  reg [1:0] stageB_waysHits;
  wire  stageB_waysHit;
  wire [31:0] stageB_dataMux;
  reg [3:0] stageB_mask;
  reg [1:0] stageB_colisions;
  reg  stageB_loaderValid;
  reg  stageB_flusher_valid;
  reg  stageB_lrsc_reserved;
  reg [31:0] stageB_requestDataBypass;
  wire  stageB_amo_compare;
  wire  stageB_amo_unsigned;
  wire [31:0] stageB_amo_addSub;
  wire  stageB_amo_less;
  wire  stageB_amo_selectRf;
  reg [31:0] stageB_amo_result;
  reg  stageB_amo_resultRegValid;
  reg [31:0] stageB_amo_resultReg;
  reg  stageB_memCmdSent;
  reg [1:0] _zz_16_;
  reg  loader_valid;
  reg  loader_counter_willIncrement;
  wire  loader_counter_willClear;
  reg [2:0] loader_counter_valueNext;
  reg [2:0] loader_counter_value;
  wire  loader_counter_willOverflowIfInc;
  wire  loader_counter_willOverflow;
  reg [1:0] loader_waysAllocator;
  reg  loader_error;
  (* ram_style = "block" *) reg [21:0] ways_0_tags [0:127];
  (* ram_style = "block" *) reg [7:0] ways_0_data_symbol0 [0:1023];
  (* ram_style = "block" *) reg [7:0] ways_0_data_symbol1 [0:1023];
  (* ram_style = "block" *) reg [7:0] ways_0_data_symbol2 [0:1023];
  (* ram_style = "block" *) reg [7:0] ways_0_data_symbol3 [0:1023];
  reg [7:0] _zz_50_;
  reg [7:0] _zz_51_;
  reg [7:0] _zz_52_;
  reg [7:0] _zz_53_;
  (* ram_style = "block" *) reg [21:0] ways_1_tags [0:127];
  (* ram_style = "block" *) reg [7:0] ways_1_data_symbol0 [0:1023];
  (* ram_style = "block" *) reg [7:0] ways_1_data_symbol1 [0:1023];
  (* ram_style = "block" *) reg [7:0] ways_1_data_symbol2 [0:1023];
  (* ram_style = "block" *) reg [7:0] ways_1_data_symbol3 [0:1023];
  reg [7:0] _zz_54_;
  reg [7:0] _zz_55_;
  reg [7:0] _zz_56_;
  reg [7:0] _zz_57_;
  assign _zz_21_ = (io_cpu_execute_isValid && (! io_cpu_memory_isStuck));
  assign _zz_22_ = (((stageB_mmuRsp_refilling || io_cpu_writeBack_accessError) || io_cpu_writeBack_mmuException) || io_cpu_writeBack_unalignedAccess);
  assign _zz_23_ = (stageB_waysHit || (stageB_request_wr && (! stageB_isAmo)));
  assign _zz_24_ = (! stageB_amo_resultRegValid);
  assign _zz_25_ = (stageB_request_isLrsc && (! stageB_lrsc_reserved));
  assign _zz_26_ = (loader_valid && io_mem_rsp_valid);
  assign _zz_27_ = (stageB_request_isLrsc && (! stageB_lrsc_reserved));
  assign _zz_28_ = ((((io_cpu_flush_valid && (! io_cpu_execute_isValid)) && (! io_cpu_memory_isValid)) && (! io_cpu_writeBack_isValid)) && (! io_cpu_redo));
  assign _zz_29_ = (((! stageB_request_wr) || stageB_isAmo) && ((stageB_colisions & stageB_waysHits) != (2'b00)));
  assign _zz_30_ = ((! io_cpu_writeBack_isStuck) && (! stageB_mmuRspFreeze));
  assign _zz_31_ = (stageB_request_amoCtrl_alu | {stageB_request_amoCtrl_swap,(2'b00)});
  assign _zz_32_ = _zz_6_[0 : 0];
  assign _zz_33_ = _zz_6_[1 : 1];
  assign _zz_34_ = _zz_9_[0 : 0];
  assign _zz_35_ = _zz_9_[1 : 1];
  assign _zz_36_ = ($signed(_zz_37_) + $signed(_zz_41_));
  assign _zz_37_ = ($signed(_zz_38_) + $signed(_zz_39_));
  assign _zz_38_ = stageB_request_data;
  assign _zz_39_ = (stageB_amo_compare ? (~ stageB_dataMux) : stageB_dataMux);
  assign _zz_40_ = (stageB_amo_compare ? _zz_42_ : _zz_43_);
  assign _zz_41_ = {{30{_zz_40_[1]}}, _zz_40_};
  assign _zz_42_ = (2'b01);
  assign _zz_43_ = (2'b00);
  assign _zz_44_ = (! stageB_lrsc_reserved);
  assign _zz_45_ = loader_counter_willIncrement;
  assign _zz_46_ = {2'd0, _zz_45_};
  assign _zz_47_ = {loader_waysAllocator,loader_waysAllocator[1]};
  assign _zz_48_ = {tagsWriteCmd_payload_data_address,{tagsWriteCmd_payload_data_error,tagsWriteCmd_payload_data_valid}};
  assign _zz_49_ = {tagsWriteCmd_payload_data_address,{tagsWriteCmd_payload_data_error,tagsWriteCmd_payload_data_valid}};
  always @ (posedge clk) begin
    if(_zz_4_) begin
      ways_0_tags[tagsWriteCmd_payload_address] <= _zz_48_;
    end
  end

  always @ (posedge clk) begin
    if(_zz_5_) begin
      _zz_17_ <= ways_0_tags[tagsReadCmd_payload];
    end
  end

  always @ (*) begin
    _zz_18_ = {_zz_53_, _zz_52_, _zz_51_, _zz_50_};
  end
  always @ (posedge clk) begin
    if(dataWriteCmd_payload_mask[0] && _zz_3_) begin
      ways_0_data_symbol0[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[7 : 0];
    end
    if(dataWriteCmd_payload_mask[1] && _zz_3_) begin
      ways_0_data_symbol1[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[15 : 8];
    end
    if(dataWriteCmd_payload_mask[2] && _zz_3_) begin
      ways_0_data_symbol2[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[23 : 16];
    end
    if(dataWriteCmd_payload_mask[3] && _zz_3_) begin
      ways_0_data_symbol3[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[31 : 24];
    end
  end

  always @ (posedge clk) begin
    if(_zz_7_) begin
      _zz_50_ <= ways_0_data_symbol0[dataReadCmd_payload];
      _zz_51_ <= ways_0_data_symbol1[dataReadCmd_payload];
      _zz_52_ <= ways_0_data_symbol2[dataReadCmd_payload];
      _zz_53_ <= ways_0_data_symbol3[dataReadCmd_payload];
    end
  end

  always @ (posedge clk) begin
    if(_zz_2_) begin
      ways_1_tags[tagsWriteCmd_payload_address] <= _zz_49_;
    end
  end

  always @ (posedge clk) begin
    if(_zz_8_) begin
      _zz_19_ <= ways_1_tags[tagsReadCmd_payload];
    end
  end

  always @ (*) begin
    _zz_20_ = {_zz_57_, _zz_56_, _zz_55_, _zz_54_};
  end
  always @ (posedge clk) begin
    if(dataWriteCmd_payload_mask[0] && _zz_1_) begin
      ways_1_data_symbol0[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[7 : 0];
    end
    if(dataWriteCmd_payload_mask[1] && _zz_1_) begin
      ways_1_data_symbol1[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[15 : 8];
    end
    if(dataWriteCmd_payload_mask[2] && _zz_1_) begin
      ways_1_data_symbol2[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[23 : 16];
    end
    if(dataWriteCmd_payload_mask[3] && _zz_1_) begin
      ways_1_data_symbol3[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[31 : 24];
    end
  end

  always @ (posedge clk) begin
    if(_zz_10_) begin
      _zz_54_ <= ways_1_data_symbol0[dataReadCmd_payload];
      _zz_55_ <= ways_1_data_symbol1[dataReadCmd_payload];
      _zz_56_ <= ways_1_data_symbol2[dataReadCmd_payload];
      _zz_57_ <= ways_1_data_symbol3[dataReadCmd_payload];
    end
  end

  always @ (*) begin
    _zz_1_ = 1'b0;
    if((dataWriteCmd_valid && dataWriteCmd_payload_way[1]))begin
      _zz_1_ = 1'b1;
    end
  end

  always @ (*) begin
    _zz_2_ = 1'b0;
    if((tagsWriteCmd_valid && tagsWriteCmd_payload_way[1]))begin
      _zz_2_ = 1'b1;
    end
  end

  always @ (*) begin
    _zz_3_ = 1'b0;
    if((dataWriteCmd_valid && dataWriteCmd_payload_way[0]))begin
      _zz_3_ = 1'b1;
    end
  end

  always @ (*) begin
    _zz_4_ = 1'b0;
    if((tagsWriteCmd_valid && tagsWriteCmd_payload_way[0]))begin
      _zz_4_ = 1'b1;
    end
  end

  assign haltCpu = 1'b0;
  assign _zz_5_ = (tagsReadCmd_valid && (! io_cpu_memory_isStuck));
  assign _zz_6_ = _zz_17_;
  assign ways_0_tagsReadRsp_valid = _zz_32_[0];
  assign ways_0_tagsReadRsp_error = _zz_33_[0];
  assign ways_0_tagsReadRsp_address = _zz_6_[21 : 2];
  assign _zz_7_ = (dataReadCmd_valid && (! io_cpu_memory_isStuck));
  assign ways_0_dataReadRsp = _zz_18_;
  assign _zz_8_ = (tagsReadCmd_valid && (! io_cpu_memory_isStuck));
  assign _zz_9_ = _zz_19_;
  assign ways_1_tagsReadRsp_valid = _zz_34_[0];
  assign ways_1_tagsReadRsp_error = _zz_35_[0];
  assign ways_1_tagsReadRsp_address = _zz_9_[21 : 2];
  assign _zz_10_ = (dataReadCmd_valid && (! io_cpu_memory_isStuck));
  assign ways_1_dataReadRsp = _zz_20_;
  always @ (*) begin
    tagsReadCmd_valid = 1'b0;
    if(_zz_21_)begin
      tagsReadCmd_valid = 1'b1;
    end
  end

  always @ (*) begin
    tagsReadCmd_payload = (7'bxxxxxxx);
    if(_zz_21_)begin
      tagsReadCmd_payload = io_cpu_execute_address[11 : 5];
    end
  end

  always @ (*) begin
    dataReadCmd_valid = 1'b0;
    if(_zz_21_)begin
      dataReadCmd_valid = 1'b1;
    end
  end

  always @ (*) begin
    dataReadCmd_payload = (10'bxxxxxxxxxx);
    if(_zz_21_)begin
      dataReadCmd_payload = io_cpu_execute_address[11 : 2];
    end
  end

  always @ (*) begin
    tagsWriteCmd_valid = 1'b0;
    if(stageB_flusher_valid)begin
      tagsWriteCmd_valid = stageB_flusher_valid;
    end
    if(_zz_22_)begin
      tagsWriteCmd_valid = 1'b0;
    end
    if(loader_counter_willOverflow)begin
      tagsWriteCmd_valid = 1'b1;
    end
  end

  always @ (*) begin
    tagsWriteCmd_payload_way = (2'bxx);
    if(stageB_flusher_valid)begin
      tagsWriteCmd_payload_way = (2'b11);
    end
    if(loader_counter_willOverflow)begin
      tagsWriteCmd_payload_way = loader_waysAllocator;
    end
  end

  always @ (*) begin
    tagsWriteCmd_payload_address = (7'bxxxxxxx);
    if(stageB_flusher_valid)begin
      tagsWriteCmd_payload_address = stageB_mmuRsp_physicalAddress[11 : 5];
    end
    if(loader_counter_willOverflow)begin
      tagsWriteCmd_payload_address = stageB_mmuRsp_physicalAddress[11 : 5];
    end
  end

  always @ (*) begin
    tagsWriteCmd_payload_data_valid = 1'bx;
    if(stageB_flusher_valid)begin
      tagsWriteCmd_payload_data_valid = 1'b0;
    end
    if(loader_counter_willOverflow)begin
      tagsWriteCmd_payload_data_valid = 1'b1;
    end
  end

  always @ (*) begin
    tagsWriteCmd_payload_data_error = 1'bx;
    if(loader_counter_willOverflow)begin
      tagsWriteCmd_payload_data_error = (loader_error || io_mem_rsp_payload_error);
    end
  end

  always @ (*) begin
    tagsWriteCmd_payload_data_address = (20'bxxxxxxxxxxxxxxxxxxxx);
    if(loader_counter_willOverflow)begin
      tagsWriteCmd_payload_data_address = stageB_mmuRsp_physicalAddress[31 : 12];
    end
  end

  always @ (*) begin
    dataWriteCmd_valid = 1'b0;
    if(io_cpu_writeBack_isValid)begin
      if(! stageB_mmuRsp_isIoAccess) begin
        if(_zz_23_)begin
          if((stageB_request_wr && stageB_waysHit))begin
            dataWriteCmd_valid = 1'b1;
          end
          if(stageB_isAmo)begin
            if(_zz_24_)begin
              dataWriteCmd_valid = 1'b0;
            end
          end
          if(_zz_25_)begin
            dataWriteCmd_valid = 1'b0;
          end
        end
      end
    end
    if(_zz_22_)begin
      dataWriteCmd_valid = 1'b0;
    end
    if(_zz_26_)begin
      dataWriteCmd_valid = 1'b1;
    end
  end

  always @ (*) begin
    dataWriteCmd_payload_way = (2'bxx);
    if(io_cpu_writeBack_isValid)begin
      if(! stageB_mmuRsp_isIoAccess) begin
        if(_zz_23_)begin
          dataWriteCmd_payload_way = stageB_waysHits;
        end
      end
    end
    if(_zz_26_)begin
      dataWriteCmd_payload_way = loader_waysAllocator;
    end
  end

  always @ (*) begin
    dataWriteCmd_payload_address = (10'bxxxxxxxxxx);
    if(io_cpu_writeBack_isValid)begin
      if(! stageB_mmuRsp_isIoAccess) begin
        if(_zz_23_)begin
          dataWriteCmd_payload_address = stageB_mmuRsp_physicalAddress[11 : 2];
        end
      end
    end
    if(_zz_26_)begin
      dataWriteCmd_payload_address = {stageB_mmuRsp_physicalAddress[11 : 5],loader_counter_value};
    end
  end

  always @ (*) begin
    dataWriteCmd_payload_data = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    if(io_cpu_writeBack_isValid)begin
      if(! stageB_mmuRsp_isIoAccess) begin
        if(_zz_23_)begin
          dataWriteCmd_payload_data = stageB_requestDataBypass;
        end
      end
    end
    if(_zz_26_)begin
      dataWriteCmd_payload_data = io_mem_rsp_payload_data;
    end
  end

  always @ (*) begin
    dataWriteCmd_payload_mask = (4'bxxxx);
    if(io_cpu_writeBack_isValid)begin
      if(! stageB_mmuRsp_isIoAccess) begin
        if(_zz_23_)begin
          dataWriteCmd_payload_mask = stageB_mask;
        end
      end
    end
    if(_zz_26_)begin
      dataWriteCmd_payload_mask = (4'b1111);
    end
  end

  always @ (*) begin
    case(io_cpu_execute_args_size)
      2'b00 : begin
        _zz_11_ = (4'b0001);
      end
      2'b01 : begin
        _zz_11_ = (4'b0011);
      end
      default : begin
        _zz_11_ = (4'b1111);
      end
    endcase
  end

  assign stage0_mask = (_zz_11_ <<< io_cpu_execute_address[1 : 0]);
  assign _zz_12_ = io_cpu_execute_address[11 : 2];
  always @ (*) begin
    stage0_colisions[0] = (((dataWriteCmd_valid && dataWriteCmd_payload_way[0]) && (dataWriteCmd_payload_address == _zz_12_)) && ((stage0_mask & dataWriteCmd_payload_mask) != (4'b0000)));
    stage0_colisions[1] = (((dataWriteCmd_valid && dataWriteCmd_payload_way[1]) && (dataWriteCmd_payload_address == _zz_12_)) && ((stage0_mask & dataWriteCmd_payload_mask) != (4'b0000)));
  end

  assign io_cpu_memory_mmuBus_cmd_isValid = io_cpu_memory_isValid;
  assign io_cpu_memory_mmuBus_cmd_virtualAddress = io_cpu_memory_address;
  assign io_cpu_memory_mmuBus_cmd_bypassTranslation = 1'b0;
  assign io_cpu_memory_mmuBus_end = ((! io_cpu_memory_isStuck) || io_cpu_memory_isRemoved);
  assign io_cpu_memory_isWrite = stageA_request_wr;
  assign stageA_wayHits_0 = ((io_cpu_memory_mmuBus_rsp_physicalAddress[31 : 12] == ways_0_tagsReadRsp_address) && ways_0_tagsReadRsp_valid);
  assign stageA_wayHits_1 = ((io_cpu_memory_mmuBus_rsp_physicalAddress[31 : 12] == ways_1_tagsReadRsp_address) && ways_1_tagsReadRsp_valid);
  assign _zz_13_ = io_cpu_memory_address[11 : 2];
  always @ (*) begin
    _zz_14_[0] = (((dataWriteCmd_valid && dataWriteCmd_payload_way[0]) && (dataWriteCmd_payload_address == _zz_13_)) && ((stageA_mask & dataWriteCmd_payload_mask) != (4'b0000)));
    _zz_14_[1] = (((dataWriteCmd_valid && dataWriteCmd_payload_way[1]) && (dataWriteCmd_payload_address == _zz_13_)) && ((stageA_mask & dataWriteCmd_payload_mask) != (4'b0000)));
  end

  assign stageA_colisions = (stage0_colisions_regNextWhen | _zz_14_);
  always @ (*) begin
    stageB_mmuRspFreeze = 1'b0;
    if((stageB_loaderValid || loader_valid))begin
      stageB_mmuRspFreeze = 1'b1;
    end
  end

  always @ (*) begin
    _zz_15_[0] = stageA_wayHits_0;
    _zz_15_[1] = stageA_wayHits_1;
  end

  assign stageB_waysHit = (stageB_waysHits != (2'b00));
  assign stageB_dataMux = (stageB_waysHits[0] ? stageB_dataReadRsp_0 : stageB_dataReadRsp_1);
  always @ (*) begin
    stageB_loaderValid = 1'b0;
    if(io_cpu_writeBack_isValid)begin
      if(! stageB_mmuRsp_isIoAccess) begin
        if(! _zz_23_) begin
          if(io_mem_cmd_ready)begin
            stageB_loaderValid = 1'b1;
          end
        end
      end
    end
    if(_zz_22_)begin
      stageB_loaderValid = 1'b0;
    end
  end

  always @ (*) begin
    io_cpu_writeBack_haltIt = io_cpu_writeBack_isValid;
    if(stageB_flusher_valid)begin
      io_cpu_writeBack_haltIt = 1'b1;
    end
    if(io_cpu_writeBack_isValid)begin
      if(stageB_mmuRsp_isIoAccess)begin
        if((stageB_request_wr ? io_mem_cmd_ready : io_mem_rsp_valid))begin
          io_cpu_writeBack_haltIt = 1'b0;
        end
        if(_zz_27_)begin
          io_cpu_writeBack_haltIt = 1'b0;
        end
      end else begin
        if(_zz_23_)begin
          if(((! stageB_request_wr) || io_mem_cmd_ready))begin
            io_cpu_writeBack_haltIt = 1'b0;
          end
          if(stageB_isAmo)begin
            if(_zz_24_)begin
              io_cpu_writeBack_haltIt = 1'b1;
            end
          end
          if(_zz_25_)begin
            io_cpu_writeBack_haltIt = 1'b0;
          end
        end
      end
    end
    if(_zz_22_)begin
      io_cpu_writeBack_haltIt = 1'b0;
    end
  end

  always @ (*) begin
    io_cpu_flush_ready = 1'b0;
    if(_zz_28_)begin
      io_cpu_flush_ready = 1'b1;
    end
  end

  always @ (*) begin
    stageB_requestDataBypass = stageB_request_data;
    if(stageB_isAmo)begin
      stageB_requestDataBypass = stageB_amo_resultReg;
    end
  end

  assign stageB_amo_compare = stageB_request_amoCtrl_alu[2];
  assign stageB_amo_unsigned = (stageB_request_amoCtrl_alu[2 : 1] == (2'b11));
  assign stageB_amo_addSub = _zz_36_;
  assign stageB_amo_less = ((stageB_request_data[31] == stageB_dataMux[31]) ? stageB_amo_addSub[31] : (stageB_amo_unsigned ? stageB_dataMux[31] : stageB_request_data[31]));
  assign stageB_amo_selectRf = (stageB_request_amoCtrl_swap ? 1'b1 : (stageB_request_amoCtrl_alu[0] ^ stageB_amo_less));
  always @ (*) begin
    case(_zz_31_)
      3'b000 : begin
        stageB_amo_result = stageB_amo_addSub;
      end
      3'b001 : begin
        stageB_amo_result = (stageB_request_data ^ stageB_dataMux);
      end
      3'b010 : begin
        stageB_amo_result = (stageB_request_data | stageB_dataMux);
      end
      3'b011 : begin
        stageB_amo_result = (stageB_request_data & stageB_dataMux);
      end
      default : begin
        stageB_amo_result = (stageB_amo_selectRf ? stageB_request_data : stageB_dataMux);
      end
    endcase
  end

  always @ (*) begin
    io_cpu_redo = 1'b0;
    if(io_cpu_writeBack_isValid)begin
      if(! stageB_mmuRsp_isIoAccess) begin
        if(_zz_23_)begin
          if(_zz_29_)begin
            io_cpu_redo = 1'b1;
          end
        end
      end
    end
    if((io_cpu_writeBack_isValid && stageB_mmuRsp_refilling))begin
      io_cpu_redo = 1'b1;
    end
    if(loader_valid)begin
      io_cpu_redo = 1'b1;
    end
  end

  always @ (*) begin
    io_cpu_writeBack_accessError = 1'b0;
    if(stageB_mmuRsp_isIoAccess)begin
      io_cpu_writeBack_accessError = (io_mem_rsp_valid && io_mem_rsp_payload_error);
    end else begin
      io_cpu_writeBack_accessError = ((stageB_waysHits & _zz_16_) != (2'b00));
    end
  end

  assign io_cpu_writeBack_mmuException = (io_cpu_writeBack_isValid && ((stageB_mmuRsp_exception || ((! stageB_mmuRsp_allowWrite) && stageB_request_wr)) || ((! stageB_mmuRsp_allowRead) && ((! stageB_request_wr) || stageB_isAmo))));
  assign io_cpu_writeBack_unalignedAccess = (io_cpu_writeBack_isValid && (((stageB_request_size == (2'b10)) && (stageB_mmuRsp_physicalAddress[1 : 0] != (2'b00))) || ((stageB_request_size == (2'b01)) && (stageB_mmuRsp_physicalAddress[0 : 0] != (1'b0)))));
  assign io_cpu_writeBack_isWrite = stageB_request_wr;
  always @ (*) begin
    io_mem_cmd_valid = 1'b0;
    if(io_cpu_writeBack_isValid)begin
      if(stageB_mmuRsp_isIoAccess)begin
        io_mem_cmd_valid = (! stageB_memCmdSent);
        if(_zz_27_)begin
          io_mem_cmd_valid = 1'b0;
        end
      end else begin
        if(_zz_23_)begin
          if(stageB_request_wr)begin
            io_mem_cmd_valid = 1'b1;
          end
          if(stageB_isAmo)begin
            if(_zz_24_)begin
              io_mem_cmd_valid = 1'b0;
            end
          end
          if(_zz_29_)begin
            io_mem_cmd_valid = 1'b0;
          end
          if(_zz_25_)begin
            io_mem_cmd_valid = 1'b0;
          end
        end else begin
          if((! stageB_memCmdSent))begin
            io_mem_cmd_valid = 1'b1;
          end
        end
      end
    end
    if(_zz_22_)begin
      io_mem_cmd_valid = 1'b0;
    end
  end

  always @ (*) begin
    io_mem_cmd_payload_address = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    if(io_cpu_writeBack_isValid)begin
      if(stageB_mmuRsp_isIoAccess)begin
        io_mem_cmd_payload_address = {stageB_mmuRsp_physicalAddress[31 : 2],(2'b00)};
      end else begin
        if(_zz_23_)begin
          io_mem_cmd_payload_address = {stageB_mmuRsp_physicalAddress[31 : 2],(2'b00)};
        end else begin
          io_mem_cmd_payload_address = {stageB_mmuRsp_physicalAddress[31 : 5],(5'b00000)};
        end
      end
    end
  end

  always @ (*) begin
    io_mem_cmd_payload_length = (3'bxxx);
    if(io_cpu_writeBack_isValid)begin
      if(stageB_mmuRsp_isIoAccess)begin
        io_mem_cmd_payload_length = (3'b000);
      end else begin
        if(_zz_23_)begin
          io_mem_cmd_payload_length = (3'b000);
        end else begin
          io_mem_cmd_payload_length = (3'b111);
        end
      end
    end
  end

  always @ (*) begin
    io_mem_cmd_payload_last = 1'bx;
    if(io_cpu_writeBack_isValid)begin
      if(stageB_mmuRsp_isIoAccess)begin
        io_mem_cmd_payload_last = 1'b1;
      end else begin
        if(_zz_23_)begin
          io_mem_cmd_payload_last = 1'b1;
        end else begin
          io_mem_cmd_payload_last = 1'b1;
        end
      end
    end
  end

  always @ (*) begin
    io_mem_cmd_payload_wr = stageB_request_wr;
    if(io_cpu_writeBack_isValid)begin
      if(! stageB_mmuRsp_isIoAccess) begin
        if(! _zz_23_) begin
          io_mem_cmd_payload_wr = 1'b0;
        end
      end
    end
  end

  assign io_mem_cmd_payload_mask = stageB_mask;
  assign io_mem_cmd_payload_data = stageB_requestDataBypass;
  always @ (*) begin
    if(stageB_mmuRsp_isIoAccess)begin
      io_cpu_writeBack_data = io_mem_rsp_payload_data;
    end else begin
      io_cpu_writeBack_data = stageB_dataMux;
    end
    if((stageB_request_isLrsc && stageB_request_wr))begin
      io_cpu_writeBack_data = {31'd0, _zz_44_};
    end
  end

  always @ (*) begin
    _zz_16_[0] = stageB_tagsReadRsp_0_error;
    _zz_16_[1] = stageB_tagsReadRsp_1_error;
  end

  always @ (*) begin
    loader_counter_willIncrement = 1'b0;
    if(_zz_26_)begin
      loader_counter_willIncrement = 1'b1;
    end
  end

  assign loader_counter_willClear = 1'b0;
  assign loader_counter_willOverflowIfInc = (loader_counter_value == (3'b111));
  assign loader_counter_willOverflow = (loader_counter_willOverflowIfInc && loader_counter_willIncrement);
  always @ (*) begin
    loader_counter_valueNext = (loader_counter_value + _zz_46_);
    if(loader_counter_willClear)begin
      loader_counter_valueNext = (3'b000);
    end
  end

  always @ (posedge clk) begin
    tagsWriteLastCmd_valid <= tagsWriteCmd_valid;
    tagsWriteLastCmd_payload_way <= tagsWriteCmd_payload_way;
    tagsWriteLastCmd_payload_address <= tagsWriteCmd_payload_address;
    tagsWriteLastCmd_payload_data_valid <= tagsWriteCmd_payload_data_valid;
    tagsWriteLastCmd_payload_data_error <= tagsWriteCmd_payload_data_error;
    tagsWriteLastCmd_payload_data_address <= tagsWriteCmd_payload_data_address;
    if((! io_cpu_memory_isStuck))begin
      stageA_request_wr <= io_cpu_execute_args_wr;
      stageA_request_data <= io_cpu_execute_args_data;
      stageA_request_size <= io_cpu_execute_args_size;
      stageA_request_isLrsc <= io_cpu_execute_args_isLrsc;
      stageA_request_isAmo <= io_cpu_execute_args_isAmo;
      stageA_request_amoCtrl_swap <= io_cpu_execute_args_amoCtrl_swap;
      stageA_request_amoCtrl_alu <= io_cpu_execute_args_amoCtrl_alu;
    end
    if((! io_cpu_memory_isStuck))begin
      stageA_mask <= stage0_mask;
    end
    if((! io_cpu_memory_isStuck))begin
      stage0_colisions_regNextWhen <= stage0_colisions;
    end
    if((! io_cpu_writeBack_isStuck))begin
      stageB_request_wr <= stageA_request_wr;
      stageB_request_data <= stageA_request_data;
      stageB_request_size <= stageA_request_size;
      stageB_request_isLrsc <= stageA_request_isLrsc;
      stageB_isAmo <= stageA_request_isAmo;
      stageB_request_amoCtrl_swap <= stageA_request_amoCtrl_swap;
      stageB_request_amoCtrl_alu <= stageA_request_amoCtrl_alu;
    end
    if(_zz_30_)begin
      stageB_mmuRsp_isIoAccess <= io_cpu_memory_mmuBus_rsp_isIoAccess;
      stageB_mmuRsp_allowRead <= io_cpu_memory_mmuBus_rsp_allowRead;
      stageB_mmuRsp_allowWrite <= io_cpu_memory_mmuBus_rsp_allowWrite;
      stageB_mmuRsp_allowExecute <= io_cpu_memory_mmuBus_rsp_allowExecute;
      stageB_mmuRsp_exception <= io_cpu_memory_mmuBus_rsp_exception;
      stageB_mmuRsp_refilling <= io_cpu_memory_mmuBus_rsp_refilling;
    end
    if((! io_cpu_writeBack_isStuck))begin
      stageB_tagsReadRsp_0_valid <= ways_0_tagsReadRsp_valid;
      stageB_tagsReadRsp_0_error <= ways_0_tagsReadRsp_error;
      stageB_tagsReadRsp_0_address <= ways_0_tagsReadRsp_address;
    end
    if((! io_cpu_writeBack_isStuck))begin
      stageB_tagsReadRsp_1_valid <= ways_1_tagsReadRsp_valid;
      stageB_tagsReadRsp_1_error <= ways_1_tagsReadRsp_error;
      stageB_tagsReadRsp_1_address <= ways_1_tagsReadRsp_address;
    end
    if((! io_cpu_writeBack_isStuck))begin
      stageB_dataReadRsp_0 <= ways_0_dataReadRsp;
    end
    if((! io_cpu_writeBack_isStuck))begin
      stageB_dataReadRsp_1 <= ways_1_dataReadRsp;
    end
    if((! io_cpu_writeBack_isStuck))begin
      stageB_waysHits <= _zz_15_;
    end
    if((! io_cpu_writeBack_isStuck))begin
      stageB_mask <= stageA_mask;
    end
    if((! io_cpu_writeBack_isStuck))begin
      stageB_colisions <= stageA_colisions;
    end
    stageB_amo_resultRegValid <= 1'b1;
    if((! io_cpu_writeBack_isStuck))begin
      stageB_amo_resultRegValid <= 1'b0;
    end
    stageB_amo_resultReg <= stageB_amo_result;
    if(!(! ((io_cpu_writeBack_isValid && (! io_cpu_writeBack_haltIt)) && io_cpu_writeBack_isStuck))) begin
      $display("ERROR writeBack stuck by another plugin is not allowed");
    end
  end

  always @ (posedge clk) begin
    if(reset) begin
      stageB_flusher_valid <= 1'b1;
      stageB_mmuRsp_physicalAddress <= (32'b00000000000000000000000000000000);
      stageB_lrsc_reserved <= 1'b0;
      stageB_memCmdSent <= 1'b0;
      loader_valid <= 1'b0;
      loader_counter_value <= (3'b000);
      loader_waysAllocator <= (2'b01);
      loader_error <= 1'b0;
    end else begin
      if(_zz_30_)begin
        stageB_mmuRsp_physicalAddress <= io_cpu_memory_mmuBus_rsp_physicalAddress;
      end
      if(stageB_flusher_valid)begin
        if((stageB_mmuRsp_physicalAddress[11 : 5] != (7'b1111111)))begin
          stageB_mmuRsp_physicalAddress[11 : 5] <= (stageB_mmuRsp_physicalAddress[11 : 5] + (7'b0000001));
        end else begin
          stageB_flusher_valid <= 1'b0;
        end
      end
      if(_zz_28_)begin
        stageB_mmuRsp_physicalAddress[11 : 5] <= (7'b0000000);
        stageB_flusher_valid <= 1'b1;
      end
      if(((((io_cpu_writeBack_isValid && (! io_cpu_writeBack_isStuck)) && (! io_cpu_redo)) && stageB_request_isLrsc) && (! stageB_request_wr)))begin
        stageB_lrsc_reserved <= 1'b1;
      end
      if(io_cpu_writeBack_clearLrsc)begin
        stageB_lrsc_reserved <= 1'b0;
      end
      if(io_mem_cmd_ready)begin
        stageB_memCmdSent <= 1'b1;
      end
      if((! io_cpu_writeBack_isStuck))begin
        stageB_memCmdSent <= 1'b0;
      end
      if(stageB_loaderValid)begin
        loader_valid <= 1'b1;
      end
      loader_counter_value <= loader_counter_valueNext;
      if(_zz_26_)begin
        loader_error <= (loader_error || io_mem_rsp_payload_error);
      end
      if(loader_counter_willOverflow)begin
        loader_valid <= 1'b0;
        loader_error <= 1'b0;
      end
      if((! loader_valid))begin
        loader_waysAllocator <= _zz_47_[1:0];
      end
    end
  end

endmodule

module VexRiscv (
      input  [31:0] externalResetVector,
      input   timerInterrupt,
      input   softwareInterrupt,
      input  [31:0] externalInterruptArray,
      output reg  iBusWishbone_CYC,
      output reg  iBusWishbone_STB,
      input   iBusWishbone_ACK,
      output  iBusWishbone_WE,
      output [29:0] iBusWishbone_ADR,
      input  [31:0] iBusWishbone_DAT_MISO,
      output [31:0] iBusWishbone_DAT_MOSI,
      output [3:0] iBusWishbone_SEL,
      input   iBusWishbone_ERR,
      output [1:0] iBusWishbone_BTE,
      output [2:0] iBusWishbone_CTI,
      output  dBusWishbone_CYC,
      output  dBusWishbone_STB,
      input   dBusWishbone_ACK,
      output  dBusWishbone_WE,
      output [29:0] dBusWishbone_ADR,
      input  [31:0] dBusWishbone_DAT_MISO,
      output [31:0] dBusWishbone_DAT_MOSI,
      output [3:0] dBusWishbone_SEL,
      input   dBusWishbone_ERR,
      output [1:0] dBusWishbone_BTE,
      output [2:0] dBusWishbone_CTI,
      input   clk,
      input   reset);
  wire  _zz_264_;
  wire  _zz_265_;
  wire  _zz_266_;
  wire  _zz_267_;
  wire [31:0] _zz_268_;
  wire  _zz_269_;
  wire  _zz_270_;
  wire  _zz_271_;
  reg  _zz_272_;
  reg  _zz_273_;
  reg [31:0] _zz_274_;
  reg  _zz_275_;
  reg [31:0] _zz_276_;
  reg [1:0] _zz_277_;
  reg  _zz_278_;
  reg  _zz_279_;
  wire  _zz_280_;
  wire [2:0] _zz_281_;
  reg  _zz_282_;
  wire [31:0] _zz_283_;
  reg  _zz_284_;
  reg  _zz_285_;
  wire  _zz_286_;
  wire [31:0] _zz_287_;
  wire  _zz_288_;
  wire  _zz_289_;
  wire [31:0] _zz_290_;
  wire [31:0] _zz_291_;
  reg [31:0] _zz_292_;
  reg  _zz_293_;
  reg  _zz_294_;
  reg  _zz_295_;
  reg [9:0] _zz_296_;
  reg [9:0] _zz_297_;
  reg [9:0] _zz_298_;
  reg [9:0] _zz_299_;
  reg  _zz_300_;
  reg  _zz_301_;
  reg  _zz_302_;
  reg  _zz_303_;
  reg  _zz_304_;
  reg  _zz_305_;
  reg  _zz_306_;
  reg [9:0] _zz_307_;
  reg [9:0] _zz_308_;
  reg [9:0] _zz_309_;
  reg [9:0] _zz_310_;
  reg  _zz_311_;
  reg  _zz_312_;
  reg  _zz_313_;
  reg  _zz_314_;
  wire  IBusCachedPlugin_cache_io_cpu_prefetch_haltIt;
  wire [31:0] IBusCachedPlugin_cache_io_cpu_fetch_data;
  wire [31:0] IBusCachedPlugin_cache_io_cpu_fetch_physicalAddress;
  wire  IBusCachedPlugin_cache_io_cpu_fetch_haltIt;
  wire  IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_isValid;
  wire [31:0] IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_virtualAddress;
  wire  IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_bypassTranslation;
  wire  IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_end;
  wire  IBusCachedPlugin_cache_io_cpu_decode_error;
  wire  IBusCachedPlugin_cache_io_cpu_decode_mmuRefilling;
  wire  IBusCachedPlugin_cache_io_cpu_decode_mmuException;
  wire [31:0] IBusCachedPlugin_cache_io_cpu_decode_data;
  wire  IBusCachedPlugin_cache_io_cpu_decode_cacheMiss;
  wire [31:0] IBusCachedPlugin_cache_io_cpu_decode_physicalAddress;
  wire  IBusCachedPlugin_cache_io_mem_cmd_valid;
  wire [31:0] IBusCachedPlugin_cache_io_mem_cmd_payload_address;
  wire [2:0] IBusCachedPlugin_cache_io_mem_cmd_payload_size;
  wire  dataCache_1__io_cpu_memory_isWrite;
  wire  dataCache_1__io_cpu_memory_mmuBus_cmd_isValid;
  wire [31:0] dataCache_1__io_cpu_memory_mmuBus_cmd_virtualAddress;
  wire  dataCache_1__io_cpu_memory_mmuBus_cmd_bypassTranslation;
  wire  dataCache_1__io_cpu_memory_mmuBus_end;
  wire  dataCache_1__io_cpu_writeBack_haltIt;
  wire [31:0] dataCache_1__io_cpu_writeBack_data;
  wire  dataCache_1__io_cpu_writeBack_mmuException;
  wire  dataCache_1__io_cpu_writeBack_unalignedAccess;
  wire  dataCache_1__io_cpu_writeBack_accessError;
  wire  dataCache_1__io_cpu_writeBack_isWrite;
  wire  dataCache_1__io_cpu_flush_ready;
  wire  dataCache_1__io_cpu_redo;
  wire  dataCache_1__io_mem_cmd_valid;
  wire  dataCache_1__io_mem_cmd_payload_wr;
  wire [31:0] dataCache_1__io_mem_cmd_payload_address;
  wire [31:0] dataCache_1__io_mem_cmd_payload_data;
  wire [3:0] dataCache_1__io_mem_cmd_payload_mask;
  wire [2:0] dataCache_1__io_mem_cmd_payload_length;
  wire  dataCache_1__io_mem_cmd_payload_last;
  wire  _zz_315_;
  wire  _zz_316_;
  wire  _zz_317_;
  wire  _zz_318_;
  wire  _zz_319_;
  wire  _zz_320_;
  wire  _zz_321_;
  wire  _zz_322_;
  wire  _zz_323_;
  wire  _zz_324_;
  wire  _zz_325_;
  wire  _zz_326_;
  wire  _zz_327_;
  wire  _zz_328_;
  wire [1:0] _zz_329_;
  wire  _zz_330_;
  wire  _zz_331_;
  wire  _zz_332_;
  wire  _zz_333_;
  wire  _zz_334_;
  wire  _zz_335_;
  wire  _zz_336_;
  wire  _zz_337_;
  wire  _zz_338_;
  wire  _zz_339_;
  wire  _zz_340_;
  wire  _zz_341_;
  wire [1:0] _zz_342_;
  wire  _zz_343_;
  wire  _zz_344_;
  wire  _zz_345_;
  wire  _zz_346_;
  wire  _zz_347_;
  wire  _zz_348_;
  wire  _zz_349_;
  wire  _zz_350_;
  wire  _zz_351_;
  wire  _zz_352_;
  wire  _zz_353_;
  wire  _zz_354_;
  wire  _zz_355_;
  wire  _zz_356_;
  wire  _zz_357_;
  wire  _zz_358_;
  wire  _zz_359_;
  wire  _zz_360_;
  wire  _zz_361_;
  wire  _zz_362_;
  wire  _zz_363_;
  wire  _zz_364_;
  wire  _zz_365_;
  wire  _zz_366_;
  wire  _zz_367_;
  wire  _zz_368_;
  wire  _zz_369_;
  wire  _zz_370_;
  wire  _zz_371_;
  wire  _zz_372_;
  wire [4:0] _zz_373_;
  wire [1:0] _zz_374_;
  wire [1:0] _zz_375_;
  wire [1:0] _zz_376_;
  wire [1:0] _zz_377_;
  wire  _zz_378_;
  wire [4:0] _zz_379_;
  wire [2:0] _zz_380_;
  wire [31:0] _zz_381_;
  wire [2:0] _zz_382_;
  wire [31:0] _zz_383_;
  wire [31:0] _zz_384_;
  wire [11:0] _zz_385_;
  wire [11:0] _zz_386_;
  wire [2:0] _zz_387_;
  wire [31:0] _zz_388_;
  wire [11:0] _zz_389_;
  wire [31:0] _zz_390_;
  wire [19:0] _zz_391_;
  wire [11:0] _zz_392_;
  wire [2:0] _zz_393_;
  wire [2:0] _zz_394_;
  wire [0:0] _zz_395_;
  wire [0:0] _zz_396_;
  wire [0:0] _zz_397_;
  wire [0:0] _zz_398_;
  wire [0:0] _zz_399_;
  wire [0:0] _zz_400_;
  wire [0:0] _zz_401_;
  wire [0:0] _zz_402_;
  wire [0:0] _zz_403_;
  wire [0:0] _zz_404_;
  wire [0:0] _zz_405_;
  wire [0:0] _zz_406_;
  wire [0:0] _zz_407_;
  wire [0:0] _zz_408_;
  wire [0:0] _zz_409_;
  wire [0:0] _zz_410_;
  wire [0:0] _zz_411_;
  wire [0:0] _zz_412_;
  wire [0:0] _zz_413_;
  wire [0:0] _zz_414_;
  wire [0:0] _zz_415_;
  wire [2:0] _zz_416_;
  wire [4:0] _zz_417_;
  wire [11:0] _zz_418_;
  wire [11:0] _zz_419_;
  wire [31:0] _zz_420_;
  wire [31:0] _zz_421_;
  wire [31:0] _zz_422_;
  wire [31:0] _zz_423_;
  wire [31:0] _zz_424_;
  wire [31:0] _zz_425_;
  wire [31:0] _zz_426_;
  wire [32:0] _zz_427_;
  wire [31:0] _zz_428_;
  wire [32:0] _zz_429_;
  wire [51:0] _zz_430_;
  wire [51:0] _zz_431_;
  wire [51:0] _zz_432_;
  wire [32:0] _zz_433_;
  wire [51:0] _zz_434_;
  wire [49:0] _zz_435_;
  wire [51:0] _zz_436_;
  wire [49:0] _zz_437_;
  wire [51:0] _zz_438_;
  wire [65:0] _zz_439_;
  wire [65:0] _zz_440_;
  wire [31:0] _zz_441_;
  wire [31:0] _zz_442_;
  wire [0:0] _zz_443_;
  wire [5:0] _zz_444_;
  wire [32:0] _zz_445_;
  wire [32:0] _zz_446_;
  wire [31:0] _zz_447_;
  wire [31:0] _zz_448_;
  wire [32:0] _zz_449_;
  wire [32:0] _zz_450_;
  wire [32:0] _zz_451_;
  wire [0:0] _zz_452_;
  wire [32:0] _zz_453_;
  wire [0:0] _zz_454_;
  wire [32:0] _zz_455_;
  wire [0:0] _zz_456_;
  wire [31:0] _zz_457_;
  wire [1:0] _zz_458_;
  wire [1:0] _zz_459_;
  wire [11:0] _zz_460_;
  wire [19:0] _zz_461_;
  wire [11:0] _zz_462_;
  wire [2:0] _zz_463_;
  wire [0:0] _zz_464_;
  wire [1:0] _zz_465_;
  wire [0:0] _zz_466_;
  wire [1:0] _zz_467_;
  wire [0:0] _zz_468_;
  wire [0:0] _zz_469_;
  wire [0:0] _zz_470_;
  wire [0:0] _zz_471_;
  wire [0:0] _zz_472_;
  wire [0:0] _zz_473_;
  wire [0:0] _zz_474_;
  wire [0:0] _zz_475_;
  wire [0:0] _zz_476_;
  wire [0:0] _zz_477_;
  wire [0:0] _zz_478_;
  wire [0:0] _zz_479_;
  wire [0:0] _zz_480_;
  wire [0:0] _zz_481_;
  wire [0:0] _zz_482_;
  wire [0:0] _zz_483_;
  wire [0:0] _zz_484_;
  wire [0:0] _zz_485_;
  wire [0:0] _zz_486_;
  wire [0:0] _zz_487_;
  wire [0:0] _zz_488_;
  wire [0:0] _zz_489_;
  wire [0:0] _zz_490_;
  wire [0:0] _zz_491_;
  wire [0:0] _zz_492_;
  wire [0:0] _zz_493_;
  wire [0:0] _zz_494_;
  wire [0:0] _zz_495_;
  wire [0:0] _zz_496_;
  wire [0:0] _zz_497_;
  wire [0:0] _zz_498_;
  wire [0:0] _zz_499_;
  wire [0:0] _zz_500_;
  wire [0:0] _zz_501_;
  wire [0:0] _zz_502_;
  wire [0:0] _zz_503_;
  wire [0:0] _zz_504_;
  wire [0:0] _zz_505_;
  wire [0:0] _zz_506_;
  wire [0:0] _zz_507_;
  wire [0:0] _zz_508_;
  wire [0:0] _zz_509_;
  wire [0:0] _zz_510_;
  wire [0:0] _zz_511_;
  wire [0:0] _zz_512_;
  wire [0:0] _zz_513_;
  wire [0:0] _zz_514_;
  wire [0:0] _zz_515_;
  wire [0:0] _zz_516_;
  wire [0:0] _zz_517_;
  wire [0:0] _zz_518_;
  wire [0:0] _zz_519_;
  wire [0:0] _zz_520_;
  wire [26:0] _zz_521_;
  wire [2:0] _zz_522_;
  wire  _zz_523_;
  wire  _zz_524_;
  wire [6:0] _zz_525_;
  wire [4:0] _zz_526_;
  wire  _zz_527_;
  wire [4:0] _zz_528_;
  wire [0:0] _zz_529_;
  wire [7:0] _zz_530_;
  wire  _zz_531_;
  wire [0:0] _zz_532_;
  wire [0:0] _zz_533_;
  wire [31:0] _zz_534_;
  wire [31:0] _zz_535_;
  wire [31:0] _zz_536_;
  wire [31:0] _zz_537_;
  wire [31:0] _zz_538_;
  wire [31:0] _zz_539_;
  wire [0:0] _zz_540_;
  wire [0:0] _zz_541_;
  wire  _zz_542_;
  wire [0:0] _zz_543_;
  wire [29:0] _zz_544_;
  wire [31:0] _zz_545_;
  wire [31:0] _zz_546_;
  wire  _zz_547_;
  wire [0:0] _zz_548_;
  wire [2:0] _zz_549_;
  wire  _zz_550_;
  wire  _zz_551_;
  wire [0:0] _zz_552_;
  wire [0:0] _zz_553_;
  wire  _zz_554_;
  wire [0:0] _zz_555_;
  wire [25:0] _zz_556_;
  wire [31:0] _zz_557_;
  wire [31:0] _zz_558_;
  wire [31:0] _zz_559_;
  wire  _zz_560_;
  wire [0:0] _zz_561_;
  wire [0:0] _zz_562_;
  wire [31:0] _zz_563_;
  wire [31:0] _zz_564_;
  wire [31:0] _zz_565_;
  wire [31:0] _zz_566_;
  wire [0:0] _zz_567_;
  wire [5:0] _zz_568_;
  wire [2:0] _zz_569_;
  wire [2:0] _zz_570_;
  wire  _zz_571_;
  wire [0:0] _zz_572_;
  wire [23:0] _zz_573_;
  wire [31:0] _zz_574_;
  wire [31:0] _zz_575_;
  wire [31:0] _zz_576_;
  wire [31:0] _zz_577_;
  wire [31:0] _zz_578_;
  wire  _zz_579_;
  wire [0:0] _zz_580_;
  wire [3:0] _zz_581_;
  wire [0:0] _zz_582_;
  wire [0:0] _zz_583_;
  wire [0:0] _zz_584_;
  wire [0:0] _zz_585_;
  wire [1:0] _zz_586_;
  wire [1:0] _zz_587_;
  wire  _zz_588_;
  wire [0:0] _zz_589_;
  wire [21:0] _zz_590_;
  wire [31:0] _zz_591_;
  wire [31:0] _zz_592_;
  wire [31:0] _zz_593_;
  wire  _zz_594_;
  wire [0:0] _zz_595_;
  wire [1:0] _zz_596_;
  wire [31:0] _zz_597_;
  wire [31:0] _zz_598_;
  wire [31:0] _zz_599_;
  wire [31:0] _zz_600_;
  wire  _zz_601_;
  wire [0:0] _zz_602_;
  wire [0:0] _zz_603_;
  wire [2:0] _zz_604_;
  wire [2:0] _zz_605_;
  wire  _zz_606_;
  wire [0:0] _zz_607_;
  wire [19:0] _zz_608_;
  wire [31:0] _zz_609_;
  wire [31:0] _zz_610_;
  wire [31:0] _zz_611_;
  wire  _zz_612_;
  wire [31:0] _zz_613_;
  wire [31:0] _zz_614_;
  wire [31:0] _zz_615_;
  wire  _zz_616_;
  wire [0:0] _zz_617_;
  wire [0:0] _zz_618_;
  wire [0:0] _zz_619_;
  wire [0:0] _zz_620_;
  wire [2:0] _zz_621_;
  wire [2:0] _zz_622_;
  wire  _zz_623_;
  wire [0:0] _zz_624_;
  wire [17:0] _zz_625_;
  wire [31:0] _zz_626_;
  wire [31:0] _zz_627_;
  wire [31:0] _zz_628_;
  wire [31:0] _zz_629_;
  wire [31:0] _zz_630_;
  wire [31:0] _zz_631_;
  wire [31:0] _zz_632_;
  wire [31:0] _zz_633_;
  wire [31:0] _zz_634_;
  wire [31:0] _zz_635_;
  wire  _zz_636_;
  wire [0:0] _zz_637_;
  wire [0:0] _zz_638_;
  wire  _zz_639_;
  wire [1:0] _zz_640_;
  wire [1:0] _zz_641_;
  wire  _zz_642_;
  wire [0:0] _zz_643_;
  wire [15:0] _zz_644_;
  wire [31:0] _zz_645_;
  wire [31:0] _zz_646_;
  wire [31:0] _zz_647_;
  wire [31:0] _zz_648_;
  wire [31:0] _zz_649_;
  wire [31:0] _zz_650_;
  wire [31:0] _zz_651_;
  wire [31:0] _zz_652_;
  wire [0:0] _zz_653_;
  wire [0:0] _zz_654_;
  wire [0:0] _zz_655_;
  wire [0:0] _zz_656_;
  wire  _zz_657_;
  wire [0:0] _zz_658_;
  wire [12:0] _zz_659_;
  wire [31:0] _zz_660_;
  wire [31:0] _zz_661_;
  wire [31:0] _zz_662_;
  wire [0:0] _zz_663_;
  wire [0:0] _zz_664_;
  wire [4:0] _zz_665_;
  wire [4:0] _zz_666_;
  wire  _zz_667_;
  wire [0:0] _zz_668_;
  wire [9:0] _zz_669_;
  wire [31:0] _zz_670_;
  wire [31:0] _zz_671_;
  wire [31:0] _zz_672_;
  wire  _zz_673_;
  wire [0:0] _zz_674_;
  wire [1:0] _zz_675_;
  wire [31:0] _zz_676_;
  wire [31:0] _zz_677_;
  wire  _zz_678_;
  wire [2:0] _zz_679_;
  wire [2:0] _zz_680_;
  wire  _zz_681_;
  wire [0:0] _zz_682_;
  wire [6:0] _zz_683_;
  wire [31:0] _zz_684_;
  wire [31:0] _zz_685_;
  wire [31:0] _zz_686_;
  wire [31:0] _zz_687_;
  wire [31:0] _zz_688_;
  wire  _zz_689_;
  wire  _zz_690_;
  wire  _zz_691_;
  wire [0:0] _zz_692_;
  wire [1:0] _zz_693_;
  wire [0:0] _zz_694_;
  wire [3:0] _zz_695_;
  wire [0:0] _zz_696_;
  wire [0:0] _zz_697_;
  wire  _zz_698_;
  wire [0:0] _zz_699_;
  wire [3:0] _zz_700_;
  wire [31:0] _zz_701_;
  wire [31:0] _zz_702_;
  wire [31:0] _zz_703_;
  wire [31:0] _zz_704_;
  wire [31:0] _zz_705_;
  wire  _zz_706_;
  wire  _zz_707_;
  wire [31:0] _zz_708_;
  wire [31:0] _zz_709_;
  wire  _zz_710_;
  wire [0:0] _zz_711_;
  wire [1:0] _zz_712_;
  wire [31:0] _zz_713_;
  wire [31:0] _zz_714_;
  wire  _zz_715_;
  wire [0:0] _zz_716_;
  wire [0:0] _zz_717_;
  wire  _zz_718_;
  wire [0:0] _zz_719_;
  wire [1:0] _zz_720_;
  wire [31:0] _zz_721_;
  wire [31:0] _zz_722_;
  wire [31:0] _zz_723_;
  wire [31:0] _zz_724_;
  wire [31:0] _zz_725_;
  wire  _zz_726_;
  wire [31:0] _zz_727_;
  wire [31:0] _zz_728_;
  wire [31:0] _zz_729_;
  wire [0:0] _zz_730_;
  wire [3:0] _zz_731_;
  wire [0:0] _zz_732_;
  wire [0:0] _zz_733_;
  wire  _zz_734_;
  wire  _zz_735_;
  wire [31:0] _zz_736_;
  wire [31:0] _zz_737_;
  wire [31:0] _zz_738_;
  wire  _zz_739_;
  wire  _zz_740_;
  wire [31:0] _zz_741_;
  wire [31:0] _zz_742_;
  wire [31:0] _zz_743_;
  wire [31:0] _zz_744_;
  wire [31:0] _zz_745_;
  wire  _zz_746_;
  wire [0:0] _zz_747_;
  wire [17:0] _zz_748_;
  wire [31:0] _zz_749_;
  wire [31:0] _zz_750_;
  wire [31:0] _zz_751_;
  wire  _zz_752_;
  wire [0:0] _zz_753_;
  wire [11:0] _zz_754_;
  wire [31:0] _zz_755_;
  wire [31:0] _zz_756_;
  wire [31:0] _zz_757_;
  wire  _zz_758_;
  wire [0:0] _zz_759_;
  wire [5:0] _zz_760_;
  wire [31:0] _zz_761_;
  wire [31:0] _zz_762_;
  wire [31:0] _zz_763_;
  wire  _zz_764_;
  wire  _zz_765_;
  wire  _zz_766_;
  wire  _zz_767_;
  wire  _zz_768_;
  wire [31:0] writeBack_FORMAL_PC_NEXT;
  wire [31:0] memory_FORMAL_PC_NEXT;
  wire [31:0] execute_FORMAL_PC_NEXT;
  wire [31:0] decode_FORMAL_PC_NEXT;
  wire `Src1CtrlEnum_defaultEncoding_type decode_SRC1_CTRL;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_1_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_2_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_3_;
  wire  execute_BYPASSABLE_MEMORY_STAGE;
  wire  decode_BYPASSABLE_MEMORY_STAGE;
  wire [33:0] memory_MUL_HH;
  wire [33:0] execute_MUL_HH;
  wire [1:0] memory_MEMORY_ADDRESS_LOW;
  wire [1:0] execute_MEMORY_ADDRESS_LOW;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_4_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_5_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_6_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_7_;
  wire `EnvCtrlEnum_defaultEncoding_type decode_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_8_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_9_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_10_;
  wire [31:0] execute_MUL_LL;
  wire  execute_BRANCH_DO;
  wire  decode_MEMORY_MANAGMENT;
  wire  decode_BYPASSABLE_EXECUTE_STAGE;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_11_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_12_;
  wire  memory_MEMORY_WR;
  wire  decode_MEMORY_WR;
  wire [31:0] memory_PC;
  wire  decode_CSR_WRITE_OPCODE;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_13_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_14_;
  wire `ShiftCtrlEnum_defaultEncoding_type decode_SHIFT_CTRL;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_15_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_16_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_17_;
  wire `AluCtrlEnum_defaultEncoding_type decode_ALU_CTRL;
  wire `AluCtrlEnum_defaultEncoding_type _zz_18_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_19_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_20_;
  wire [31:0] execute_PIPELINED_CSR_READ;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type decode_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_21_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_22_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_23_;
  wire [33:0] execute_MUL_HL;
  wire  decode_MEMORY_LRSC;
  wire  decode_SRC2_FORCE_ZERO;
  wire  decode_IS_DIV;
  wire  decode_IS_RS2_SIGNED;
  wire  decode_PREDICTION_HAD_BRANCHED2;
  wire  decode_MEMORY_AMO;
  wire  decode_CSR_READ_OPCODE;
  wire  memory_IS_SFENCE_VMA;
  wire  execute_IS_SFENCE_VMA;
  wire  decode_IS_SFENCE_VMA;
  wire [31:0] execute_SHIFT_RIGHT;
  wire [31:0] execute_REGFILE_WRITE_DATA;
  wire [33:0] execute_MUL_LH;
  wire  memory_IS_MUL;
  wire  execute_IS_MUL;
  wire  decode_IS_MUL;
  wire [31:0] execute_BRANCH_CALC;
  wire [51:0] memory_MUL_LOW;
  wire  decode_IS_CSR;
  wire  execute_IS_DBUS_SHARING;
  wire  decode_SRC_LESS_UNSIGNED;
  wire `Src2CtrlEnum_defaultEncoding_type decode_SRC2_CTRL;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_24_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_25_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_26_;
  wire  decode_IS_RS1_SIGNED;
  wire  writeBack_IS_SFENCE_VMA;
  wire [31:0] memory_BRANCH_CALC;
  wire  memory_BRANCH_DO;
  wire [31:0] _zz_27_;
  wire [31:0] execute_PC;
  wire  execute_BRANCH_COND_RESULT;
  wire  execute_PREDICTION_HAD_BRANCHED2;
  wire  _zz_28_;
  wire `BranchCtrlEnum_defaultEncoding_type execute_BRANCH_CTRL;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_29_;
  wire  _zz_30_;
  wire  _zz_31_;
  wire [31:0] memory_PIPELINED_CSR_READ;
  wire  memory_IS_CSR;
  wire [31:0] _zz_32_;
  wire  execute_CSR_READ_OPCODE;
  wire  execute_CSR_WRITE_OPCODE;
  wire  execute_IS_CSR;
  wire `EnvCtrlEnum_defaultEncoding_type memory_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_33_;
  wire `EnvCtrlEnum_defaultEncoding_type execute_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_34_;
  wire  _zz_35_;
  wire  _zz_36_;
  wire `EnvCtrlEnum_defaultEncoding_type writeBack_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_37_;
  wire  execute_IS_RS1_SIGNED;
  wire [31:0] execute_RS1;
  wire  execute_IS_DIV;
  wire  execute_IS_RS2_SIGNED;
  wire  memory_IS_DIV;
  wire  writeBack_IS_MUL;
  wire [33:0] writeBack_MUL_HH;
  wire [51:0] writeBack_MUL_LOW;
  wire [33:0] memory_MUL_HL;
  wire [33:0] memory_MUL_LH;
  wire [31:0] memory_MUL_LL;
  wire [51:0] _zz_38_;
  wire [33:0] _zz_39_;
  wire [33:0] _zz_40_;
  wire [33:0] _zz_41_;
  wire [31:0] _zz_42_;
  wire  decode_RS2_USE;
  wire  decode_RS1_USE;
  reg [31:0] _zz_43_;
  wire  execute_REGFILE_WRITE_VALID;
  wire  execute_BYPASSABLE_EXECUTE_STAGE;
  wire  memory_REGFILE_WRITE_VALID;
  wire [31:0] memory_INSTRUCTION;
  wire  memory_BYPASSABLE_MEMORY_STAGE;
  wire  writeBack_REGFILE_WRITE_VALID;
  reg [31:0] decode_RS2;
  reg [31:0] decode_RS1;
  wire [31:0] memory_SHIFT_RIGHT;
  reg [31:0] _zz_44_;
  wire `ShiftCtrlEnum_defaultEncoding_type memory_SHIFT_CTRL;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_45_;
  wire [31:0] _zz_46_;
  wire `ShiftCtrlEnum_defaultEncoding_type execute_SHIFT_CTRL;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_47_;
  wire  _zz_48_;
  wire [31:0] _zz_49_;
  wire [31:0] _zz_50_;
  wire  execute_SRC_LESS_UNSIGNED;
  wire  execute_SRC2_FORCE_ZERO;
  wire  execute_SRC_USE_SUB_LESS;
  wire [31:0] _zz_51_;
  wire `Src2CtrlEnum_defaultEncoding_type execute_SRC2_CTRL;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_52_;
  wire [31:0] _zz_53_;
  wire  execute_IS_RVC;
  wire `Src1CtrlEnum_defaultEncoding_type execute_SRC1_CTRL;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_54_;
  wire [31:0] _zz_55_;
  wire  decode_SRC_USE_SUB_LESS;
  wire  decode_SRC_ADD_ZERO;
  wire  _zz_56_;
  wire [31:0] execute_SRC_ADD_SUB;
  wire  execute_SRC_LESS;
  wire `AluCtrlEnum_defaultEncoding_type execute_ALU_CTRL;
  wire `AluCtrlEnum_defaultEncoding_type _zz_57_;
  wire [31:0] _zz_58_;
  wire [31:0] execute_SRC2;
  wire [31:0] execute_SRC1;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type execute_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_59_;
  wire [31:0] _zz_60_;
  wire  _zz_61_;
  reg  _zz_62_;
  wire [31:0] _zz_63_;
  wire [31:0] _zz_64_;
  reg  decode_REGFILE_WRITE_VALID;
  wire  decode_LEGAL_INSTRUCTION;
  wire  decode_INSTRUCTION_READY;
  wire  _zz_65_;
  wire  _zz_66_;
  wire  _zz_67_;
  wire  _zz_68_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_69_;
  wire  _zz_70_;
  wire  _zz_71_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_72_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_73_;
  wire  _zz_74_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_75_;
  wire  _zz_76_;
  wire  _zz_77_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_78_;
  wire  _zz_79_;
  wire  _zz_80_;
  wire  _zz_81_;
  wire  _zz_82_;
  wire  _zz_83_;
  wire  _zz_84_;
  wire  _zz_85_;
  wire  _zz_86_;
  wire  _zz_87_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_88_;
  wire  _zz_89_;
  wire  _zz_90_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_91_;
  wire  _zz_92_;
  wire  writeBack_IS_DBUS_SHARING;
  wire  memory_IS_DBUS_SHARING;
  wire  _zz_93_;
  reg [31:0] _zz_94_;
  wire [1:0] writeBack_MEMORY_ADDRESS_LOW;
  wire  writeBack_MEMORY_WR;
  wire [31:0] writeBack_REGFILE_WRITE_DATA;
  wire  writeBack_MEMORY_ENABLE;
  wire [31:0] memory_REGFILE_WRITE_DATA;
  wire  memory_MEMORY_ENABLE;
  wire [1:0] _zz_95_;
  wire  execute_MEMORY_AMO;
  wire  execute_MEMORY_LRSC;
  wire  execute_MEMORY_MANAGMENT;
  wire [31:0] execute_RS2;
  wire  execute_MEMORY_WR;
  wire [31:0] execute_SRC_ADD;
  wire  execute_MEMORY_ENABLE;
  wire [31:0] execute_INSTRUCTION;
  wire  decode_MEMORY_ENABLE;
  wire  decode_FLUSH_ALL;
  reg  IBusCachedPlugin_rsp_issueDetected;
  reg  _zz_96_;
  reg  _zz_97_;
  reg  _zz_98_;
  wire `BranchCtrlEnum_defaultEncoding_type decode_BRANCH_CTRL;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_99_;
  reg [31:0] _zz_100_;
  reg [31:0] _zz_101_;
  wire [31:0] decode_PC;
  wire [31:0] _zz_102_;
  wire  _zz_103_;
  wire [31:0] _zz_104_;
  wire [31:0] _zz_105_;
  wire [31:0] decode_INSTRUCTION;
  wire  decode_IS_RVC;
  wire [31:0] writeBack_PC;
  wire [31:0] writeBack_INSTRUCTION;
  reg  decode_arbitration_haltItself;
  reg  decode_arbitration_haltByOther;
  reg  decode_arbitration_removeIt;
  wire  decode_arbitration_flushIt;
  reg  decode_arbitration_flushNext;
  wire  decode_arbitration_isValid;
  wire  decode_arbitration_isStuck;
  wire  decode_arbitration_isStuckByOthers;
  wire  decode_arbitration_isFlushed;
  wire  decode_arbitration_isMoving;
  wire  decode_arbitration_isFiring;
  reg  execute_arbitration_haltItself;
  wire  execute_arbitration_haltByOther;
  reg  execute_arbitration_removeIt;
  wire  execute_arbitration_flushIt;
  reg  execute_arbitration_flushNext;
  reg  execute_arbitration_isValid;
  wire  execute_arbitration_isStuck;
  wire  execute_arbitration_isStuckByOthers;
  wire  execute_arbitration_isFlushed;
  wire  execute_arbitration_isMoving;
  wire  execute_arbitration_isFiring;
  reg  memory_arbitration_haltItself;
  wire  memory_arbitration_haltByOther;
  reg  memory_arbitration_removeIt;
  wire  memory_arbitration_flushIt;
  reg  memory_arbitration_flushNext;
  reg  memory_arbitration_isValid;
  wire  memory_arbitration_isStuck;
  wire  memory_arbitration_isStuckByOthers;
  wire  memory_arbitration_isFlushed;
  wire  memory_arbitration_isMoving;
  wire  memory_arbitration_isFiring;
  reg  writeBack_arbitration_haltItself;
  wire  writeBack_arbitration_haltByOther;
  reg  writeBack_arbitration_removeIt;
  reg  writeBack_arbitration_flushIt;
  reg  writeBack_arbitration_flushNext;
  reg  writeBack_arbitration_isValid;
  wire  writeBack_arbitration_isStuck;
  wire  writeBack_arbitration_isStuckByOthers;
  wire  writeBack_arbitration_isFlushed;
  wire  writeBack_arbitration_isMoving;
  wire  writeBack_arbitration_isFiring;
  wire [31:0] lastStageInstruction /* verilator public */ ;
  wire [31:0] lastStagePc /* verilator public */ ;
  wire  lastStageIsValid /* verilator public */ ;
  wire  lastStageIsFiring /* verilator public */ ;
  reg  IBusCachedPlugin_fetcherHalt;
  reg  IBusCachedPlugin_fetcherflushIt;
  reg  IBusCachedPlugin_incomingInstruction;
  wire  IBusCachedPlugin_predictionJumpInterface_valid;
  (* syn_keep , keep *) wire [31:0] IBusCachedPlugin_predictionJumpInterface_payload /* synthesis syn_keep = 1 */ ;
  wire  IBusCachedPlugin_decodePrediction_cmd_hadBranch;
  wire  IBusCachedPlugin_decodePrediction_rsp_wasWrong;
  wire  IBusCachedPlugin_pcValids_0;
  wire  IBusCachedPlugin_pcValids_1;
  wire  IBusCachedPlugin_pcValids_2;
  wire  IBusCachedPlugin_pcValids_3;
  wire  IBusCachedPlugin_redoBranch_valid;
  wire [31:0] IBusCachedPlugin_redoBranch_payload;
  reg  IBusCachedPlugin_decodeExceptionPort_valid;
  reg [3:0] IBusCachedPlugin_decodeExceptionPort_payload_code;
  wire [31:0] IBusCachedPlugin_decodeExceptionPort_payload_badAddr;
  wire  IBusCachedPlugin_mmuBus_cmd_isValid;
  wire [31:0] IBusCachedPlugin_mmuBus_cmd_virtualAddress;
  wire  IBusCachedPlugin_mmuBus_cmd_bypassTranslation;
  reg [31:0] IBusCachedPlugin_mmuBus_rsp_physicalAddress;
  wire  IBusCachedPlugin_mmuBus_rsp_isIoAccess;
  reg  IBusCachedPlugin_mmuBus_rsp_allowRead;
  reg  IBusCachedPlugin_mmuBus_rsp_allowWrite;
  reg  IBusCachedPlugin_mmuBus_rsp_allowExecute;
  reg  IBusCachedPlugin_mmuBus_rsp_exception;
  reg  IBusCachedPlugin_mmuBus_rsp_refilling;
  wire  IBusCachedPlugin_mmuBus_end;
  wire  IBusCachedPlugin_mmuBus_busy;
  wire  DBusCachedPlugin_mmuBus_cmd_isValid;
  wire [31:0] DBusCachedPlugin_mmuBus_cmd_virtualAddress;
  reg  DBusCachedPlugin_mmuBus_cmd_bypassTranslation;
  reg [31:0] DBusCachedPlugin_mmuBus_rsp_physicalAddress;
  wire  DBusCachedPlugin_mmuBus_rsp_isIoAccess;
  reg  DBusCachedPlugin_mmuBus_rsp_allowRead;
  reg  DBusCachedPlugin_mmuBus_rsp_allowWrite;
  reg  DBusCachedPlugin_mmuBus_rsp_allowExecute;
  reg  DBusCachedPlugin_mmuBus_rsp_exception;
  reg  DBusCachedPlugin_mmuBus_rsp_refilling;
  wire  DBusCachedPlugin_mmuBus_end;
  wire  DBusCachedPlugin_mmuBus_busy;
  reg  DBusCachedPlugin_redoBranch_valid;
  wire [31:0] DBusCachedPlugin_redoBranch_payload;
  reg  DBusCachedPlugin_exceptionBus_valid;
  reg [3:0] DBusCachedPlugin_exceptionBus_payload_code;
  wire [31:0] DBusCachedPlugin_exceptionBus_payload_badAddr;
  wire  decodeExceptionPort_valid;
  wire [3:0] decodeExceptionPort_payload_code;
  wire [31:0] decodeExceptionPort_payload_badAddr;
  reg  CsrPlugin_jumpInterface_valid;
  reg [31:0] CsrPlugin_jumpInterface_payload;
  wire  CsrPlugin_exceptionPendings_0;
  wire  CsrPlugin_exceptionPendings_1;
  wire  CsrPlugin_exceptionPendings_2;
  wire  CsrPlugin_exceptionPendings_3;
  wire  externalInterrupt;
  wire  externalInterruptS;
  wire  contextSwitching;
  reg [1:0] CsrPlugin_privilege;
  wire  CsrPlugin_forceMachineWire;
  reg  CsrPlugin_selfException_valid;
  reg [3:0] CsrPlugin_selfException_payload_code;
  wire [31:0] CsrPlugin_selfException_payload_badAddr;
  wire  CsrPlugin_allowInterrupts;
  wire  CsrPlugin_allowException;
  wire  BranchPlugin_jumpInterface_valid;
  wire [31:0] BranchPlugin_jumpInterface_payload;
  reg  MmuPlugin_dBusAccess_cmd_valid;
  reg  MmuPlugin_dBusAccess_cmd_ready;
  reg [31:0] MmuPlugin_dBusAccess_cmd_payload_address;
  wire [1:0] MmuPlugin_dBusAccess_cmd_payload_size;
  wire  MmuPlugin_dBusAccess_cmd_payload_write;
  wire [31:0] MmuPlugin_dBusAccess_cmd_payload_data;
  wire [3:0] MmuPlugin_dBusAccess_cmd_payload_writeMask;
  wire  MmuPlugin_dBusAccess_rsp_valid;
  wire [31:0] MmuPlugin_dBusAccess_rsp_payload_data;
  wire  MmuPlugin_dBusAccess_rsp_payload_error;
  wire  MmuPlugin_dBusAccess_rsp_payload_redo;
  wire  IBusCachedPlugin_jump_pcLoad_valid;
  wire [31:0] IBusCachedPlugin_jump_pcLoad_payload;
  wire [4:0] _zz_106_;
  wire [4:0] _zz_107_;
  wire  _zz_108_;
  wire  _zz_109_;
  wire  _zz_110_;
  wire  _zz_111_;
  wire  IBusCachedPlugin_fetchPc_output_valid;
  wire  IBusCachedPlugin_fetchPc_output_ready;
  wire [31:0] IBusCachedPlugin_fetchPc_output_payload;
  reg [31:0] IBusCachedPlugin_fetchPc_pcReg /* verilator public */ ;
  reg  IBusCachedPlugin_fetchPc_corrected;
  reg  IBusCachedPlugin_fetchPc_pcRegPropagate;
  reg  IBusCachedPlugin_fetchPc_booted;
  reg  IBusCachedPlugin_fetchPc_inc;
  reg [31:0] IBusCachedPlugin_fetchPc_pc;
  reg [31:0] IBusCachedPlugin_decodePc_pcReg /* verilator public */ ;
  wire [31:0] IBusCachedPlugin_decodePc_pcPlus;
  wire  IBusCachedPlugin_decodePc_injectedDecode;
  wire  IBusCachedPlugin_iBusRsp_stages_0_input_valid;
  wire  IBusCachedPlugin_iBusRsp_stages_0_input_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_stages_0_input_payload;
  wire  IBusCachedPlugin_iBusRsp_stages_0_output_valid;
  wire  IBusCachedPlugin_iBusRsp_stages_0_output_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_stages_0_output_payload;
  wire  IBusCachedPlugin_iBusRsp_stages_0_halt;
  wire  IBusCachedPlugin_iBusRsp_stages_0_inputSample;
  wire  IBusCachedPlugin_iBusRsp_stages_1_input_valid;
  wire  IBusCachedPlugin_iBusRsp_stages_1_input_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_stages_1_input_payload;
  wire  IBusCachedPlugin_iBusRsp_stages_1_output_valid;
  wire  IBusCachedPlugin_iBusRsp_stages_1_output_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_stages_1_output_payload;
  reg  IBusCachedPlugin_iBusRsp_stages_1_halt;
  wire  IBusCachedPlugin_iBusRsp_stages_1_inputSample;
  wire  IBusCachedPlugin_iBusRsp_stages_2_input_valid;
  wire  IBusCachedPlugin_iBusRsp_stages_2_input_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_stages_2_input_payload;
  wire  IBusCachedPlugin_iBusRsp_stages_2_output_valid;
  wire  IBusCachedPlugin_iBusRsp_stages_2_output_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_stages_2_output_payload;
  reg  IBusCachedPlugin_iBusRsp_stages_2_halt;
  wire  IBusCachedPlugin_iBusRsp_stages_2_inputSample;
  wire  IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_valid;
  wire  IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_payload;
  wire  IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_valid;
  wire  IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_payload;
  reg  IBusCachedPlugin_iBusRsp_cacheRspArbitration_halt;
  wire  IBusCachedPlugin_iBusRsp_cacheRspArbitration_inputSample;
  wire  _zz_112_;
  wire  _zz_113_;
  wire  _zz_114_;
  wire  _zz_115_;
  wire  _zz_116_;
  wire  _zz_117_;
  reg  _zz_118_;
  wire  _zz_119_;
  reg  _zz_120_;
  reg [31:0] _zz_121_;
  wire  _zz_122_;
  reg  _zz_123_;
  reg [31:0] _zz_124_;
  reg  IBusCachedPlugin_iBusRsp_readyForError;
  wire  IBusCachedPlugin_iBusRsp_output_valid;
  wire  IBusCachedPlugin_iBusRsp_output_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_output_payload_pc;
  wire  IBusCachedPlugin_iBusRsp_output_payload_rsp_error;
  wire [31:0] IBusCachedPlugin_iBusRsp_output_payload_rsp_inst;
  wire  IBusCachedPlugin_iBusRsp_output_payload_isRvc;
  wire  IBusCachedPlugin_decompressor_inputBeforeStage_valid;
  wire  IBusCachedPlugin_decompressor_inputBeforeStage_ready;
  wire [31:0] IBusCachedPlugin_decompressor_inputBeforeStage_payload_pc;
  wire  IBusCachedPlugin_decompressor_inputBeforeStage_payload_rsp_error;
  wire [31:0] IBusCachedPlugin_decompressor_inputBeforeStage_payload_rsp_inst;
  wire  IBusCachedPlugin_decompressor_inputBeforeStage_payload_isRvc;
  reg  IBusCachedPlugin_decompressor_bufferValid;
  reg [15:0] IBusCachedPlugin_decompressor_bufferData;
  wire [31:0] IBusCachedPlugin_decompressor_raw;
  wire  IBusCachedPlugin_decompressor_isRvc;
  wire [15:0] _zz_125_;
  reg [31:0] IBusCachedPlugin_decompressor_decompressed;
  wire [4:0] _zz_126_;
  wire [4:0] _zz_127_;
  wire [11:0] _zz_128_;
  wire  _zz_129_;
  reg [11:0] _zz_130_;
  wire  _zz_131_;
  reg [9:0] _zz_132_;
  wire [20:0] _zz_133_;
  wire  _zz_134_;
  reg [14:0] _zz_135_;
  wire  _zz_136_;
  reg [2:0] _zz_137_;
  wire  _zz_138_;
  reg [9:0] _zz_139_;
  wire [20:0] _zz_140_;
  wire  _zz_141_;
  reg [4:0] _zz_142_;
  wire [12:0] _zz_143_;
  wire [4:0] _zz_144_;
  wire [4:0] _zz_145_;
  wire [4:0] _zz_146_;
  wire  _zz_147_;
  reg [2:0] _zz_148_;
  reg [2:0] _zz_149_;
  wire  _zz_150_;
  reg [6:0] _zz_151_;
  reg  IBusCachedPlugin_decompressor_bufferFill;
  wire  IBusCachedPlugin_injector_decodeInput_valid;
  wire  IBusCachedPlugin_injector_decodeInput_ready;
  wire [31:0] IBusCachedPlugin_injector_decodeInput_payload_pc;
  wire  IBusCachedPlugin_injector_decodeInput_payload_rsp_error;
  wire [31:0] IBusCachedPlugin_injector_decodeInput_payload_rsp_inst;
  wire  IBusCachedPlugin_injector_decodeInput_payload_isRvc;
  reg  _zz_152_;
  reg [31:0] _zz_153_;
  reg  _zz_154_;
  reg [31:0] _zz_155_;
  reg  _zz_156_;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_0;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_1;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_2;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_3;
  reg  IBusCachedPlugin_injector_decodeRemoved;
  reg [31:0] IBusCachedPlugin_injector_formal_rawInDecode;
  wire  _zz_157_;
  reg [18:0] _zz_158_;
  wire  _zz_159_;
  reg [10:0] _zz_160_;
  wire  _zz_161_;
  reg [18:0] _zz_162_;
  wire  iBus_cmd_valid;
  wire  iBus_cmd_ready;
  reg [31:0] iBus_cmd_payload_address;
  wire [2:0] iBus_cmd_payload_size;
  wire  iBus_rsp_valid;
  wire [31:0] iBus_rsp_payload_data;
  wire  iBus_rsp_payload_error;
  wire [31:0] _zz_163_;
  reg [31:0] IBusCachedPlugin_rspCounter;
  wire  IBusCachedPlugin_s0_tightlyCoupledHit;
  reg  IBusCachedPlugin_s1_tightlyCoupledHit;
  reg  IBusCachedPlugin_s2_tightlyCoupledHit;
  wire  IBusCachedPlugin_rsp_iBusRspOutputHalt;
  reg  IBusCachedPlugin_rsp_redoFetch;
  wire  dBus_cmd_valid;
  wire  dBus_cmd_ready;
  wire  dBus_cmd_payload_wr;
  wire [31:0] dBus_cmd_payload_address;
  wire [31:0] dBus_cmd_payload_data;
  wire [3:0] dBus_cmd_payload_mask;
  wire [2:0] dBus_cmd_payload_length;
  wire  dBus_cmd_payload_last;
  wire  dBus_rsp_valid;
  wire [31:0] dBus_rsp_payload_data;
  wire  dBus_rsp_payload_error;
  wire  dataCache_1__io_mem_cmd_s2mPipe_valid;
  wire  dataCache_1__io_mem_cmd_s2mPipe_ready;
  wire  dataCache_1__io_mem_cmd_s2mPipe_payload_wr;
  wire [31:0] dataCache_1__io_mem_cmd_s2mPipe_payload_address;
  wire [31:0] dataCache_1__io_mem_cmd_s2mPipe_payload_data;
  wire [3:0] dataCache_1__io_mem_cmd_s2mPipe_payload_mask;
  wire [2:0] dataCache_1__io_mem_cmd_s2mPipe_payload_length;
  wire  dataCache_1__io_mem_cmd_s2mPipe_payload_last;
  reg  _zz_164_;
  reg  _zz_165_;
  reg [31:0] _zz_166_;
  reg [31:0] _zz_167_;
  reg [3:0] _zz_168_;
  reg [2:0] _zz_169_;
  reg  _zz_170_;
  wire  dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_valid;
  wire  dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_ready;
  wire  dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_wr;
  wire [31:0] dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_address;
  wire [31:0] dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_data;
  wire [3:0] dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_mask;
  wire [2:0] dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_length;
  wire  dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_last;
  reg  _zz_171_;
  reg  _zz_172_;
  reg [31:0] _zz_173_;
  reg [31:0] _zz_174_;
  reg [3:0] _zz_175_;
  reg [2:0] _zz_176_;
  reg  _zz_177_;
  wire [31:0] _zz_178_;
  reg [31:0] DBusCachedPlugin_rspCounter;
  wire [1:0] execute_DBusCachedPlugin_size;
  reg [31:0] _zz_179_;
  reg [31:0] writeBack_DBusCachedPlugin_rspShifted;
  wire  _zz_180_;
  reg [31:0] _zz_181_;
  wire  _zz_182_;
  reg [31:0] _zz_183_;
  reg [31:0] writeBack_DBusCachedPlugin_rspFormated;
  reg  DBusCachedPlugin_forceDatapath;
  wire [35:0] _zz_184_;
  wire  _zz_185_;
  wire  _zz_186_;
  wire  _zz_187_;
  wire  _zz_188_;
  wire  _zz_189_;
  wire  _zz_190_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_191_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_192_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_193_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_194_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_195_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_196_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_197_;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress1;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress2;
  wire [31:0] decode_RegFilePlugin_rs1Data;
  wire [31:0] decode_RegFilePlugin_rs2Data;
  reg  lastStageRegFileWrite_valid /* verilator public */ ;
  wire [4:0] lastStageRegFileWrite_payload_address /* verilator public */ ;
  wire [31:0] lastStageRegFileWrite_payload_data /* verilator public */ ;
  reg  _zz_198_;
  reg [31:0] execute_IntAluPlugin_bitwise;
  reg [31:0] _zz_199_;
  reg [31:0] _zz_200_;
  wire  _zz_201_;
  reg [19:0] _zz_202_;
  wire  _zz_203_;
  reg [19:0] _zz_204_;
  reg [31:0] _zz_205_;
  reg [31:0] execute_SrcPlugin_addSub;
  wire  execute_SrcPlugin_less;
  wire [4:0] execute_FullBarrelShifterPlugin_amplitude;
  reg [31:0] _zz_206_;
  wire [31:0] execute_FullBarrelShifterPlugin_reversed;
  reg [31:0] _zz_207_;
  reg  _zz_208_;
  reg  _zz_209_;
  wire  _zz_210_;
  reg  _zz_211_;
  reg [4:0] _zz_212_;
  reg [31:0] _zz_213_;
  wire  _zz_214_;
  wire  _zz_215_;
  wire  _zz_216_;
  wire  _zz_217_;
  wire  _zz_218_;
  wire  _zz_219_;
  reg  execute_MulPlugin_aSigned;
  reg  execute_MulPlugin_bSigned;
  wire [31:0] execute_MulPlugin_a;
  wire [31:0] execute_MulPlugin_b;
  wire [15:0] execute_MulPlugin_aULow;
  wire [15:0] execute_MulPlugin_bULow;
  wire [16:0] execute_MulPlugin_aSLow;
  wire [16:0] execute_MulPlugin_bSLow;
  wire [16:0] execute_MulPlugin_aHigh;
  wire [16:0] execute_MulPlugin_bHigh;
  wire [65:0] writeBack_MulPlugin_result;
  reg [32:0] memory_DivPlugin_rs1;
  reg [31:0] memory_DivPlugin_rs2;
  reg [64:0] memory_DivPlugin_accumulator;
  reg  memory_DivPlugin_div_needRevert;
  reg  memory_DivPlugin_div_counter_willIncrement;
  reg  memory_DivPlugin_div_counter_willClear;
  reg [5:0] memory_DivPlugin_div_counter_valueNext;
  reg [5:0] memory_DivPlugin_div_counter_value;
  wire  memory_DivPlugin_div_counter_willOverflowIfInc;
  wire  memory_DivPlugin_div_counter_willOverflow;
  reg  memory_DivPlugin_div_done;
  reg [31:0] memory_DivPlugin_div_result;
  wire [31:0] _zz_220_;
  wire [32:0] _zz_221_;
  wire [32:0] _zz_222_;
  wire [31:0] _zz_223_;
  wire  _zz_224_;
  wire  _zz_225_;
  reg [32:0] _zz_226_;
  reg [1:0] _zz_227_;
  wire [1:0] CsrPlugin_misa_base;
  wire [25:0] CsrPlugin_misa_extensions;
  reg [1:0] CsrPlugin_mtvec_mode;
  reg [29:0] CsrPlugin_mtvec_base;
  reg [31:0] CsrPlugin_mepc;
  reg  CsrPlugin_mstatus_MIE;
  reg  CsrPlugin_mstatus_MPIE;
  reg [1:0] CsrPlugin_mstatus_MPP;
  reg  CsrPlugin_mip_MEIP;
  reg  CsrPlugin_mip_MTIP;
  reg  CsrPlugin_mip_MSIP;
  reg  CsrPlugin_mie_MEIE;
  reg  CsrPlugin_mie_MTIE;
  reg  CsrPlugin_mie_MSIE;
  reg [31:0] CsrPlugin_mscratch;
  reg  CsrPlugin_mcause_interrupt;
  reg [3:0] CsrPlugin_mcause_exceptionCode;
  reg [31:0] CsrPlugin_mtval;
  reg [63:0] CsrPlugin_mcycle = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  reg [63:0] CsrPlugin_minstret = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  reg  CsrPlugin_medeleg_IAM;
  reg  CsrPlugin_medeleg_IAF;
  reg  CsrPlugin_medeleg_II;
  reg  CsrPlugin_medeleg_LAM;
  reg  CsrPlugin_medeleg_LAF;
  reg  CsrPlugin_medeleg_SAM;
  reg  CsrPlugin_medeleg_SAF;
  reg  CsrPlugin_medeleg_EU;
  reg  CsrPlugin_medeleg_ES;
  reg  CsrPlugin_medeleg_IPF;
  reg  CsrPlugin_medeleg_LPF;
  reg  CsrPlugin_medeleg_SPF;
  reg  CsrPlugin_mideleg_ST;
  reg  CsrPlugin_mideleg_SE;
  reg  CsrPlugin_mideleg_SS;
  reg  CsrPlugin_sstatus_SIE;
  reg  CsrPlugin_sstatus_SPIE;
  reg [0:0] CsrPlugin_sstatus_SPP;
  reg  CsrPlugin_sip_SEIP_SOFT;
  reg  CsrPlugin_sip_SEIP_INPUT;
  wire  CsrPlugin_sip_SEIP_OR;
  reg  CsrPlugin_sip_STIP;
  reg  CsrPlugin_sip_SSIP;
  reg  CsrPlugin_sie_SEIE;
  reg  CsrPlugin_sie_STIE;
  reg  CsrPlugin_sie_SSIE;
  reg [1:0] CsrPlugin_stvec_mode;
  reg [29:0] CsrPlugin_stvec_base;
  reg [31:0] CsrPlugin_sscratch;
  reg  CsrPlugin_scause_interrupt;
  reg [3:0] CsrPlugin_scause_exceptionCode;
  reg [31:0] CsrPlugin_stval;
  reg [31:0] CsrPlugin_sepc;
  reg [21:0] CsrPlugin_satp_PPN;
  reg [8:0] CsrPlugin_satp_ASID;
  reg [0:0] CsrPlugin_satp_MODE;
  wire  _zz_228_;
  wire  _zz_229_;
  wire  _zz_230_;
  wire  _zz_231_;
  wire  _zz_232_;
  wire  _zz_233_;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  reg [3:0] CsrPlugin_exceptionPortCtrl_exceptionContext_code;
  reg [31:0] CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
  reg [1:0] CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped;
  wire [1:0] CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
  wire [1:0] _zz_234_;
  wire  _zz_235_;
  reg  CsrPlugin_interrupt_valid;
  reg [3:0] CsrPlugin_interrupt_code /* verilator public */ ;
  reg [1:0] CsrPlugin_interrupt_targetPrivilege;
  wire  CsrPlugin_exception;
  reg  CsrPlugin_lastStageWasWfi;
  reg  CsrPlugin_pipelineLiberator_done;
  wire  CsrPlugin_interruptJump /* verilator public */ ;
  reg  CsrPlugin_hadException;
  reg [1:0] CsrPlugin_targetPrivilege;
  reg [3:0] CsrPlugin_trapCause;
  reg [1:0] CsrPlugin_xtvec_mode;
  reg [29:0] CsrPlugin_xtvec_base;
  reg  execute_CsrPlugin_inWfi /* verilator public */ ;
  reg  execute_CsrPlugin_wfiWake;
  wire  execute_CsrPlugin_blockedBySideEffects;
  reg  execute_CsrPlugin_illegalAccess;
  reg  execute_CsrPlugin_illegalInstruction;
  reg [31:0] execute_CsrPlugin_readData;
  wire  execute_CsrPlugin_writeInstruction;
  wire  execute_CsrPlugin_readInstruction;
  wire  execute_CsrPlugin_writeEnable;
  wire  execute_CsrPlugin_readEnable;
  reg [31:0] execute_CsrPlugin_readToWriteData;
  reg [31:0] execute_CsrPlugin_writeData;
  wire [11:0] execute_CsrPlugin_csrAddress;
  wire  execute_BranchPlugin_eq;
  wire [2:0] _zz_236_;
  reg  _zz_237_;
  reg  _zz_238_;
  wire  execute_BranchPlugin_missAlignedTarget;
  reg [31:0] execute_BranchPlugin_branch_src1;
  reg [31:0] execute_BranchPlugin_branch_src2;
  wire  _zz_239_;
  reg [19:0] _zz_240_;
  wire  _zz_241_;
  reg [10:0] _zz_242_;
  wire  _zz_243_;
  reg [18:0] _zz_244_;
  wire [31:0] execute_BranchPlugin_branchAdder;
  reg  MmuPlugin_status_sum;
  reg  MmuPlugin_status_mxr;
  reg  MmuPlugin_status_mprv;
  reg  MmuPlugin_satp_mode;
  reg [8:0] MmuPlugin_satp_asid;
  reg [19:0] MmuPlugin_satp_ppn;
  reg  MmuPlugin_ports_0_cache_0_valid;
  reg  MmuPlugin_ports_0_cache_0_exception;
  reg  MmuPlugin_ports_0_cache_0_superPage;
  reg [9:0] MmuPlugin_ports_0_cache_0_virtualAddress_0;
  reg [9:0] MmuPlugin_ports_0_cache_0_virtualAddress_1;
  reg [9:0] MmuPlugin_ports_0_cache_0_physicalAddress_0;
  reg [9:0] MmuPlugin_ports_0_cache_0_physicalAddress_1;
  reg  MmuPlugin_ports_0_cache_0_allowRead;
  reg  MmuPlugin_ports_0_cache_0_allowWrite;
  reg  MmuPlugin_ports_0_cache_0_allowExecute;
  reg  MmuPlugin_ports_0_cache_0_allowUser;
  reg  MmuPlugin_ports_0_cache_1_valid;
  reg  MmuPlugin_ports_0_cache_1_exception;
  reg  MmuPlugin_ports_0_cache_1_superPage;
  reg [9:0] MmuPlugin_ports_0_cache_1_virtualAddress_0;
  reg [9:0] MmuPlugin_ports_0_cache_1_virtualAddress_1;
  reg [9:0] MmuPlugin_ports_0_cache_1_physicalAddress_0;
  reg [9:0] MmuPlugin_ports_0_cache_1_physicalAddress_1;
  reg  MmuPlugin_ports_0_cache_1_allowRead;
  reg  MmuPlugin_ports_0_cache_1_allowWrite;
  reg  MmuPlugin_ports_0_cache_1_allowExecute;
  reg  MmuPlugin_ports_0_cache_1_allowUser;
  reg  MmuPlugin_ports_0_cache_2_valid;
  reg  MmuPlugin_ports_0_cache_2_exception;
  reg  MmuPlugin_ports_0_cache_2_superPage;
  reg [9:0] MmuPlugin_ports_0_cache_2_virtualAddress_0;
  reg [9:0] MmuPlugin_ports_0_cache_2_virtualAddress_1;
  reg [9:0] MmuPlugin_ports_0_cache_2_physicalAddress_0;
  reg [9:0] MmuPlugin_ports_0_cache_2_physicalAddress_1;
  reg  MmuPlugin_ports_0_cache_2_allowRead;
  reg  MmuPlugin_ports_0_cache_2_allowWrite;
  reg  MmuPlugin_ports_0_cache_2_allowExecute;
  reg  MmuPlugin_ports_0_cache_2_allowUser;
  reg  MmuPlugin_ports_0_cache_3_valid;
  reg  MmuPlugin_ports_0_cache_3_exception;
  reg  MmuPlugin_ports_0_cache_3_superPage;
  reg [9:0] MmuPlugin_ports_0_cache_3_virtualAddress_0;
  reg [9:0] MmuPlugin_ports_0_cache_3_virtualAddress_1;
  reg [9:0] MmuPlugin_ports_0_cache_3_physicalAddress_0;
  reg [9:0] MmuPlugin_ports_0_cache_3_physicalAddress_1;
  reg  MmuPlugin_ports_0_cache_3_allowRead;
  reg  MmuPlugin_ports_0_cache_3_allowWrite;
  reg  MmuPlugin_ports_0_cache_3_allowExecute;
  reg  MmuPlugin_ports_0_cache_3_allowUser;
  wire  MmuPlugin_ports_0_cacheHits_0;
  wire  MmuPlugin_ports_0_cacheHits_1;
  wire  MmuPlugin_ports_0_cacheHits_2;
  wire  MmuPlugin_ports_0_cacheHits_3;
  wire  MmuPlugin_ports_0_cacheHit;
  wire  _zz_245_;
  wire  _zz_246_;
  wire [1:0] _zz_247_;
  wire  MmuPlugin_ports_0_cacheLine_valid;
  wire  MmuPlugin_ports_0_cacheLine_exception;
  wire  MmuPlugin_ports_0_cacheLine_superPage;
  wire [9:0] MmuPlugin_ports_0_cacheLine_virtualAddress_0;
  wire [9:0] MmuPlugin_ports_0_cacheLine_virtualAddress_1;
  wire [9:0] MmuPlugin_ports_0_cacheLine_physicalAddress_0;
  wire [9:0] MmuPlugin_ports_0_cacheLine_physicalAddress_1;
  wire  MmuPlugin_ports_0_cacheLine_allowRead;
  wire  MmuPlugin_ports_0_cacheLine_allowWrite;
  wire  MmuPlugin_ports_0_cacheLine_allowExecute;
  wire  MmuPlugin_ports_0_cacheLine_allowUser;
  reg  MmuPlugin_ports_0_entryToReplace_willIncrement;
  wire  MmuPlugin_ports_0_entryToReplace_willClear;
  reg [1:0] MmuPlugin_ports_0_entryToReplace_valueNext;
  reg [1:0] MmuPlugin_ports_0_entryToReplace_value;
  wire  MmuPlugin_ports_0_entryToReplace_willOverflowIfInc;
  wire  MmuPlugin_ports_0_entryToReplace_willOverflow;
  reg  MmuPlugin_ports_0_requireMmuLockup;
  reg  MmuPlugin_ports_1_cache_0_valid;
  reg  MmuPlugin_ports_1_cache_0_exception;
  reg  MmuPlugin_ports_1_cache_0_superPage;
  reg [9:0] MmuPlugin_ports_1_cache_0_virtualAddress_0;
  reg [9:0] MmuPlugin_ports_1_cache_0_virtualAddress_1;
  reg [9:0] MmuPlugin_ports_1_cache_0_physicalAddress_0;
  reg [9:0] MmuPlugin_ports_1_cache_0_physicalAddress_1;
  reg  MmuPlugin_ports_1_cache_0_allowRead;
  reg  MmuPlugin_ports_1_cache_0_allowWrite;
  reg  MmuPlugin_ports_1_cache_0_allowExecute;
  reg  MmuPlugin_ports_1_cache_0_allowUser;
  reg  MmuPlugin_ports_1_cache_1_valid;
  reg  MmuPlugin_ports_1_cache_1_exception;
  reg  MmuPlugin_ports_1_cache_1_superPage;
  reg [9:0] MmuPlugin_ports_1_cache_1_virtualAddress_0;
  reg [9:0] MmuPlugin_ports_1_cache_1_virtualAddress_1;
  reg [9:0] MmuPlugin_ports_1_cache_1_physicalAddress_0;
  reg [9:0] MmuPlugin_ports_1_cache_1_physicalAddress_1;
  reg  MmuPlugin_ports_1_cache_1_allowRead;
  reg  MmuPlugin_ports_1_cache_1_allowWrite;
  reg  MmuPlugin_ports_1_cache_1_allowExecute;
  reg  MmuPlugin_ports_1_cache_1_allowUser;
  reg  MmuPlugin_ports_1_cache_2_valid;
  reg  MmuPlugin_ports_1_cache_2_exception;
  reg  MmuPlugin_ports_1_cache_2_superPage;
  reg [9:0] MmuPlugin_ports_1_cache_2_virtualAddress_0;
  reg [9:0] MmuPlugin_ports_1_cache_2_virtualAddress_1;
  reg [9:0] MmuPlugin_ports_1_cache_2_physicalAddress_0;
  reg [9:0] MmuPlugin_ports_1_cache_2_physicalAddress_1;
  reg  MmuPlugin_ports_1_cache_2_allowRead;
  reg  MmuPlugin_ports_1_cache_2_allowWrite;
  reg  MmuPlugin_ports_1_cache_2_allowExecute;
  reg  MmuPlugin_ports_1_cache_2_allowUser;
  reg  MmuPlugin_ports_1_cache_3_valid;
  reg  MmuPlugin_ports_1_cache_3_exception;
  reg  MmuPlugin_ports_1_cache_3_superPage;
  reg [9:0] MmuPlugin_ports_1_cache_3_virtualAddress_0;
  reg [9:0] MmuPlugin_ports_1_cache_3_virtualAddress_1;
  reg [9:0] MmuPlugin_ports_1_cache_3_physicalAddress_0;
  reg [9:0] MmuPlugin_ports_1_cache_3_physicalAddress_1;
  reg  MmuPlugin_ports_1_cache_3_allowRead;
  reg  MmuPlugin_ports_1_cache_3_allowWrite;
  reg  MmuPlugin_ports_1_cache_3_allowExecute;
  reg  MmuPlugin_ports_1_cache_3_allowUser;
  wire  MmuPlugin_ports_1_cacheHits_0;
  wire  MmuPlugin_ports_1_cacheHits_1;
  wire  MmuPlugin_ports_1_cacheHits_2;
  wire  MmuPlugin_ports_1_cacheHits_3;
  wire  MmuPlugin_ports_1_cacheHit;
  wire  _zz_248_;
  wire  _zz_249_;
  wire [1:0] _zz_250_;
  wire  MmuPlugin_ports_1_cacheLine_valid;
  wire  MmuPlugin_ports_1_cacheLine_exception;
  wire  MmuPlugin_ports_1_cacheLine_superPage;
  wire [9:0] MmuPlugin_ports_1_cacheLine_virtualAddress_0;
  wire [9:0] MmuPlugin_ports_1_cacheLine_virtualAddress_1;
  wire [9:0] MmuPlugin_ports_1_cacheLine_physicalAddress_0;
  wire [9:0] MmuPlugin_ports_1_cacheLine_physicalAddress_1;
  wire  MmuPlugin_ports_1_cacheLine_allowRead;
  wire  MmuPlugin_ports_1_cacheLine_allowWrite;
  wire  MmuPlugin_ports_1_cacheLine_allowExecute;
  wire  MmuPlugin_ports_1_cacheLine_allowUser;
  reg  MmuPlugin_ports_1_entryToReplace_willIncrement;
  wire  MmuPlugin_ports_1_entryToReplace_willClear;
  reg [1:0] MmuPlugin_ports_1_entryToReplace_valueNext;
  reg [1:0] MmuPlugin_ports_1_entryToReplace_value;
  wire  MmuPlugin_ports_1_entryToReplace_willOverflowIfInc;
  wire  MmuPlugin_ports_1_entryToReplace_willOverflow;
  reg  MmuPlugin_ports_1_requireMmuLockup;
  reg `MmuPlugin_shared_State_defaultEncoding_type MmuPlugin_shared_state_1_;
  reg [9:0] MmuPlugin_shared_vpn_0;
  reg [9:0] MmuPlugin_shared_vpn_1;
  reg [0:0] MmuPlugin_shared_portId;
  wire  MmuPlugin_shared_dBusRsp_pte_V;
  wire  MmuPlugin_shared_dBusRsp_pte_R;
  wire  MmuPlugin_shared_dBusRsp_pte_W;
  wire  MmuPlugin_shared_dBusRsp_pte_X;
  wire  MmuPlugin_shared_dBusRsp_pte_U;
  wire  MmuPlugin_shared_dBusRsp_pte_G;
  wire  MmuPlugin_shared_dBusRsp_pte_A;
  wire  MmuPlugin_shared_dBusRsp_pte_D;
  wire [1:0] MmuPlugin_shared_dBusRsp_pte_RSW;
  wire [9:0] MmuPlugin_shared_dBusRsp_pte_PPN0;
  wire [11:0] MmuPlugin_shared_dBusRsp_pte_PPN1;
  wire  MmuPlugin_shared_dBusRsp_exception;
  wire  MmuPlugin_shared_dBusRsp_leaf;
  reg  MmuPlugin_shared_pteBuffer_V;
  reg  MmuPlugin_shared_pteBuffer_R;
  reg  MmuPlugin_shared_pteBuffer_W;
  reg  MmuPlugin_shared_pteBuffer_X;
  reg  MmuPlugin_shared_pteBuffer_U;
  reg  MmuPlugin_shared_pteBuffer_G;
  reg  MmuPlugin_shared_pteBuffer_A;
  reg  MmuPlugin_shared_pteBuffer_D;
  reg [1:0] MmuPlugin_shared_pteBuffer_RSW;
  reg [9:0] MmuPlugin_shared_pteBuffer_PPN0;
  reg [11:0] MmuPlugin_shared_pteBuffer_PPN1;
  reg [31:0] externalInterruptArray_regNext;
  reg [31:0] _zz_251_;
  wire [31:0] _zz_252_;
  reg [31:0] _zz_253_;
  wire [31:0] _zz_254_;
  reg  decode_to_execute_IS_RS1_SIGNED;
  reg `Src2CtrlEnum_defaultEncoding_type decode_to_execute_SRC2_CTRL;
  reg  decode_to_execute_SRC_LESS_UNSIGNED;
  reg  execute_to_memory_IS_DBUS_SHARING;
  reg  memory_to_writeBack_IS_DBUS_SHARING;
  reg  decode_to_execute_IS_CSR;
  reg  execute_to_memory_IS_CSR;
  reg [51:0] memory_to_writeBack_MUL_LOW;
  reg [31:0] execute_to_memory_BRANCH_CALC;
  reg  decode_to_execute_IS_MUL;
  reg  execute_to_memory_IS_MUL;
  reg  memory_to_writeBack_IS_MUL;
  reg [33:0] execute_to_memory_MUL_LH;
  reg [31:0] execute_to_memory_REGFILE_WRITE_DATA;
  reg [31:0] memory_to_writeBack_REGFILE_WRITE_DATA;
  reg  decode_to_execute_MEMORY_ENABLE;
  reg  execute_to_memory_MEMORY_ENABLE;
  reg  memory_to_writeBack_MEMORY_ENABLE;
  reg [31:0] execute_to_memory_SHIFT_RIGHT;
  reg  decode_to_execute_IS_SFENCE_VMA;
  reg  execute_to_memory_IS_SFENCE_VMA;
  reg  memory_to_writeBack_IS_SFENCE_VMA;
  reg  decode_to_execute_CSR_READ_OPCODE;
  reg  decode_to_execute_MEMORY_AMO;
  reg [31:0] decode_to_execute_INSTRUCTION;
  reg [31:0] execute_to_memory_INSTRUCTION;
  reg [31:0] memory_to_writeBack_INSTRUCTION;
  reg  decode_to_execute_IS_RVC;
  reg  decode_to_execute_PREDICTION_HAD_BRANCHED2;
  reg  decode_to_execute_IS_RS2_SIGNED;
  reg  decode_to_execute_IS_DIV;
  reg  execute_to_memory_IS_DIV;
  reg  decode_to_execute_SRC2_FORCE_ZERO;
  reg  decode_to_execute_MEMORY_LRSC;
  reg [31:0] decode_to_execute_RS1;
  reg [33:0] execute_to_memory_MUL_HL;
  reg `AluBitwiseCtrlEnum_defaultEncoding_type decode_to_execute_ALU_BITWISE_CTRL;
  reg [31:0] execute_to_memory_PIPELINED_CSR_READ;
  reg `AluCtrlEnum_defaultEncoding_type decode_to_execute_ALU_CTRL;
  reg `ShiftCtrlEnum_defaultEncoding_type decode_to_execute_SHIFT_CTRL;
  reg `ShiftCtrlEnum_defaultEncoding_type execute_to_memory_SHIFT_CTRL;
  reg  decode_to_execute_CSR_WRITE_OPCODE;
  reg [31:0] decode_to_execute_PC;
  reg [31:0] execute_to_memory_PC;
  reg [31:0] memory_to_writeBack_PC;
  reg  decode_to_execute_MEMORY_WR;
  reg  execute_to_memory_MEMORY_WR;
  reg  memory_to_writeBack_MEMORY_WR;
  reg `BranchCtrlEnum_defaultEncoding_type decode_to_execute_BRANCH_CTRL;
  reg  decode_to_execute_REGFILE_WRITE_VALID;
  reg  execute_to_memory_REGFILE_WRITE_VALID;
  reg  memory_to_writeBack_REGFILE_WRITE_VALID;
  reg  decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  reg  decode_to_execute_MEMORY_MANAGMENT;
  reg  execute_to_memory_BRANCH_DO;
  reg [31:0] execute_to_memory_MUL_LL;
  reg [31:0] decode_to_execute_RS2;
  reg `EnvCtrlEnum_defaultEncoding_type decode_to_execute_ENV_CTRL;
  reg `EnvCtrlEnum_defaultEncoding_type execute_to_memory_ENV_CTRL;
  reg `EnvCtrlEnum_defaultEncoding_type memory_to_writeBack_ENV_CTRL;
  reg [1:0] execute_to_memory_MEMORY_ADDRESS_LOW;
  reg [1:0] memory_to_writeBack_MEMORY_ADDRESS_LOW;
  reg [33:0] execute_to_memory_MUL_HH;
  reg [33:0] memory_to_writeBack_MUL_HH;
  reg  decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  reg  execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  reg `Src1CtrlEnum_defaultEncoding_type decode_to_execute_SRC1_CTRL;
  reg [31:0] decode_to_execute_FORMAL_PC_NEXT;
  reg [31:0] execute_to_memory_FORMAL_PC_NEXT;
  reg [31:0] memory_to_writeBack_FORMAL_PC_NEXT;
  reg  decode_to_execute_SRC_USE_SUB_LESS;
  reg [2:0] _zz_255_;
  reg  _zz_256_;
  reg [31:0] iBusWishbone_DAT_MISO_regNext;
  reg [2:0] _zz_257_;
  wire  _zz_258_;
  wire  _zz_259_;
  wire  _zz_260_;
  wire  _zz_261_;
  wire  _zz_262_;
  reg  _zz_263_;
  reg [31:0] dBusWishbone_DAT_MISO_regNext;
  `ifndef SYNTHESIS
  reg [95:0] decode_SRC1_CTRL_string;
  reg [95:0] _zz_1__string;
  reg [95:0] _zz_2__string;
  reg [95:0] _zz_3__string;
  reg [47:0] _zz_4__string;
  reg [47:0] _zz_5__string;
  reg [47:0] _zz_6__string;
  reg [47:0] _zz_7__string;
  reg [47:0] decode_ENV_CTRL_string;
  reg [47:0] _zz_8__string;
  reg [47:0] _zz_9__string;
  reg [47:0] _zz_10__string;
  reg [31:0] _zz_11__string;
  reg [31:0] _zz_12__string;
  reg [71:0] _zz_13__string;
  reg [71:0] _zz_14__string;
  reg [71:0] decode_SHIFT_CTRL_string;
  reg [71:0] _zz_15__string;
  reg [71:0] _zz_16__string;
  reg [71:0] _zz_17__string;
  reg [63:0] decode_ALU_CTRL_string;
  reg [63:0] _zz_18__string;
  reg [63:0] _zz_19__string;
  reg [63:0] _zz_20__string;
  reg [39:0] decode_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_21__string;
  reg [39:0] _zz_22__string;
  reg [39:0] _zz_23__string;
  reg [23:0] decode_SRC2_CTRL_string;
  reg [23:0] _zz_24__string;
  reg [23:0] _zz_25__string;
  reg [23:0] _zz_26__string;
  reg [31:0] execute_BRANCH_CTRL_string;
  reg [31:0] _zz_29__string;
  reg [47:0] memory_ENV_CTRL_string;
  reg [47:0] _zz_33__string;
  reg [47:0] execute_ENV_CTRL_string;
  reg [47:0] _zz_34__string;
  reg [47:0] writeBack_ENV_CTRL_string;
  reg [47:0] _zz_37__string;
  reg [71:0] memory_SHIFT_CTRL_string;
  reg [71:0] _zz_45__string;
  reg [71:0] execute_SHIFT_CTRL_string;
  reg [71:0] _zz_47__string;
  reg [23:0] execute_SRC2_CTRL_string;
  reg [23:0] _zz_52__string;
  reg [95:0] execute_SRC1_CTRL_string;
  reg [95:0] _zz_54__string;
  reg [63:0] execute_ALU_CTRL_string;
  reg [63:0] _zz_57__string;
  reg [39:0] execute_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_59__string;
  reg [31:0] _zz_69__string;
  reg [95:0] _zz_72__string;
  reg [23:0] _zz_73__string;
  reg [71:0] _zz_75__string;
  reg [47:0] _zz_78__string;
  reg [63:0] _zz_88__string;
  reg [39:0] _zz_91__string;
  reg [31:0] decode_BRANCH_CTRL_string;
  reg [31:0] _zz_99__string;
  reg [39:0] _zz_191__string;
  reg [63:0] _zz_192__string;
  reg [47:0] _zz_193__string;
  reg [71:0] _zz_194__string;
  reg [23:0] _zz_195__string;
  reg [95:0] _zz_196__string;
  reg [31:0] _zz_197__string;
  reg [47:0] MmuPlugin_shared_state_1__string;
  reg [23:0] decode_to_execute_SRC2_CTRL_string;
  reg [39:0] decode_to_execute_ALU_BITWISE_CTRL_string;
  reg [63:0] decode_to_execute_ALU_CTRL_string;
  reg [71:0] decode_to_execute_SHIFT_CTRL_string;
  reg [71:0] execute_to_memory_SHIFT_CTRL_string;
  reg [31:0] decode_to_execute_BRANCH_CTRL_string;
  reg [47:0] decode_to_execute_ENV_CTRL_string;
  reg [47:0] execute_to_memory_ENV_CTRL_string;
  reg [47:0] memory_to_writeBack_ENV_CTRL_string;
  reg [95:0] decode_to_execute_SRC1_CTRL_string;
  `endif

  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;
  assign _zz_315_ = (writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID);
  assign _zz_316_ = 1'b1;
  assign _zz_317_ = (memory_arbitration_isValid && memory_REGFILE_WRITE_VALID);
  assign _zz_318_ = (execute_arbitration_isValid && execute_REGFILE_WRITE_VALID);
  assign _zz_319_ = (memory_arbitration_isValid && memory_IS_DIV);
  assign _zz_320_ = ((_zz_269_ && IBusCachedPlugin_cache_io_cpu_decode_error) && (! _zz_96_));
  assign _zz_321_ = ((_zz_269_ && IBusCachedPlugin_cache_io_cpu_decode_cacheMiss) && (! _zz_97_));
  assign _zz_322_ = ((_zz_269_ && IBusCachedPlugin_cache_io_cpu_decode_mmuException) && (! _zz_98_));
  assign _zz_323_ = ((_zz_269_ && IBusCachedPlugin_cache_io_cpu_decode_mmuRefilling) && (! 1'b0));
  assign _zz_324_ = ({decodeExceptionPort_valid,IBusCachedPlugin_decodeExceptionPort_valid} != (2'b00));
  assign _zz_325_ = (execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_WFI));
  assign _zz_326_ = (! memory_DivPlugin_div_done);
  assign _zz_327_ = (CsrPlugin_hadException || CsrPlugin_interruptJump);
  assign _zz_328_ = (writeBack_arbitration_isValid && (writeBack_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET));
  assign _zz_329_ = writeBack_INSTRUCTION[29 : 28];
  assign _zz_330_ = (IBusCachedPlugin_iBusRsp_output_valid && IBusCachedPlugin_iBusRsp_output_ready);
  assign _zz_331_ = ((! (((! IBusCachedPlugin_decompressor_isRvc) && (! IBusCachedPlugin_iBusRsp_output_payload_pc[1])) && (! IBusCachedPlugin_decompressor_bufferValid))) && (! ((IBusCachedPlugin_decompressor_isRvc && IBusCachedPlugin_iBusRsp_output_payload_pc[1]) && IBusCachedPlugin_decompressor_inputBeforeStage_ready)));
  assign _zz_332_ = (! IBusCachedPlugin_iBusRsp_readyForError);
  assign _zz_333_ = (! ({(writeBack_arbitration_isValid || CsrPlugin_exceptionPendings_3),{(memory_arbitration_isValid || CsrPlugin_exceptionPendings_2),(execute_arbitration_isValid || CsrPlugin_exceptionPendings_1)}} != (3'b000)));
  assign _zz_334_ = (! dataCache_1__io_cpu_redo);
  assign _zz_335_ = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE);
  assign _zz_336_ = (writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID);
  assign _zz_337_ = (1'b0 || (! 1'b1));
  assign _zz_338_ = (memory_arbitration_isValid && memory_REGFILE_WRITE_VALID);
  assign _zz_339_ = (1'b0 || (! memory_BYPASSABLE_MEMORY_STAGE));
  assign _zz_340_ = (execute_arbitration_isValid && execute_REGFILE_WRITE_VALID);
  assign _zz_341_ = (1'b0 || (! execute_BYPASSABLE_EXECUTE_STAGE));
  assign _zz_342_ = execute_INSTRUCTION[13 : 12];
  assign _zz_343_ = (! memory_arbitration_isStuck);
  assign _zz_344_ = (execute_CsrPlugin_illegalAccess || execute_CsrPlugin_illegalInstruction);
  assign _zz_345_ = (execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_ECALL));
  assign _zz_346_ = (execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_EBREAK));
  assign _zz_347_ = ((MmuPlugin_dBusAccess_rsp_valid && (! MmuPlugin_dBusAccess_rsp_payload_redo)) && (MmuPlugin_shared_dBusRsp_leaf || MmuPlugin_shared_dBusRsp_exception));
  assign _zz_348_ = (MmuPlugin_shared_portId == (1'b1));
  assign _zz_349_ = (MmuPlugin_shared_portId == (1'b0));
  assign _zz_350_ = (iBus_cmd_valid || (_zz_255_ != (3'b000)));
  assign _zz_351_ = (_zz_289_ && (! dataCache_1__io_mem_cmd_s2mPipe_ready));
  assign _zz_352_ = ((CsrPlugin_sstatus_SIE && (CsrPlugin_privilege == (2'b01))) || (CsrPlugin_privilege < (2'b01)));
  assign _zz_353_ = ((_zz_228_ && (1'b1 && CsrPlugin_mideleg_ST)) && (! 1'b0));
  assign _zz_354_ = ((_zz_229_ && (1'b1 && CsrPlugin_mideleg_SS)) && (! 1'b0));
  assign _zz_355_ = ((_zz_230_ && (1'b1 && CsrPlugin_mideleg_SE)) && (! 1'b0));
  assign _zz_356_ = (CsrPlugin_mstatus_MIE || (CsrPlugin_privilege < (2'b11)));
  assign _zz_357_ = ((_zz_228_ && 1'b1) && (! (CsrPlugin_mideleg_ST != (1'b0))));
  assign _zz_358_ = ((_zz_229_ && 1'b1) && (! (CsrPlugin_mideleg_SS != (1'b0))));
  assign _zz_359_ = ((_zz_230_ && 1'b1) && (! (CsrPlugin_mideleg_SE != (1'b0))));
  assign _zz_360_ = ((_zz_231_ && 1'b1) && (! 1'b0));
  assign _zz_361_ = ((_zz_232_ && 1'b1) && (! 1'b0));
  assign _zz_362_ = ((_zz_233_ && 1'b1) && (! 1'b0));
  assign _zz_363_ = (IBusCachedPlugin_mmuBus_cmd_isValid && IBusCachedPlugin_mmuBus_rsp_refilling);
  assign _zz_364_ = (DBusCachedPlugin_mmuBus_cmd_isValid && DBusCachedPlugin_mmuBus_rsp_refilling);
  assign _zz_365_ = (MmuPlugin_ports_0_entryToReplace_value == (2'b00));
  assign _zz_366_ = (MmuPlugin_ports_0_entryToReplace_value == (2'b01));
  assign _zz_367_ = (MmuPlugin_ports_0_entryToReplace_value == (2'b10));
  assign _zz_368_ = (MmuPlugin_ports_0_entryToReplace_value == (2'b11));
  assign _zz_369_ = (MmuPlugin_ports_1_entryToReplace_value == (2'b00));
  assign _zz_370_ = (MmuPlugin_ports_1_entryToReplace_value == (2'b01));
  assign _zz_371_ = (MmuPlugin_ports_1_entryToReplace_value == (2'b10));
  assign _zz_372_ = (MmuPlugin_ports_1_entryToReplace_value == (2'b11));
  assign _zz_373_ = {_zz_125_[1 : 0],_zz_125_[15 : 13]};
  assign _zz_374_ = _zz_125_[6 : 5];
  assign _zz_375_ = _zz_125_[11 : 10];
  assign _zz_376_ = writeBack_INSTRUCTION[13 : 12];
  assign _zz_377_ = writeBack_INSTRUCTION[13 : 12];
  assign _zz_378_ = execute_INSTRUCTION[13];
  assign _zz_379_ = (_zz_106_ - (5'b00001));
  assign _zz_380_ = {IBusCachedPlugin_fetchPc_inc,(2'b00)};
  assign _zz_381_ = {29'd0, _zz_380_};
  assign _zz_382_ = (decode_IS_RVC ? (3'b010) : (3'b100));
  assign _zz_383_ = {29'd0, _zz_382_};
  assign _zz_384_ = {{_zz_135_,_zz_125_[6 : 2]},(12'b000000000000)};
  assign _zz_385_ = {{{(4'b0000),_zz_125_[8 : 7]},_zz_125_[12 : 9]},(2'b00)};
  assign _zz_386_ = {{{(4'b0000),_zz_125_[8 : 7]},_zz_125_[12 : 9]},(2'b00)};
  assign _zz_387_ = (decode_IS_RVC ? (3'b010) : (3'b100));
  assign _zz_388_ = {29'd0, _zz_387_};
  assign _zz_389_ = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_390_ = {{_zz_158_,{{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz_391_ = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]};
  assign _zz_392_ = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_393_ = (writeBack_MEMORY_WR ? (3'b111) : (3'b101));
  assign _zz_394_ = (writeBack_MEMORY_WR ? (3'b110) : (3'b100));
  assign _zz_395_ = _zz_184_[2 : 2];
  assign _zz_396_ = _zz_184_[3 : 3];
  assign _zz_397_ = _zz_184_[6 : 6];
  assign _zz_398_ = _zz_184_[7 : 7];
  assign _zz_399_ = _zz_184_[8 : 8];
  assign _zz_400_ = _zz_184_[9 : 9];
  assign _zz_401_ = _zz_184_[10 : 10];
  assign _zz_402_ = _zz_184_[11 : 11];
  assign _zz_403_ = _zz_184_[12 : 12];
  assign _zz_404_ = _zz_184_[13 : 13];
  assign _zz_405_ = _zz_184_[14 : 14];
  assign _zz_406_ = _zz_184_[18 : 18];
  assign _zz_407_ = _zz_184_[19 : 19];
  assign _zz_408_ = _zz_184_[22 : 22];
  assign _zz_409_ = _zz_184_[27 : 27];
  assign _zz_410_ = _zz_184_[28 : 28];
  assign _zz_411_ = _zz_184_[32 : 32];
  assign _zz_412_ = _zz_184_[33 : 33];
  assign _zz_413_ = _zz_184_[34 : 34];
  assign _zz_414_ = _zz_184_[35 : 35];
  assign _zz_415_ = execute_SRC_LESS;
  assign _zz_416_ = (execute_IS_RVC ? (3'b010) : (3'b100));
  assign _zz_417_ = execute_INSTRUCTION[19 : 15];
  assign _zz_418_ = execute_INSTRUCTION[31 : 20];
  assign _zz_419_ = {execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]};
  assign _zz_420_ = ($signed(_zz_421_) + $signed(_zz_424_));
  assign _zz_421_ = ($signed(_zz_422_) + $signed(_zz_423_));
  assign _zz_422_ = execute_SRC1;
  assign _zz_423_ = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_424_ = (execute_SRC_USE_SUB_LESS ? _zz_425_ : _zz_426_);
  assign _zz_425_ = (32'b00000000000000000000000000000001);
  assign _zz_426_ = (32'b00000000000000000000000000000000);
  assign _zz_427_ = ($signed(_zz_429_) >>> execute_FullBarrelShifterPlugin_amplitude);
  assign _zz_428_ = _zz_427_[31 : 0];
  assign _zz_429_ = {((execute_SHIFT_CTRL == `ShiftCtrlEnum_defaultEncoding_SRA_1) && execute_FullBarrelShifterPlugin_reversed[31]),execute_FullBarrelShifterPlugin_reversed};
  assign _zz_430_ = ($signed(_zz_431_) + $signed(_zz_436_));
  assign _zz_431_ = ($signed(_zz_432_) + $signed(_zz_434_));
  assign _zz_432_ = (52'b0000000000000000000000000000000000000000000000000000);
  assign _zz_433_ = {1'b0,memory_MUL_LL};
  assign _zz_434_ = {{19{_zz_433_[32]}}, _zz_433_};
  assign _zz_435_ = ({16'd0,memory_MUL_LH} <<< 16);
  assign _zz_436_ = {{2{_zz_435_[49]}}, _zz_435_};
  assign _zz_437_ = ({16'd0,memory_MUL_HL} <<< 16);
  assign _zz_438_ = {{2{_zz_437_[49]}}, _zz_437_};
  assign _zz_439_ = {{14{writeBack_MUL_LOW[51]}}, writeBack_MUL_LOW};
  assign _zz_440_ = ({32'd0,writeBack_MUL_HH} <<< 32);
  assign _zz_441_ = writeBack_MUL_LOW[31 : 0];
  assign _zz_442_ = writeBack_MulPlugin_result[63 : 32];
  assign _zz_443_ = memory_DivPlugin_div_counter_willIncrement;
  assign _zz_444_ = {5'd0, _zz_443_};
  assign _zz_445_ = {1'd0, memory_DivPlugin_rs2};
  assign _zz_446_ = {_zz_220_,(! _zz_222_[32])};
  assign _zz_447_ = _zz_222_[31:0];
  assign _zz_448_ = _zz_221_[31:0];
  assign _zz_449_ = _zz_450_;
  assign _zz_450_ = _zz_451_;
  assign _zz_451_ = ({1'b0,(memory_DivPlugin_div_needRevert ? (~ _zz_223_) : _zz_223_)} + _zz_453_);
  assign _zz_452_ = memory_DivPlugin_div_needRevert;
  assign _zz_453_ = {32'd0, _zz_452_};
  assign _zz_454_ = _zz_225_;
  assign _zz_455_ = {32'd0, _zz_454_};
  assign _zz_456_ = _zz_224_;
  assign _zz_457_ = {31'd0, _zz_456_};
  assign _zz_458_ = (_zz_234_ & (~ _zz_459_));
  assign _zz_459_ = (_zz_234_ - (2'b01));
  assign _zz_460_ = execute_INSTRUCTION[31 : 20];
  assign _zz_461_ = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz_462_ = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_463_ = (execute_IS_RVC ? (3'b010) : (3'b100));
  assign _zz_464_ = MmuPlugin_ports_0_entryToReplace_willIncrement;
  assign _zz_465_ = {1'd0, _zz_464_};
  assign _zz_466_ = MmuPlugin_ports_1_entryToReplace_willIncrement;
  assign _zz_467_ = {1'd0, _zz_466_};
  assign _zz_468_ = MmuPlugin_dBusAccess_rsp_payload_data[0 : 0];
  assign _zz_469_ = MmuPlugin_dBusAccess_rsp_payload_data[1 : 1];
  assign _zz_470_ = MmuPlugin_dBusAccess_rsp_payload_data[2 : 2];
  assign _zz_471_ = MmuPlugin_dBusAccess_rsp_payload_data[3 : 3];
  assign _zz_472_ = MmuPlugin_dBusAccess_rsp_payload_data[4 : 4];
  assign _zz_473_ = MmuPlugin_dBusAccess_rsp_payload_data[5 : 5];
  assign _zz_474_ = MmuPlugin_dBusAccess_rsp_payload_data[6 : 6];
  assign _zz_475_ = MmuPlugin_dBusAccess_rsp_payload_data[7 : 7];
  assign _zz_476_ = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_477_ = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_478_ = execute_CsrPlugin_writeData[5 : 5];
  assign _zz_479_ = execute_CsrPlugin_writeData[1 : 1];
  assign _zz_480_ = execute_CsrPlugin_writeData[19 : 19];
  assign _zz_481_ = execute_CsrPlugin_writeData[18 : 18];
  assign _zz_482_ = execute_CsrPlugin_writeData[17 : 17];
  assign _zz_483_ = execute_CsrPlugin_writeData[9 : 9];
  assign _zz_484_ = execute_CsrPlugin_writeData[5 : 5];
  assign _zz_485_ = execute_CsrPlugin_writeData[1 : 1];
  assign _zz_486_ = execute_CsrPlugin_writeData[31 : 31];
  assign _zz_487_ = execute_CsrPlugin_writeData[5 : 5];
  assign _zz_488_ = execute_CsrPlugin_writeData[1 : 1];
  assign _zz_489_ = execute_CsrPlugin_writeData[19 : 19];
  assign _zz_490_ = execute_CsrPlugin_writeData[18 : 18];
  assign _zz_491_ = execute_CsrPlugin_writeData[17 : 17];
  assign _zz_492_ = execute_CsrPlugin_writeData[8 : 8];
  assign _zz_493_ = execute_CsrPlugin_writeData[2 : 2];
  assign _zz_494_ = execute_CsrPlugin_writeData[5 : 5];
  assign _zz_495_ = execute_CsrPlugin_writeData[13 : 13];
  assign _zz_496_ = execute_CsrPlugin_writeData[4 : 4];
  assign _zz_497_ = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_498_ = execute_CsrPlugin_writeData[1 : 1];
  assign _zz_499_ = execute_CsrPlugin_writeData[9 : 9];
  assign _zz_500_ = execute_CsrPlugin_writeData[12 : 12];
  assign _zz_501_ = execute_CsrPlugin_writeData[15 : 15];
  assign _zz_502_ = execute_CsrPlugin_writeData[6 : 6];
  assign _zz_503_ = execute_CsrPlugin_writeData[0 : 0];
  assign _zz_504_ = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_505_ = execute_CsrPlugin_writeData[5 : 5];
  assign _zz_506_ = execute_CsrPlugin_writeData[1 : 1];
  assign _zz_507_ = execute_CsrPlugin_writeData[9 : 9];
  assign _zz_508_ = execute_CsrPlugin_writeData[31 : 31];
  assign _zz_509_ = execute_CsrPlugin_writeData[5 : 5];
  assign _zz_510_ = execute_CsrPlugin_writeData[1 : 1];
  assign _zz_511_ = execute_CsrPlugin_writeData[9 : 9];
  assign _zz_512_ = execute_CsrPlugin_writeData[11 : 11];
  assign _zz_513_ = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_514_ = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_515_ = execute_CsrPlugin_writeData[9 : 9];
  assign _zz_516_ = execute_CsrPlugin_writeData[5 : 5];
  assign _zz_517_ = execute_CsrPlugin_writeData[1 : 1];
  assign _zz_518_ = execute_CsrPlugin_writeData[9 : 9];
  assign _zz_519_ = execute_CsrPlugin_writeData[5 : 5];
  assign _zz_520_ = execute_CsrPlugin_writeData[1 : 1];
  assign _zz_521_ = (iBus_cmd_payload_address >>> 5);
  assign _zz_522_ = {_zz_109_,{_zz_111_,_zz_110_}};
  assign _zz_523_ = (_zz_125_[11 : 10] == (2'b01));
  assign _zz_524_ = ((_zz_125_[11 : 10] == (2'b11)) && (_zz_125_[6 : 5] == (2'b00)));
  assign _zz_525_ = (7'b0000000);
  assign _zz_526_ = _zz_125_[6 : 2];
  assign _zz_527_ = _zz_125_[12];
  assign _zz_528_ = _zz_125_[11 : 7];
  assign _zz_529_ = decode_INSTRUCTION[31];
  assign _zz_530_ = decode_INSTRUCTION[19 : 12];
  assign _zz_531_ = decode_INSTRUCTION[20];
  assign _zz_532_ = decode_INSTRUCTION[31];
  assign _zz_533_ = decode_INSTRUCTION[7];
  assign _zz_534_ = (decode_INSTRUCTION & (32'b00000000000000000001000001010000));
  assign _zz_535_ = (32'b00000000000000000001000001010000);
  assign _zz_536_ = (decode_INSTRUCTION & (32'b00000000000000000010000001010000));
  assign _zz_537_ = (32'b00000000000000000010000001010000);
  assign _zz_538_ = (decode_INSTRUCTION & (32'b00000010000000000100000001100100));
  assign _zz_539_ = (32'b00000010000000000100000000100000);
  assign _zz_540_ = ((decode_INSTRUCTION & (32'b00000000000000000100000001001000)) == (32'b00000000000000000100000000001000));
  assign _zz_541_ = (1'b0);
  assign _zz_542_ = ({(_zz_545_ == _zz_546_),{_zz_547_,{_zz_548_,_zz_549_}}} != (6'b000000));
  assign _zz_543_ = ({_zz_190_,_zz_550_} != (2'b00));
  assign _zz_544_ = {(_zz_551_ != (1'b0)),{(_zz_552_ != _zz_553_),{_zz_554_,{_zz_555_,_zz_556_}}}};
  assign _zz_545_ = (decode_INSTRUCTION & (32'b00000000000000000010000001000000));
  assign _zz_546_ = (32'b00000000000000000010000001000000);
  assign _zz_547_ = ((decode_INSTRUCTION & _zz_557_) == (32'b00000000000000000001000001000000));
  assign _zz_548_ = (_zz_558_ == _zz_559_);
  assign _zz_549_ = {_zz_560_,{_zz_561_,_zz_562_}};
  assign _zz_550_ = ((decode_INSTRUCTION & _zz_563_) == (32'b00000000000000000000000000000100));
  assign _zz_551_ = ((decode_INSTRUCTION & _zz_564_) == (32'b00000000000000000000000001000000));
  assign _zz_552_ = (_zz_565_ == _zz_566_);
  assign _zz_553_ = (1'b0);
  assign _zz_554_ = ({_zz_567_,_zz_568_} != (7'b0000000));
  assign _zz_555_ = (_zz_569_ != _zz_570_);
  assign _zz_556_ = {_zz_571_,{_zz_572_,_zz_573_}};
  assign _zz_557_ = (32'b00000000000000000001000001000000);
  assign _zz_558_ = (decode_INSTRUCTION & (32'b00000000000000000000000001010000));
  assign _zz_559_ = (32'b00000000000000000000000001000000);
  assign _zz_560_ = ((decode_INSTRUCTION & _zz_574_) == (32'b00000000000000000000000001000000));
  assign _zz_561_ = (_zz_575_ == _zz_576_);
  assign _zz_562_ = (_zz_577_ == _zz_578_);
  assign _zz_563_ = (32'b00000000000000000000000000011100);
  assign _zz_564_ = (32'b00000000000000000000000001011000);
  assign _zz_565_ = (decode_INSTRUCTION & (32'b00000010000000000100000001110100));
  assign _zz_566_ = (32'b00000010000000000000000000110000);
  assign _zz_567_ = _zz_190_;
  assign _zz_568_ = {_zz_579_,{_zz_580_,_zz_581_}};
  assign _zz_569_ = {_zz_190_,{_zz_582_,_zz_583_}};
  assign _zz_570_ = (3'b000);
  assign _zz_571_ = ({_zz_584_,_zz_585_} != (2'b00));
  assign _zz_572_ = (_zz_586_ != _zz_587_);
  assign _zz_573_ = {_zz_588_,{_zz_589_,_zz_590_}};
  assign _zz_574_ = (32'b00000010010000000000000001000000);
  assign _zz_575_ = (decode_INSTRUCTION & (32'b00000000000000000000000000111000));
  assign _zz_576_ = (32'b00000000000000000000000000000000);
  assign _zz_577_ = (decode_INSTRUCTION & (32'b00011000000000000010000000001000));
  assign _zz_578_ = (32'b00010000000000000010000000001000);
  assign _zz_579_ = ((decode_INSTRUCTION & _zz_591_) == (32'b00000000000000000001000000010000));
  assign _zz_580_ = (_zz_592_ == _zz_593_);
  assign _zz_581_ = {_zz_594_,{_zz_595_,_zz_596_}};
  assign _zz_582_ = _zz_189_;
  assign _zz_583_ = (_zz_597_ == _zz_598_);
  assign _zz_584_ = _zz_189_;
  assign _zz_585_ = (_zz_599_ == _zz_600_);
  assign _zz_586_ = {_zz_188_,_zz_601_};
  assign _zz_587_ = (2'b00);
  assign _zz_588_ = ({_zz_602_,_zz_603_} != (2'b00));
  assign _zz_589_ = (_zz_604_ != _zz_605_);
  assign _zz_590_ = {_zz_606_,{_zz_607_,_zz_608_}};
  assign _zz_591_ = (32'b00000000000000000001000000010000);
  assign _zz_592_ = (decode_INSTRUCTION & (32'b00000000000000000010000000010000));
  assign _zz_593_ = (32'b00000000000000000010000000010000);
  assign _zz_594_ = ((decode_INSTRUCTION & _zz_609_) == (32'b00000000000000000010000000001000));
  assign _zz_595_ = (_zz_610_ == _zz_611_);
  assign _zz_596_ = {_zz_185_,_zz_612_};
  assign _zz_597_ = (decode_INSTRUCTION & (32'b00000000000000000010000000010100));
  assign _zz_598_ = (32'b00000000000000000000000000000100);
  assign _zz_599_ = (decode_INSTRUCTION & (32'b00000000000000000000000001001100));
  assign _zz_600_ = (32'b00000000000000000000000000000100);
  assign _zz_601_ = ((decode_INSTRUCTION & _zz_613_) == (32'b00000000000000000000000000100000));
  assign _zz_602_ = _zz_188_;
  assign _zz_603_ = (_zz_614_ == _zz_615_);
  assign _zz_604_ = {_zz_616_,{_zz_617_,_zz_618_}};
  assign _zz_605_ = (3'b000);
  assign _zz_606_ = ({_zz_619_,_zz_620_} != (2'b00));
  assign _zz_607_ = (_zz_621_ != _zz_622_);
  assign _zz_608_ = {_zz_623_,{_zz_624_,_zz_625_}};
  assign _zz_609_ = (32'b00000000000000000010000000001000);
  assign _zz_610_ = (decode_INSTRUCTION & (32'b00000000000000000000000001010000));
  assign _zz_611_ = (32'b00000000000000000000000000010000);
  assign _zz_612_ = ((decode_INSTRUCTION & _zz_626_) == (32'b00000000000000000000000000000000));
  assign _zz_613_ = (32'b00000000000000000000000001110000);
  assign _zz_614_ = (decode_INSTRUCTION & (32'b00000000000000000000000000100000));
  assign _zz_615_ = (32'b00000000000000000000000000000000);
  assign _zz_616_ = ((decode_INSTRUCTION & _zz_627_) == (32'b00000000000000000000000001000000));
  assign _zz_617_ = (_zz_628_ == _zz_629_);
  assign _zz_618_ = (_zz_630_ == _zz_631_);
  assign _zz_619_ = (_zz_632_ == _zz_633_);
  assign _zz_620_ = (_zz_634_ == _zz_635_);
  assign _zz_621_ = {_zz_636_,{_zz_637_,_zz_638_}};
  assign _zz_622_ = (3'b000);
  assign _zz_623_ = (_zz_639_ != (1'b0));
  assign _zz_624_ = (_zz_640_ != _zz_641_);
  assign _zz_625_ = {_zz_642_,{_zz_643_,_zz_644_}};
  assign _zz_626_ = (32'b00000000000000000000000000101000);
  assign _zz_627_ = (32'b00000000000000000000000001000100);
  assign _zz_628_ = (decode_INSTRUCTION & (32'b00000000000000000010000000010100));
  assign _zz_629_ = (32'b00000000000000000010000000010000);
  assign _zz_630_ = (decode_INSTRUCTION & (32'b01000000000000000000000000110100));
  assign _zz_631_ = (32'b01000000000000000000000000110000);
  assign _zz_632_ = (decode_INSTRUCTION & (32'b00000000000000000111000000110100));
  assign _zz_633_ = (32'b00000000000000000101000000010000);
  assign _zz_634_ = (decode_INSTRUCTION & (32'b00000010000000000111000001100100));
  assign _zz_635_ = (32'b00000000000000000101000000100000);
  assign _zz_636_ = ((decode_INSTRUCTION & (32'b01000000000000000011000001010100)) == (32'b01000000000000000001000000010000));
  assign _zz_637_ = ((decode_INSTRUCTION & _zz_645_) == (32'b00000000000000000001000000010000));
  assign _zz_638_ = ((decode_INSTRUCTION & _zz_646_) == (32'b00000000000000000001000000010000));
  assign _zz_639_ = ((decode_INSTRUCTION & (32'b00010000000000000000000000001000)) == (32'b00000000000000000000000000001000));
  assign _zz_640_ = {(_zz_647_ == _zz_648_),(_zz_649_ == _zz_650_)};
  assign _zz_641_ = (2'b00);
  assign _zz_642_ = ((_zz_651_ == _zz_652_) != (1'b0));
  assign _zz_643_ = ({_zz_653_,_zz_654_} != (2'b00));
  assign _zz_644_ = {(_zz_655_ != _zz_656_),{_zz_657_,{_zz_658_,_zz_659_}}};
  assign _zz_645_ = (32'b00000000000000000111000000110100);
  assign _zz_646_ = (32'b00000010000000000111000001010100);
  assign _zz_647_ = (decode_INSTRUCTION & (32'b00000000000000000010000000010000));
  assign _zz_648_ = (32'b00000000000000000010000000000000);
  assign _zz_649_ = (decode_INSTRUCTION & (32'b00000000000000000101000000000000));
  assign _zz_650_ = (32'b00000000000000000001000000000000);
  assign _zz_651_ = (decode_INSTRUCTION & (32'b00010000000100000011000001010000));
  assign _zz_652_ = (32'b00000000000100000000000001010000);
  assign _zz_653_ = ((decode_INSTRUCTION & _zz_660_) == (32'b00000000000000000000000001010000));
  assign _zz_654_ = ((decode_INSTRUCTION & _zz_661_) == (32'b00010000000000000000000001010000));
  assign _zz_655_ = ((decode_INSTRUCTION & _zz_662_) == (32'b00000000000000000000000001010000));
  assign _zz_656_ = (1'b0);
  assign _zz_657_ = (_zz_187_ != (1'b0));
  assign _zz_658_ = ({_zz_663_,_zz_664_} != (2'b00));
  assign _zz_659_ = {(_zz_665_ != _zz_666_),{_zz_667_,{_zz_668_,_zz_669_}}};
  assign _zz_660_ = (32'b00010000000100000011000001010000);
  assign _zz_661_ = (32'b00010010001000000011000001010000);
  assign _zz_662_ = (32'b00000010000100000011000001010000);
  assign _zz_663_ = _zz_186_;
  assign _zz_664_ = ((decode_INSTRUCTION & _zz_670_) == (32'b00000000000000000000000000000000));
  assign _zz_665_ = {(_zz_671_ == _zz_672_),{_zz_673_,{_zz_674_,_zz_675_}}};
  assign _zz_666_ = (5'b00000);
  assign _zz_667_ = ((_zz_676_ == _zz_677_) != (1'b0));
  assign _zz_668_ = (_zz_678_ != (1'b0));
  assign _zz_669_ = {(_zz_679_ != _zz_680_),{_zz_681_,{_zz_682_,_zz_683_}}};
  assign _zz_670_ = (32'b00000000000000000000000001011000);
  assign _zz_671_ = (decode_INSTRUCTION & (32'b00000000000000000000000001000000));
  assign _zz_672_ = (32'b00000000000000000000000001000000);
  assign _zz_673_ = ((decode_INSTRUCTION & (32'b00000000000000000100000000100000)) == (32'b00000000000000000100000000100000));
  assign _zz_674_ = ((decode_INSTRUCTION & _zz_684_) == (32'b00000000000000000000000000010000));
  assign _zz_675_ = {_zz_185_,(_zz_685_ == _zz_686_)};
  assign _zz_676_ = (decode_INSTRUCTION & (32'b00000000000000000000000001100100));
  assign _zz_677_ = (32'b00000000000000000000000000100100);
  assign _zz_678_ = ((decode_INSTRUCTION & (32'b00000010000000000011000001010000)) == (32'b00000010000000000000000001010000));
  assign _zz_679_ = {(_zz_687_ == _zz_688_),{_zz_689_,_zz_690_}};
  assign _zz_680_ = (3'b000);
  assign _zz_681_ = ({_zz_691_,{_zz_692_,_zz_693_}} != (4'b0000));
  assign _zz_682_ = ({_zz_694_,_zz_695_} != (5'b00000));
  assign _zz_683_ = {(_zz_696_ != _zz_697_),{_zz_698_,{_zz_699_,_zz_700_}}};
  assign _zz_684_ = (32'b00000000000000000000000000110000);
  assign _zz_685_ = (decode_INSTRUCTION & (32'b00000010000000000000000000101000));
  assign _zz_686_ = (32'b00000000000000000000000000100000);
  assign _zz_687_ = (decode_INSTRUCTION & (32'b00001000000000000000000000100000));
  assign _zz_688_ = (32'b00001000000000000000000000100000);
  assign _zz_689_ = ((decode_INSTRUCTION & _zz_701_) == (32'b00000000000000000000000000100000));
  assign _zz_690_ = ((decode_INSTRUCTION & _zz_702_) == (32'b00000000000000000000000000100000));
  assign _zz_691_ = ((decode_INSTRUCTION & _zz_703_) == (32'b00000000000000000000000000100000));
  assign _zz_692_ = (_zz_704_ == _zz_705_);
  assign _zz_693_ = {_zz_706_,_zz_707_};
  assign _zz_694_ = (_zz_708_ == _zz_709_);
  assign _zz_695_ = {_zz_710_,{_zz_711_,_zz_712_}};
  assign _zz_696_ = (_zz_713_ == _zz_714_);
  assign _zz_697_ = (1'b0);
  assign _zz_698_ = (_zz_715_ != (1'b0));
  assign _zz_699_ = (_zz_716_ != _zz_717_);
  assign _zz_700_ = {_zz_718_,{_zz_719_,_zz_720_}};
  assign _zz_701_ = (32'b00010000000000000000000000100000);
  assign _zz_702_ = (32'b00000000000000000000000000101000);
  assign _zz_703_ = (32'b00000000000000000000000000110100);
  assign _zz_704_ = (decode_INSTRUCTION & (32'b00000000000000000000000001100100));
  assign _zz_705_ = (32'b00000000000000000000000000100000);
  assign _zz_706_ = ((decode_INSTRUCTION & _zz_721_) == (32'b00001000000000000000000000100000));
  assign _zz_707_ = ((decode_INSTRUCTION & _zz_722_) == (32'b00000000000000000000000000100000));
  assign _zz_708_ = (decode_INSTRUCTION & (32'b00000000000000000000000001000100));
  assign _zz_709_ = (32'b00000000000000000000000000000000);
  assign _zz_710_ = ((decode_INSTRUCTION & _zz_723_) == (32'b00000000000000000000000000000000));
  assign _zz_711_ = (_zz_724_ == _zz_725_);
  assign _zz_712_ = {_zz_726_,_zz_186_};
  assign _zz_713_ = (decode_INSTRUCTION & (32'b00010000000000000000000000001000));
  assign _zz_714_ = (32'b00010000000000000000000000001000);
  assign _zz_715_ = ((decode_INSTRUCTION & _zz_727_) == (32'b00000000000000000100000000010000));
  assign _zz_716_ = (_zz_728_ == _zz_729_);
  assign _zz_717_ = (1'b0);
  assign _zz_718_ = ({_zz_730_,_zz_731_} != (5'b00000));
  assign _zz_719_ = (_zz_732_ != _zz_733_);
  assign _zz_720_ = {_zz_734_,_zz_735_};
  assign _zz_721_ = (32'b00001000000000000000000001110000);
  assign _zz_722_ = (32'b00010000000000000000000001110000);
  assign _zz_723_ = (32'b00000000000000000000000000011000);
  assign _zz_724_ = (decode_INSTRUCTION & (32'b00000000000000000110000000000100));
  assign _zz_725_ = (32'b00000000000000000010000000000000);
  assign _zz_726_ = ((decode_INSTRUCTION & (32'b00000000000000000101000000000100)) == (32'b00000000000000000001000000000000));
  assign _zz_727_ = (32'b00000000000000000100000000010100);
  assign _zz_728_ = (decode_INSTRUCTION & (32'b00000000000000000110000000010100));
  assign _zz_729_ = (32'b00000000000000000010000000010000);
  assign _zz_730_ = _zz_185_;
  assign _zz_731_ = {((decode_INSTRUCTION & _zz_736_) == (32'b00000000000000000010000000010000)),{(_zz_737_ == _zz_738_),{_zz_739_,_zz_740_}}};
  assign _zz_732_ = ((decode_INSTRUCTION & (32'b00000000000000000101000001001000)) == (32'b00000000000000000001000000001000));
  assign _zz_733_ = (1'b0);
  assign _zz_734_ = (((decode_INSTRUCTION & _zz_741_) == (32'b00000000000000000001000000000000)) != (1'b0));
  assign _zz_735_ = (((decode_INSTRUCTION & _zz_742_) == (32'b00000000000000000010000000000000)) != (1'b0));
  assign _zz_736_ = (32'b00000000000000000010000000110000);
  assign _zz_737_ = (decode_INSTRUCTION & (32'b00000000000000000001000000110000));
  assign _zz_738_ = (32'b00000000000000000000000000010000);
  assign _zz_739_ = ((decode_INSTRUCTION & (32'b00000010000000000011000000100000)) == (32'b00000000000000000000000000100000));
  assign _zz_740_ = ((decode_INSTRUCTION & (32'b00000010000000000010000001101000)) == (32'b00000000000000000010000000100000));
  assign _zz_741_ = (32'b00000000000000000001000000000000);
  assign _zz_742_ = (32'b00000000000000000011000000000000);
  assign _zz_743_ = (32'b00000000000000000001000001111111);
  assign _zz_744_ = (decode_INSTRUCTION & (32'b00000000000000000010000001111111));
  assign _zz_745_ = (32'b00000000000000000010000001110011);
  assign _zz_746_ = ((decode_INSTRUCTION & (32'b00000000000000000100000001111111)) == (32'b00000000000000000100000001100011));
  assign _zz_747_ = ((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000010000000010011));
  assign _zz_748_ = {((decode_INSTRUCTION & (32'b00000000000000000110000000111111)) == (32'b00000000000000000000000000100011)),{((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & _zz_749_) == (32'b00000000000000000000000000000011)),{(_zz_750_ == _zz_751_),{_zz_752_,{_zz_753_,_zz_754_}}}}}};
  assign _zz_749_ = (32'b00000000000000000101000001011111);
  assign _zz_750_ = (decode_INSTRUCTION & (32'b00000000000000000111000001111011));
  assign _zz_751_ = (32'b00000000000000000000000001100011);
  assign _zz_752_ = ((decode_INSTRUCTION & (32'b00000000000000000110000001111111)) == (32'b00000000000000000000000000001111));
  assign _zz_753_ = ((decode_INSTRUCTION & (32'b00011000000000000111000001111111)) == (32'b00000000000000000010000000101111));
  assign _zz_754_ = {((decode_INSTRUCTION & (32'b11111100000000000000000001111111)) == (32'b00000000000000000000000000110011)),{((decode_INSTRUCTION & (32'b11101000000000000111000001111111)) == (32'b00001000000000000010000000101111)),{((decode_INSTRUCTION & _zz_755_) == (32'b00000000000000000101000000001111)),{(_zz_756_ == _zz_757_),{_zz_758_,{_zz_759_,_zz_760_}}}}}};
  assign _zz_755_ = (32'b00000001111100000111000001111111);
  assign _zz_756_ = (decode_INSTRUCTION & (32'b10111100000000000111000001111111));
  assign _zz_757_ = (32'b00000000000000000101000000010011);
  assign _zz_758_ = ((decode_INSTRUCTION & (32'b11111100000000000011000001111111)) == (32'b00000000000000000001000000010011));
  assign _zz_759_ = ((decode_INSTRUCTION & (32'b10111110000000000111000001111111)) == (32'b00000000000000000101000000110011));
  assign _zz_760_ = {((decode_INSTRUCTION & (32'b10111110000000000111000001111111)) == (32'b00000000000000000000000000110011)),{((decode_INSTRUCTION & (32'b11111001111100000111000001111111)) == (32'b00010000000000000010000000101111)),{((decode_INSTRUCTION & _zz_761_) == (32'b00010010000000000000000001110011)),{(_zz_762_ == _zz_763_),{_zz_764_,_zz_765_}}}}};
  assign _zz_761_ = (32'b11111110000000000111111111111111);
  assign _zz_762_ = (decode_INSTRUCTION & (32'b11011111111111111111111111111111));
  assign _zz_763_ = (32'b00010000001000000000000001110011);
  assign _zz_764_ = ((decode_INSTRUCTION & (32'b11111111111011111111111111111111)) == (32'b00000000000000000000000001110011));
  assign _zz_765_ = ((decode_INSTRUCTION & (32'b11111111111111111111111111111111)) == (32'b00010000010100000000000001110011));
  assign _zz_766_ = execute_INSTRUCTION[31];
  assign _zz_767_ = execute_INSTRUCTION[31];
  assign _zz_768_ = execute_INSTRUCTION[7];
  always @ (posedge clk) begin
    if(_zz_62_) begin
      RegFilePlugin_regFile[lastStageRegFileWrite_payload_address] <= lastStageRegFileWrite_payload_data;
    end
  end

  assign _zz_290_ = RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
  assign _zz_291_ = RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
  InstructionCache IBusCachedPlugin_cache ( 
    .io_flush(_zz_264_),
    .io_cpu_prefetch_isValid(_zz_265_),
    .io_cpu_prefetch_haltIt(IBusCachedPlugin_cache_io_cpu_prefetch_haltIt),
    .io_cpu_prefetch_pc(IBusCachedPlugin_iBusRsp_stages_1_input_payload),
    .io_cpu_fetch_isValid(_zz_266_),
    .io_cpu_fetch_isStuck(_zz_267_),
    .io_cpu_fetch_isRemoved(IBusCachedPlugin_fetcherflushIt),
    .io_cpu_fetch_pc(IBusCachedPlugin_iBusRsp_stages_2_input_payload),
    .io_cpu_fetch_data(IBusCachedPlugin_cache_io_cpu_fetch_data),
    .io_cpu_fetch_dataBypassValid(IBusCachedPlugin_s1_tightlyCoupledHit),
    .io_cpu_fetch_dataBypass(_zz_268_),
    .io_cpu_fetch_mmuBus_cmd_isValid(IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_isValid),
    .io_cpu_fetch_mmuBus_cmd_virtualAddress(IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_virtualAddress),
    .io_cpu_fetch_mmuBus_cmd_bypassTranslation(IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_bypassTranslation),
    .io_cpu_fetch_mmuBus_rsp_physicalAddress(IBusCachedPlugin_mmuBus_rsp_physicalAddress),
    .io_cpu_fetch_mmuBus_rsp_isIoAccess(IBusCachedPlugin_mmuBus_rsp_isIoAccess),
    .io_cpu_fetch_mmuBus_rsp_allowRead(IBusCachedPlugin_mmuBus_rsp_allowRead),
    .io_cpu_fetch_mmuBus_rsp_allowWrite(IBusCachedPlugin_mmuBus_rsp_allowWrite),
    .io_cpu_fetch_mmuBus_rsp_allowExecute(IBusCachedPlugin_mmuBus_rsp_allowExecute),
    .io_cpu_fetch_mmuBus_rsp_exception(IBusCachedPlugin_mmuBus_rsp_exception),
    .io_cpu_fetch_mmuBus_rsp_refilling(IBusCachedPlugin_mmuBus_rsp_refilling),
    .io_cpu_fetch_mmuBus_end(IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_end),
    .io_cpu_fetch_mmuBus_busy(IBusCachedPlugin_mmuBus_busy),
    .io_cpu_fetch_physicalAddress(IBusCachedPlugin_cache_io_cpu_fetch_physicalAddress),
    .io_cpu_fetch_haltIt(IBusCachedPlugin_cache_io_cpu_fetch_haltIt),
    .io_cpu_decode_isValid(_zz_269_),
    .io_cpu_decode_isStuck(_zz_270_),
    .io_cpu_decode_pc(IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_payload),
    .io_cpu_decode_physicalAddress(IBusCachedPlugin_cache_io_cpu_decode_physicalAddress),
    .io_cpu_decode_data(IBusCachedPlugin_cache_io_cpu_decode_data),
    .io_cpu_decode_cacheMiss(IBusCachedPlugin_cache_io_cpu_decode_cacheMiss),
    .io_cpu_decode_error(IBusCachedPlugin_cache_io_cpu_decode_error),
    .io_cpu_decode_mmuRefilling(IBusCachedPlugin_cache_io_cpu_decode_mmuRefilling),
    .io_cpu_decode_mmuException(IBusCachedPlugin_cache_io_cpu_decode_mmuException),
    .io_cpu_decode_isUser(_zz_271_),
    .io_cpu_fill_valid(_zz_272_),
    .io_cpu_fill_payload(IBusCachedPlugin_cache_io_cpu_decode_physicalAddress),
    .io_mem_cmd_valid(IBusCachedPlugin_cache_io_mem_cmd_valid),
    .io_mem_cmd_ready(iBus_cmd_ready),
    .io_mem_cmd_payload_address(IBusCachedPlugin_cache_io_mem_cmd_payload_address),
    .io_mem_cmd_payload_size(IBusCachedPlugin_cache_io_mem_cmd_payload_size),
    .io_mem_rsp_valid(iBus_rsp_valid),
    .io_mem_rsp_payload_data(iBus_rsp_payload_data),
    .io_mem_rsp_payload_error(iBus_rsp_payload_error),
    .clk(clk),
    .reset(reset) 
  );
  DataCache dataCache_1_ ( 
    .io_cpu_execute_isValid(_zz_273_),
    .io_cpu_execute_address(_zz_274_),
    .io_cpu_execute_args_wr(_zz_275_),
    .io_cpu_execute_args_data(_zz_276_),
    .io_cpu_execute_args_size(_zz_277_),
    .io_cpu_execute_args_isLrsc(_zz_278_),
    .io_cpu_execute_args_isAmo(_zz_279_),
    .io_cpu_execute_args_amoCtrl_swap(_zz_280_),
    .io_cpu_execute_args_amoCtrl_alu(_zz_281_),
    .io_cpu_memory_isValid(_zz_282_),
    .io_cpu_memory_isStuck(memory_arbitration_isStuck),
    .io_cpu_memory_isRemoved(memory_arbitration_removeIt),
    .io_cpu_memory_isWrite(dataCache_1__io_cpu_memory_isWrite),
    .io_cpu_memory_address(_zz_283_),
    .io_cpu_memory_mmuBus_cmd_isValid(dataCache_1__io_cpu_memory_mmuBus_cmd_isValid),
    .io_cpu_memory_mmuBus_cmd_virtualAddress(dataCache_1__io_cpu_memory_mmuBus_cmd_virtualAddress),
    .io_cpu_memory_mmuBus_cmd_bypassTranslation(dataCache_1__io_cpu_memory_mmuBus_cmd_bypassTranslation),
    .io_cpu_memory_mmuBus_rsp_physicalAddress(DBusCachedPlugin_mmuBus_rsp_physicalAddress),
    .io_cpu_memory_mmuBus_rsp_isIoAccess(_zz_284_),
    .io_cpu_memory_mmuBus_rsp_allowRead(DBusCachedPlugin_mmuBus_rsp_allowRead),
    .io_cpu_memory_mmuBus_rsp_allowWrite(DBusCachedPlugin_mmuBus_rsp_allowWrite),
    .io_cpu_memory_mmuBus_rsp_allowExecute(DBusCachedPlugin_mmuBus_rsp_allowExecute),
    .io_cpu_memory_mmuBus_rsp_exception(DBusCachedPlugin_mmuBus_rsp_exception),
    .io_cpu_memory_mmuBus_rsp_refilling(DBusCachedPlugin_mmuBus_rsp_refilling),
    .io_cpu_memory_mmuBus_end(dataCache_1__io_cpu_memory_mmuBus_end),
    .io_cpu_memory_mmuBus_busy(DBusCachedPlugin_mmuBus_busy),
    .io_cpu_writeBack_isValid(_zz_285_),
    .io_cpu_writeBack_isStuck(writeBack_arbitration_isStuck),
    .io_cpu_writeBack_isUser(_zz_286_),
    .io_cpu_writeBack_haltIt(dataCache_1__io_cpu_writeBack_haltIt),
    .io_cpu_writeBack_isWrite(dataCache_1__io_cpu_writeBack_isWrite),
    .io_cpu_writeBack_data(dataCache_1__io_cpu_writeBack_data),
    .io_cpu_writeBack_address(_zz_287_),
    .io_cpu_writeBack_mmuException(dataCache_1__io_cpu_writeBack_mmuException),
    .io_cpu_writeBack_unalignedAccess(dataCache_1__io_cpu_writeBack_unalignedAccess),
    .io_cpu_writeBack_accessError(dataCache_1__io_cpu_writeBack_accessError),
    .io_cpu_writeBack_clearLrsc(contextSwitching),
    .io_cpu_redo(dataCache_1__io_cpu_redo),
    .io_cpu_flush_valid(_zz_288_),
    .io_cpu_flush_ready(dataCache_1__io_cpu_flush_ready),
    .io_mem_cmd_valid(dataCache_1__io_mem_cmd_valid),
    .io_mem_cmd_ready(_zz_289_),
    .io_mem_cmd_payload_wr(dataCache_1__io_mem_cmd_payload_wr),
    .io_mem_cmd_payload_address(dataCache_1__io_mem_cmd_payload_address),
    .io_mem_cmd_payload_data(dataCache_1__io_mem_cmd_payload_data),
    .io_mem_cmd_payload_mask(dataCache_1__io_mem_cmd_payload_mask),
    .io_mem_cmd_payload_length(dataCache_1__io_mem_cmd_payload_length),
    .io_mem_cmd_payload_last(dataCache_1__io_mem_cmd_payload_last),
    .io_mem_rsp_valid(dBus_rsp_valid),
    .io_mem_rsp_payload_data(dBus_rsp_payload_data),
    .io_mem_rsp_payload_error(dBus_rsp_payload_error),
    .clk(clk),
    .reset(reset) 
  );
  always @(*) begin
    case(_zz_522_)
      3'b000 : begin
        _zz_292_ = DBusCachedPlugin_redoBranch_payload;
      end
      3'b001 : begin
        _zz_292_ = CsrPlugin_jumpInterface_payload;
      end
      3'b010 : begin
        _zz_292_ = BranchPlugin_jumpInterface_payload;
      end
      3'b011 : begin
        _zz_292_ = IBusCachedPlugin_redoBranch_payload;
      end
      default : begin
        _zz_292_ = IBusCachedPlugin_predictionJumpInterface_payload;
      end
    endcase
  end

  always @(*) begin
    case(_zz_247_)
      2'b00 : begin
        _zz_293_ = MmuPlugin_ports_0_cache_0_valid;
        _zz_294_ = MmuPlugin_ports_0_cache_0_exception;
        _zz_295_ = MmuPlugin_ports_0_cache_0_superPage;
        _zz_296_ = MmuPlugin_ports_0_cache_0_virtualAddress_0;
        _zz_297_ = MmuPlugin_ports_0_cache_0_virtualAddress_1;
        _zz_298_ = MmuPlugin_ports_0_cache_0_physicalAddress_0;
        _zz_299_ = MmuPlugin_ports_0_cache_0_physicalAddress_1;
        _zz_300_ = MmuPlugin_ports_0_cache_0_allowRead;
        _zz_301_ = MmuPlugin_ports_0_cache_0_allowWrite;
        _zz_302_ = MmuPlugin_ports_0_cache_0_allowExecute;
        _zz_303_ = MmuPlugin_ports_0_cache_0_allowUser;
      end
      2'b01 : begin
        _zz_293_ = MmuPlugin_ports_0_cache_1_valid;
        _zz_294_ = MmuPlugin_ports_0_cache_1_exception;
        _zz_295_ = MmuPlugin_ports_0_cache_1_superPage;
        _zz_296_ = MmuPlugin_ports_0_cache_1_virtualAddress_0;
        _zz_297_ = MmuPlugin_ports_0_cache_1_virtualAddress_1;
        _zz_298_ = MmuPlugin_ports_0_cache_1_physicalAddress_0;
        _zz_299_ = MmuPlugin_ports_0_cache_1_physicalAddress_1;
        _zz_300_ = MmuPlugin_ports_0_cache_1_allowRead;
        _zz_301_ = MmuPlugin_ports_0_cache_1_allowWrite;
        _zz_302_ = MmuPlugin_ports_0_cache_1_allowExecute;
        _zz_303_ = MmuPlugin_ports_0_cache_1_allowUser;
      end
      2'b10 : begin
        _zz_293_ = MmuPlugin_ports_0_cache_2_valid;
        _zz_294_ = MmuPlugin_ports_0_cache_2_exception;
        _zz_295_ = MmuPlugin_ports_0_cache_2_superPage;
        _zz_296_ = MmuPlugin_ports_0_cache_2_virtualAddress_0;
        _zz_297_ = MmuPlugin_ports_0_cache_2_virtualAddress_1;
        _zz_298_ = MmuPlugin_ports_0_cache_2_physicalAddress_0;
        _zz_299_ = MmuPlugin_ports_0_cache_2_physicalAddress_1;
        _zz_300_ = MmuPlugin_ports_0_cache_2_allowRead;
        _zz_301_ = MmuPlugin_ports_0_cache_2_allowWrite;
        _zz_302_ = MmuPlugin_ports_0_cache_2_allowExecute;
        _zz_303_ = MmuPlugin_ports_0_cache_2_allowUser;
      end
      default : begin
        _zz_293_ = MmuPlugin_ports_0_cache_3_valid;
        _zz_294_ = MmuPlugin_ports_0_cache_3_exception;
        _zz_295_ = MmuPlugin_ports_0_cache_3_superPage;
        _zz_296_ = MmuPlugin_ports_0_cache_3_virtualAddress_0;
        _zz_297_ = MmuPlugin_ports_0_cache_3_virtualAddress_1;
        _zz_298_ = MmuPlugin_ports_0_cache_3_physicalAddress_0;
        _zz_299_ = MmuPlugin_ports_0_cache_3_physicalAddress_1;
        _zz_300_ = MmuPlugin_ports_0_cache_3_allowRead;
        _zz_301_ = MmuPlugin_ports_0_cache_3_allowWrite;
        _zz_302_ = MmuPlugin_ports_0_cache_3_allowExecute;
        _zz_303_ = MmuPlugin_ports_0_cache_3_allowUser;
      end
    endcase
  end

  always @(*) begin
    case(_zz_250_)
      2'b00 : begin
        _zz_304_ = MmuPlugin_ports_1_cache_0_valid;
        _zz_305_ = MmuPlugin_ports_1_cache_0_exception;
        _zz_306_ = MmuPlugin_ports_1_cache_0_superPage;
        _zz_307_ = MmuPlugin_ports_1_cache_0_virtualAddress_0;
        _zz_308_ = MmuPlugin_ports_1_cache_0_virtualAddress_1;
        _zz_309_ = MmuPlugin_ports_1_cache_0_physicalAddress_0;
        _zz_310_ = MmuPlugin_ports_1_cache_0_physicalAddress_1;
        _zz_311_ = MmuPlugin_ports_1_cache_0_allowRead;
        _zz_312_ = MmuPlugin_ports_1_cache_0_allowWrite;
        _zz_313_ = MmuPlugin_ports_1_cache_0_allowExecute;
        _zz_314_ = MmuPlugin_ports_1_cache_0_allowUser;
      end
      2'b01 : begin
        _zz_304_ = MmuPlugin_ports_1_cache_1_valid;
        _zz_305_ = MmuPlugin_ports_1_cache_1_exception;
        _zz_306_ = MmuPlugin_ports_1_cache_1_superPage;
        _zz_307_ = MmuPlugin_ports_1_cache_1_virtualAddress_0;
        _zz_308_ = MmuPlugin_ports_1_cache_1_virtualAddress_1;
        _zz_309_ = MmuPlugin_ports_1_cache_1_physicalAddress_0;
        _zz_310_ = MmuPlugin_ports_1_cache_1_physicalAddress_1;
        _zz_311_ = MmuPlugin_ports_1_cache_1_allowRead;
        _zz_312_ = MmuPlugin_ports_1_cache_1_allowWrite;
        _zz_313_ = MmuPlugin_ports_1_cache_1_allowExecute;
        _zz_314_ = MmuPlugin_ports_1_cache_1_allowUser;
      end
      2'b10 : begin
        _zz_304_ = MmuPlugin_ports_1_cache_2_valid;
        _zz_305_ = MmuPlugin_ports_1_cache_2_exception;
        _zz_306_ = MmuPlugin_ports_1_cache_2_superPage;
        _zz_307_ = MmuPlugin_ports_1_cache_2_virtualAddress_0;
        _zz_308_ = MmuPlugin_ports_1_cache_2_virtualAddress_1;
        _zz_309_ = MmuPlugin_ports_1_cache_2_physicalAddress_0;
        _zz_310_ = MmuPlugin_ports_1_cache_2_physicalAddress_1;
        _zz_311_ = MmuPlugin_ports_1_cache_2_allowRead;
        _zz_312_ = MmuPlugin_ports_1_cache_2_allowWrite;
        _zz_313_ = MmuPlugin_ports_1_cache_2_allowExecute;
        _zz_314_ = MmuPlugin_ports_1_cache_2_allowUser;
      end
      default : begin
        _zz_304_ = MmuPlugin_ports_1_cache_3_valid;
        _zz_305_ = MmuPlugin_ports_1_cache_3_exception;
        _zz_306_ = MmuPlugin_ports_1_cache_3_superPage;
        _zz_307_ = MmuPlugin_ports_1_cache_3_virtualAddress_0;
        _zz_308_ = MmuPlugin_ports_1_cache_3_virtualAddress_1;
        _zz_309_ = MmuPlugin_ports_1_cache_3_physicalAddress_0;
        _zz_310_ = MmuPlugin_ports_1_cache_3_physicalAddress_1;
        _zz_311_ = MmuPlugin_ports_1_cache_3_allowRead;
        _zz_312_ = MmuPlugin_ports_1_cache_3_allowWrite;
        _zz_313_ = MmuPlugin_ports_1_cache_3_allowExecute;
        _zz_314_ = MmuPlugin_ports_1_cache_3_allowUser;
      end
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(decode_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : decode_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : decode_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : decode_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : decode_SRC1_CTRL_string = "URS1        ";
      default : decode_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_1_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_1__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_1__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_1__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_1__string = "URS1        ";
      default : _zz_1__string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_2_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_2__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_2__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_2__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_2__string = "URS1        ";
      default : _zz_2__string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_3_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_3__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_3__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_3__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_3__string = "URS1        ";
      default : _zz_3__string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_4_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_4__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_4__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_4__string = "WFI   ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_4__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_4__string = "EBREAK";
      default : _zz_4__string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_5_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_5__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_5__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_5__string = "WFI   ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_5__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_5__string = "EBREAK";
      default : _zz_5__string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_6_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_6__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_6__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_6__string = "WFI   ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_6__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_6__string = "EBREAK";
      default : _zz_6__string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_7_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_7__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_7__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_7__string = "WFI   ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_7__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_7__string = "EBREAK";
      default : _zz_7__string = "??????";
    endcase
  end
  always @(*) begin
    case(decode_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : decode_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : decode_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_WFI : decode_ENV_CTRL_string = "WFI   ";
      `EnvCtrlEnum_defaultEncoding_ECALL : decode_ENV_CTRL_string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : decode_ENV_CTRL_string = "EBREAK";
      default : decode_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_8_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_8__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_8__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_8__string = "WFI   ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_8__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_8__string = "EBREAK";
      default : _zz_8__string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_9_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_9__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_9__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_9__string = "WFI   ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_9__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_9__string = "EBREAK";
      default : _zz_9__string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_10_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_10__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_10__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_10__string = "WFI   ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_10__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_10__string = "EBREAK";
      default : _zz_10__string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_11_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_11__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_11__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_11__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_11__string = "JALR";
      default : _zz_11__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_12_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_12__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_12__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_12__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_12__string = "JALR";
      default : _zz_12__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_13_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_13__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_13__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_13__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_13__string = "SRA_1    ";
      default : _zz_13__string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_14_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_14__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_14__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_14__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_14__string = "SRA_1    ";
      default : _zz_14__string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : decode_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : decode_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : decode_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : decode_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_15_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_15__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_15__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_15__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_15__string = "SRA_1    ";
      default : _zz_15__string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_16_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_16__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_16__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_16__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_16__string = "SRA_1    ";
      default : _zz_16__string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_17_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_17__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_17__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_17__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_17__string = "SRA_1    ";
      default : _zz_17__string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : decode_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : decode_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : decode_ALU_CTRL_string = "BITWISE ";
      default : decode_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_18_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_18__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_18__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_18__string = "BITWISE ";
      default : _zz_18__string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_19_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_19__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_19__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_19__string = "BITWISE ";
      default : _zz_19__string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_20_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_20__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_20__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_20__string = "BITWISE ";
      default : _zz_20__string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : decode_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : decode_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : decode_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_21_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_21__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_21__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_21__string = "AND_1";
      default : _zz_21__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_22_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_22__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_22__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_22__string = "AND_1";
      default : _zz_22__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_23_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_23__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_23__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_23__string = "AND_1";
      default : _zz_23__string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : decode_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : decode_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : decode_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : decode_SRC2_CTRL_string = "PC ";
      default : decode_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_24_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_24__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_24__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_24__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_24__string = "PC ";
      default : _zz_24__string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_25_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_25__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_25__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_25__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_25__string = "PC ";
      default : _zz_25__string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_26_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_26__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_26__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_26__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_26__string = "PC ";
      default : _zz_26__string = "???";
    endcase
  end
  always @(*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : execute_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : execute_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : execute_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : execute_BRANCH_CTRL_string = "JALR";
      default : execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_29_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_29__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_29__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_29__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_29__string = "JALR";
      default : _zz_29__string = "????";
    endcase
  end
  always @(*) begin
    case(memory_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : memory_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : memory_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_WFI : memory_ENV_CTRL_string = "WFI   ";
      `EnvCtrlEnum_defaultEncoding_ECALL : memory_ENV_CTRL_string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : memory_ENV_CTRL_string = "EBREAK";
      default : memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_33_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_33__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_33__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_33__string = "WFI   ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_33__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_33__string = "EBREAK";
      default : _zz_33__string = "??????";
    endcase
  end
  always @(*) begin
    case(execute_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : execute_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : execute_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_WFI : execute_ENV_CTRL_string = "WFI   ";
      `EnvCtrlEnum_defaultEncoding_ECALL : execute_ENV_CTRL_string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : execute_ENV_CTRL_string = "EBREAK";
      default : execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_34_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_34__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_34__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_34__string = "WFI   ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_34__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_34__string = "EBREAK";
      default : _zz_34__string = "??????";
    endcase
  end
  always @(*) begin
    case(writeBack_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : writeBack_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : writeBack_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_WFI : writeBack_ENV_CTRL_string = "WFI   ";
      `EnvCtrlEnum_defaultEncoding_ECALL : writeBack_ENV_CTRL_string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : writeBack_ENV_CTRL_string = "EBREAK";
      default : writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_37_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_37__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_37__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_37__string = "WFI   ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_37__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_37__string = "EBREAK";
      default : _zz_37__string = "??????";
    endcase
  end
  always @(*) begin
    case(memory_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : memory_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : memory_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : memory_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : memory_SHIFT_CTRL_string = "SRA_1    ";
      default : memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_45_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_45__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_45__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_45__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_45__string = "SRA_1    ";
      default : _zz_45__string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : execute_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : execute_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : execute_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : execute_SHIFT_CTRL_string = "SRA_1    ";
      default : execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_47_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_47__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_47__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_47__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_47__string = "SRA_1    ";
      default : _zz_47__string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : execute_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : execute_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : execute_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : execute_SRC2_CTRL_string = "PC ";
      default : execute_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_52_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_52__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_52__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_52__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_52__string = "PC ";
      default : _zz_52__string = "???";
    endcase
  end
  always @(*) begin
    case(execute_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : execute_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : execute_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : execute_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : execute_SRC1_CTRL_string = "URS1        ";
      default : execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_54_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_54__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_54__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_54__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_54__string = "URS1        ";
      default : _zz_54__string = "????????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : execute_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : execute_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : execute_ALU_CTRL_string = "BITWISE ";
      default : execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_57_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_57__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_57__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_57__string = "BITWISE ";
      default : _zz_57__string = "????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : execute_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_59_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_59__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_59__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_59__string = "AND_1";
      default : _zz_59__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_69_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_69__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_69__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_69__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_69__string = "JALR";
      default : _zz_69__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_72_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_72__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_72__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_72__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_72__string = "URS1        ";
      default : _zz_72__string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_73_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_73__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_73__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_73__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_73__string = "PC ";
      default : _zz_73__string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_75_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_75__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_75__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_75__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_75__string = "SRA_1    ";
      default : _zz_75__string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_78_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_78__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_78__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_78__string = "WFI   ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_78__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_78__string = "EBREAK";
      default : _zz_78__string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_88_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_88__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_88__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_88__string = "BITWISE ";
      default : _zz_88__string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_91_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_91__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_91__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_91__string = "AND_1";
      default : _zz_91__string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : decode_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : decode_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : decode_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : decode_BRANCH_CTRL_string = "JALR";
      default : decode_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_99_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_99__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_99__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_99__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_99__string = "JALR";
      default : _zz_99__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_191_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_191__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_191__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_191__string = "AND_1";
      default : _zz_191__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_192_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_192__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_192__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_192__string = "BITWISE ";
      default : _zz_192__string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_193_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_193__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_193__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_193__string = "WFI   ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_193__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_193__string = "EBREAK";
      default : _zz_193__string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_194_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_194__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_194__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_194__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_194__string = "SRA_1    ";
      default : _zz_194__string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_195_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_195__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_195__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_195__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_195__string = "PC ";
      default : _zz_195__string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_196_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_196__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_196__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_196__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_196__string = "URS1        ";
      default : _zz_196__string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_197_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_197__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_197__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_197__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_197__string = "JALR";
      default : _zz_197__string = "????";
    endcase
  end
  always @(*) begin
    case(MmuPlugin_shared_state_1_)
      `MmuPlugin_shared_State_defaultEncoding_IDLE : MmuPlugin_shared_state_1__string = "IDLE  ";
      `MmuPlugin_shared_State_defaultEncoding_L1_CMD : MmuPlugin_shared_state_1__string = "L1_CMD";
      `MmuPlugin_shared_State_defaultEncoding_L1_RSP : MmuPlugin_shared_state_1__string = "L1_RSP";
      `MmuPlugin_shared_State_defaultEncoding_L0_CMD : MmuPlugin_shared_state_1__string = "L0_CMD";
      `MmuPlugin_shared_State_defaultEncoding_L0_RSP : MmuPlugin_shared_state_1__string = "L0_RSP";
      default : MmuPlugin_shared_state_1__string = "??????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : decode_to_execute_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : decode_to_execute_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : decode_to_execute_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : decode_to_execute_SRC2_CTRL_string = "PC ";
      default : decode_to_execute_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_to_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : decode_to_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : decode_to_execute_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : decode_to_execute_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : decode_to_execute_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : decode_to_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_to_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_to_memory_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : execute_to_memory_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : execute_to_memory_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : execute_to_memory_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : execute_to_memory_SHIFT_CTRL_string = "SRA_1    ";
      default : execute_to_memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : decode_to_execute_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : decode_to_execute_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : decode_to_execute_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : decode_to_execute_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : decode_to_execute_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_WFI : decode_to_execute_ENV_CTRL_string = "WFI   ";
      `EnvCtrlEnum_defaultEncoding_ECALL : decode_to_execute_ENV_CTRL_string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : decode_to_execute_ENV_CTRL_string = "EBREAK";
      default : decode_to_execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(execute_to_memory_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : execute_to_memory_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : execute_to_memory_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_WFI : execute_to_memory_ENV_CTRL_string = "WFI   ";
      `EnvCtrlEnum_defaultEncoding_ECALL : execute_to_memory_ENV_CTRL_string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : execute_to_memory_ENV_CTRL_string = "EBREAK";
      default : execute_to_memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(memory_to_writeBack_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : memory_to_writeBack_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : memory_to_writeBack_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_WFI : memory_to_writeBack_ENV_CTRL_string = "WFI   ";
      `EnvCtrlEnum_defaultEncoding_ECALL : memory_to_writeBack_ENV_CTRL_string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : memory_to_writeBack_ENV_CTRL_string = "EBREAK";
      default : memory_to_writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : decode_to_execute_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : decode_to_execute_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : decode_to_execute_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : decode_to_execute_SRC1_CTRL_string = "URS1        ";
      default : decode_to_execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  `endif

  assign writeBack_FORMAL_PC_NEXT = memory_to_writeBack_FORMAL_PC_NEXT;
  assign memory_FORMAL_PC_NEXT = execute_to_memory_FORMAL_PC_NEXT;
  assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT;
  assign decode_FORMAL_PC_NEXT = _zz_102_;
  assign decode_SRC1_CTRL = _zz_1_;
  assign _zz_2_ = _zz_3_;
  assign execute_BYPASSABLE_MEMORY_STAGE = decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_81_;
  assign memory_MUL_HH = execute_to_memory_MUL_HH;
  assign execute_MUL_HH = _zz_39_;
  assign memory_MEMORY_ADDRESS_LOW = execute_to_memory_MEMORY_ADDRESS_LOW;
  assign execute_MEMORY_ADDRESS_LOW = _zz_95_;
  assign _zz_4_ = _zz_5_;
  assign _zz_6_ = _zz_7_;
  assign decode_ENV_CTRL = _zz_8_;
  assign _zz_9_ = _zz_10_;
  assign execute_MUL_LL = _zz_42_;
  assign execute_BRANCH_DO = _zz_28_;
  assign decode_MEMORY_MANAGMENT = _zz_68_;
  assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_89_;
  assign _zz_11_ = _zz_12_;
  assign memory_MEMORY_WR = execute_to_memory_MEMORY_WR;
  assign decode_MEMORY_WR = _zz_84_;
  assign memory_PC = execute_to_memory_PC;
  assign decode_CSR_WRITE_OPCODE = _zz_36_;
  assign _zz_13_ = _zz_14_;
  assign decode_SHIFT_CTRL = _zz_15_;
  assign _zz_16_ = _zz_17_;
  assign decode_ALU_CTRL = _zz_18_;
  assign _zz_19_ = _zz_20_;
  assign execute_PIPELINED_CSR_READ = _zz_32_;
  assign decode_ALU_BITWISE_CTRL = _zz_21_;
  assign _zz_22_ = _zz_23_;
  assign execute_MUL_HL = _zz_40_;
  assign decode_MEMORY_LRSC = _zz_87_;
  assign decode_SRC2_FORCE_ZERO = _zz_56_;
  assign decode_IS_DIV = _zz_66_;
  assign decode_IS_RS2_SIGNED = _zz_67_;
  assign decode_PREDICTION_HAD_BRANCHED2 = _zz_31_;
  assign decode_MEMORY_AMO = _zz_76_;
  assign decode_CSR_READ_OPCODE = _zz_35_;
  assign memory_IS_SFENCE_VMA = execute_to_memory_IS_SFENCE_VMA;
  assign execute_IS_SFENCE_VMA = decode_to_execute_IS_SFENCE_VMA;
  assign decode_IS_SFENCE_VMA = _zz_83_;
  assign execute_SHIFT_RIGHT = _zz_46_;
  assign execute_REGFILE_WRITE_DATA = _zz_58_;
  assign execute_MUL_LH = _zz_41_;
  assign memory_IS_MUL = execute_to_memory_IS_MUL;
  assign execute_IS_MUL = decode_to_execute_IS_MUL;
  assign decode_IS_MUL = _zz_70_;
  assign execute_BRANCH_CALC = _zz_27_;
  assign memory_MUL_LOW = _zz_38_;
  assign decode_IS_CSR = _zz_65_;
  assign execute_IS_DBUS_SHARING = _zz_93_;
  assign decode_SRC_LESS_UNSIGNED = _zz_77_;
  assign decode_SRC2_CTRL = _zz_24_;
  assign _zz_25_ = _zz_26_;
  assign decode_IS_RS1_SIGNED = _zz_79_;
  assign writeBack_IS_SFENCE_VMA = memory_to_writeBack_IS_SFENCE_VMA;
  assign memory_BRANCH_CALC = execute_to_memory_BRANCH_CALC;
  assign memory_BRANCH_DO = execute_to_memory_BRANCH_DO;
  assign execute_PC = decode_to_execute_PC;
  assign execute_BRANCH_COND_RESULT = _zz_30_;
  assign execute_PREDICTION_HAD_BRANCHED2 = decode_to_execute_PREDICTION_HAD_BRANCHED2;
  assign execute_BRANCH_CTRL = _zz_29_;
  assign memory_PIPELINED_CSR_READ = execute_to_memory_PIPELINED_CSR_READ;
  assign memory_IS_CSR = execute_to_memory_IS_CSR;
  assign execute_CSR_READ_OPCODE = decode_to_execute_CSR_READ_OPCODE;
  assign execute_CSR_WRITE_OPCODE = decode_to_execute_CSR_WRITE_OPCODE;
  assign execute_IS_CSR = decode_to_execute_IS_CSR;
  assign memory_ENV_CTRL = _zz_33_;
  assign execute_ENV_CTRL = _zz_34_;
  assign writeBack_ENV_CTRL = _zz_37_;
  assign execute_IS_RS1_SIGNED = decode_to_execute_IS_RS1_SIGNED;
  assign execute_RS1 = decode_to_execute_RS1;
  assign execute_IS_DIV = decode_to_execute_IS_DIV;
  assign execute_IS_RS2_SIGNED = decode_to_execute_IS_RS2_SIGNED;
  assign memory_IS_DIV = execute_to_memory_IS_DIV;
  assign writeBack_IS_MUL = memory_to_writeBack_IS_MUL;
  assign writeBack_MUL_HH = memory_to_writeBack_MUL_HH;
  assign writeBack_MUL_LOW = memory_to_writeBack_MUL_LOW;
  assign memory_MUL_HL = execute_to_memory_MUL_HL;
  assign memory_MUL_LH = execute_to_memory_MUL_LH;
  assign memory_MUL_LL = execute_to_memory_MUL_LL;
  assign decode_RS2_USE = _zz_85_;
  assign decode_RS1_USE = _zz_86_;
  always @ (*) begin
    _zz_43_ = execute_REGFILE_WRITE_DATA;
    if(DBusCachedPlugin_forceDatapath)begin
      _zz_43_ = MmuPlugin_dBusAccess_cmd_payload_address;
    end
  end

  assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID;
  assign execute_BYPASSABLE_EXECUTE_STAGE = decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  assign memory_REGFILE_WRITE_VALID = execute_to_memory_REGFILE_WRITE_VALID;
  assign memory_INSTRUCTION = execute_to_memory_INSTRUCTION;
  assign memory_BYPASSABLE_MEMORY_STAGE = execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  assign writeBack_REGFILE_WRITE_VALID = memory_to_writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    decode_RS2 = _zz_63_;
    if(_zz_211_)begin
      if((_zz_212_ == decode_INSTRUCTION[24 : 20]))begin
        decode_RS2 = _zz_213_;
      end
    end
    if(_zz_315_)begin
      if(_zz_316_)begin
        if(_zz_215_)begin
          decode_RS2 = _zz_94_;
        end
      end
    end
    if(_zz_317_)begin
      if(memory_BYPASSABLE_MEMORY_STAGE)begin
        if(_zz_217_)begin
          decode_RS2 = _zz_44_;
        end
      end
    end
    if(_zz_318_)begin
      if(execute_BYPASSABLE_EXECUTE_STAGE)begin
        if(_zz_219_)begin
          decode_RS2 = _zz_43_;
        end
      end
    end
  end

  always @ (*) begin
    decode_RS1 = _zz_64_;
    if(_zz_211_)begin
      if((_zz_212_ == decode_INSTRUCTION[19 : 15]))begin
        decode_RS1 = _zz_213_;
      end
    end
    if(_zz_315_)begin
      if(_zz_316_)begin
        if(_zz_214_)begin
          decode_RS1 = _zz_94_;
        end
      end
    end
    if(_zz_317_)begin
      if(memory_BYPASSABLE_MEMORY_STAGE)begin
        if(_zz_216_)begin
          decode_RS1 = _zz_44_;
        end
      end
    end
    if(_zz_318_)begin
      if(execute_BYPASSABLE_EXECUTE_STAGE)begin
        if(_zz_218_)begin
          decode_RS1 = _zz_43_;
        end
      end
    end
  end

  assign memory_SHIFT_RIGHT = execute_to_memory_SHIFT_RIGHT;
  always @ (*) begin
    _zz_44_ = memory_REGFILE_WRITE_DATA;
    if(memory_arbitration_isValid)begin
      case(memory_SHIFT_CTRL)
        `ShiftCtrlEnum_defaultEncoding_SLL_1 : begin
          _zz_44_ = _zz_207_;
        end
        `ShiftCtrlEnum_defaultEncoding_SRL_1, `ShiftCtrlEnum_defaultEncoding_SRA_1 : begin
          _zz_44_ = memory_SHIFT_RIGHT;
        end
        default : begin
        end
      endcase
    end
    if(_zz_319_)begin
      _zz_44_ = memory_DivPlugin_div_result;
    end
    if((memory_arbitration_isValid && memory_IS_CSR))begin
      _zz_44_ = memory_PIPELINED_CSR_READ;
    end
  end

  assign memory_SHIFT_CTRL = _zz_45_;
  assign execute_SHIFT_CTRL = _zz_47_;
  assign execute_SRC_LESS_UNSIGNED = decode_to_execute_SRC_LESS_UNSIGNED;
  assign execute_SRC2_FORCE_ZERO = decode_to_execute_SRC2_FORCE_ZERO;
  assign execute_SRC_USE_SUB_LESS = decode_to_execute_SRC_USE_SUB_LESS;
  assign _zz_51_ = execute_PC;
  assign execute_SRC2_CTRL = _zz_52_;
  assign execute_IS_RVC = decode_to_execute_IS_RVC;
  assign execute_SRC1_CTRL = _zz_54_;
  assign decode_SRC_USE_SUB_LESS = _zz_74_;
  assign decode_SRC_ADD_ZERO = _zz_82_;
  assign execute_SRC_ADD_SUB = _zz_50_;
  assign execute_SRC_LESS = _zz_48_;
  assign execute_ALU_CTRL = _zz_57_;
  assign execute_SRC2 = _zz_53_;
  assign execute_SRC1 = _zz_55_;
  assign execute_ALU_BITWISE_CTRL = _zz_59_;
  assign _zz_60_ = writeBack_INSTRUCTION;
  assign _zz_61_ = writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    _zz_62_ = 1'b0;
    if(lastStageRegFileWrite_valid)begin
      _zz_62_ = 1'b1;
    end
  end

  always @ (*) begin
    decode_REGFILE_WRITE_VALID = _zz_71_;
    if((decode_INSTRUCTION[11 : 7] == (5'b00000)))begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  assign decode_LEGAL_INSTRUCTION = _zz_92_;
  assign decode_INSTRUCTION_READY = 1'b1;
  assign writeBack_IS_DBUS_SHARING = memory_to_writeBack_IS_DBUS_SHARING;
  assign memory_IS_DBUS_SHARING = execute_to_memory_IS_DBUS_SHARING;
  always @ (*) begin
    _zz_94_ = writeBack_REGFILE_WRITE_DATA;
    if((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE))begin
      _zz_94_ = writeBack_DBusCachedPlugin_rspFormated;
    end
    if((writeBack_arbitration_isValid && writeBack_IS_MUL))begin
      case(_zz_377_)
        2'b00 : begin
          _zz_94_ = _zz_441_;
        end
        default : begin
          _zz_94_ = _zz_442_;
        end
      endcase
    end
  end

  assign writeBack_MEMORY_ADDRESS_LOW = memory_to_writeBack_MEMORY_ADDRESS_LOW;
  assign writeBack_MEMORY_WR = memory_to_writeBack_MEMORY_WR;
  assign writeBack_REGFILE_WRITE_DATA = memory_to_writeBack_REGFILE_WRITE_DATA;
  assign writeBack_MEMORY_ENABLE = memory_to_writeBack_MEMORY_ENABLE;
  assign memory_REGFILE_WRITE_DATA = execute_to_memory_REGFILE_WRITE_DATA;
  assign memory_MEMORY_ENABLE = execute_to_memory_MEMORY_ENABLE;
  assign execute_MEMORY_AMO = decode_to_execute_MEMORY_AMO;
  assign execute_MEMORY_LRSC = decode_to_execute_MEMORY_LRSC;
  assign execute_MEMORY_MANAGMENT = decode_to_execute_MEMORY_MANAGMENT;
  assign execute_RS2 = decode_to_execute_RS2;
  assign execute_MEMORY_WR = decode_to_execute_MEMORY_WR;
  assign execute_SRC_ADD = _zz_49_;
  assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE;
  assign execute_INSTRUCTION = decode_to_execute_INSTRUCTION;
  assign decode_MEMORY_ENABLE = _zz_80_;
  assign decode_FLUSH_ALL = _zz_90_;
  always @ (*) begin
    IBusCachedPlugin_rsp_issueDetected = _zz_96_;
    if(_zz_320_)begin
      IBusCachedPlugin_rsp_issueDetected = 1'b1;
    end
  end

  always @ (*) begin
    _zz_96_ = _zz_97_;
    if(_zz_321_)begin
      _zz_96_ = 1'b1;
    end
  end

  always @ (*) begin
    _zz_97_ = _zz_98_;
    if(_zz_322_)begin
      _zz_97_ = 1'b1;
    end
  end

  always @ (*) begin
    _zz_98_ = 1'b0;
    if(_zz_323_)begin
      _zz_98_ = 1'b1;
    end
  end

  assign decode_BRANCH_CTRL = _zz_99_;
  always @ (*) begin
    _zz_100_ = memory_FORMAL_PC_NEXT;
    if(BranchPlugin_jumpInterface_valid)begin
      _zz_100_ = BranchPlugin_jumpInterface_payload;
    end
  end

  always @ (*) begin
    _zz_101_ = decode_FORMAL_PC_NEXT;
    if(IBusCachedPlugin_predictionJumpInterface_valid)begin
      _zz_101_ = IBusCachedPlugin_predictionJumpInterface_payload;
    end
    if(IBusCachedPlugin_redoBranch_valid)begin
      _zz_101_ = IBusCachedPlugin_redoBranch_payload;
    end
  end

  assign decode_PC = _zz_105_;
  assign decode_INSTRUCTION = _zz_104_;
  assign decode_IS_RVC = _zz_103_;
  assign writeBack_PC = memory_to_writeBack_PC;
  assign writeBack_INSTRUCTION = memory_to_writeBack_INSTRUCTION;
  always @ (*) begin
    decode_arbitration_haltItself = 1'b0;
    if(((DBusCachedPlugin_mmuBus_busy && decode_arbitration_isValid) && decode_MEMORY_ENABLE))begin
      decode_arbitration_haltItself = 1'b1;
    end
  end

  always @ (*) begin
    decode_arbitration_haltByOther = 1'b0;
    if(MmuPlugin_dBusAccess_cmd_valid)begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if((decode_arbitration_isValid && (_zz_208_ || _zz_209_)))begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if((CsrPlugin_interrupt_valid && CsrPlugin_allowInterrupts))begin
      decode_arbitration_haltByOther = decode_arbitration_isValid;
    end
    if(({(writeBack_arbitration_isValid && (writeBack_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET)),{(memory_arbitration_isValid && (memory_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET)),(execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET))}} != (3'b000)))begin
      decode_arbitration_haltByOther = 1'b1;
    end
  end

  always @ (*) begin
    decode_arbitration_removeIt = 1'b0;
    if(_zz_324_)begin
      decode_arbitration_removeIt = 1'b1;
    end
    if(decode_arbitration_isFlushed)begin
      decode_arbitration_removeIt = 1'b1;
    end
  end

  assign decode_arbitration_flushIt = 1'b0;
  always @ (*) begin
    decode_arbitration_flushNext = 1'b0;
    if(IBusCachedPlugin_redoBranch_valid)begin
      decode_arbitration_flushNext = 1'b1;
    end
    if(_zz_324_)begin
      decode_arbitration_flushNext = 1'b1;
    end
  end

  always @ (*) begin
    execute_arbitration_haltItself = 1'b0;
    if((_zz_288_ && (! dataCache_1__io_cpu_flush_ready)))begin
      execute_arbitration_haltItself = 1'b1;
    end
    if(((dataCache_1__io_cpu_redo && execute_arbitration_isValid) && execute_MEMORY_ENABLE))begin
      execute_arbitration_haltItself = 1'b1;
    end
    if(_zz_325_)begin
      if((! execute_CsrPlugin_wfiWake))begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
    if((execute_arbitration_isValid && execute_IS_CSR))begin
      if(execute_CsrPlugin_blockedBySideEffects)begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
  end

  assign execute_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    execute_arbitration_removeIt = 1'b0;
    if(CsrPlugin_selfException_valid)begin
      execute_arbitration_removeIt = 1'b1;
    end
    if(execute_arbitration_isFlushed)begin
      execute_arbitration_removeIt = 1'b1;
    end
  end

  assign execute_arbitration_flushIt = 1'b0;
  always @ (*) begin
    execute_arbitration_flushNext = 1'b0;
    if(CsrPlugin_selfException_valid)begin
      execute_arbitration_flushNext = 1'b1;
    end
  end

  always @ (*) begin
    memory_arbitration_haltItself = 1'b0;
    if(_zz_319_)begin
      if(_zz_326_)begin
        memory_arbitration_haltItself = 1'b1;
      end
    end
  end

  assign memory_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    memory_arbitration_removeIt = 1'b0;
    if(memory_arbitration_isFlushed)begin
      memory_arbitration_removeIt = 1'b1;
    end
  end

  assign memory_arbitration_flushIt = 1'b0;
  always @ (*) begin
    memory_arbitration_flushNext = 1'b0;
    if(BranchPlugin_jumpInterface_valid)begin
      memory_arbitration_flushNext = 1'b1;
    end
  end

  always @ (*) begin
    writeBack_arbitration_haltItself = 1'b0;
    if(dataCache_1__io_cpu_writeBack_haltIt)begin
      writeBack_arbitration_haltItself = 1'b1;
    end
  end

  assign writeBack_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    writeBack_arbitration_removeIt = 1'b0;
    if(DBusCachedPlugin_exceptionBus_valid)begin
      writeBack_arbitration_removeIt = 1'b1;
    end
    if(writeBack_arbitration_isFlushed)begin
      writeBack_arbitration_removeIt = 1'b1;
    end
  end

  always @ (*) begin
    writeBack_arbitration_flushIt = 1'b0;
    if(DBusCachedPlugin_redoBranch_valid)begin
      writeBack_arbitration_flushIt = 1'b1;
    end
  end

  always @ (*) begin
    writeBack_arbitration_flushNext = 1'b0;
    if(DBusCachedPlugin_redoBranch_valid)begin
      writeBack_arbitration_flushNext = 1'b1;
    end
    if(DBusCachedPlugin_exceptionBus_valid)begin
      writeBack_arbitration_flushNext = 1'b1;
    end
    if(_zz_327_)begin
      writeBack_arbitration_flushNext = 1'b1;
    end
    if(_zz_328_)begin
      writeBack_arbitration_flushNext = 1'b1;
    end
  end

  assign lastStageInstruction = writeBack_INSTRUCTION;
  assign lastStagePc = writeBack_PC;
  assign lastStageIsValid = writeBack_arbitration_isValid;
  assign lastStageIsFiring = writeBack_arbitration_isFiring;
  always @ (*) begin
    IBusCachedPlugin_fetcherHalt = 1'b0;
    if(({CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValids_memory,{CsrPlugin_exceptionPortCtrl_exceptionValids_execute,CsrPlugin_exceptionPortCtrl_exceptionValids_decode}}} != (4'b0000)))begin
      IBusCachedPlugin_fetcherHalt = 1'b1;
    end
    if(_zz_327_)begin
      IBusCachedPlugin_fetcherHalt = 1'b1;
    end
    if(_zz_328_)begin
      IBusCachedPlugin_fetcherHalt = 1'b1;
    end
  end

  always @ (*) begin
    IBusCachedPlugin_fetcherflushIt = 1'b0;
    if(({writeBack_arbitration_flushNext,{memory_arbitration_flushNext,{execute_arbitration_flushNext,decode_arbitration_flushNext}}} != (4'b0000)))begin
      IBusCachedPlugin_fetcherflushIt = 1'b1;
    end
    if((IBusCachedPlugin_predictionJumpInterface_valid && decode_arbitration_isFiring))begin
      IBusCachedPlugin_fetcherflushIt = 1'b1;
    end
  end

  always @ (*) begin
    IBusCachedPlugin_incomingInstruction = 1'b0;
    if(((IBusCachedPlugin_iBusRsp_stages_1_input_valid || IBusCachedPlugin_iBusRsp_stages_2_input_valid) || IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_valid))begin
      IBusCachedPlugin_incomingInstruction = 1'b1;
    end
    if((IBusCachedPlugin_decompressor_bufferValid && (IBusCachedPlugin_decompressor_bufferData[1 : 0] != (2'b11))))begin
      IBusCachedPlugin_incomingInstruction = 1'b1;
    end
    if(IBusCachedPlugin_injector_decodeInput_valid)begin
      IBusCachedPlugin_incomingInstruction = 1'b1;
    end
  end

  always @ (*) begin
    CsrPlugin_jumpInterface_valid = 1'b0;
    if(_zz_327_)begin
      CsrPlugin_jumpInterface_valid = 1'b1;
    end
    if(_zz_328_)begin
      CsrPlugin_jumpInterface_valid = 1'b1;
    end
  end

  always @ (*) begin
    CsrPlugin_jumpInterface_payload = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    if(_zz_327_)begin
      CsrPlugin_jumpInterface_payload = {CsrPlugin_xtvec_base,(2'b00)};
    end
    if(_zz_328_)begin
      case(_zz_329_)
        2'b11 : begin
          CsrPlugin_jumpInterface_payload = CsrPlugin_mepc;
        end
        2'b01 : begin
          CsrPlugin_jumpInterface_payload = CsrPlugin_sepc;
        end
        default : begin
        end
      endcase
    end
  end

  assign CsrPlugin_forceMachineWire = 1'b0;
  assign CsrPlugin_allowInterrupts = 1'b1;
  assign CsrPlugin_allowException = 1'b1;
  assign IBusCachedPlugin_jump_pcLoad_valid = ({BranchPlugin_jumpInterface_valid,{CsrPlugin_jumpInterface_valid,{DBusCachedPlugin_redoBranch_valid,{IBusCachedPlugin_redoBranch_valid,IBusCachedPlugin_predictionJumpInterface_valid}}}} != (5'b00000));
  assign _zz_106_ = {IBusCachedPlugin_predictionJumpInterface_valid,{IBusCachedPlugin_redoBranch_valid,{BranchPlugin_jumpInterface_valid,{CsrPlugin_jumpInterface_valid,DBusCachedPlugin_redoBranch_valid}}}};
  assign _zz_107_ = (_zz_106_ & (~ _zz_379_));
  assign _zz_108_ = _zz_107_[3];
  assign _zz_109_ = _zz_107_[4];
  assign _zz_110_ = (_zz_107_[1] || _zz_108_);
  assign _zz_111_ = (_zz_107_[2] || _zz_108_);
  assign IBusCachedPlugin_jump_pcLoad_payload = _zz_292_;
  always @ (*) begin
    IBusCachedPlugin_fetchPc_corrected = 1'b0;
    if(IBusCachedPlugin_jump_pcLoad_valid)begin
      IBusCachedPlugin_fetchPc_corrected = 1'b1;
    end
  end

  always @ (*) begin
    IBusCachedPlugin_fetchPc_pcRegPropagate = 1'b0;
    if(IBusCachedPlugin_iBusRsp_stages_1_input_ready)begin
      IBusCachedPlugin_fetchPc_pcRegPropagate = 1'b1;
    end
  end

  always @ (*) begin
    IBusCachedPlugin_fetchPc_pc = (IBusCachedPlugin_fetchPc_pcReg + _zz_381_);
    if(IBusCachedPlugin_fetchPc_inc)begin
      IBusCachedPlugin_fetchPc_pc[1] = 1'b0;
    end
    if(IBusCachedPlugin_jump_pcLoad_valid)begin
      IBusCachedPlugin_fetchPc_pc = IBusCachedPlugin_jump_pcLoad_payload;
    end
    IBusCachedPlugin_fetchPc_pc[0] = 1'b0;
  end

  assign IBusCachedPlugin_fetchPc_output_valid = ((! IBusCachedPlugin_fetcherHalt) && IBusCachedPlugin_fetchPc_booted);
  assign IBusCachedPlugin_fetchPc_output_payload = IBusCachedPlugin_fetchPc_pc;
  assign IBusCachedPlugin_decodePc_pcPlus = (IBusCachedPlugin_decodePc_pcReg + _zz_383_);
  assign IBusCachedPlugin_decodePc_injectedDecode = 1'b0;
  assign IBusCachedPlugin_iBusRsp_stages_0_input_valid = IBusCachedPlugin_fetchPc_output_valid;
  assign IBusCachedPlugin_fetchPc_output_ready = IBusCachedPlugin_iBusRsp_stages_0_input_ready;
  assign IBusCachedPlugin_iBusRsp_stages_0_input_payload = IBusCachedPlugin_fetchPc_output_payload;
  assign IBusCachedPlugin_iBusRsp_stages_0_inputSample = 1'b1;
  assign IBusCachedPlugin_iBusRsp_stages_0_halt = 1'b0;
  assign _zz_112_ = (! IBusCachedPlugin_iBusRsp_stages_0_halt);
  assign IBusCachedPlugin_iBusRsp_stages_0_input_ready = (IBusCachedPlugin_iBusRsp_stages_0_output_ready && _zz_112_);
  assign IBusCachedPlugin_iBusRsp_stages_0_output_valid = (IBusCachedPlugin_iBusRsp_stages_0_input_valid && _zz_112_);
  assign IBusCachedPlugin_iBusRsp_stages_0_output_payload = IBusCachedPlugin_iBusRsp_stages_0_input_payload;
  always @ (*) begin
    IBusCachedPlugin_iBusRsp_stages_1_halt = 1'b0;
    if(IBusCachedPlugin_cache_io_cpu_prefetch_haltIt)begin
      IBusCachedPlugin_iBusRsp_stages_1_halt = 1'b1;
    end
  end

  assign _zz_113_ = (! IBusCachedPlugin_iBusRsp_stages_1_halt);
  assign IBusCachedPlugin_iBusRsp_stages_1_input_ready = (IBusCachedPlugin_iBusRsp_stages_1_output_ready && _zz_113_);
  assign IBusCachedPlugin_iBusRsp_stages_1_output_valid = (IBusCachedPlugin_iBusRsp_stages_1_input_valid && _zz_113_);
  assign IBusCachedPlugin_iBusRsp_stages_1_output_payload = IBusCachedPlugin_iBusRsp_stages_1_input_payload;
  always @ (*) begin
    IBusCachedPlugin_iBusRsp_stages_2_halt = 1'b0;
    if(IBusCachedPlugin_cache_io_cpu_fetch_haltIt)begin
      IBusCachedPlugin_iBusRsp_stages_2_halt = 1'b1;
    end
  end

  assign _zz_114_ = (! IBusCachedPlugin_iBusRsp_stages_2_halt);
  assign IBusCachedPlugin_iBusRsp_stages_2_input_ready = (IBusCachedPlugin_iBusRsp_stages_2_output_ready && _zz_114_);
  assign IBusCachedPlugin_iBusRsp_stages_2_output_valid = (IBusCachedPlugin_iBusRsp_stages_2_input_valid && _zz_114_);
  assign IBusCachedPlugin_iBusRsp_stages_2_output_payload = IBusCachedPlugin_iBusRsp_stages_2_input_payload;
  always @ (*) begin
    IBusCachedPlugin_iBusRsp_cacheRspArbitration_halt = 1'b0;
    if((IBusCachedPlugin_rsp_issueDetected || IBusCachedPlugin_rsp_iBusRspOutputHalt))begin
      IBusCachedPlugin_iBusRsp_cacheRspArbitration_halt = 1'b1;
    end
  end

  assign _zz_115_ = (! IBusCachedPlugin_iBusRsp_cacheRspArbitration_halt);
  assign IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_ready = (IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_ready && _zz_115_);
  assign IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_valid = (IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_valid && _zz_115_);
  assign IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_payload = IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_payload;
  assign IBusCachedPlugin_iBusRsp_stages_0_output_ready = _zz_116_;
  assign _zz_116_ = ((1'b0 && (! _zz_117_)) || IBusCachedPlugin_iBusRsp_stages_1_input_ready);
  assign _zz_117_ = _zz_118_;
  assign IBusCachedPlugin_iBusRsp_stages_1_input_valid = _zz_117_;
  assign IBusCachedPlugin_iBusRsp_stages_1_input_payload = IBusCachedPlugin_fetchPc_pcReg;
  assign IBusCachedPlugin_iBusRsp_stages_1_output_ready = ((1'b0 && (! _zz_119_)) || IBusCachedPlugin_iBusRsp_stages_2_input_ready);
  assign _zz_119_ = _zz_120_;
  assign IBusCachedPlugin_iBusRsp_stages_2_input_valid = _zz_119_;
  assign IBusCachedPlugin_iBusRsp_stages_2_input_payload = _zz_121_;
  assign IBusCachedPlugin_iBusRsp_stages_2_output_ready = ((1'b0 && (! _zz_122_)) || IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_ready);
  assign _zz_122_ = _zz_123_;
  assign IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_valid = _zz_122_;
  assign IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_payload = _zz_124_;
  always @ (*) begin
    IBusCachedPlugin_iBusRsp_readyForError = 1'b1;
    if((IBusCachedPlugin_decompressor_bufferValid && IBusCachedPlugin_decompressor_isRvc))begin
      IBusCachedPlugin_iBusRsp_readyForError = 1'b0;
    end
    if(IBusCachedPlugin_injector_decodeInput_valid)begin
      IBusCachedPlugin_iBusRsp_readyForError = 1'b0;
    end
  end

  assign IBusCachedPlugin_decompressor_raw = (IBusCachedPlugin_decompressor_bufferValid ? {IBusCachedPlugin_iBusRsp_output_payload_rsp_inst[15 : 0],IBusCachedPlugin_decompressor_bufferData} : {IBusCachedPlugin_iBusRsp_output_payload_rsp_inst[31 : 16],(IBusCachedPlugin_iBusRsp_output_payload_pc[1] ? IBusCachedPlugin_iBusRsp_output_payload_rsp_inst[31 : 16] : IBusCachedPlugin_iBusRsp_output_payload_rsp_inst[15 : 0])});
  assign IBusCachedPlugin_decompressor_isRvc = (IBusCachedPlugin_decompressor_raw[1 : 0] != (2'b11));
  assign _zz_125_ = IBusCachedPlugin_decompressor_raw[15 : 0];
  always @ (*) begin
    IBusCachedPlugin_decompressor_decompressed = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    case(_zz_373_)
      5'b00000 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{{{{{(2'b00),_zz_125_[10 : 7]},_zz_125_[12 : 11]},_zz_125_[5]},_zz_125_[6]},(2'b00)},(5'b00010)},(3'b000)},_zz_127_},(7'b0010011)};
      end
      5'b00010 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{_zz_128_,_zz_126_},(3'b010)},_zz_127_},(7'b0000011)};
      end
      5'b00110 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{_zz_128_[11 : 5],_zz_127_},_zz_126_},(3'b010)},_zz_128_[4 : 0]},(7'b0100011)};
      end
      5'b01000 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{_zz_130_,_zz_125_[11 : 7]},(3'b000)},_zz_125_[11 : 7]},(7'b0010011)};
      end
      5'b01001 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{_zz_133_[20],_zz_133_[10 : 1]},_zz_133_[11]},_zz_133_[19 : 12]},_zz_145_},(7'b1101111)};
      end
      5'b01010 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{_zz_130_,(5'b00000)},(3'b000)},_zz_125_[11 : 7]},(7'b0010011)};
      end
      5'b01011 : begin
        IBusCachedPlugin_decompressor_decompressed = ((_zz_125_[11 : 7] == (5'b00010)) ? {{{{{{{{{_zz_137_,_zz_125_[4 : 3]},_zz_125_[5]},_zz_125_[2]},_zz_125_[6]},(4'b0000)},_zz_125_[11 : 7]},(3'b000)},_zz_125_[11 : 7]},(7'b0010011)} : {{_zz_384_[31 : 12],_zz_125_[11 : 7]},(7'b0110111)});
      end
      5'b01100 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{((_zz_125_[11 : 10] == (2'b10)) ? _zz_151_ : {{(1'b0),(_zz_523_ || _zz_524_)},(5'b00000)}),(((! _zz_125_[11]) || _zz_147_) ? _zz_125_[6 : 2] : _zz_127_)},_zz_126_},_zz_149_},_zz_126_},(_zz_147_ ? (7'b0010011) : (7'b0110011))};
      end
      5'b01101 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{_zz_140_[20],_zz_140_[10 : 1]},_zz_140_[11]},_zz_140_[19 : 12]},_zz_144_},(7'b1101111)};
      end
      5'b01110 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{{{_zz_143_[12],_zz_143_[10 : 5]},_zz_144_},_zz_126_},(3'b000)},_zz_143_[4 : 1]},_zz_143_[11]},(7'b1100011)};
      end
      5'b01111 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{{{_zz_143_[12],_zz_143_[10 : 5]},_zz_144_},_zz_126_},(3'b001)},_zz_143_[4 : 1]},_zz_143_[11]},(7'b1100011)};
      end
      5'b10000 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{(7'b0000000),_zz_125_[6 : 2]},_zz_125_[11 : 7]},(3'b001)},_zz_125_[11 : 7]},(7'b0010011)};
      end
      5'b10010 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{{{{(4'b0000),_zz_125_[3 : 2]},_zz_125_[12]},_zz_125_[6 : 4]},(2'b00)},_zz_146_},(3'b010)},_zz_125_[11 : 7]},(7'b0000011)};
      end
      5'b10100 : begin
        IBusCachedPlugin_decompressor_decompressed = ((_zz_125_[12 : 2] == (11'b10000000000)) ? (32'b00000000000100000000000001110011) : ((_zz_125_[6 : 2] == (5'b00000)) ? {{{{(12'b000000000000),_zz_125_[11 : 7]},(3'b000)},(_zz_125_[12] ? _zz_145_ : _zz_144_)},(7'b1100111)} : {{{{{_zz_525_,_zz_526_},(_zz_527_ ? _zz_528_ : _zz_144_)},(3'b000)},_zz_125_[11 : 7]},(7'b0110011)}));
      end
      5'b10110 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{_zz_385_[11 : 5],_zz_125_[6 : 2]},_zz_146_},(3'b010)},_zz_386_[4 : 0]},(7'b0100011)};
      end
      default : begin
      end
    endcase
  end

  assign _zz_126_ = {(2'b01),_zz_125_[9 : 7]};
  assign _zz_127_ = {(2'b01),_zz_125_[4 : 2]};
  assign _zz_128_ = {{{{(5'b00000),_zz_125_[5]},_zz_125_[12 : 10]},_zz_125_[6]},(2'b00)};
  assign _zz_129_ = _zz_125_[12];
  always @ (*) begin
    _zz_130_[11] = _zz_129_;
    _zz_130_[10] = _zz_129_;
    _zz_130_[9] = _zz_129_;
    _zz_130_[8] = _zz_129_;
    _zz_130_[7] = _zz_129_;
    _zz_130_[6] = _zz_129_;
    _zz_130_[5] = _zz_129_;
    _zz_130_[4 : 0] = _zz_125_[6 : 2];
  end

  assign _zz_131_ = _zz_125_[12];
  always @ (*) begin
    _zz_132_[9] = _zz_131_;
    _zz_132_[8] = _zz_131_;
    _zz_132_[7] = _zz_131_;
    _zz_132_[6] = _zz_131_;
    _zz_132_[5] = _zz_131_;
    _zz_132_[4] = _zz_131_;
    _zz_132_[3] = _zz_131_;
    _zz_132_[2] = _zz_131_;
    _zz_132_[1] = _zz_131_;
    _zz_132_[0] = _zz_131_;
  end

  assign _zz_133_ = {{{{{{{{_zz_132_,_zz_125_[8]},_zz_125_[10 : 9]},_zz_125_[6]},_zz_125_[7]},_zz_125_[2]},_zz_125_[11]},_zz_125_[5 : 3]},(1'b0)};
  assign _zz_134_ = _zz_125_[12];
  always @ (*) begin
    _zz_135_[14] = _zz_134_;
    _zz_135_[13] = _zz_134_;
    _zz_135_[12] = _zz_134_;
    _zz_135_[11] = _zz_134_;
    _zz_135_[10] = _zz_134_;
    _zz_135_[9] = _zz_134_;
    _zz_135_[8] = _zz_134_;
    _zz_135_[7] = _zz_134_;
    _zz_135_[6] = _zz_134_;
    _zz_135_[5] = _zz_134_;
    _zz_135_[4] = _zz_134_;
    _zz_135_[3] = _zz_134_;
    _zz_135_[2] = _zz_134_;
    _zz_135_[1] = _zz_134_;
    _zz_135_[0] = _zz_134_;
  end

  assign _zz_136_ = _zz_125_[12];
  always @ (*) begin
    _zz_137_[2] = _zz_136_;
    _zz_137_[1] = _zz_136_;
    _zz_137_[0] = _zz_136_;
  end

  assign _zz_138_ = _zz_125_[12];
  always @ (*) begin
    _zz_139_[9] = _zz_138_;
    _zz_139_[8] = _zz_138_;
    _zz_139_[7] = _zz_138_;
    _zz_139_[6] = _zz_138_;
    _zz_139_[5] = _zz_138_;
    _zz_139_[4] = _zz_138_;
    _zz_139_[3] = _zz_138_;
    _zz_139_[2] = _zz_138_;
    _zz_139_[1] = _zz_138_;
    _zz_139_[0] = _zz_138_;
  end

  assign _zz_140_ = {{{{{{{{_zz_139_,_zz_125_[8]},_zz_125_[10 : 9]},_zz_125_[6]},_zz_125_[7]},_zz_125_[2]},_zz_125_[11]},_zz_125_[5 : 3]},(1'b0)};
  assign _zz_141_ = _zz_125_[12];
  always @ (*) begin
    _zz_142_[4] = _zz_141_;
    _zz_142_[3] = _zz_141_;
    _zz_142_[2] = _zz_141_;
    _zz_142_[1] = _zz_141_;
    _zz_142_[0] = _zz_141_;
  end

  assign _zz_143_ = {{{{{_zz_142_,_zz_125_[6 : 5]},_zz_125_[2]},_zz_125_[11 : 10]},_zz_125_[4 : 3]},(1'b0)};
  assign _zz_144_ = (5'b00000);
  assign _zz_145_ = (5'b00001);
  assign _zz_146_ = (5'b00010);
  assign _zz_147_ = (_zz_125_[11 : 10] != (2'b11));
  always @ (*) begin
    case(_zz_374_)
      2'b00 : begin
        _zz_148_ = (3'b000);
      end
      2'b01 : begin
        _zz_148_ = (3'b100);
      end
      2'b10 : begin
        _zz_148_ = (3'b110);
      end
      default : begin
        _zz_148_ = (3'b111);
      end
    endcase
  end

  always @ (*) begin
    case(_zz_375_)
      2'b00 : begin
        _zz_149_ = (3'b101);
      end
      2'b01 : begin
        _zz_149_ = (3'b101);
      end
      2'b10 : begin
        _zz_149_ = (3'b111);
      end
      default : begin
        _zz_149_ = _zz_148_;
      end
    endcase
  end

  assign _zz_150_ = _zz_125_[12];
  always @ (*) begin
    _zz_151_[6] = _zz_150_;
    _zz_151_[5] = _zz_150_;
    _zz_151_[4] = _zz_150_;
    _zz_151_[3] = _zz_150_;
    _zz_151_[2] = _zz_150_;
    _zz_151_[1] = _zz_150_;
    _zz_151_[0] = _zz_150_;
  end

  assign IBusCachedPlugin_decompressor_inputBeforeStage_valid = (IBusCachedPlugin_decompressor_isRvc ? (IBusCachedPlugin_decompressor_bufferValid || IBusCachedPlugin_iBusRsp_output_valid) : (IBusCachedPlugin_iBusRsp_output_valid && (IBusCachedPlugin_decompressor_bufferValid || (! IBusCachedPlugin_iBusRsp_output_payload_pc[1]))));
  assign IBusCachedPlugin_decompressor_inputBeforeStage_payload_pc = IBusCachedPlugin_iBusRsp_output_payload_pc;
  assign IBusCachedPlugin_decompressor_inputBeforeStage_payload_isRvc = IBusCachedPlugin_decompressor_isRvc;
  assign IBusCachedPlugin_decompressor_inputBeforeStage_payload_rsp_inst = (IBusCachedPlugin_decompressor_isRvc ? IBusCachedPlugin_decompressor_decompressed : IBusCachedPlugin_decompressor_raw);
  assign IBusCachedPlugin_iBusRsp_output_ready = ((! IBusCachedPlugin_decompressor_inputBeforeStage_valid) || (! (((! IBusCachedPlugin_decompressor_inputBeforeStage_ready) || ((IBusCachedPlugin_decompressor_isRvc && (! IBusCachedPlugin_iBusRsp_output_payload_pc[1])) && (IBusCachedPlugin_iBusRsp_output_payload_rsp_inst[17 : 16] != (2'b11)))) || (((! IBusCachedPlugin_decompressor_isRvc) && IBusCachedPlugin_decompressor_bufferValid) && (IBusCachedPlugin_iBusRsp_output_payload_rsp_inst[17 : 16] != (2'b11))))));
  always @ (*) begin
    IBusCachedPlugin_decompressor_bufferFill = 1'b0;
    if(_zz_330_)begin
      if(_zz_331_)begin
        IBusCachedPlugin_decompressor_bufferFill = 1'b1;
      end
    end
  end

  assign IBusCachedPlugin_decompressor_inputBeforeStage_ready = ((1'b0 && (! IBusCachedPlugin_injector_decodeInput_valid)) || IBusCachedPlugin_injector_decodeInput_ready);
  assign IBusCachedPlugin_injector_decodeInput_valid = _zz_152_;
  assign IBusCachedPlugin_injector_decodeInput_payload_pc = _zz_153_;
  assign IBusCachedPlugin_injector_decodeInput_payload_rsp_error = _zz_154_;
  assign IBusCachedPlugin_injector_decodeInput_payload_rsp_inst = _zz_155_;
  assign IBusCachedPlugin_injector_decodeInput_payload_isRvc = _zz_156_;
  assign IBusCachedPlugin_pcValids_0 = IBusCachedPlugin_injector_nextPcCalc_valids_0;
  assign IBusCachedPlugin_pcValids_1 = IBusCachedPlugin_injector_nextPcCalc_valids_1;
  assign IBusCachedPlugin_pcValids_2 = IBusCachedPlugin_injector_nextPcCalc_valids_2;
  assign IBusCachedPlugin_pcValids_3 = IBusCachedPlugin_injector_nextPcCalc_valids_3;
  assign IBusCachedPlugin_injector_decodeInput_ready = (! decode_arbitration_isStuck);
  assign decode_arbitration_isValid = (IBusCachedPlugin_injector_decodeInput_valid && (! IBusCachedPlugin_injector_decodeRemoved));
  assign _zz_105_ = IBusCachedPlugin_decodePc_pcReg;
  assign _zz_104_ = IBusCachedPlugin_injector_decodeInput_payload_rsp_inst;
  assign _zz_103_ = IBusCachedPlugin_injector_decodeInput_payload_isRvc;
  assign _zz_102_ = (decode_PC + _zz_388_);
  assign _zz_157_ = _zz_389_[11];
  always @ (*) begin
    _zz_158_[18] = _zz_157_;
    _zz_158_[17] = _zz_157_;
    _zz_158_[16] = _zz_157_;
    _zz_158_[15] = _zz_157_;
    _zz_158_[14] = _zz_157_;
    _zz_158_[13] = _zz_157_;
    _zz_158_[12] = _zz_157_;
    _zz_158_[11] = _zz_157_;
    _zz_158_[10] = _zz_157_;
    _zz_158_[9] = _zz_157_;
    _zz_158_[8] = _zz_157_;
    _zz_158_[7] = _zz_157_;
    _zz_158_[6] = _zz_157_;
    _zz_158_[5] = _zz_157_;
    _zz_158_[4] = _zz_157_;
    _zz_158_[3] = _zz_157_;
    _zz_158_[2] = _zz_157_;
    _zz_158_[1] = _zz_157_;
    _zz_158_[0] = _zz_157_;
  end

  assign IBusCachedPlugin_decodePrediction_cmd_hadBranch = ((decode_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_JAL) || ((decode_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_B) && _zz_390_[31]));
  assign IBusCachedPlugin_predictionJumpInterface_valid = (decode_arbitration_isValid && IBusCachedPlugin_decodePrediction_cmd_hadBranch);
  assign _zz_159_ = _zz_391_[19];
  always @ (*) begin
    _zz_160_[10] = _zz_159_;
    _zz_160_[9] = _zz_159_;
    _zz_160_[8] = _zz_159_;
    _zz_160_[7] = _zz_159_;
    _zz_160_[6] = _zz_159_;
    _zz_160_[5] = _zz_159_;
    _zz_160_[4] = _zz_159_;
    _zz_160_[3] = _zz_159_;
    _zz_160_[2] = _zz_159_;
    _zz_160_[1] = _zz_159_;
    _zz_160_[0] = _zz_159_;
  end

  assign _zz_161_ = _zz_392_[11];
  always @ (*) begin
    _zz_162_[18] = _zz_161_;
    _zz_162_[17] = _zz_161_;
    _zz_162_[16] = _zz_161_;
    _zz_162_[15] = _zz_161_;
    _zz_162_[14] = _zz_161_;
    _zz_162_[13] = _zz_161_;
    _zz_162_[12] = _zz_161_;
    _zz_162_[11] = _zz_161_;
    _zz_162_[10] = _zz_161_;
    _zz_162_[9] = _zz_161_;
    _zz_162_[8] = _zz_161_;
    _zz_162_[7] = _zz_161_;
    _zz_162_[6] = _zz_161_;
    _zz_162_[5] = _zz_161_;
    _zz_162_[4] = _zz_161_;
    _zz_162_[3] = _zz_161_;
    _zz_162_[2] = _zz_161_;
    _zz_162_[1] = _zz_161_;
    _zz_162_[0] = _zz_161_;
  end

  assign IBusCachedPlugin_predictionJumpInterface_payload = (decode_PC + ((decode_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_JAL) ? {{_zz_160_,{{{_zz_529_,_zz_530_},_zz_531_},decode_INSTRUCTION[30 : 21]}},1'b0} : {{_zz_162_,{{{_zz_532_,_zz_533_},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0}));
  assign iBus_cmd_valid = IBusCachedPlugin_cache_io_mem_cmd_valid;
  always @ (*) begin
    iBus_cmd_payload_address = IBusCachedPlugin_cache_io_mem_cmd_payload_address;
    iBus_cmd_payload_address = IBusCachedPlugin_cache_io_mem_cmd_payload_address;
  end

  assign iBus_cmd_payload_size = IBusCachedPlugin_cache_io_mem_cmd_payload_size;
  assign IBusCachedPlugin_s0_tightlyCoupledHit = 1'b0;
  assign _zz_265_ = (IBusCachedPlugin_iBusRsp_stages_1_input_valid && (! IBusCachedPlugin_s0_tightlyCoupledHit));
  assign _zz_268_ = (32'b00000000000000000000000000000000);
  assign _zz_266_ = (IBusCachedPlugin_iBusRsp_stages_2_input_valid && (! IBusCachedPlugin_s1_tightlyCoupledHit));
  assign _zz_267_ = (! IBusCachedPlugin_iBusRsp_stages_2_input_ready);
  assign _zz_269_ = (IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_valid && (! IBusCachedPlugin_s2_tightlyCoupledHit));
  assign _zz_270_ = (! IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_ready);
  assign _zz_271_ = (CsrPlugin_privilege == (2'b00));
  assign IBusCachedPlugin_rsp_iBusRspOutputHalt = 1'b0;
  always @ (*) begin
    IBusCachedPlugin_rsp_redoFetch = 1'b0;
    if(_zz_323_)begin
      IBusCachedPlugin_rsp_redoFetch = 1'b1;
    end
    if(_zz_321_)begin
      IBusCachedPlugin_rsp_redoFetch = 1'b1;
    end
    if(_zz_332_)begin
      IBusCachedPlugin_rsp_redoFetch = 1'b0;
    end
  end

  always @ (*) begin
    _zz_272_ = (IBusCachedPlugin_rsp_redoFetch && (! IBusCachedPlugin_cache_io_cpu_decode_mmuRefilling));
    if(_zz_321_)begin
      _zz_272_ = 1'b1;
    end
    if(_zz_332_)begin
      _zz_272_ = 1'b0;
    end
  end

  always @ (*) begin
    IBusCachedPlugin_decodeExceptionPort_valid = 1'b0;
    if(_zz_322_)begin
      IBusCachedPlugin_decodeExceptionPort_valid = IBusCachedPlugin_iBusRsp_readyForError;
    end
    if(_zz_320_)begin
      IBusCachedPlugin_decodeExceptionPort_valid = IBusCachedPlugin_iBusRsp_readyForError;
    end
  end

  always @ (*) begin
    IBusCachedPlugin_decodeExceptionPort_payload_code = (4'bxxxx);
    if(_zz_322_)begin
      IBusCachedPlugin_decodeExceptionPort_payload_code = (4'b1100);
    end
    if(_zz_320_)begin
      IBusCachedPlugin_decodeExceptionPort_payload_code = (4'b0001);
    end
  end

  assign IBusCachedPlugin_decodeExceptionPort_payload_badAddr = {IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_payload[31 : 2],(2'b00)};
  assign IBusCachedPlugin_redoBranch_valid = IBusCachedPlugin_rsp_redoFetch;
  assign IBusCachedPlugin_redoBranch_payload = decode_PC;
  assign IBusCachedPlugin_iBusRsp_output_valid = IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_valid;
  assign IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_ready = IBusCachedPlugin_iBusRsp_output_ready;
  assign IBusCachedPlugin_iBusRsp_output_payload_rsp_inst = IBusCachedPlugin_cache_io_cpu_decode_data;
  assign IBusCachedPlugin_iBusRsp_output_payload_pc = IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_payload;
  assign IBusCachedPlugin_mmuBus_cmd_isValid = IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_isValid;
  assign IBusCachedPlugin_mmuBus_cmd_virtualAddress = IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_virtualAddress;
  assign IBusCachedPlugin_mmuBus_cmd_bypassTranslation = IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_bypassTranslation;
  assign IBusCachedPlugin_mmuBus_end = IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_end;
  assign _zz_264_ = (decode_arbitration_isValid && decode_FLUSH_ALL);
  assign dataCache_1__io_mem_cmd_s2mPipe_valid = (dataCache_1__io_mem_cmd_valid || _zz_164_);
  assign _zz_289_ = (! _zz_164_);
  assign dataCache_1__io_mem_cmd_s2mPipe_payload_wr = (_zz_164_ ? _zz_165_ : dataCache_1__io_mem_cmd_payload_wr);
  assign dataCache_1__io_mem_cmd_s2mPipe_payload_address = (_zz_164_ ? _zz_166_ : dataCache_1__io_mem_cmd_payload_address);
  assign dataCache_1__io_mem_cmd_s2mPipe_payload_data = (_zz_164_ ? _zz_167_ : dataCache_1__io_mem_cmd_payload_data);
  assign dataCache_1__io_mem_cmd_s2mPipe_payload_mask = (_zz_164_ ? _zz_168_ : dataCache_1__io_mem_cmd_payload_mask);
  assign dataCache_1__io_mem_cmd_s2mPipe_payload_length = (_zz_164_ ? _zz_169_ : dataCache_1__io_mem_cmd_payload_length);
  assign dataCache_1__io_mem_cmd_s2mPipe_payload_last = (_zz_164_ ? _zz_170_ : dataCache_1__io_mem_cmd_payload_last);
  assign dataCache_1__io_mem_cmd_s2mPipe_ready = ((1'b1 && (! dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_valid)) || dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_ready);
  assign dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_valid = _zz_171_;
  assign dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_wr = _zz_172_;
  assign dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_address = _zz_173_;
  assign dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_data = _zz_174_;
  assign dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_mask = _zz_175_;
  assign dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_length = _zz_176_;
  assign dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_last = _zz_177_;
  assign dBus_cmd_valid = dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_valid;
  assign dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_ready = dBus_cmd_ready;
  assign dBus_cmd_payload_wr = dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_wr;
  assign dBus_cmd_payload_address = dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_address;
  assign dBus_cmd_payload_data = dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_data;
  assign dBus_cmd_payload_mask = dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_mask;
  assign dBus_cmd_payload_length = dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_length;
  assign dBus_cmd_payload_last = dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_last;
  assign execute_DBusCachedPlugin_size = execute_INSTRUCTION[13 : 12];
  always @ (*) begin
    _zz_273_ = (execute_arbitration_isValid && execute_MEMORY_ENABLE);
    if(MmuPlugin_dBusAccess_cmd_valid)begin
      if(_zz_333_)begin
        if(_zz_334_)begin
          _zz_273_ = 1'b1;
        end
      end
    end
  end

  always @ (*) begin
    _zz_274_ = execute_SRC_ADD;
    if(MmuPlugin_dBusAccess_cmd_valid)begin
      if(_zz_333_)begin
        _zz_274_ = MmuPlugin_dBusAccess_cmd_payload_address;
      end
    end
  end

  always @ (*) begin
    _zz_275_ = execute_MEMORY_WR;
    if(MmuPlugin_dBusAccess_cmd_valid)begin
      if(_zz_333_)begin
        _zz_275_ = MmuPlugin_dBusAccess_cmd_payload_write;
      end
    end
  end

  always @ (*) begin
    case(execute_DBusCachedPlugin_size)
      2'b00 : begin
        _zz_179_ = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        _zz_179_ = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _zz_179_ = execute_RS2[31 : 0];
      end
    endcase
  end

  always @ (*) begin
    _zz_276_ = _zz_179_;
    if(MmuPlugin_dBusAccess_cmd_valid)begin
      if(_zz_333_)begin
        _zz_276_ = MmuPlugin_dBusAccess_cmd_payload_data;
      end
    end
  end

  always @ (*) begin
    _zz_277_ = execute_DBusCachedPlugin_size;
    if(MmuPlugin_dBusAccess_cmd_valid)begin
      if(_zz_333_)begin
        _zz_277_ = MmuPlugin_dBusAccess_cmd_payload_size;
      end
    end
  end

  assign _zz_288_ = (execute_arbitration_isValid && execute_MEMORY_MANAGMENT);
  always @ (*) begin
    _zz_278_ = 1'b0;
    if(execute_MEMORY_LRSC)begin
      _zz_278_ = 1'b1;
    end
    if(MmuPlugin_dBusAccess_cmd_valid)begin
      if(_zz_333_)begin
        _zz_278_ = 1'b0;
      end
    end
  end

  always @ (*) begin
    _zz_279_ = execute_MEMORY_AMO;
    if(MmuPlugin_dBusAccess_cmd_valid)begin
      if(_zz_333_)begin
        _zz_279_ = 1'b0;
      end
    end
  end

  assign _zz_281_ = execute_INSTRUCTION[31 : 29];
  assign _zz_280_ = execute_INSTRUCTION[27];
  assign _zz_95_ = _zz_274_[1 : 0];
  always @ (*) begin
    _zz_282_ = (memory_arbitration_isValid && memory_MEMORY_ENABLE);
    if(memory_IS_DBUS_SHARING)begin
      _zz_282_ = 1'b1;
    end
  end

  assign _zz_283_ = memory_REGFILE_WRITE_DATA;
  assign DBusCachedPlugin_mmuBus_cmd_isValid = dataCache_1__io_cpu_memory_mmuBus_cmd_isValid;
  assign DBusCachedPlugin_mmuBus_cmd_virtualAddress = dataCache_1__io_cpu_memory_mmuBus_cmd_virtualAddress;
  always @ (*) begin
    DBusCachedPlugin_mmuBus_cmd_bypassTranslation = dataCache_1__io_cpu_memory_mmuBus_cmd_bypassTranslation;
    if(memory_IS_DBUS_SHARING)begin
      DBusCachedPlugin_mmuBus_cmd_bypassTranslation = 1'b1;
    end
  end

  always @ (*) begin
    _zz_284_ = DBusCachedPlugin_mmuBus_rsp_isIoAccess;
    if((1'b0 && (! dataCache_1__io_cpu_memory_isWrite)))begin
      _zz_284_ = 1'b1;
    end
  end

  assign DBusCachedPlugin_mmuBus_end = dataCache_1__io_cpu_memory_mmuBus_end;
  always @ (*) begin
    _zz_285_ = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE);
    if(writeBack_IS_DBUS_SHARING)begin
      _zz_285_ = 1'b1;
    end
  end

  assign _zz_286_ = (CsrPlugin_privilege == (2'b00));
  assign _zz_287_ = writeBack_REGFILE_WRITE_DATA;
  always @ (*) begin
    DBusCachedPlugin_redoBranch_valid = 1'b0;
    if(_zz_335_)begin
      if(dataCache_1__io_cpu_redo)begin
        DBusCachedPlugin_redoBranch_valid = 1'b1;
      end
    end
  end

  assign DBusCachedPlugin_redoBranch_payload = writeBack_PC;
  always @ (*) begin
    DBusCachedPlugin_exceptionBus_valid = 1'b0;
    if(_zz_335_)begin
      if(dataCache_1__io_cpu_writeBack_accessError)begin
        DBusCachedPlugin_exceptionBus_valid = 1'b1;
      end
      if(dataCache_1__io_cpu_writeBack_unalignedAccess)begin
        DBusCachedPlugin_exceptionBus_valid = 1'b1;
      end
      if(dataCache_1__io_cpu_writeBack_mmuException)begin
        DBusCachedPlugin_exceptionBus_valid = 1'b1;
      end
      if(dataCache_1__io_cpu_redo)begin
        DBusCachedPlugin_exceptionBus_valid = 1'b0;
      end
    end
  end

  assign DBusCachedPlugin_exceptionBus_payload_badAddr = writeBack_REGFILE_WRITE_DATA;
  always @ (*) begin
    DBusCachedPlugin_exceptionBus_payload_code = (4'bxxxx);
    if(_zz_335_)begin
      if(dataCache_1__io_cpu_writeBack_accessError)begin
        DBusCachedPlugin_exceptionBus_payload_code = {1'd0, _zz_393_};
      end
      if(dataCache_1__io_cpu_writeBack_unalignedAccess)begin
        DBusCachedPlugin_exceptionBus_payload_code = {1'd0, _zz_394_};
      end
      if(dataCache_1__io_cpu_writeBack_mmuException)begin
        DBusCachedPlugin_exceptionBus_payload_code = (writeBack_MEMORY_WR ? (4'b1111) : (4'b1101));
      end
    end
  end

  always @ (*) begin
    writeBack_DBusCachedPlugin_rspShifted = dataCache_1__io_cpu_writeBack_data;
    case(writeBack_MEMORY_ADDRESS_LOW)
      2'b01 : begin
        writeBack_DBusCachedPlugin_rspShifted[7 : 0] = dataCache_1__io_cpu_writeBack_data[15 : 8];
      end
      2'b10 : begin
        writeBack_DBusCachedPlugin_rspShifted[15 : 0] = dataCache_1__io_cpu_writeBack_data[31 : 16];
      end
      2'b11 : begin
        writeBack_DBusCachedPlugin_rspShifted[7 : 0] = dataCache_1__io_cpu_writeBack_data[31 : 24];
      end
      default : begin
      end
    endcase
  end

  assign _zz_180_ = (writeBack_DBusCachedPlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_181_[31] = _zz_180_;
    _zz_181_[30] = _zz_180_;
    _zz_181_[29] = _zz_180_;
    _zz_181_[28] = _zz_180_;
    _zz_181_[27] = _zz_180_;
    _zz_181_[26] = _zz_180_;
    _zz_181_[25] = _zz_180_;
    _zz_181_[24] = _zz_180_;
    _zz_181_[23] = _zz_180_;
    _zz_181_[22] = _zz_180_;
    _zz_181_[21] = _zz_180_;
    _zz_181_[20] = _zz_180_;
    _zz_181_[19] = _zz_180_;
    _zz_181_[18] = _zz_180_;
    _zz_181_[17] = _zz_180_;
    _zz_181_[16] = _zz_180_;
    _zz_181_[15] = _zz_180_;
    _zz_181_[14] = _zz_180_;
    _zz_181_[13] = _zz_180_;
    _zz_181_[12] = _zz_180_;
    _zz_181_[11] = _zz_180_;
    _zz_181_[10] = _zz_180_;
    _zz_181_[9] = _zz_180_;
    _zz_181_[8] = _zz_180_;
    _zz_181_[7 : 0] = writeBack_DBusCachedPlugin_rspShifted[7 : 0];
  end

  assign _zz_182_ = (writeBack_DBusCachedPlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_183_[31] = _zz_182_;
    _zz_183_[30] = _zz_182_;
    _zz_183_[29] = _zz_182_;
    _zz_183_[28] = _zz_182_;
    _zz_183_[27] = _zz_182_;
    _zz_183_[26] = _zz_182_;
    _zz_183_[25] = _zz_182_;
    _zz_183_[24] = _zz_182_;
    _zz_183_[23] = _zz_182_;
    _zz_183_[22] = _zz_182_;
    _zz_183_[21] = _zz_182_;
    _zz_183_[20] = _zz_182_;
    _zz_183_[19] = _zz_182_;
    _zz_183_[18] = _zz_182_;
    _zz_183_[17] = _zz_182_;
    _zz_183_[16] = _zz_182_;
    _zz_183_[15 : 0] = writeBack_DBusCachedPlugin_rspShifted[15 : 0];
  end

  always @ (*) begin
    case(_zz_376_)
      2'b00 : begin
        writeBack_DBusCachedPlugin_rspFormated = _zz_181_;
      end
      2'b01 : begin
        writeBack_DBusCachedPlugin_rspFormated = _zz_183_;
      end
      default : begin
        writeBack_DBusCachedPlugin_rspFormated = writeBack_DBusCachedPlugin_rspShifted;
      end
    endcase
  end

  always @ (*) begin
    MmuPlugin_dBusAccess_cmd_ready = 1'b0;
    if(MmuPlugin_dBusAccess_cmd_valid)begin
      if(_zz_333_)begin
        if(_zz_334_)begin
          MmuPlugin_dBusAccess_cmd_ready = (! execute_arbitration_isStuck);
        end
      end
    end
  end

  always @ (*) begin
    DBusCachedPlugin_forceDatapath = 1'b0;
    if(MmuPlugin_dBusAccess_cmd_valid)begin
      if(_zz_333_)begin
        DBusCachedPlugin_forceDatapath = 1'b1;
      end
    end
  end

  assign _zz_93_ = (MmuPlugin_dBusAccess_cmd_valid && MmuPlugin_dBusAccess_cmd_ready);
  assign MmuPlugin_dBusAccess_rsp_valid = ((writeBack_IS_DBUS_SHARING && (! dataCache_1__io_cpu_writeBack_isWrite)) && (dataCache_1__io_cpu_redo || (! dataCache_1__io_cpu_writeBack_haltIt)));
  assign MmuPlugin_dBusAccess_rsp_payload_data = dataCache_1__io_cpu_writeBack_data;
  assign MmuPlugin_dBusAccess_rsp_payload_error = (dataCache_1__io_cpu_writeBack_unalignedAccess || dataCache_1__io_cpu_writeBack_accessError);
  assign MmuPlugin_dBusAccess_rsp_payload_redo = dataCache_1__io_cpu_redo;
  assign _zz_185_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000001100)) == (32'b00000000000000000000000000000100));
  assign _zz_186_ = ((decode_INSTRUCTION & (32'b00000000000000000010000001010000)) == (32'b00000000000000000010000000000000));
  assign _zz_187_ = ((decode_INSTRUCTION & (32'b00000000000000000001000000000000)) == (32'b00000000000000000000000000000000));
  assign _zz_188_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000000100)) == (32'b00000000000000000000000000000100));
  assign _zz_189_ = ((decode_INSTRUCTION & (32'b00000000000000000100000001010000)) == (32'b00000000000000000100000001010000));
  assign _zz_190_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001001000)) == (32'b00000000000000000000000001001000));
  assign _zz_184_ = {({(_zz_534_ == _zz_535_),(_zz_536_ == _zz_537_)} != (2'b00)),{((_zz_538_ == _zz_539_) != (1'b0)),{(_zz_187_ != (1'b0)),{(_zz_540_ != _zz_541_),{_zz_542_,{_zz_543_,_zz_544_}}}}}};
  assign _zz_92_ = ({((decode_INSTRUCTION & (32'b00000000000000000000000001011111)) == (32'b00000000000000000000000000010111)),{((decode_INSTRUCTION & (32'b00000000000000000000000001111111)) == (32'b00000000000000000000000001101111)),{((decode_INSTRUCTION & (32'b00000000000000000001000001101111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & _zz_743_) == (32'b00000000000000000001000001110011)),{(_zz_744_ == _zz_745_),{_zz_746_,{_zz_747_,_zz_748_}}}}}}} != (25'b0000000000000000000000000));
  assign _zz_191_ = _zz_184_[1 : 0];
  assign _zz_91_ = _zz_191_;
  assign _zz_90_ = _zz_395_[0];
  assign _zz_89_ = _zz_396_[0];
  assign _zz_192_ = _zz_184_[5 : 4];
  assign _zz_88_ = _zz_192_;
  assign _zz_87_ = _zz_397_[0];
  assign _zz_86_ = _zz_398_[0];
  assign _zz_85_ = _zz_399_[0];
  assign _zz_84_ = _zz_400_[0];
  assign _zz_83_ = _zz_401_[0];
  assign _zz_82_ = _zz_402_[0];
  assign _zz_81_ = _zz_403_[0];
  assign _zz_80_ = _zz_404_[0];
  assign _zz_79_ = _zz_405_[0];
  assign _zz_193_ = _zz_184_[17 : 15];
  assign _zz_78_ = _zz_193_;
  assign _zz_77_ = _zz_406_[0];
  assign _zz_76_ = _zz_407_[0];
  assign _zz_194_ = _zz_184_[21 : 20];
  assign _zz_75_ = _zz_194_;
  assign _zz_74_ = _zz_408_[0];
  assign _zz_195_ = _zz_184_[24 : 23];
  assign _zz_73_ = _zz_195_;
  assign _zz_196_ = _zz_184_[26 : 25];
  assign _zz_72_ = _zz_196_;
  assign _zz_71_ = _zz_409_[0];
  assign _zz_70_ = _zz_410_[0];
  assign _zz_197_ = _zz_184_[30 : 29];
  assign _zz_69_ = _zz_197_;
  assign _zz_68_ = _zz_411_[0];
  assign _zz_67_ = _zz_412_[0];
  assign _zz_66_ = _zz_413_[0];
  assign _zz_65_ = _zz_414_[0];
  assign decodeExceptionPort_valid = ((decode_arbitration_isValid && decode_INSTRUCTION_READY) && (! decode_LEGAL_INSTRUCTION));
  assign decodeExceptionPort_payload_code = (4'b0010);
  assign decodeExceptionPort_payload_badAddr = decode_INSTRUCTION;
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION[24 : 20];
  assign decode_RegFilePlugin_rs1Data = _zz_290_;
  assign decode_RegFilePlugin_rs2Data = _zz_291_;
  assign _zz_64_ = decode_RegFilePlugin_rs1Data;
  assign _zz_63_ = decode_RegFilePlugin_rs2Data;
  always @ (*) begin
    lastStageRegFileWrite_valid = (_zz_61_ && writeBack_arbitration_isFiring);
    if(_zz_198_)begin
      lastStageRegFileWrite_valid = 1'b1;
    end
  end

  assign lastStageRegFileWrite_payload_address = _zz_60_[11 : 7];
  assign lastStageRegFileWrite_payload_data = _zz_94_;
  always @ (*) begin
    case(execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 & execute_SRC2);
      end
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 | execute_SRC2);
      end
      default : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 ^ execute_SRC2);
      end
    endcase
  end

  always @ (*) begin
    case(execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_BITWISE : begin
        _zz_199_ = execute_IntAluPlugin_bitwise;
      end
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : begin
        _zz_199_ = {31'd0, _zz_415_};
      end
      default : begin
        _zz_199_ = execute_SRC_ADD_SUB;
      end
    endcase
  end

  assign _zz_58_ = _zz_199_;
  assign _zz_56_ = (decode_SRC_ADD_ZERO && (! decode_SRC_USE_SUB_LESS));
  always @ (*) begin
    case(execute_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : begin
        _zz_200_ = execute_RS1;
      end
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : begin
        _zz_200_ = {29'd0, _zz_416_};
      end
      `Src1CtrlEnum_defaultEncoding_IMU : begin
        _zz_200_ = {execute_INSTRUCTION[31 : 12],(12'b000000000000)};
      end
      default : begin
        _zz_200_ = {27'd0, _zz_417_};
      end
    endcase
  end

  assign _zz_55_ = _zz_200_;
  assign _zz_201_ = _zz_418_[11];
  always @ (*) begin
    _zz_202_[19] = _zz_201_;
    _zz_202_[18] = _zz_201_;
    _zz_202_[17] = _zz_201_;
    _zz_202_[16] = _zz_201_;
    _zz_202_[15] = _zz_201_;
    _zz_202_[14] = _zz_201_;
    _zz_202_[13] = _zz_201_;
    _zz_202_[12] = _zz_201_;
    _zz_202_[11] = _zz_201_;
    _zz_202_[10] = _zz_201_;
    _zz_202_[9] = _zz_201_;
    _zz_202_[8] = _zz_201_;
    _zz_202_[7] = _zz_201_;
    _zz_202_[6] = _zz_201_;
    _zz_202_[5] = _zz_201_;
    _zz_202_[4] = _zz_201_;
    _zz_202_[3] = _zz_201_;
    _zz_202_[2] = _zz_201_;
    _zz_202_[1] = _zz_201_;
    _zz_202_[0] = _zz_201_;
  end

  assign _zz_203_ = _zz_419_[11];
  always @ (*) begin
    _zz_204_[19] = _zz_203_;
    _zz_204_[18] = _zz_203_;
    _zz_204_[17] = _zz_203_;
    _zz_204_[16] = _zz_203_;
    _zz_204_[15] = _zz_203_;
    _zz_204_[14] = _zz_203_;
    _zz_204_[13] = _zz_203_;
    _zz_204_[12] = _zz_203_;
    _zz_204_[11] = _zz_203_;
    _zz_204_[10] = _zz_203_;
    _zz_204_[9] = _zz_203_;
    _zz_204_[8] = _zz_203_;
    _zz_204_[7] = _zz_203_;
    _zz_204_[6] = _zz_203_;
    _zz_204_[5] = _zz_203_;
    _zz_204_[4] = _zz_203_;
    _zz_204_[3] = _zz_203_;
    _zz_204_[2] = _zz_203_;
    _zz_204_[1] = _zz_203_;
    _zz_204_[0] = _zz_203_;
  end

  always @ (*) begin
    case(execute_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : begin
        _zz_205_ = execute_RS2;
      end
      `Src2CtrlEnum_defaultEncoding_IMI : begin
        _zz_205_ = {_zz_202_,execute_INSTRUCTION[31 : 20]};
      end
      `Src2CtrlEnum_defaultEncoding_IMS : begin
        _zz_205_ = {_zz_204_,{execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_205_ = _zz_51_;
      end
    endcase
  end

  assign _zz_53_ = _zz_205_;
  always @ (*) begin
    execute_SrcPlugin_addSub = _zz_420_;
    if(execute_SRC2_FORCE_ZERO)begin
      execute_SrcPlugin_addSub = execute_SRC1;
    end
  end

  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign _zz_50_ = execute_SrcPlugin_addSub;
  assign _zz_49_ = execute_SrcPlugin_addSub;
  assign _zz_48_ = execute_SrcPlugin_less;
  assign execute_FullBarrelShifterPlugin_amplitude = execute_SRC2[4 : 0];
  always @ (*) begin
    _zz_206_[0] = execute_SRC1[31];
    _zz_206_[1] = execute_SRC1[30];
    _zz_206_[2] = execute_SRC1[29];
    _zz_206_[3] = execute_SRC1[28];
    _zz_206_[4] = execute_SRC1[27];
    _zz_206_[5] = execute_SRC1[26];
    _zz_206_[6] = execute_SRC1[25];
    _zz_206_[7] = execute_SRC1[24];
    _zz_206_[8] = execute_SRC1[23];
    _zz_206_[9] = execute_SRC1[22];
    _zz_206_[10] = execute_SRC1[21];
    _zz_206_[11] = execute_SRC1[20];
    _zz_206_[12] = execute_SRC1[19];
    _zz_206_[13] = execute_SRC1[18];
    _zz_206_[14] = execute_SRC1[17];
    _zz_206_[15] = execute_SRC1[16];
    _zz_206_[16] = execute_SRC1[15];
    _zz_206_[17] = execute_SRC1[14];
    _zz_206_[18] = execute_SRC1[13];
    _zz_206_[19] = execute_SRC1[12];
    _zz_206_[20] = execute_SRC1[11];
    _zz_206_[21] = execute_SRC1[10];
    _zz_206_[22] = execute_SRC1[9];
    _zz_206_[23] = execute_SRC1[8];
    _zz_206_[24] = execute_SRC1[7];
    _zz_206_[25] = execute_SRC1[6];
    _zz_206_[26] = execute_SRC1[5];
    _zz_206_[27] = execute_SRC1[4];
    _zz_206_[28] = execute_SRC1[3];
    _zz_206_[29] = execute_SRC1[2];
    _zz_206_[30] = execute_SRC1[1];
    _zz_206_[31] = execute_SRC1[0];
  end

  assign execute_FullBarrelShifterPlugin_reversed = ((execute_SHIFT_CTRL == `ShiftCtrlEnum_defaultEncoding_SLL_1) ? _zz_206_ : execute_SRC1);
  assign _zz_46_ = _zz_428_;
  always @ (*) begin
    _zz_207_[0] = memory_SHIFT_RIGHT[31];
    _zz_207_[1] = memory_SHIFT_RIGHT[30];
    _zz_207_[2] = memory_SHIFT_RIGHT[29];
    _zz_207_[3] = memory_SHIFT_RIGHT[28];
    _zz_207_[4] = memory_SHIFT_RIGHT[27];
    _zz_207_[5] = memory_SHIFT_RIGHT[26];
    _zz_207_[6] = memory_SHIFT_RIGHT[25];
    _zz_207_[7] = memory_SHIFT_RIGHT[24];
    _zz_207_[8] = memory_SHIFT_RIGHT[23];
    _zz_207_[9] = memory_SHIFT_RIGHT[22];
    _zz_207_[10] = memory_SHIFT_RIGHT[21];
    _zz_207_[11] = memory_SHIFT_RIGHT[20];
    _zz_207_[12] = memory_SHIFT_RIGHT[19];
    _zz_207_[13] = memory_SHIFT_RIGHT[18];
    _zz_207_[14] = memory_SHIFT_RIGHT[17];
    _zz_207_[15] = memory_SHIFT_RIGHT[16];
    _zz_207_[16] = memory_SHIFT_RIGHT[15];
    _zz_207_[17] = memory_SHIFT_RIGHT[14];
    _zz_207_[18] = memory_SHIFT_RIGHT[13];
    _zz_207_[19] = memory_SHIFT_RIGHT[12];
    _zz_207_[20] = memory_SHIFT_RIGHT[11];
    _zz_207_[21] = memory_SHIFT_RIGHT[10];
    _zz_207_[22] = memory_SHIFT_RIGHT[9];
    _zz_207_[23] = memory_SHIFT_RIGHT[8];
    _zz_207_[24] = memory_SHIFT_RIGHT[7];
    _zz_207_[25] = memory_SHIFT_RIGHT[6];
    _zz_207_[26] = memory_SHIFT_RIGHT[5];
    _zz_207_[27] = memory_SHIFT_RIGHT[4];
    _zz_207_[28] = memory_SHIFT_RIGHT[3];
    _zz_207_[29] = memory_SHIFT_RIGHT[2];
    _zz_207_[30] = memory_SHIFT_RIGHT[1];
    _zz_207_[31] = memory_SHIFT_RIGHT[0];
  end

  always @ (*) begin
    _zz_208_ = 1'b0;
    if(_zz_336_)begin
      if(_zz_337_)begin
        if(_zz_214_)begin
          _zz_208_ = 1'b1;
        end
      end
    end
    if(_zz_338_)begin
      if(_zz_339_)begin
        if(_zz_216_)begin
          _zz_208_ = 1'b1;
        end
      end
    end
    if(_zz_340_)begin
      if(_zz_341_)begin
        if(_zz_218_)begin
          _zz_208_ = 1'b1;
        end
      end
    end
    if((! decode_RS1_USE))begin
      _zz_208_ = 1'b0;
    end
  end

  always @ (*) begin
    _zz_209_ = 1'b0;
    if(_zz_336_)begin
      if(_zz_337_)begin
        if(_zz_215_)begin
          _zz_209_ = 1'b1;
        end
      end
    end
    if(_zz_338_)begin
      if(_zz_339_)begin
        if(_zz_217_)begin
          _zz_209_ = 1'b1;
        end
      end
    end
    if(_zz_340_)begin
      if(_zz_341_)begin
        if(_zz_219_)begin
          _zz_209_ = 1'b1;
        end
      end
    end
    if((! decode_RS2_USE))begin
      _zz_209_ = 1'b0;
    end
  end

  assign _zz_210_ = (_zz_61_ && writeBack_arbitration_isFiring);
  assign _zz_214_ = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_215_ = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_216_ = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_217_ = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_218_ = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_219_ = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign execute_MulPlugin_a = execute_SRC1;
  assign execute_MulPlugin_b = execute_SRC2;
  always @ (*) begin
    case(_zz_342_)
      2'b01 : begin
        execute_MulPlugin_aSigned = 1'b1;
      end
      2'b10 : begin
        execute_MulPlugin_aSigned = 1'b1;
      end
      default : begin
        execute_MulPlugin_aSigned = 1'b0;
      end
    endcase
  end

  always @ (*) begin
    case(_zz_342_)
      2'b01 : begin
        execute_MulPlugin_bSigned = 1'b1;
      end
      2'b10 : begin
        execute_MulPlugin_bSigned = 1'b0;
      end
      default : begin
        execute_MulPlugin_bSigned = 1'b0;
      end
    endcase
  end

  assign execute_MulPlugin_aULow = execute_MulPlugin_a[15 : 0];
  assign execute_MulPlugin_bULow = execute_MulPlugin_b[15 : 0];
  assign execute_MulPlugin_aSLow = {1'b0,execute_MulPlugin_a[15 : 0]};
  assign execute_MulPlugin_bSLow = {1'b0,execute_MulPlugin_b[15 : 0]};
  assign execute_MulPlugin_aHigh = {(execute_MulPlugin_aSigned && execute_MulPlugin_a[31]),execute_MulPlugin_a[31 : 16]};
  assign execute_MulPlugin_bHigh = {(execute_MulPlugin_bSigned && execute_MulPlugin_b[31]),execute_MulPlugin_b[31 : 16]};
  assign _zz_42_ = (execute_MulPlugin_aULow * execute_MulPlugin_bULow);
  assign _zz_41_ = ($signed(execute_MulPlugin_aSLow) * $signed(execute_MulPlugin_bHigh));
  assign _zz_40_ = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bSLow));
  assign _zz_39_ = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bHigh));
  assign _zz_38_ = ($signed(_zz_430_) + $signed(_zz_438_));
  assign writeBack_MulPlugin_result = ($signed(_zz_439_) + $signed(_zz_440_));
  always @ (*) begin
    memory_DivPlugin_div_counter_willIncrement = 1'b0;
    if(_zz_319_)begin
      if(_zz_326_)begin
        memory_DivPlugin_div_counter_willIncrement = 1'b1;
      end
    end
  end

  always @ (*) begin
    memory_DivPlugin_div_counter_willClear = 1'b0;
    if(_zz_343_)begin
      memory_DivPlugin_div_counter_willClear = 1'b1;
    end
  end

  assign memory_DivPlugin_div_counter_willOverflowIfInc = (memory_DivPlugin_div_counter_value == (6'b100001));
  assign memory_DivPlugin_div_counter_willOverflow = (memory_DivPlugin_div_counter_willOverflowIfInc && memory_DivPlugin_div_counter_willIncrement);
  always @ (*) begin
    if(memory_DivPlugin_div_counter_willOverflow)begin
      memory_DivPlugin_div_counter_valueNext = (6'b000000);
    end else begin
      memory_DivPlugin_div_counter_valueNext = (memory_DivPlugin_div_counter_value + _zz_444_);
    end
    if(memory_DivPlugin_div_counter_willClear)begin
      memory_DivPlugin_div_counter_valueNext = (6'b000000);
    end
  end

  assign _zz_220_ = memory_DivPlugin_rs1[31 : 0];
  assign _zz_221_ = {memory_DivPlugin_accumulator[31 : 0],_zz_220_[31]};
  assign _zz_222_ = (_zz_221_ - _zz_445_);
  assign _zz_223_ = (memory_INSTRUCTION[13] ? memory_DivPlugin_accumulator[31 : 0] : memory_DivPlugin_rs1[31 : 0]);
  assign _zz_224_ = (execute_RS2[31] && execute_IS_RS2_SIGNED);
  assign _zz_225_ = (1'b0 || ((execute_IS_DIV && execute_RS1[31]) && execute_IS_RS1_SIGNED));
  always @ (*) begin
    _zz_226_[32] = (execute_IS_RS1_SIGNED && execute_RS1[31]);
    _zz_226_[31 : 0] = execute_RS1;
  end

  always @ (*) begin
    CsrPlugin_privilege = _zz_227_;
    if(CsrPlugin_forceMachineWire)begin
      CsrPlugin_privilege = (2'b11);
    end
  end

  assign CsrPlugin_misa_base = (2'b01);
  assign CsrPlugin_misa_extensions = (26'b00000000000000000000000000);
  assign CsrPlugin_sip_SEIP_OR = (CsrPlugin_sip_SEIP_SOFT || CsrPlugin_sip_SEIP_INPUT);
  assign _zz_228_ = (CsrPlugin_sip_STIP && CsrPlugin_sie_STIE);
  assign _zz_229_ = (CsrPlugin_sip_SSIP && CsrPlugin_sie_SSIE);
  assign _zz_230_ = (CsrPlugin_sip_SEIP_OR && CsrPlugin_sie_SEIE);
  assign _zz_231_ = (CsrPlugin_mip_MTIP && CsrPlugin_mie_MTIE);
  assign _zz_232_ = (CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE);
  assign _zz_233_ = (CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE);
  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = (2'b11);
    case(CsrPlugin_exceptionPortCtrl_exceptionContext_code)
      4'b1000 : begin
        if(((1'b1 && CsrPlugin_medeleg_EU) && (! 1'b0)))begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = (2'b01);
        end
      end
      4'b0010 : begin
        if(((1'b1 && CsrPlugin_medeleg_II) && (! 1'b0)))begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = (2'b01);
        end
      end
      4'b0101 : begin
        if(((1'b1 && CsrPlugin_medeleg_LAF) && (! 1'b0)))begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = (2'b01);
        end
      end
      4'b1101 : begin
        if(((1'b1 && CsrPlugin_medeleg_LPF) && (! 1'b0)))begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = (2'b01);
        end
      end
      4'b0100 : begin
        if(((1'b1 && CsrPlugin_medeleg_LAM) && (! 1'b0)))begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = (2'b01);
        end
      end
      4'b0111 : begin
        if(((1'b1 && CsrPlugin_medeleg_SAF) && (! 1'b0)))begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = (2'b01);
        end
      end
      4'b0001 : begin
        if(((1'b1 && CsrPlugin_medeleg_IAF) && (! 1'b0)))begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = (2'b01);
        end
      end
      4'b1001 : begin
        if(((1'b1 && CsrPlugin_medeleg_ES) && (! 1'b0)))begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = (2'b01);
        end
      end
      4'b1100 : begin
        if(((1'b1 && CsrPlugin_medeleg_IPF) && (! 1'b0)))begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = (2'b01);
        end
      end
      4'b1111 : begin
        if(((1'b1 && CsrPlugin_medeleg_SPF) && (! 1'b0)))begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = (2'b01);
        end
      end
      4'b0110 : begin
        if(((1'b1 && CsrPlugin_medeleg_SAM) && (! 1'b0)))begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = (2'b01);
        end
      end
      4'b0000 : begin
        if(((1'b1 && CsrPlugin_medeleg_IAM) && (! 1'b0)))begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = (2'b01);
        end
      end
      default : begin
      end
    endcase
  end

  assign CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege = ((CsrPlugin_privilege < CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped) ? CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped : CsrPlugin_privilege);
  assign _zz_234_ = {decodeExceptionPort_valid,IBusCachedPlugin_decodeExceptionPort_valid};
  assign _zz_235_ = _zz_458_[0];
  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_decode = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
    if(_zz_324_)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_decode = 1'b1;
    end
    if(decode_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_decode = 1'b0;
    end
  end

  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_execute = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
    if(CsrPlugin_selfException_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b1;
    end
    if(execute_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b0;
    end
  end

  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_memory = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
    if(memory_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b0;
    end
  end

  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
    if(DBusCachedPlugin_exceptionBus_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b1;
    end
    if(writeBack_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b0;
    end
  end

  assign CsrPlugin_exceptionPendings_0 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  assign CsrPlugin_exceptionPendings_1 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  assign CsrPlugin_exceptionPendings_2 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  assign CsrPlugin_exceptionPendings_3 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  assign CsrPlugin_exception = (CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack && CsrPlugin_allowException);
  always @ (*) begin
    CsrPlugin_pipelineLiberator_done = ((! ({writeBack_arbitration_isValid,{memory_arbitration_isValid,execute_arbitration_isValid}} != (3'b000))) && IBusCachedPlugin_pcValids_3);
    if(({CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory,CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute}} != (3'b000)))begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
    if(CsrPlugin_hadException)begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
  end

  assign CsrPlugin_interruptJump = ((CsrPlugin_interrupt_valid && CsrPlugin_pipelineLiberator_done) && CsrPlugin_allowInterrupts);
  always @ (*) begin
    CsrPlugin_targetPrivilege = CsrPlugin_interrupt_targetPrivilege;
    if(CsrPlugin_hadException)begin
      CsrPlugin_targetPrivilege = CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
    end
  end

  always @ (*) begin
    CsrPlugin_trapCause = CsrPlugin_interrupt_code;
    if(CsrPlugin_hadException)begin
      CsrPlugin_trapCause = CsrPlugin_exceptionPortCtrl_exceptionContext_code;
    end
  end

  always @ (*) begin
    CsrPlugin_xtvec_mode = (2'bxx);
    case(CsrPlugin_targetPrivilege)
      2'b01 : begin
        CsrPlugin_xtvec_mode = CsrPlugin_stvec_mode;
      end
      2'b11 : begin
        CsrPlugin_xtvec_mode = CsrPlugin_mtvec_mode;
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    CsrPlugin_xtvec_base = (30'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    case(CsrPlugin_targetPrivilege)
      2'b01 : begin
        CsrPlugin_xtvec_base = CsrPlugin_stvec_base;
      end
      2'b11 : begin
        CsrPlugin_xtvec_base = CsrPlugin_mtvec_base;
      end
      default : begin
      end
    endcase
  end

  assign contextSwitching = CsrPlugin_jumpInterface_valid;
  assign _zz_36_ = (! (((decode_INSTRUCTION[14 : 13] == (2'b01)) && (decode_INSTRUCTION[19 : 15] == (5'b00000))) || ((decode_INSTRUCTION[14 : 13] == (2'b11)) && (decode_INSTRUCTION[19 : 15] == (5'b00000)))));
  assign _zz_35_ = (decode_INSTRUCTION[13 : 7] != (7'b0100000));
  always @ (*) begin
    execute_CsrPlugin_inWfi = 1'b0;
    if(_zz_325_)begin
      execute_CsrPlugin_inWfi = 1'b1;
    end
  end

  assign execute_CsrPlugin_blockedBySideEffects = ({writeBack_arbitration_isValid,memory_arbitration_isValid} != (2'b00));
  always @ (*) begin
    execute_CsrPlugin_illegalAccess = 1'b1;
    case(execute_CsrPlugin_csrAddress)
      12'b101111000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b001100000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b001100000011 : begin
        if(execute_CSR_WRITE_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b111100010001 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b000101000010 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b111100010100 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b100111000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b000100000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b001100000010 : begin
        if(execute_CSR_WRITE_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b001101000001 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b001101000100 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b001100000101 : begin
        if(execute_CSR_WRITE_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b000110000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b110011000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b000101000001 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b111100010011 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b000101000100 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b001101000011 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b000100000101 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b111111000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b001101000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b001100000100 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b111100010010 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b000101000011 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b110111000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b000101000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b001101000010 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b000100000100 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      default : begin
      end
    endcase
    if((CsrPlugin_privilege < execute_CsrPlugin_csrAddress[9 : 8]))begin
      execute_CsrPlugin_illegalAccess = 1'b1;
    end
    if(((! execute_arbitration_isValid) || (! execute_IS_CSR)))begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
  end

  always @ (*) begin
    execute_CsrPlugin_illegalInstruction = 1'b0;
    if((execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET)))begin
      if((CsrPlugin_privilege < execute_INSTRUCTION[29 : 28]))begin
        execute_CsrPlugin_illegalInstruction = 1'b1;
      end
    end
  end

  always @ (*) begin
    CsrPlugin_selfException_valid = 1'b0;
    if(_zz_344_)begin
      CsrPlugin_selfException_valid = 1'b1;
    end
    if(_zz_345_)begin
      CsrPlugin_selfException_valid = 1'b1;
    end
    if(_zz_346_)begin
      CsrPlugin_selfException_valid = 1'b1;
    end
  end

  always @ (*) begin
    CsrPlugin_selfException_payload_code = (4'bxxxx);
    if(_zz_344_)begin
      CsrPlugin_selfException_payload_code = (4'b0010);
    end
    if(_zz_345_)begin
      case(CsrPlugin_privilege)
        2'b00 : begin
          CsrPlugin_selfException_payload_code = (4'b1000);
        end
        2'b01 : begin
          CsrPlugin_selfException_payload_code = (4'b1001);
        end
        default : begin
          CsrPlugin_selfException_payload_code = (4'b1011);
        end
      endcase
    end
    if(_zz_346_)begin
      CsrPlugin_selfException_payload_code = (4'b0011);
    end
  end

  assign CsrPlugin_selfException_payload_badAddr = execute_INSTRUCTION;
  always @ (*) begin
    execute_CsrPlugin_readData = (32'b00000000000000000000000000000000);
    case(execute_CsrPlugin_csrAddress)
      12'b101111000000 : begin
        execute_CsrPlugin_readData[31 : 0] = _zz_251_;
      end
      12'b001100000000 : begin
        execute_CsrPlugin_readData[12 : 11] = CsrPlugin_mstatus_MPP;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mstatus_MPIE;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mstatus_MIE;
        execute_CsrPlugin_readData[8 : 8] = CsrPlugin_sstatus_SPP;
        execute_CsrPlugin_readData[5 : 5] = CsrPlugin_sstatus_SPIE;
        execute_CsrPlugin_readData[1 : 1] = CsrPlugin_sstatus_SIE;
        execute_CsrPlugin_readData[19 : 19] = MmuPlugin_status_mxr;
        execute_CsrPlugin_readData[18 : 18] = MmuPlugin_status_sum;
        execute_CsrPlugin_readData[17 : 17] = MmuPlugin_status_mprv;
      end
      12'b001100000011 : begin
      end
      12'b111100010001 : begin
        execute_CsrPlugin_readData[0 : 0] = (1'b1);
      end
      12'b000101000010 : begin
        execute_CsrPlugin_readData[31 : 31] = CsrPlugin_scause_interrupt;
        execute_CsrPlugin_readData[3 : 0] = CsrPlugin_scause_exceptionCode;
      end
      12'b111100010100 : begin
      end
      12'b100111000000 : begin
        execute_CsrPlugin_readData[31 : 0] = _zz_253_;
      end
      12'b000100000000 : begin
        execute_CsrPlugin_readData[8 : 8] = CsrPlugin_sstatus_SPP;
        execute_CsrPlugin_readData[5 : 5] = CsrPlugin_sstatus_SPIE;
        execute_CsrPlugin_readData[1 : 1] = CsrPlugin_sstatus_SIE;
        execute_CsrPlugin_readData[19 : 19] = MmuPlugin_status_mxr;
        execute_CsrPlugin_readData[18 : 18] = MmuPlugin_status_sum;
        execute_CsrPlugin_readData[17 : 17] = MmuPlugin_status_mprv;
      end
      12'b001100000010 : begin
      end
      12'b001101000001 : begin
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mepc;
      end
      12'b001101000100 : begin
        execute_CsrPlugin_readData[11 : 11] = CsrPlugin_mip_MEIP;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mip_MTIP;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mip_MSIP;
        execute_CsrPlugin_readData[5 : 5] = CsrPlugin_sip_STIP;
        execute_CsrPlugin_readData[1 : 1] = CsrPlugin_sip_SSIP;
        execute_CsrPlugin_readData[9 : 9] = CsrPlugin_sip_SEIP_OR;
      end
      12'b001100000101 : begin
      end
      12'b000110000000 : begin
        execute_CsrPlugin_readData[31 : 31] = MmuPlugin_satp_mode;
        execute_CsrPlugin_readData[30 : 22] = MmuPlugin_satp_asid;
        execute_CsrPlugin_readData[19 : 0] = MmuPlugin_satp_ppn;
      end
      12'b110011000000 : begin
        execute_CsrPlugin_readData[12 : 0] = (13'b1000000000000);
        execute_CsrPlugin_readData[25 : 20] = (6'b100000);
      end
      12'b000101000001 : begin
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_sepc;
      end
      12'b111100010011 : begin
        execute_CsrPlugin_readData[1 : 0] = (2'b11);
      end
      12'b000101000100 : begin
        execute_CsrPlugin_readData[5 : 5] = CsrPlugin_sip_STIP;
        execute_CsrPlugin_readData[1 : 1] = CsrPlugin_sip_SSIP;
        execute_CsrPlugin_readData[9 : 9] = CsrPlugin_sip_SEIP_OR;
      end
      12'b001101000011 : begin
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mtval;
      end
      12'b000100000101 : begin
        execute_CsrPlugin_readData[31 : 2] = CsrPlugin_stvec_base;
        execute_CsrPlugin_readData[1 : 0] = CsrPlugin_stvec_mode;
      end
      12'b111111000000 : begin
        execute_CsrPlugin_readData[31 : 0] = _zz_252_;
      end
      12'b001101000000 : begin
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mscratch;
      end
      12'b001100000100 : begin
        execute_CsrPlugin_readData[11 : 11] = CsrPlugin_mie_MEIE;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mie_MTIE;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mie_MSIE;
        execute_CsrPlugin_readData[9 : 9] = CsrPlugin_sie_SEIE;
        execute_CsrPlugin_readData[5 : 5] = CsrPlugin_sie_STIE;
        execute_CsrPlugin_readData[1 : 1] = CsrPlugin_sie_SSIE;
      end
      12'b111100010010 : begin
        execute_CsrPlugin_readData[1 : 0] = (2'b10);
      end
      12'b000101000011 : begin
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_stval;
      end
      12'b110111000000 : begin
        execute_CsrPlugin_readData[31 : 0] = _zz_254_;
      end
      12'b000101000000 : begin
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_sscratch;
      end
      12'b001101000010 : begin
        execute_CsrPlugin_readData[31 : 31] = CsrPlugin_mcause_interrupt;
        execute_CsrPlugin_readData[3 : 0] = CsrPlugin_mcause_exceptionCode;
      end
      12'b000100000100 : begin
        execute_CsrPlugin_readData[9 : 9] = CsrPlugin_sie_SEIE;
        execute_CsrPlugin_readData[5 : 5] = CsrPlugin_sie_STIE;
        execute_CsrPlugin_readData[1 : 1] = CsrPlugin_sie_SSIE;
      end
      default : begin
      end
    endcase
  end

  assign execute_CsrPlugin_writeInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_WRITE_OPCODE);
  assign execute_CsrPlugin_readInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_READ_OPCODE);
  assign execute_CsrPlugin_writeEnable = ((execute_CsrPlugin_writeInstruction && (! execute_CsrPlugin_blockedBySideEffects)) && (! execute_arbitration_isStuckByOthers));
  assign execute_CsrPlugin_readEnable = ((execute_CsrPlugin_readInstruction && (! execute_CsrPlugin_blockedBySideEffects)) && (! execute_arbitration_isStuckByOthers));
  always @ (*) begin
    execute_CsrPlugin_readToWriteData = execute_CsrPlugin_readData;
    case(execute_CsrPlugin_csrAddress)
      12'b001101000100 : begin
        execute_CsrPlugin_readToWriteData[9 : 9] = CsrPlugin_sip_SEIP_SOFT;
      end
      12'b000101000100 : begin
        execute_CsrPlugin_readToWriteData[9 : 9] = CsrPlugin_sip_SEIP_SOFT;
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    case(_zz_378_)
      1'b0 : begin
        execute_CsrPlugin_writeData = execute_SRC1;
      end
      default : begin
        execute_CsrPlugin_writeData = (execute_INSTRUCTION[12] ? (execute_CsrPlugin_readToWriteData & (~ execute_SRC1)) : (execute_CsrPlugin_readToWriteData | execute_SRC1));
      end
    endcase
  end

  assign _zz_32_ = execute_CsrPlugin_readData;
  assign execute_CsrPlugin_csrAddress = execute_INSTRUCTION[31 : 20];
  assign _zz_31_ = IBusCachedPlugin_decodePrediction_cmd_hadBranch;
  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign _zz_236_ = execute_INSTRUCTION[14 : 12];
  always @ (*) begin
    if((_zz_236_ == (3'b000))) begin
        _zz_237_ = execute_BranchPlugin_eq;
    end else if((_zz_236_ == (3'b001))) begin
        _zz_237_ = (! execute_BranchPlugin_eq);
    end else if((((_zz_236_ & (3'b101)) == (3'b101)))) begin
        _zz_237_ = (! execute_SRC_LESS);
    end else begin
        _zz_237_ = execute_SRC_LESS;
    end
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : begin
        _zz_238_ = 1'b0;
      end
      `BranchCtrlEnum_defaultEncoding_JAL : begin
        _zz_238_ = 1'b1;
      end
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        _zz_238_ = 1'b1;
      end
      default : begin
        _zz_238_ = _zz_237_;
      end
    endcase
  end

  assign _zz_30_ = _zz_238_;
  assign execute_BranchPlugin_missAlignedTarget = 1'b0;
  assign _zz_28_ = ((execute_PREDICTION_HAD_BRANCHED2 != execute_BRANCH_COND_RESULT) || execute_BranchPlugin_missAlignedTarget);
  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        execute_BranchPlugin_branch_src1 = execute_RS1;
      end
      default : begin
        execute_BranchPlugin_branch_src1 = execute_PC;
      end
    endcase
  end

  assign _zz_239_ = _zz_460_[11];
  always @ (*) begin
    _zz_240_[19] = _zz_239_;
    _zz_240_[18] = _zz_239_;
    _zz_240_[17] = _zz_239_;
    _zz_240_[16] = _zz_239_;
    _zz_240_[15] = _zz_239_;
    _zz_240_[14] = _zz_239_;
    _zz_240_[13] = _zz_239_;
    _zz_240_[12] = _zz_239_;
    _zz_240_[11] = _zz_239_;
    _zz_240_[10] = _zz_239_;
    _zz_240_[9] = _zz_239_;
    _zz_240_[8] = _zz_239_;
    _zz_240_[7] = _zz_239_;
    _zz_240_[6] = _zz_239_;
    _zz_240_[5] = _zz_239_;
    _zz_240_[4] = _zz_239_;
    _zz_240_[3] = _zz_239_;
    _zz_240_[2] = _zz_239_;
    _zz_240_[1] = _zz_239_;
    _zz_240_[0] = _zz_239_;
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        execute_BranchPlugin_branch_src2 = {_zz_240_,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        execute_BranchPlugin_branch_src2 = ((execute_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_JAL) ? {{_zz_242_,{{{_zz_766_,execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0} : {{_zz_244_,{{{_zz_767_,_zz_768_},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0});
        if(execute_PREDICTION_HAD_BRANCHED2)begin
          execute_BranchPlugin_branch_src2 = {29'd0, _zz_463_};
        end
      end
    endcase
  end

  assign _zz_241_ = _zz_461_[19];
  always @ (*) begin
    _zz_242_[10] = _zz_241_;
    _zz_242_[9] = _zz_241_;
    _zz_242_[8] = _zz_241_;
    _zz_242_[7] = _zz_241_;
    _zz_242_[6] = _zz_241_;
    _zz_242_[5] = _zz_241_;
    _zz_242_[4] = _zz_241_;
    _zz_242_[3] = _zz_241_;
    _zz_242_[2] = _zz_241_;
    _zz_242_[1] = _zz_241_;
    _zz_242_[0] = _zz_241_;
  end

  assign _zz_243_ = _zz_462_[11];
  always @ (*) begin
    _zz_244_[18] = _zz_243_;
    _zz_244_[17] = _zz_243_;
    _zz_244_[16] = _zz_243_;
    _zz_244_[15] = _zz_243_;
    _zz_244_[14] = _zz_243_;
    _zz_244_[13] = _zz_243_;
    _zz_244_[12] = _zz_243_;
    _zz_244_[11] = _zz_243_;
    _zz_244_[10] = _zz_243_;
    _zz_244_[9] = _zz_243_;
    _zz_244_[8] = _zz_243_;
    _zz_244_[7] = _zz_243_;
    _zz_244_[6] = _zz_243_;
    _zz_244_[5] = _zz_243_;
    _zz_244_[4] = _zz_243_;
    _zz_244_[3] = _zz_243_;
    _zz_244_[2] = _zz_243_;
    _zz_244_[1] = _zz_243_;
    _zz_244_[0] = _zz_243_;
  end

  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign _zz_27_ = {execute_BranchPlugin_branchAdder[31 : 1],(1'b0)};
  assign BranchPlugin_jumpInterface_valid = ((memory_arbitration_isValid && memory_BRANCH_DO) && (! 1'b0));
  assign BranchPlugin_jumpInterface_payload = memory_BRANCH_CALC;
  assign IBusCachedPlugin_decodePrediction_rsp_wasWrong = BranchPlugin_jumpInterface_valid;
  assign MmuPlugin_ports_0_cacheHits_0 = ((MmuPlugin_ports_0_cache_0_valid && (MmuPlugin_ports_0_cache_0_virtualAddress_1 == DBusCachedPlugin_mmuBus_cmd_virtualAddress[31 : 22])) && (MmuPlugin_ports_0_cache_0_superPage || (MmuPlugin_ports_0_cache_0_virtualAddress_0 == DBusCachedPlugin_mmuBus_cmd_virtualAddress[21 : 12])));
  assign MmuPlugin_ports_0_cacheHits_1 = ((MmuPlugin_ports_0_cache_1_valid && (MmuPlugin_ports_0_cache_1_virtualAddress_1 == DBusCachedPlugin_mmuBus_cmd_virtualAddress[31 : 22])) && (MmuPlugin_ports_0_cache_1_superPage || (MmuPlugin_ports_0_cache_1_virtualAddress_0 == DBusCachedPlugin_mmuBus_cmd_virtualAddress[21 : 12])));
  assign MmuPlugin_ports_0_cacheHits_2 = ((MmuPlugin_ports_0_cache_2_valid && (MmuPlugin_ports_0_cache_2_virtualAddress_1 == DBusCachedPlugin_mmuBus_cmd_virtualAddress[31 : 22])) && (MmuPlugin_ports_0_cache_2_superPage || (MmuPlugin_ports_0_cache_2_virtualAddress_0 == DBusCachedPlugin_mmuBus_cmd_virtualAddress[21 : 12])));
  assign MmuPlugin_ports_0_cacheHits_3 = ((MmuPlugin_ports_0_cache_3_valid && (MmuPlugin_ports_0_cache_3_virtualAddress_1 == DBusCachedPlugin_mmuBus_cmd_virtualAddress[31 : 22])) && (MmuPlugin_ports_0_cache_3_superPage || (MmuPlugin_ports_0_cache_3_virtualAddress_0 == DBusCachedPlugin_mmuBus_cmd_virtualAddress[21 : 12])));
  assign MmuPlugin_ports_0_cacheHit = ({MmuPlugin_ports_0_cacheHits_3,{MmuPlugin_ports_0_cacheHits_2,{MmuPlugin_ports_0_cacheHits_1,MmuPlugin_ports_0_cacheHits_0}}} != (4'b0000));
  assign _zz_245_ = (MmuPlugin_ports_0_cacheHits_1 || MmuPlugin_ports_0_cacheHits_3);
  assign _zz_246_ = (MmuPlugin_ports_0_cacheHits_2 || MmuPlugin_ports_0_cacheHits_3);
  assign _zz_247_ = {_zz_246_,_zz_245_};
  assign MmuPlugin_ports_0_cacheLine_valid = _zz_293_;
  assign MmuPlugin_ports_0_cacheLine_exception = _zz_294_;
  assign MmuPlugin_ports_0_cacheLine_superPage = _zz_295_;
  assign MmuPlugin_ports_0_cacheLine_virtualAddress_0 = _zz_296_;
  assign MmuPlugin_ports_0_cacheLine_virtualAddress_1 = _zz_297_;
  assign MmuPlugin_ports_0_cacheLine_physicalAddress_0 = _zz_298_;
  assign MmuPlugin_ports_0_cacheLine_physicalAddress_1 = _zz_299_;
  assign MmuPlugin_ports_0_cacheLine_allowRead = _zz_300_;
  assign MmuPlugin_ports_0_cacheLine_allowWrite = _zz_301_;
  assign MmuPlugin_ports_0_cacheLine_allowExecute = _zz_302_;
  assign MmuPlugin_ports_0_cacheLine_allowUser = _zz_303_;
  always @ (*) begin
    MmuPlugin_ports_0_entryToReplace_willIncrement = 1'b0;
    if(_zz_347_)begin
      if(_zz_348_)begin
        MmuPlugin_ports_0_entryToReplace_willIncrement = 1'b1;
      end
    end
  end

  assign MmuPlugin_ports_0_entryToReplace_willClear = 1'b0;
  assign MmuPlugin_ports_0_entryToReplace_willOverflowIfInc = (MmuPlugin_ports_0_entryToReplace_value == (2'b11));
  assign MmuPlugin_ports_0_entryToReplace_willOverflow = (MmuPlugin_ports_0_entryToReplace_willOverflowIfInc && MmuPlugin_ports_0_entryToReplace_willIncrement);
  always @ (*) begin
    MmuPlugin_ports_0_entryToReplace_valueNext = (MmuPlugin_ports_0_entryToReplace_value + _zz_465_);
    if(MmuPlugin_ports_0_entryToReplace_willClear)begin
      MmuPlugin_ports_0_entryToReplace_valueNext = (2'b00);
    end
  end

  always @ (*) begin
    MmuPlugin_ports_0_requireMmuLockup = ((1'b1 && (! DBusCachedPlugin_mmuBus_cmd_bypassTranslation)) && MmuPlugin_satp_mode);
    if(((! MmuPlugin_status_mprv) && (CsrPlugin_privilege == (2'b11))))begin
      MmuPlugin_ports_0_requireMmuLockup = 1'b0;
    end
    if((CsrPlugin_privilege == (2'b11)))begin
      if(((! MmuPlugin_status_mprv) || (CsrPlugin_mstatus_MPP == (2'b11))))begin
        MmuPlugin_ports_0_requireMmuLockup = 1'b0;
      end
    end
  end

  always @ (*) begin
    if(MmuPlugin_ports_0_requireMmuLockup)begin
      DBusCachedPlugin_mmuBus_rsp_physicalAddress = {{MmuPlugin_ports_0_cacheLine_physicalAddress_1,(MmuPlugin_ports_0_cacheLine_superPage ? DBusCachedPlugin_mmuBus_cmd_virtualAddress[21 : 12] : MmuPlugin_ports_0_cacheLine_physicalAddress_0)},DBusCachedPlugin_mmuBus_cmd_virtualAddress[11 : 0]};
    end else begin
      DBusCachedPlugin_mmuBus_rsp_physicalAddress = DBusCachedPlugin_mmuBus_cmd_virtualAddress;
    end
  end

  always @ (*) begin
    if(MmuPlugin_ports_0_requireMmuLockup)begin
      DBusCachedPlugin_mmuBus_rsp_allowRead = (MmuPlugin_ports_0_cacheLine_allowRead || (MmuPlugin_status_mxr && MmuPlugin_ports_0_cacheLine_allowExecute));
    end else begin
      DBusCachedPlugin_mmuBus_rsp_allowRead = 1'b1;
    end
  end

  always @ (*) begin
    if(MmuPlugin_ports_0_requireMmuLockup)begin
      DBusCachedPlugin_mmuBus_rsp_allowWrite = MmuPlugin_ports_0_cacheLine_allowWrite;
    end else begin
      DBusCachedPlugin_mmuBus_rsp_allowWrite = 1'b1;
    end
  end

  always @ (*) begin
    if(MmuPlugin_ports_0_requireMmuLockup)begin
      DBusCachedPlugin_mmuBus_rsp_allowExecute = MmuPlugin_ports_0_cacheLine_allowExecute;
    end else begin
      DBusCachedPlugin_mmuBus_rsp_allowExecute = 1'b1;
    end
  end

  always @ (*) begin
    if(MmuPlugin_ports_0_requireMmuLockup)begin
      DBusCachedPlugin_mmuBus_rsp_exception = (MmuPlugin_ports_0_cacheHit && ((MmuPlugin_ports_0_cacheLine_exception || ((MmuPlugin_ports_0_cacheLine_allowUser && (CsrPlugin_privilege == (2'b01))) && (! MmuPlugin_status_sum))) || ((! MmuPlugin_ports_0_cacheLine_allowUser) && (CsrPlugin_privilege == (2'b00)))));
    end else begin
      DBusCachedPlugin_mmuBus_rsp_exception = 1'b0;
    end
  end

  always @ (*) begin
    if(MmuPlugin_ports_0_requireMmuLockup)begin
      DBusCachedPlugin_mmuBus_rsp_refilling = (! MmuPlugin_ports_0_cacheHit);
    end else begin
      DBusCachedPlugin_mmuBus_rsp_refilling = 1'b0;
    end
  end

  assign DBusCachedPlugin_mmuBus_rsp_isIoAccess = (((DBusCachedPlugin_mmuBus_rsp_physicalAddress[31 : 28] == (4'b1011)) || (DBusCachedPlugin_mmuBus_rsp_physicalAddress[31 : 28] == (4'b1110))) || (DBusCachedPlugin_mmuBus_rsp_physicalAddress[31 : 28] == (4'b1111)));
  assign MmuPlugin_ports_1_cacheHits_0 = ((MmuPlugin_ports_1_cache_0_valid && (MmuPlugin_ports_1_cache_0_virtualAddress_1 == IBusCachedPlugin_mmuBus_cmd_virtualAddress[31 : 22])) && (MmuPlugin_ports_1_cache_0_superPage || (MmuPlugin_ports_1_cache_0_virtualAddress_0 == IBusCachedPlugin_mmuBus_cmd_virtualAddress[21 : 12])));
  assign MmuPlugin_ports_1_cacheHits_1 = ((MmuPlugin_ports_1_cache_1_valid && (MmuPlugin_ports_1_cache_1_virtualAddress_1 == IBusCachedPlugin_mmuBus_cmd_virtualAddress[31 : 22])) && (MmuPlugin_ports_1_cache_1_superPage || (MmuPlugin_ports_1_cache_1_virtualAddress_0 == IBusCachedPlugin_mmuBus_cmd_virtualAddress[21 : 12])));
  assign MmuPlugin_ports_1_cacheHits_2 = ((MmuPlugin_ports_1_cache_2_valid && (MmuPlugin_ports_1_cache_2_virtualAddress_1 == IBusCachedPlugin_mmuBus_cmd_virtualAddress[31 : 22])) && (MmuPlugin_ports_1_cache_2_superPage || (MmuPlugin_ports_1_cache_2_virtualAddress_0 == IBusCachedPlugin_mmuBus_cmd_virtualAddress[21 : 12])));
  assign MmuPlugin_ports_1_cacheHits_3 = ((MmuPlugin_ports_1_cache_3_valid && (MmuPlugin_ports_1_cache_3_virtualAddress_1 == IBusCachedPlugin_mmuBus_cmd_virtualAddress[31 : 22])) && (MmuPlugin_ports_1_cache_3_superPage || (MmuPlugin_ports_1_cache_3_virtualAddress_0 == IBusCachedPlugin_mmuBus_cmd_virtualAddress[21 : 12])));
  assign MmuPlugin_ports_1_cacheHit = ({MmuPlugin_ports_1_cacheHits_3,{MmuPlugin_ports_1_cacheHits_2,{MmuPlugin_ports_1_cacheHits_1,MmuPlugin_ports_1_cacheHits_0}}} != (4'b0000));
  assign _zz_248_ = (MmuPlugin_ports_1_cacheHits_1 || MmuPlugin_ports_1_cacheHits_3);
  assign _zz_249_ = (MmuPlugin_ports_1_cacheHits_2 || MmuPlugin_ports_1_cacheHits_3);
  assign _zz_250_ = {_zz_249_,_zz_248_};
  assign MmuPlugin_ports_1_cacheLine_valid = _zz_304_;
  assign MmuPlugin_ports_1_cacheLine_exception = _zz_305_;
  assign MmuPlugin_ports_1_cacheLine_superPage = _zz_306_;
  assign MmuPlugin_ports_1_cacheLine_virtualAddress_0 = _zz_307_;
  assign MmuPlugin_ports_1_cacheLine_virtualAddress_1 = _zz_308_;
  assign MmuPlugin_ports_1_cacheLine_physicalAddress_0 = _zz_309_;
  assign MmuPlugin_ports_1_cacheLine_physicalAddress_1 = _zz_310_;
  assign MmuPlugin_ports_1_cacheLine_allowRead = _zz_311_;
  assign MmuPlugin_ports_1_cacheLine_allowWrite = _zz_312_;
  assign MmuPlugin_ports_1_cacheLine_allowExecute = _zz_313_;
  assign MmuPlugin_ports_1_cacheLine_allowUser = _zz_314_;
  always @ (*) begin
    MmuPlugin_ports_1_entryToReplace_willIncrement = 1'b0;
    if(_zz_347_)begin
      if(_zz_349_)begin
        MmuPlugin_ports_1_entryToReplace_willIncrement = 1'b1;
      end
    end
  end

  assign MmuPlugin_ports_1_entryToReplace_willClear = 1'b0;
  assign MmuPlugin_ports_1_entryToReplace_willOverflowIfInc = (MmuPlugin_ports_1_entryToReplace_value == (2'b11));
  assign MmuPlugin_ports_1_entryToReplace_willOverflow = (MmuPlugin_ports_1_entryToReplace_willOverflowIfInc && MmuPlugin_ports_1_entryToReplace_willIncrement);
  always @ (*) begin
    MmuPlugin_ports_1_entryToReplace_valueNext = (MmuPlugin_ports_1_entryToReplace_value + _zz_467_);
    if(MmuPlugin_ports_1_entryToReplace_willClear)begin
      MmuPlugin_ports_1_entryToReplace_valueNext = (2'b00);
    end
  end

  always @ (*) begin
    MmuPlugin_ports_1_requireMmuLockup = ((1'b1 && (! IBusCachedPlugin_mmuBus_cmd_bypassTranslation)) && MmuPlugin_satp_mode);
    if(((! MmuPlugin_status_mprv) && (CsrPlugin_privilege == (2'b11))))begin
      MmuPlugin_ports_1_requireMmuLockup = 1'b0;
    end
    if((CsrPlugin_privilege == (2'b11)))begin
      MmuPlugin_ports_1_requireMmuLockup = 1'b0;
    end
  end

  always @ (*) begin
    if(MmuPlugin_ports_1_requireMmuLockup)begin
      IBusCachedPlugin_mmuBus_rsp_physicalAddress = {{MmuPlugin_ports_1_cacheLine_physicalAddress_1,(MmuPlugin_ports_1_cacheLine_superPage ? IBusCachedPlugin_mmuBus_cmd_virtualAddress[21 : 12] : MmuPlugin_ports_1_cacheLine_physicalAddress_0)},IBusCachedPlugin_mmuBus_cmd_virtualAddress[11 : 0]};
    end else begin
      IBusCachedPlugin_mmuBus_rsp_physicalAddress = IBusCachedPlugin_mmuBus_cmd_virtualAddress;
    end
  end

  always @ (*) begin
    if(MmuPlugin_ports_1_requireMmuLockup)begin
      IBusCachedPlugin_mmuBus_rsp_allowRead = (MmuPlugin_ports_1_cacheLine_allowRead || (MmuPlugin_status_mxr && MmuPlugin_ports_1_cacheLine_allowExecute));
    end else begin
      IBusCachedPlugin_mmuBus_rsp_allowRead = 1'b1;
    end
  end

  always @ (*) begin
    if(MmuPlugin_ports_1_requireMmuLockup)begin
      IBusCachedPlugin_mmuBus_rsp_allowWrite = MmuPlugin_ports_1_cacheLine_allowWrite;
    end else begin
      IBusCachedPlugin_mmuBus_rsp_allowWrite = 1'b1;
    end
  end

  always @ (*) begin
    if(MmuPlugin_ports_1_requireMmuLockup)begin
      IBusCachedPlugin_mmuBus_rsp_allowExecute = MmuPlugin_ports_1_cacheLine_allowExecute;
    end else begin
      IBusCachedPlugin_mmuBus_rsp_allowExecute = 1'b1;
    end
  end

  always @ (*) begin
    if(MmuPlugin_ports_1_requireMmuLockup)begin
      IBusCachedPlugin_mmuBus_rsp_exception = (MmuPlugin_ports_1_cacheHit && ((MmuPlugin_ports_1_cacheLine_exception || ((MmuPlugin_ports_1_cacheLine_allowUser && (CsrPlugin_privilege == (2'b01))) && (! MmuPlugin_status_sum))) || ((! MmuPlugin_ports_1_cacheLine_allowUser) && (CsrPlugin_privilege == (2'b00)))));
    end else begin
      IBusCachedPlugin_mmuBus_rsp_exception = 1'b0;
    end
  end

  always @ (*) begin
    if(MmuPlugin_ports_1_requireMmuLockup)begin
      IBusCachedPlugin_mmuBus_rsp_refilling = (! MmuPlugin_ports_1_cacheHit);
    end else begin
      IBusCachedPlugin_mmuBus_rsp_refilling = 1'b0;
    end
  end

  assign IBusCachedPlugin_mmuBus_rsp_isIoAccess = (((IBusCachedPlugin_mmuBus_rsp_physicalAddress[31 : 28] == (4'b1011)) || (IBusCachedPlugin_mmuBus_rsp_physicalAddress[31 : 28] == (4'b1110))) || (IBusCachedPlugin_mmuBus_rsp_physicalAddress[31 : 28] == (4'b1111)));
  assign MmuPlugin_shared_dBusRsp_pte_V = _zz_468_[0];
  assign MmuPlugin_shared_dBusRsp_pte_R = _zz_469_[0];
  assign MmuPlugin_shared_dBusRsp_pte_W = _zz_470_[0];
  assign MmuPlugin_shared_dBusRsp_pte_X = _zz_471_[0];
  assign MmuPlugin_shared_dBusRsp_pte_U = _zz_472_[0];
  assign MmuPlugin_shared_dBusRsp_pte_G = _zz_473_[0];
  assign MmuPlugin_shared_dBusRsp_pte_A = _zz_474_[0];
  assign MmuPlugin_shared_dBusRsp_pte_D = _zz_475_[0];
  assign MmuPlugin_shared_dBusRsp_pte_RSW = MmuPlugin_dBusAccess_rsp_payload_data[9 : 8];
  assign MmuPlugin_shared_dBusRsp_pte_PPN0 = MmuPlugin_dBusAccess_rsp_payload_data[19 : 10];
  assign MmuPlugin_shared_dBusRsp_pte_PPN1 = MmuPlugin_dBusAccess_rsp_payload_data[31 : 20];
  assign MmuPlugin_shared_dBusRsp_exception = (((! MmuPlugin_shared_dBusRsp_pte_V) || ((! MmuPlugin_shared_dBusRsp_pte_R) && MmuPlugin_shared_dBusRsp_pte_W)) || MmuPlugin_dBusAccess_rsp_payload_error);
  assign MmuPlugin_shared_dBusRsp_leaf = (MmuPlugin_shared_dBusRsp_pte_R || MmuPlugin_shared_dBusRsp_pte_X);
  always @ (*) begin
    MmuPlugin_dBusAccess_cmd_valid = 1'b0;
    case(MmuPlugin_shared_state_1_)
      `MmuPlugin_shared_State_defaultEncoding_IDLE : begin
      end
      `MmuPlugin_shared_State_defaultEncoding_L1_CMD : begin
        MmuPlugin_dBusAccess_cmd_valid = 1'b1;
      end
      `MmuPlugin_shared_State_defaultEncoding_L1_RSP : begin
      end
      `MmuPlugin_shared_State_defaultEncoding_L0_CMD : begin
        MmuPlugin_dBusAccess_cmd_valid = 1'b1;
      end
      default : begin
      end
    endcase
  end

  assign MmuPlugin_dBusAccess_cmd_payload_write = 1'b0;
  assign MmuPlugin_dBusAccess_cmd_payload_size = (2'b10);
  always @ (*) begin
    MmuPlugin_dBusAccess_cmd_payload_address = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    case(MmuPlugin_shared_state_1_)
      `MmuPlugin_shared_State_defaultEncoding_IDLE : begin
      end
      `MmuPlugin_shared_State_defaultEncoding_L1_CMD : begin
        MmuPlugin_dBusAccess_cmd_payload_address = {{MmuPlugin_satp_ppn,MmuPlugin_shared_vpn_1},(2'b00)};
      end
      `MmuPlugin_shared_State_defaultEncoding_L1_RSP : begin
      end
      `MmuPlugin_shared_State_defaultEncoding_L0_CMD : begin
        MmuPlugin_dBusAccess_cmd_payload_address = {{{MmuPlugin_shared_pteBuffer_PPN1[9 : 0],MmuPlugin_shared_pteBuffer_PPN0},MmuPlugin_shared_vpn_0},(2'b00)};
      end
      default : begin
      end
    endcase
  end

  assign MmuPlugin_dBusAccess_cmd_payload_data = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  assign MmuPlugin_dBusAccess_cmd_payload_writeMask = (4'bxxxx);
  assign DBusCachedPlugin_mmuBus_busy = ((MmuPlugin_shared_state_1_ != `MmuPlugin_shared_State_defaultEncoding_IDLE) && (MmuPlugin_shared_portId == (1'b1)));
  assign IBusCachedPlugin_mmuBus_busy = ((MmuPlugin_shared_state_1_ != `MmuPlugin_shared_State_defaultEncoding_IDLE) && (MmuPlugin_shared_portId == (1'b0)));
  assign _zz_252_ = (_zz_251_ & externalInterruptArray_regNext);
  assign externalInterrupt = (_zz_252_ != (32'b00000000000000000000000000000000));
  assign _zz_254_ = (_zz_253_ & externalInterruptArray_regNext);
  assign externalInterruptS = (_zz_254_ != (32'b00000000000000000000000000000000));
  assign _zz_26_ = decode_SRC2_CTRL;
  assign _zz_24_ = _zz_73_;
  assign _zz_52_ = decode_to_execute_SRC2_CTRL;
  assign _zz_23_ = decode_ALU_BITWISE_CTRL;
  assign _zz_21_ = _zz_91_;
  assign _zz_59_ = decode_to_execute_ALU_BITWISE_CTRL;
  assign _zz_20_ = decode_ALU_CTRL;
  assign _zz_18_ = _zz_88_;
  assign _zz_57_ = decode_to_execute_ALU_CTRL;
  assign _zz_17_ = decode_SHIFT_CTRL;
  assign _zz_14_ = execute_SHIFT_CTRL;
  assign _zz_15_ = _zz_75_;
  assign _zz_47_ = decode_to_execute_SHIFT_CTRL;
  assign _zz_45_ = execute_to_memory_SHIFT_CTRL;
  assign _zz_12_ = decode_BRANCH_CTRL;
  assign _zz_99_ = _zz_69_;
  assign _zz_29_ = decode_to_execute_BRANCH_CTRL;
  assign _zz_10_ = decode_ENV_CTRL;
  assign _zz_7_ = execute_ENV_CTRL;
  assign _zz_5_ = memory_ENV_CTRL;
  assign _zz_8_ = _zz_78_;
  assign _zz_34_ = decode_to_execute_ENV_CTRL;
  assign _zz_33_ = execute_to_memory_ENV_CTRL;
  assign _zz_37_ = memory_to_writeBack_ENV_CTRL;
  assign _zz_3_ = decode_SRC1_CTRL;
  assign _zz_1_ = _zz_72_;
  assign _zz_54_ = decode_to_execute_SRC1_CTRL;
  assign decode_arbitration_isFlushed = (({writeBack_arbitration_flushNext,{memory_arbitration_flushNext,execute_arbitration_flushNext}} != (3'b000)) || ({writeBack_arbitration_flushIt,{memory_arbitration_flushIt,{execute_arbitration_flushIt,decode_arbitration_flushIt}}} != (4'b0000)));
  assign execute_arbitration_isFlushed = (({writeBack_arbitration_flushNext,memory_arbitration_flushNext} != (2'b00)) || ({writeBack_arbitration_flushIt,{memory_arbitration_flushIt,execute_arbitration_flushIt}} != (3'b000)));
  assign memory_arbitration_isFlushed = ((writeBack_arbitration_flushNext != (1'b0)) || ({writeBack_arbitration_flushIt,memory_arbitration_flushIt} != (2'b00)));
  assign writeBack_arbitration_isFlushed = (1'b0 || (writeBack_arbitration_flushIt != (1'b0)));
  assign decode_arbitration_isStuckByOthers = (decode_arbitration_haltByOther || (((1'b0 || execute_arbitration_isStuck) || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign decode_arbitration_isStuck = (decode_arbitration_haltItself || decode_arbitration_isStuckByOthers);
  assign decode_arbitration_isMoving = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign decode_arbitration_isFiring = ((decode_arbitration_isValid && (! decode_arbitration_isStuck)) && (! decode_arbitration_removeIt));
  assign execute_arbitration_isStuckByOthers = (execute_arbitration_haltByOther || ((1'b0 || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign execute_arbitration_isStuck = (execute_arbitration_haltItself || execute_arbitration_isStuckByOthers);
  assign execute_arbitration_isMoving = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign execute_arbitration_isFiring = ((execute_arbitration_isValid && (! execute_arbitration_isStuck)) && (! execute_arbitration_removeIt));
  assign memory_arbitration_isStuckByOthers = (memory_arbitration_haltByOther || (1'b0 || writeBack_arbitration_isStuck));
  assign memory_arbitration_isStuck = (memory_arbitration_haltItself || memory_arbitration_isStuckByOthers);
  assign memory_arbitration_isMoving = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  assign memory_arbitration_isFiring = ((memory_arbitration_isValid && (! memory_arbitration_isStuck)) && (! memory_arbitration_removeIt));
  assign writeBack_arbitration_isStuckByOthers = (writeBack_arbitration_haltByOther || 1'b0);
  assign writeBack_arbitration_isStuck = (writeBack_arbitration_haltItself || writeBack_arbitration_isStuckByOthers);
  assign writeBack_arbitration_isMoving = ((! writeBack_arbitration_isStuck) && (! writeBack_arbitration_removeIt));
  assign writeBack_arbitration_isFiring = ((writeBack_arbitration_isValid && (! writeBack_arbitration_isStuck)) && (! writeBack_arbitration_removeIt));
  assign iBusWishbone_ADR = {_zz_521_,_zz_255_};
  assign iBusWishbone_CTI = ((_zz_255_ == (3'b111)) ? (3'b111) : (3'b010));
  assign iBusWishbone_BTE = (2'b00);
  assign iBusWishbone_SEL = (4'b1111);
  assign iBusWishbone_WE = 1'b0;
  assign iBusWishbone_DAT_MOSI = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  always @ (*) begin
    iBusWishbone_CYC = 1'b0;
    if(_zz_350_)begin
      iBusWishbone_CYC = 1'b1;
    end
  end

  always @ (*) begin
    iBusWishbone_STB = 1'b0;
    if(_zz_350_)begin
      iBusWishbone_STB = 1'b1;
    end
  end

  assign iBus_cmd_ready = (iBus_cmd_valid && iBusWishbone_ACK);
  assign iBus_rsp_valid = _zz_256_;
  assign iBus_rsp_payload_data = iBusWishbone_DAT_MISO_regNext;
  assign iBus_rsp_payload_error = 1'b0;
  assign _zz_262_ = (dBus_cmd_payload_length != (3'b000));
  assign _zz_258_ = dBus_cmd_valid;
  assign _zz_260_ = dBus_cmd_payload_wr;
  assign _zz_261_ = (_zz_257_ == dBus_cmd_payload_length);
  assign dBus_cmd_ready = (_zz_259_ && (_zz_260_ || _zz_261_));
  assign dBusWishbone_ADR = ((_zz_262_ ? {{dBus_cmd_payload_address[31 : 5],_zz_257_},(2'b00)} : {dBus_cmd_payload_address[31 : 2],(2'b00)}) >>> 2);
  assign dBusWishbone_CTI = (_zz_262_ ? (_zz_261_ ? (3'b111) : (3'b010)) : (3'b000));
  assign dBusWishbone_BTE = (2'b00);
  assign dBusWishbone_SEL = (_zz_260_ ? dBus_cmd_payload_mask : (4'b1111));
  assign dBusWishbone_WE = _zz_260_;
  assign dBusWishbone_DAT_MOSI = dBus_cmd_payload_data;
  assign _zz_259_ = (_zz_258_ && dBusWishbone_ACK);
  assign dBusWishbone_CYC = _zz_258_;
  assign dBusWishbone_STB = _zz_258_;
  assign dBus_rsp_valid = _zz_263_;
  assign dBus_rsp_payload_data = dBusWishbone_DAT_MISO_regNext;
  assign dBus_rsp_payload_error = 1'b0;
  always @ (posedge clk) begin
    if(reset) begin
      IBusCachedPlugin_fetchPc_pcReg <= externalResetVector;
      IBusCachedPlugin_fetchPc_booted <= 1'b0;
      IBusCachedPlugin_fetchPc_inc <= 1'b0;
      IBusCachedPlugin_decodePc_pcReg <= externalResetVector;
      _zz_118_ <= 1'b0;
      _zz_120_ <= 1'b0;
      _zz_123_ <= 1'b0;
      IBusCachedPlugin_decompressor_bufferValid <= 1'b0;
      _zz_152_ <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      IBusCachedPlugin_injector_decodeRemoved <= 1'b0;
      IBusCachedPlugin_rspCounter <= _zz_163_;
      IBusCachedPlugin_rspCounter <= (32'b00000000000000000000000000000000);
      _zz_164_ <= 1'b0;
      _zz_171_ <= 1'b0;
      DBusCachedPlugin_rspCounter <= _zz_178_;
      DBusCachedPlugin_rspCounter <= (32'b00000000000000000000000000000000);
      _zz_198_ <= 1'b1;
      _zz_211_ <= 1'b0;
      memory_DivPlugin_div_counter_value <= (6'b000000);
      _zz_227_ <= (2'b11);
      CsrPlugin_mstatus_MIE <= 1'b0;
      CsrPlugin_mstatus_MPIE <= 1'b0;
      CsrPlugin_mstatus_MPP <= (2'b11);
      CsrPlugin_mie_MEIE <= 1'b0;
      CsrPlugin_mie_MTIE <= 1'b0;
      CsrPlugin_mie_MSIE <= 1'b0;
      CsrPlugin_medeleg_IAM <= 1'b0;
      CsrPlugin_medeleg_IAF <= 1'b0;
      CsrPlugin_medeleg_II <= 1'b0;
      CsrPlugin_medeleg_LAM <= 1'b0;
      CsrPlugin_medeleg_LAF <= 1'b0;
      CsrPlugin_medeleg_SAM <= 1'b0;
      CsrPlugin_medeleg_SAF <= 1'b0;
      CsrPlugin_medeleg_EU <= 1'b0;
      CsrPlugin_medeleg_ES <= 1'b0;
      CsrPlugin_medeleg_IPF <= 1'b0;
      CsrPlugin_medeleg_LPF <= 1'b0;
      CsrPlugin_medeleg_SPF <= 1'b0;
      CsrPlugin_mideleg_ST <= 1'b0;
      CsrPlugin_mideleg_SE <= 1'b0;
      CsrPlugin_mideleg_SS <= 1'b0;
      CsrPlugin_sstatus_SIE <= 1'b0;
      CsrPlugin_sstatus_SPIE <= 1'b0;
      CsrPlugin_sstatus_SPP <= (1'b1);
      CsrPlugin_sip_SEIP_SOFT <= 1'b0;
      CsrPlugin_sip_STIP <= 1'b0;
      CsrPlugin_sip_SSIP <= 1'b0;
      CsrPlugin_sie_SEIE <= 1'b0;
      CsrPlugin_sie_STIE <= 1'b0;
      CsrPlugin_sie_SSIE <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      CsrPlugin_interrupt_valid <= 1'b0;
      CsrPlugin_lastStageWasWfi <= 1'b0;
      CsrPlugin_hadException <= 1'b0;
      execute_CsrPlugin_wfiWake <= 1'b0;
      MmuPlugin_status_sum <= 1'b0;
      MmuPlugin_status_mxr <= 1'b0;
      MmuPlugin_status_mprv <= 1'b0;
      MmuPlugin_satp_mode <= 1'b0;
      MmuPlugin_ports_0_cache_0_valid <= 1'b0;
      MmuPlugin_ports_0_cache_1_valid <= 1'b0;
      MmuPlugin_ports_0_cache_2_valid <= 1'b0;
      MmuPlugin_ports_0_cache_3_valid <= 1'b0;
      MmuPlugin_ports_0_entryToReplace_value <= (2'b00);
      MmuPlugin_ports_1_cache_0_valid <= 1'b0;
      MmuPlugin_ports_1_cache_1_valid <= 1'b0;
      MmuPlugin_ports_1_cache_2_valid <= 1'b0;
      MmuPlugin_ports_1_cache_3_valid <= 1'b0;
      MmuPlugin_ports_1_entryToReplace_value <= (2'b00);
      MmuPlugin_shared_state_1_ <= `MmuPlugin_shared_State_defaultEncoding_IDLE;
      _zz_251_ <= (32'b00000000000000000000000000000000);
      _zz_253_ <= (32'b00000000000000000000000000000000);
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
      execute_to_memory_IS_DBUS_SHARING <= 1'b0;
      memory_to_writeBack_IS_DBUS_SHARING <= 1'b0;
      memory_to_writeBack_REGFILE_WRITE_DATA <= (32'b00000000000000000000000000000000);
      memory_to_writeBack_INSTRUCTION <= (32'b00000000000000000000000000000000);
      _zz_255_ <= (3'b000);
      _zz_256_ <= 1'b0;
      _zz_257_ <= (3'b000);
      _zz_263_ <= 1'b0;
    end else begin
      IBusCachedPlugin_fetchPc_booted <= 1'b1;
      if((IBusCachedPlugin_fetchPc_corrected || IBusCachedPlugin_fetchPc_pcRegPropagate))begin
        IBusCachedPlugin_fetchPc_inc <= 1'b0;
      end
      if((IBusCachedPlugin_fetchPc_output_valid && IBusCachedPlugin_fetchPc_output_ready))begin
        IBusCachedPlugin_fetchPc_inc <= 1'b1;
      end
      if(((! IBusCachedPlugin_fetchPc_output_valid) && IBusCachedPlugin_fetchPc_output_ready))begin
        IBusCachedPlugin_fetchPc_inc <= 1'b0;
      end
      if((IBusCachedPlugin_fetchPc_booted && ((IBusCachedPlugin_fetchPc_output_ready || IBusCachedPlugin_fetcherflushIt) || IBusCachedPlugin_fetchPc_pcRegPropagate)))begin
        IBusCachedPlugin_fetchPc_pcReg <= IBusCachedPlugin_fetchPc_pc;
      end
      if((decode_arbitration_isFiring && (! IBusCachedPlugin_decodePc_injectedDecode)))begin
        IBusCachedPlugin_decodePc_pcReg <= IBusCachedPlugin_decodePc_pcPlus;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid && ((! decode_arbitration_isStuck) || decode_arbitration_removeIt)))begin
        IBusCachedPlugin_decodePc_pcReg <= IBusCachedPlugin_jump_pcLoad_payload;
      end
      if(IBusCachedPlugin_fetcherflushIt)begin
        _zz_118_ <= 1'b0;
      end
      if(_zz_116_)begin
        _zz_118_ <= IBusCachedPlugin_iBusRsp_stages_0_output_valid;
      end
      if(IBusCachedPlugin_iBusRsp_stages_1_output_ready)begin
        _zz_120_ <= IBusCachedPlugin_iBusRsp_stages_1_output_valid;
      end
      if(IBusCachedPlugin_fetcherflushIt)begin
        _zz_120_ <= 1'b0;
      end
      if(IBusCachedPlugin_iBusRsp_stages_2_output_ready)begin
        _zz_123_ <= IBusCachedPlugin_iBusRsp_stages_2_output_valid;
      end
      if(IBusCachedPlugin_fetcherflushIt)begin
        _zz_123_ <= 1'b0;
      end
      if((IBusCachedPlugin_decompressor_inputBeforeStage_valid && IBusCachedPlugin_decompressor_inputBeforeStage_ready))begin
        IBusCachedPlugin_decompressor_bufferValid <= 1'b0;
      end
      if(_zz_330_)begin
        if(_zz_331_)begin
          IBusCachedPlugin_decompressor_bufferValid <= 1'b1;
        end else begin
          IBusCachedPlugin_decompressor_bufferValid <= 1'b0;
        end
      end
      if(IBusCachedPlugin_fetcherflushIt)begin
        IBusCachedPlugin_decompressor_bufferValid <= 1'b0;
      end
      if(IBusCachedPlugin_decompressor_inputBeforeStage_ready)begin
        _zz_152_ <= IBusCachedPlugin_decompressor_inputBeforeStage_valid;
      end
      if(IBusCachedPlugin_fetcherflushIt)begin
        _zz_152_ <= 1'b0;
      end
      if((! 1'b0))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b1;
      end
      if(IBusCachedPlugin_fetcherflushIt)begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      end
      if((! execute_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= IBusCachedPlugin_injector_nextPcCalc_valids_0;
      end
      if(IBusCachedPlugin_fetcherflushIt)begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if((! memory_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= IBusCachedPlugin_injector_nextPcCalc_valids_1;
      end
      if(IBusCachedPlugin_fetcherflushIt)begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if((! writeBack_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= IBusCachedPlugin_injector_nextPcCalc_valids_2;
      end
      if(IBusCachedPlugin_fetcherflushIt)begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if(decode_arbitration_removeIt)begin
        IBusCachedPlugin_injector_decodeRemoved <= 1'b1;
      end
      if(IBusCachedPlugin_fetcherflushIt)begin
        IBusCachedPlugin_injector_decodeRemoved <= 1'b0;
      end
      if(iBus_rsp_valid)begin
        IBusCachedPlugin_rspCounter <= (IBusCachedPlugin_rspCounter + (32'b00000000000000000000000000000001));
      end
      if(dataCache_1__io_mem_cmd_s2mPipe_ready)begin
        _zz_164_ <= 1'b0;
      end
      if(_zz_351_)begin
        _zz_164_ <= dataCache_1__io_mem_cmd_valid;
      end
      if(dataCache_1__io_mem_cmd_s2mPipe_ready)begin
        _zz_171_ <= dataCache_1__io_mem_cmd_s2mPipe_valid;
      end
      if(dBus_rsp_valid)begin
        DBusCachedPlugin_rspCounter <= (DBusCachedPlugin_rspCounter + (32'b00000000000000000000000000000001));
      end
      _zz_198_ <= 1'b0;
      _zz_211_ <= _zz_210_;
      memory_DivPlugin_div_counter_value <= memory_DivPlugin_div_counter_valueNext;
      if((! decode_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= 1'b0;
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
      end
      if((! execute_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= (CsrPlugin_exceptionPortCtrl_exceptionValids_decode && (! decode_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
      end
      if((! memory_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= (CsrPlugin_exceptionPortCtrl_exceptionValids_execute && (! execute_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
      end
      if((! writeBack_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= (CsrPlugin_exceptionPortCtrl_exceptionValids_memory && (! memory_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      end
      CsrPlugin_interrupt_valid <= 1'b0;
      if(_zz_352_)begin
        if(_zz_353_)begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(_zz_354_)begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(_zz_355_)begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
      end
      if(_zz_356_)begin
        if(_zz_357_)begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(_zz_358_)begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(_zz_359_)begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(_zz_360_)begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(_zz_361_)begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(_zz_362_)begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
      end
      CsrPlugin_lastStageWasWfi <= (writeBack_arbitration_isFiring && (writeBack_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_WFI));
      CsrPlugin_hadException <= CsrPlugin_exception;
      if(_zz_327_)begin
        _zz_227_ <= CsrPlugin_targetPrivilege;
        case(CsrPlugin_targetPrivilege)
          2'b01 : begin
            CsrPlugin_sstatus_SIE <= 1'b0;
            CsrPlugin_sstatus_SPIE <= CsrPlugin_sstatus_SIE;
            CsrPlugin_sstatus_SPP <= CsrPlugin_privilege[0 : 0];
          end
          2'b11 : begin
            CsrPlugin_mstatus_MIE <= 1'b0;
            CsrPlugin_mstatus_MPIE <= CsrPlugin_mstatus_MIE;
            CsrPlugin_mstatus_MPP <= CsrPlugin_privilege;
          end
          default : begin
          end
        endcase
      end
      if(_zz_328_)begin
        case(_zz_329_)
          2'b11 : begin
            CsrPlugin_mstatus_MPP <= (2'b00);
            CsrPlugin_mstatus_MIE <= CsrPlugin_mstatus_MPIE;
            CsrPlugin_mstatus_MPIE <= 1'b1;
            _zz_227_ <= CsrPlugin_mstatus_MPP;
          end
          2'b01 : begin
            CsrPlugin_sstatus_SPP <= (1'b0);
            CsrPlugin_sstatus_SIE <= CsrPlugin_sstatus_SPIE;
            CsrPlugin_sstatus_SPIE <= 1'b1;
            _zz_227_ <= {(1'b0),CsrPlugin_sstatus_SPP};
          end
          default : begin
          end
        endcase
      end
      execute_CsrPlugin_wfiWake <= ({_zz_233_,{_zz_232_,{_zz_231_,{_zz_230_,{_zz_229_,_zz_228_}}}}} != (6'b000000));
      MmuPlugin_ports_0_entryToReplace_value <= MmuPlugin_ports_0_entryToReplace_valueNext;
      if(contextSwitching)begin
        if(MmuPlugin_ports_0_cache_0_exception)begin
          MmuPlugin_ports_0_cache_0_valid <= 1'b0;
        end
        if(MmuPlugin_ports_0_cache_1_exception)begin
          MmuPlugin_ports_0_cache_1_valid <= 1'b0;
        end
        if(MmuPlugin_ports_0_cache_2_exception)begin
          MmuPlugin_ports_0_cache_2_valid <= 1'b0;
        end
        if(MmuPlugin_ports_0_cache_3_exception)begin
          MmuPlugin_ports_0_cache_3_valid <= 1'b0;
        end
      end
      MmuPlugin_ports_1_entryToReplace_value <= MmuPlugin_ports_1_entryToReplace_valueNext;
      if(contextSwitching)begin
        if(MmuPlugin_ports_1_cache_0_exception)begin
          MmuPlugin_ports_1_cache_0_valid <= 1'b0;
        end
        if(MmuPlugin_ports_1_cache_1_exception)begin
          MmuPlugin_ports_1_cache_1_valid <= 1'b0;
        end
        if(MmuPlugin_ports_1_cache_2_exception)begin
          MmuPlugin_ports_1_cache_2_valid <= 1'b0;
        end
        if(MmuPlugin_ports_1_cache_3_exception)begin
          MmuPlugin_ports_1_cache_3_valid <= 1'b0;
        end
      end
      case(MmuPlugin_shared_state_1_)
        `MmuPlugin_shared_State_defaultEncoding_IDLE : begin
          if(_zz_363_)begin
            MmuPlugin_shared_state_1_ <= `MmuPlugin_shared_State_defaultEncoding_L1_CMD;
          end
          if(_zz_364_)begin
            MmuPlugin_shared_state_1_ <= `MmuPlugin_shared_State_defaultEncoding_L1_CMD;
          end
        end
        `MmuPlugin_shared_State_defaultEncoding_L1_CMD : begin
          if(MmuPlugin_dBusAccess_cmd_ready)begin
            MmuPlugin_shared_state_1_ <= `MmuPlugin_shared_State_defaultEncoding_L1_RSP;
          end
        end
        `MmuPlugin_shared_State_defaultEncoding_L1_RSP : begin
          if(MmuPlugin_dBusAccess_rsp_valid)begin
            MmuPlugin_shared_state_1_ <= `MmuPlugin_shared_State_defaultEncoding_L0_CMD;
            if((MmuPlugin_shared_dBusRsp_leaf || MmuPlugin_shared_dBusRsp_exception))begin
              MmuPlugin_shared_state_1_ <= `MmuPlugin_shared_State_defaultEncoding_IDLE;
            end
            if(MmuPlugin_dBusAccess_rsp_payload_redo)begin
              MmuPlugin_shared_state_1_ <= `MmuPlugin_shared_State_defaultEncoding_L1_CMD;
            end
          end
        end
        `MmuPlugin_shared_State_defaultEncoding_L0_CMD : begin
          if(MmuPlugin_dBusAccess_cmd_ready)begin
            MmuPlugin_shared_state_1_ <= `MmuPlugin_shared_State_defaultEncoding_L0_RSP;
          end
        end
        default : begin
          if(MmuPlugin_dBusAccess_rsp_valid)begin
            MmuPlugin_shared_state_1_ <= `MmuPlugin_shared_State_defaultEncoding_IDLE;
            if(MmuPlugin_dBusAccess_rsp_payload_redo)begin
              MmuPlugin_shared_state_1_ <= `MmuPlugin_shared_State_defaultEncoding_L0_CMD;
            end
          end
        end
      endcase
      if(_zz_347_)begin
        if(_zz_348_)begin
          if(_zz_365_)begin
            MmuPlugin_ports_0_cache_0_valid <= 1'b1;
          end
          if(_zz_366_)begin
            MmuPlugin_ports_0_cache_1_valid <= 1'b1;
          end
          if(_zz_367_)begin
            MmuPlugin_ports_0_cache_2_valid <= 1'b1;
          end
          if(_zz_368_)begin
            MmuPlugin_ports_0_cache_3_valid <= 1'b1;
          end
        end
        if(_zz_349_)begin
          if(_zz_369_)begin
            MmuPlugin_ports_1_cache_0_valid <= 1'b1;
          end
          if(_zz_370_)begin
            MmuPlugin_ports_1_cache_1_valid <= 1'b1;
          end
          if(_zz_371_)begin
            MmuPlugin_ports_1_cache_2_valid <= 1'b1;
          end
          if(_zz_372_)begin
            MmuPlugin_ports_1_cache_3_valid <= 1'b1;
          end
        end
      end
      if((writeBack_arbitration_isValid && writeBack_IS_SFENCE_VMA))begin
        MmuPlugin_ports_0_cache_0_valid <= 1'b0;
        MmuPlugin_ports_0_cache_1_valid <= 1'b0;
        MmuPlugin_ports_0_cache_2_valid <= 1'b0;
        MmuPlugin_ports_0_cache_3_valid <= 1'b0;
        MmuPlugin_ports_1_cache_0_valid <= 1'b0;
        MmuPlugin_ports_1_cache_1_valid <= 1'b0;
        MmuPlugin_ports_1_cache_2_valid <= 1'b0;
        MmuPlugin_ports_1_cache_3_valid <= 1'b0;
      end
      if((! memory_arbitration_isStuck))begin
        execute_to_memory_IS_DBUS_SHARING <= execute_IS_DBUS_SHARING;
      end
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_IS_DBUS_SHARING <= memory_IS_DBUS_SHARING;
      end
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_REGFILE_WRITE_DATA <= _zz_44_;
      end
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_INSTRUCTION <= memory_INSTRUCTION;
      end
      if(((! execute_arbitration_isStuck) || execute_arbitration_removeIt))begin
        execute_arbitration_isValid <= 1'b0;
      end
      if(((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt)))begin
        execute_arbitration_isValid <= decode_arbitration_isValid;
      end
      if(((! memory_arbitration_isStuck) || memory_arbitration_removeIt))begin
        memory_arbitration_isValid <= 1'b0;
      end
      if(((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt)))begin
        memory_arbitration_isValid <= execute_arbitration_isValid;
      end
      if(((! writeBack_arbitration_isStuck) || writeBack_arbitration_removeIt))begin
        writeBack_arbitration_isValid <= 1'b0;
      end
      if(((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt)))begin
        writeBack_arbitration_isValid <= memory_arbitration_isValid;
      end
      if(MmuPlugin_dBusAccess_rsp_valid)begin
        memory_to_writeBack_IS_DBUS_SHARING <= 1'b0;
      end
      case(execute_CsrPlugin_csrAddress)
        12'b101111000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            _zz_251_ <= execute_CsrPlugin_writeData[31 : 0];
          end
        end
        12'b001100000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mstatus_MPP <= execute_CsrPlugin_writeData[12 : 11];
            CsrPlugin_mstatus_MPIE <= _zz_476_[0];
            CsrPlugin_mstatus_MIE <= _zz_477_[0];
            CsrPlugin_sstatus_SPP <= execute_CsrPlugin_writeData[8 : 8];
            CsrPlugin_sstatus_SPIE <= _zz_478_[0];
            CsrPlugin_sstatus_SIE <= _zz_479_[0];
            MmuPlugin_status_mxr <= _zz_480_[0];
            MmuPlugin_status_sum <= _zz_481_[0];
            MmuPlugin_status_mprv <= _zz_482_[0];
          end
        end
        12'b001100000011 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mideleg_SE <= _zz_483_[0];
            CsrPlugin_mideleg_ST <= _zz_484_[0];
            CsrPlugin_mideleg_SS <= _zz_485_[0];
          end
        end
        12'b111100010001 : begin
        end
        12'b000101000010 : begin
        end
        12'b111100010100 : begin
        end
        12'b100111000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            _zz_253_ <= execute_CsrPlugin_writeData[31 : 0];
          end
        end
        12'b000100000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_sstatus_SPP <= execute_CsrPlugin_writeData[8 : 8];
            CsrPlugin_sstatus_SPIE <= _zz_487_[0];
            CsrPlugin_sstatus_SIE <= _zz_488_[0];
            MmuPlugin_status_mxr <= _zz_489_[0];
            MmuPlugin_status_sum <= _zz_490_[0];
            MmuPlugin_status_mprv <= _zz_491_[0];
          end
        end
        12'b001100000010 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_medeleg_EU <= _zz_492_[0];
            CsrPlugin_medeleg_II <= _zz_493_[0];
            CsrPlugin_medeleg_LAF <= _zz_494_[0];
            CsrPlugin_medeleg_LPF <= _zz_495_[0];
            CsrPlugin_medeleg_LAM <= _zz_496_[0];
            CsrPlugin_medeleg_SAF <= _zz_497_[0];
            CsrPlugin_medeleg_IAF <= _zz_498_[0];
            CsrPlugin_medeleg_ES <= _zz_499_[0];
            CsrPlugin_medeleg_IPF <= _zz_500_[0];
            CsrPlugin_medeleg_SPF <= _zz_501_[0];
            CsrPlugin_medeleg_SAM <= _zz_502_[0];
            CsrPlugin_medeleg_IAM <= _zz_503_[0];
          end
        end
        12'b001101000001 : begin
        end
        12'b001101000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_sip_STIP <= _zz_505_[0];
            CsrPlugin_sip_SSIP <= _zz_506_[0];
            CsrPlugin_sip_SEIP_SOFT <= _zz_507_[0];
          end
        end
        12'b001100000101 : begin
        end
        12'b000110000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            MmuPlugin_satp_mode <= _zz_508_[0];
          end
        end
        12'b110011000000 : begin
        end
        12'b000101000001 : begin
        end
        12'b111100010011 : begin
        end
        12'b000101000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_sip_STIP <= _zz_509_[0];
            CsrPlugin_sip_SSIP <= _zz_510_[0];
            CsrPlugin_sip_SEIP_SOFT <= _zz_511_[0];
          end
        end
        12'b001101000011 : begin
        end
        12'b000100000101 : begin
        end
        12'b111111000000 : begin
        end
        12'b001101000000 : begin
        end
        12'b001100000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mie_MEIE <= _zz_512_[0];
            CsrPlugin_mie_MTIE <= _zz_513_[0];
            CsrPlugin_mie_MSIE <= _zz_514_[0];
            CsrPlugin_sie_SEIE <= _zz_515_[0];
            CsrPlugin_sie_STIE <= _zz_516_[0];
            CsrPlugin_sie_SSIE <= _zz_517_[0];
          end
        end
        12'b111100010010 : begin
        end
        12'b000101000011 : begin
        end
        12'b110111000000 : begin
        end
        12'b000101000000 : begin
        end
        12'b001101000010 : begin
        end
        12'b000100000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_sie_SEIE <= _zz_518_[0];
            CsrPlugin_sie_STIE <= _zz_519_[0];
            CsrPlugin_sie_SSIE <= _zz_520_[0];
          end
        end
        default : begin
        end
      endcase
      if(_zz_350_)begin
        if(iBusWishbone_ACK)begin
          _zz_255_ <= (_zz_255_ + (3'b001));
        end
      end
      _zz_256_ <= (iBusWishbone_CYC && iBusWishbone_ACK);
      if((_zz_258_ && _zz_259_))begin
        _zz_257_ <= (_zz_257_ + (3'b001));
        if(_zz_261_)begin
          _zz_257_ <= (3'b000);
        end
      end
      _zz_263_ <= ((_zz_258_ && (! dBusWishbone_WE)) && dBusWishbone_ACK);
    end
  end

  always @ (posedge clk) begin
    if(IBusCachedPlugin_iBusRsp_stages_1_output_ready)begin
      _zz_121_ <= IBusCachedPlugin_iBusRsp_stages_1_output_payload;
    end
    if(IBusCachedPlugin_iBusRsp_stages_2_output_ready)begin
      _zz_124_ <= IBusCachedPlugin_iBusRsp_stages_2_output_payload;
    end
    if(_zz_330_)begin
      IBusCachedPlugin_decompressor_bufferData <= IBusCachedPlugin_iBusRsp_output_payload_rsp_inst[31 : 16];
    end
    if(IBusCachedPlugin_decompressor_inputBeforeStage_ready)begin
      _zz_153_ <= IBusCachedPlugin_decompressor_inputBeforeStage_payload_pc;
      _zz_154_ <= IBusCachedPlugin_decompressor_inputBeforeStage_payload_rsp_error;
      _zz_155_ <= IBusCachedPlugin_decompressor_inputBeforeStage_payload_rsp_inst;
      _zz_156_ <= IBusCachedPlugin_decompressor_inputBeforeStage_payload_isRvc;
    end
    if(IBusCachedPlugin_injector_decodeInput_ready)begin
      IBusCachedPlugin_injector_formal_rawInDecode <= IBusCachedPlugin_decompressor_raw;
    end
    if(IBusCachedPlugin_iBusRsp_stages_2_input_ready)begin
      IBusCachedPlugin_s1_tightlyCoupledHit <= IBusCachedPlugin_s0_tightlyCoupledHit;
    end
    if(IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_ready)begin
      IBusCachedPlugin_s2_tightlyCoupledHit <= IBusCachedPlugin_s1_tightlyCoupledHit;
    end
    if(_zz_351_)begin
      _zz_165_ <= dataCache_1__io_mem_cmd_payload_wr;
      _zz_166_ <= dataCache_1__io_mem_cmd_payload_address;
      _zz_167_ <= dataCache_1__io_mem_cmd_payload_data;
      _zz_168_ <= dataCache_1__io_mem_cmd_payload_mask;
      _zz_169_ <= dataCache_1__io_mem_cmd_payload_length;
      _zz_170_ <= dataCache_1__io_mem_cmd_payload_last;
    end
    if(dataCache_1__io_mem_cmd_s2mPipe_ready)begin
      _zz_172_ <= dataCache_1__io_mem_cmd_s2mPipe_payload_wr;
      _zz_173_ <= dataCache_1__io_mem_cmd_s2mPipe_payload_address;
      _zz_174_ <= dataCache_1__io_mem_cmd_s2mPipe_payload_data;
      _zz_175_ <= dataCache_1__io_mem_cmd_s2mPipe_payload_mask;
      _zz_176_ <= dataCache_1__io_mem_cmd_s2mPipe_payload_length;
      _zz_177_ <= dataCache_1__io_mem_cmd_s2mPipe_payload_last;
    end
    if(_zz_210_)begin
      _zz_212_ <= _zz_60_[11 : 7];
      _zz_213_ <= _zz_94_;
    end
    if((memory_DivPlugin_div_counter_value == (6'b100000)))begin
      memory_DivPlugin_div_done <= 1'b1;
    end
    if((! memory_arbitration_isStuck))begin
      memory_DivPlugin_div_done <= 1'b0;
    end
    if(_zz_319_)begin
      if(_zz_326_)begin
        memory_DivPlugin_rs1[31 : 0] <= _zz_446_[31:0];
        memory_DivPlugin_accumulator[31 : 0] <= ((! _zz_222_[32]) ? _zz_447_ : _zz_448_);
        if((memory_DivPlugin_div_counter_value == (6'b100000)))begin
          memory_DivPlugin_div_result <= _zz_449_[31:0];
        end
      end
    end
    if(_zz_343_)begin
      memory_DivPlugin_accumulator <= (65'b00000000000000000000000000000000000000000000000000000000000000000);
      memory_DivPlugin_rs1 <= ((_zz_225_ ? (~ _zz_226_) : _zz_226_) + _zz_455_);
      memory_DivPlugin_rs2 <= ((_zz_224_ ? (~ execute_RS2) : execute_RS2) + _zz_457_);
      memory_DivPlugin_div_needRevert <= ((_zz_225_ ^ (_zz_224_ && (! execute_INSTRUCTION[13]))) && (! (((execute_RS2 == (32'b00000000000000000000000000000000)) && execute_IS_RS2_SIGNED) && (! execute_INSTRUCTION[13]))));
    end
    CsrPlugin_mip_MEIP <= externalInterrupt;
    CsrPlugin_mip_MTIP <= timerInterrupt;
    CsrPlugin_mip_MSIP <= softwareInterrupt;
    CsrPlugin_sip_SEIP_INPUT <= externalInterruptS;
    CsrPlugin_mcycle <= (CsrPlugin_mcycle + (64'b0000000000000000000000000000000000000000000000000000000000000001));
    if(writeBack_arbitration_isFiring)begin
      CsrPlugin_minstret <= (CsrPlugin_minstret + (64'b0000000000000000000000000000000000000000000000000000000000000001));
    end
    if(_zz_324_)begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= (_zz_235_ ? IBusCachedPlugin_decodeExceptionPort_payload_code : decodeExceptionPort_payload_code);
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= (_zz_235_ ? IBusCachedPlugin_decodeExceptionPort_payload_badAddr : decodeExceptionPort_payload_badAddr);
    end
    if(CsrPlugin_selfException_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= CsrPlugin_selfException_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= CsrPlugin_selfException_payload_badAddr;
    end
    if(DBusCachedPlugin_exceptionBus_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= DBusCachedPlugin_exceptionBus_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= DBusCachedPlugin_exceptionBus_payload_badAddr;
    end
    if(_zz_352_)begin
      if(_zz_353_)begin
        CsrPlugin_interrupt_code <= (4'b0101);
        CsrPlugin_interrupt_targetPrivilege <= (2'b01);
      end
      if(_zz_354_)begin
        CsrPlugin_interrupt_code <= (4'b0001);
        CsrPlugin_interrupt_targetPrivilege <= (2'b01);
      end
      if(_zz_355_)begin
        CsrPlugin_interrupt_code <= (4'b1001);
        CsrPlugin_interrupt_targetPrivilege <= (2'b01);
      end
    end
    if(_zz_356_)begin
      if(_zz_357_)begin
        CsrPlugin_interrupt_code <= (4'b0101);
        CsrPlugin_interrupt_targetPrivilege <= (2'b11);
      end
      if(_zz_358_)begin
        CsrPlugin_interrupt_code <= (4'b0001);
        CsrPlugin_interrupt_targetPrivilege <= (2'b11);
      end
      if(_zz_359_)begin
        CsrPlugin_interrupt_code <= (4'b1001);
        CsrPlugin_interrupt_targetPrivilege <= (2'b11);
      end
      if(_zz_360_)begin
        CsrPlugin_interrupt_code <= (4'b0111);
        CsrPlugin_interrupt_targetPrivilege <= (2'b11);
      end
      if(_zz_361_)begin
        CsrPlugin_interrupt_code <= (4'b0011);
        CsrPlugin_interrupt_targetPrivilege <= (2'b11);
      end
      if(_zz_362_)begin
        CsrPlugin_interrupt_code <= (4'b1011);
        CsrPlugin_interrupt_targetPrivilege <= (2'b11);
      end
    end
    if(_zz_327_)begin
      case(CsrPlugin_targetPrivilege)
        2'b01 : begin
          CsrPlugin_scause_interrupt <= (! CsrPlugin_hadException);
          CsrPlugin_scause_exceptionCode <= CsrPlugin_trapCause;
          CsrPlugin_sepc <= writeBack_PC;
          if(CsrPlugin_hadException)begin
            CsrPlugin_stval <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
          end
        end
        2'b11 : begin
          CsrPlugin_mcause_interrupt <= (! CsrPlugin_hadException);
          CsrPlugin_mcause_exceptionCode <= CsrPlugin_trapCause;
          CsrPlugin_mepc <= writeBack_PC;
          if(CsrPlugin_hadException)begin
            CsrPlugin_mtval <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
          end
        end
        default : begin
        end
      endcase
    end
    if((MmuPlugin_dBusAccess_rsp_valid && (! MmuPlugin_dBusAccess_rsp_payload_redo)))begin
      MmuPlugin_shared_pteBuffer_V <= MmuPlugin_shared_dBusRsp_pte_V;
      MmuPlugin_shared_pteBuffer_R <= MmuPlugin_shared_dBusRsp_pte_R;
      MmuPlugin_shared_pteBuffer_W <= MmuPlugin_shared_dBusRsp_pte_W;
      MmuPlugin_shared_pteBuffer_X <= MmuPlugin_shared_dBusRsp_pte_X;
      MmuPlugin_shared_pteBuffer_U <= MmuPlugin_shared_dBusRsp_pte_U;
      MmuPlugin_shared_pteBuffer_G <= MmuPlugin_shared_dBusRsp_pte_G;
      MmuPlugin_shared_pteBuffer_A <= MmuPlugin_shared_dBusRsp_pte_A;
      MmuPlugin_shared_pteBuffer_D <= MmuPlugin_shared_dBusRsp_pte_D;
      MmuPlugin_shared_pteBuffer_RSW <= MmuPlugin_shared_dBusRsp_pte_RSW;
      MmuPlugin_shared_pteBuffer_PPN0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
      MmuPlugin_shared_pteBuffer_PPN1 <= MmuPlugin_shared_dBusRsp_pte_PPN1;
    end
    case(MmuPlugin_shared_state_1_)
      `MmuPlugin_shared_State_defaultEncoding_IDLE : begin
        if(_zz_363_)begin
          MmuPlugin_shared_vpn_1 <= IBusCachedPlugin_mmuBus_cmd_virtualAddress[31 : 22];
          MmuPlugin_shared_vpn_0 <= IBusCachedPlugin_mmuBus_cmd_virtualAddress[21 : 12];
          MmuPlugin_shared_portId <= (1'b0);
        end
        if(_zz_364_)begin
          MmuPlugin_shared_vpn_1 <= DBusCachedPlugin_mmuBus_cmd_virtualAddress[31 : 22];
          MmuPlugin_shared_vpn_0 <= DBusCachedPlugin_mmuBus_cmd_virtualAddress[21 : 12];
          MmuPlugin_shared_portId <= (1'b1);
        end
      end
      `MmuPlugin_shared_State_defaultEncoding_L1_CMD : begin
      end
      `MmuPlugin_shared_State_defaultEncoding_L1_RSP : begin
      end
      `MmuPlugin_shared_State_defaultEncoding_L0_CMD : begin
      end
      default : begin
      end
    endcase
    if(_zz_347_)begin
      if(_zz_348_)begin
        if(_zz_365_)begin
          MmuPlugin_ports_0_cache_0_exception <= (MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1_ == `MmuPlugin_shared_State_defaultEncoding_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != (10'b0000000000))));
          MmuPlugin_ports_0_cache_0_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
          MmuPlugin_ports_0_cache_0_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
          MmuPlugin_ports_0_cache_0_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
          MmuPlugin_ports_0_cache_0_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9 : 0];
          MmuPlugin_ports_0_cache_0_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
          MmuPlugin_ports_0_cache_0_allowWrite <= MmuPlugin_shared_dBusRsp_pte_W;
          MmuPlugin_ports_0_cache_0_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
          MmuPlugin_ports_0_cache_0_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
          MmuPlugin_ports_0_cache_0_superPage <= (MmuPlugin_shared_state_1_ == `MmuPlugin_shared_State_defaultEncoding_L1_RSP);
        end
        if(_zz_366_)begin
          MmuPlugin_ports_0_cache_1_exception <= (MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1_ == `MmuPlugin_shared_State_defaultEncoding_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != (10'b0000000000))));
          MmuPlugin_ports_0_cache_1_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
          MmuPlugin_ports_0_cache_1_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
          MmuPlugin_ports_0_cache_1_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
          MmuPlugin_ports_0_cache_1_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9 : 0];
          MmuPlugin_ports_0_cache_1_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
          MmuPlugin_ports_0_cache_1_allowWrite <= MmuPlugin_shared_dBusRsp_pte_W;
          MmuPlugin_ports_0_cache_1_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
          MmuPlugin_ports_0_cache_1_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
          MmuPlugin_ports_0_cache_1_superPage <= (MmuPlugin_shared_state_1_ == `MmuPlugin_shared_State_defaultEncoding_L1_RSP);
        end
        if(_zz_367_)begin
          MmuPlugin_ports_0_cache_2_exception <= (MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1_ == `MmuPlugin_shared_State_defaultEncoding_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != (10'b0000000000))));
          MmuPlugin_ports_0_cache_2_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
          MmuPlugin_ports_0_cache_2_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
          MmuPlugin_ports_0_cache_2_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
          MmuPlugin_ports_0_cache_2_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9 : 0];
          MmuPlugin_ports_0_cache_2_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
          MmuPlugin_ports_0_cache_2_allowWrite <= MmuPlugin_shared_dBusRsp_pte_W;
          MmuPlugin_ports_0_cache_2_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
          MmuPlugin_ports_0_cache_2_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
          MmuPlugin_ports_0_cache_2_superPage <= (MmuPlugin_shared_state_1_ == `MmuPlugin_shared_State_defaultEncoding_L1_RSP);
        end
        if(_zz_368_)begin
          MmuPlugin_ports_0_cache_3_exception <= (MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1_ == `MmuPlugin_shared_State_defaultEncoding_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != (10'b0000000000))));
          MmuPlugin_ports_0_cache_3_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
          MmuPlugin_ports_0_cache_3_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
          MmuPlugin_ports_0_cache_3_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
          MmuPlugin_ports_0_cache_3_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9 : 0];
          MmuPlugin_ports_0_cache_3_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
          MmuPlugin_ports_0_cache_3_allowWrite <= MmuPlugin_shared_dBusRsp_pte_W;
          MmuPlugin_ports_0_cache_3_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
          MmuPlugin_ports_0_cache_3_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
          MmuPlugin_ports_0_cache_3_superPage <= (MmuPlugin_shared_state_1_ == `MmuPlugin_shared_State_defaultEncoding_L1_RSP);
        end
      end
      if(_zz_349_)begin
        if(_zz_369_)begin
          MmuPlugin_ports_1_cache_0_exception <= (MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1_ == `MmuPlugin_shared_State_defaultEncoding_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != (10'b0000000000))));
          MmuPlugin_ports_1_cache_0_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
          MmuPlugin_ports_1_cache_0_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
          MmuPlugin_ports_1_cache_0_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
          MmuPlugin_ports_1_cache_0_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9 : 0];
          MmuPlugin_ports_1_cache_0_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
          MmuPlugin_ports_1_cache_0_allowWrite <= MmuPlugin_shared_dBusRsp_pte_W;
          MmuPlugin_ports_1_cache_0_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
          MmuPlugin_ports_1_cache_0_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
          MmuPlugin_ports_1_cache_0_superPage <= (MmuPlugin_shared_state_1_ == `MmuPlugin_shared_State_defaultEncoding_L1_RSP);
        end
        if(_zz_370_)begin
          MmuPlugin_ports_1_cache_1_exception <= (MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1_ == `MmuPlugin_shared_State_defaultEncoding_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != (10'b0000000000))));
          MmuPlugin_ports_1_cache_1_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
          MmuPlugin_ports_1_cache_1_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
          MmuPlugin_ports_1_cache_1_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
          MmuPlugin_ports_1_cache_1_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9 : 0];
          MmuPlugin_ports_1_cache_1_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
          MmuPlugin_ports_1_cache_1_allowWrite <= MmuPlugin_shared_dBusRsp_pte_W;
          MmuPlugin_ports_1_cache_1_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
          MmuPlugin_ports_1_cache_1_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
          MmuPlugin_ports_1_cache_1_superPage <= (MmuPlugin_shared_state_1_ == `MmuPlugin_shared_State_defaultEncoding_L1_RSP);
        end
        if(_zz_371_)begin
          MmuPlugin_ports_1_cache_2_exception <= (MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1_ == `MmuPlugin_shared_State_defaultEncoding_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != (10'b0000000000))));
          MmuPlugin_ports_1_cache_2_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
          MmuPlugin_ports_1_cache_2_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
          MmuPlugin_ports_1_cache_2_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
          MmuPlugin_ports_1_cache_2_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9 : 0];
          MmuPlugin_ports_1_cache_2_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
          MmuPlugin_ports_1_cache_2_allowWrite <= MmuPlugin_shared_dBusRsp_pte_W;
          MmuPlugin_ports_1_cache_2_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
          MmuPlugin_ports_1_cache_2_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
          MmuPlugin_ports_1_cache_2_superPage <= (MmuPlugin_shared_state_1_ == `MmuPlugin_shared_State_defaultEncoding_L1_RSP);
        end
        if(_zz_372_)begin
          MmuPlugin_ports_1_cache_3_exception <= (MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1_ == `MmuPlugin_shared_State_defaultEncoding_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != (10'b0000000000))));
          MmuPlugin_ports_1_cache_3_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
          MmuPlugin_ports_1_cache_3_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
          MmuPlugin_ports_1_cache_3_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
          MmuPlugin_ports_1_cache_3_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9 : 0];
          MmuPlugin_ports_1_cache_3_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
          MmuPlugin_ports_1_cache_3_allowWrite <= MmuPlugin_shared_dBusRsp_pte_W;
          MmuPlugin_ports_1_cache_3_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
          MmuPlugin_ports_1_cache_3_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
          MmuPlugin_ports_1_cache_3_superPage <= (MmuPlugin_shared_state_1_ == `MmuPlugin_shared_State_defaultEncoding_L1_RSP);
        end
      end
    end
    externalInterruptArray_regNext <= externalInterruptArray;
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_RS1_SIGNED <= decode_IS_RS1_SIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC2_CTRL <= _zz_25_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_CSR <= decode_IS_CSR;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_IS_CSR <= execute_IS_CSR;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MUL_LOW <= memory_MUL_LOW;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_CALC <= execute_BRANCH_CALC;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_MUL <= decode_IS_MUL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_IS_MUL <= execute_IS_MUL;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_IS_MUL <= memory_IS_MUL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_LH <= execute_MUL_LH;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_REGFILE_WRITE_DATA <= _zz_43_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_ENABLE <= decode_MEMORY_ENABLE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_ENABLE <= execute_MEMORY_ENABLE;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_ENABLE <= memory_MEMORY_ENABLE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_SHIFT_RIGHT <= execute_SHIFT_RIGHT;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_SFENCE_VMA <= decode_IS_SFENCE_VMA;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_IS_SFENCE_VMA <= execute_IS_SFENCE_VMA;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_IS_SFENCE_VMA <= memory_IS_SFENCE_VMA;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_READ_OPCODE <= decode_CSR_READ_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_AMO <= decode_MEMORY_AMO;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_INSTRUCTION <= decode_INSTRUCTION;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_INSTRUCTION <= execute_INSTRUCTION;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_RVC <= decode_IS_RVC;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_PREDICTION_HAD_BRANCHED2 <= decode_PREDICTION_HAD_BRANCHED2;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_RS2_SIGNED <= decode_IS_RS2_SIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_DIV <= decode_IS_DIV;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_IS_DIV <= execute_IS_DIV;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC2_FORCE_ZERO <= decode_SRC2_FORCE_ZERO;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_LRSC <= decode_MEMORY_LRSC;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS1 <= decode_RS1;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_HL <= execute_MUL_HL;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_BITWISE_CTRL <= _zz_22_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_PIPELINED_CSR_READ <= execute_PIPELINED_CSR_READ;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_CTRL <= _zz_19_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SHIFT_CTRL <= _zz_16_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_SHIFT_CTRL <= _zz_13_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_WRITE_OPCODE <= decode_CSR_WRITE_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_PC <= decode_PC;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_PC <= _zz_51_;
    end
    if(((! writeBack_arbitration_isStuck) && (! CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack)))begin
      memory_to_writeBack_PC <= memory_PC;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_WR <= decode_MEMORY_WR;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_WR <= execute_MEMORY_WR;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_WR <= memory_MEMORY_WR;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BRANCH_CTRL <= _zz_11_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_REGFILE_WRITE_VALID <= decode_REGFILE_WRITE_VALID;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_REGFILE_WRITE_VALID <= execute_REGFILE_WRITE_VALID;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_REGFILE_WRITE_VALID <= memory_REGFILE_WRITE_VALID;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BYPASSABLE_EXECUTE_STAGE <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_MANAGMENT <= decode_MEMORY_MANAGMENT;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_DO <= execute_BRANCH_DO;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_LL <= execute_MUL_LL;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS2 <= decode_RS2;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ENV_CTRL <= _zz_9_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_ENV_CTRL <= _zz_6_;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_ENV_CTRL <= _zz_4_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_ADDRESS_LOW <= execute_MEMORY_ADDRESS_LOW;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_ADDRESS_LOW <= memory_MEMORY_ADDRESS_LOW;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_HH <= execute_MUL_HH;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MUL_HH <= memory_MUL_HH;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BYPASSABLE_MEMORY_STAGE <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BYPASSABLE_MEMORY_STAGE <= execute_BYPASSABLE_MEMORY_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC1_CTRL <= _zz_2_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_FORMAL_PC_NEXT <= _zz_101_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_FORMAL_PC_NEXT <= execute_FORMAL_PC_NEXT;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_FORMAL_PC_NEXT <= _zz_100_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS;
    end
    if((((! IBusCachedPlugin_iBusRsp_output_ready) && (IBusCachedPlugin_decompressor_inputBeforeStage_valid && IBusCachedPlugin_decompressor_inputBeforeStage_ready)) && (! IBusCachedPlugin_fetcherflushIt)))begin
      _zz_124_[1] <= 1'b1;
    end
    case(execute_CsrPlugin_csrAddress)
      12'b101111000000 : begin
      end
      12'b001100000000 : begin
      end
      12'b001100000011 : begin
      end
      12'b111100010001 : begin
      end
      12'b000101000010 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_scause_interrupt <= _zz_486_[0];
          CsrPlugin_scause_exceptionCode <= execute_CsrPlugin_writeData[3 : 0];
        end
      end
      12'b111100010100 : begin
      end
      12'b100111000000 : begin
      end
      12'b000100000000 : begin
      end
      12'b001100000010 : begin
      end
      12'b001101000001 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mepc <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b001101000100 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mip_MSIP <= _zz_504_[0];
        end
      end
      12'b001100000101 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mtvec_base <= execute_CsrPlugin_writeData[31 : 2];
          CsrPlugin_mtvec_mode <= execute_CsrPlugin_writeData[1 : 0];
        end
      end
      12'b000110000000 : begin
        if(execute_CsrPlugin_writeEnable)begin
          MmuPlugin_satp_asid <= execute_CsrPlugin_writeData[30 : 22];
          MmuPlugin_satp_ppn <= execute_CsrPlugin_writeData[19 : 0];
        end
      end
      12'b110011000000 : begin
      end
      12'b000101000001 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_sepc <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b111100010011 : begin
      end
      12'b000101000100 : begin
      end
      12'b001101000011 : begin
      end
      12'b000100000101 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_stvec_base <= execute_CsrPlugin_writeData[31 : 2];
          CsrPlugin_stvec_mode <= execute_CsrPlugin_writeData[1 : 0];
        end
      end
      12'b111111000000 : begin
      end
      12'b001101000000 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mscratch <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b001100000100 : begin
      end
      12'b111100010010 : begin
      end
      12'b000101000011 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_stval <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b110111000000 : begin
      end
      12'b000101000000 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_sscratch <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b001101000010 : begin
      end
      12'b000100000100 : begin
      end
      default : begin
      end
    endcase
    iBusWishbone_DAT_MISO_regNext <= iBusWishbone_DAT_MISO;
    dBusWishbone_DAT_MISO_regNext <= dBusWishbone_DAT_MISO;
  end

endmodule


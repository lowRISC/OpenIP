/* packages */
package global_types;
    typedef enum logic[1:0] {
        enum_0_BURST_FIXED = 2'd0,
        enum_0_BURST_INCR = 2'd1,
        enum_0_BURST_WRAP = 2'd2
    } enum_0;
    typedef enum logic[1:0] {
        enum_1_RESP_OKAY = 2'd0,
        enum_1_RESP_EXOKAY = 2'd1,
        enum_1_RESP_SLVERR = 2'd2,
        enum_1_RESP_DECERR = 2'd3
    } enum_1;
    typedef struct packed {
        logic[3:0] id;
        logic[63:0] addr;
        logic[7:0] len;
        logic[2:0] size;
        logic[1:0] burst;
        logic lock;
        logic[3:0] cache;
        logic[2:0] prot;
        logic[3:0] qos;
        logic[3:0] region;
        logic[5:0] atop;
    } struct_0;
    typedef struct packed {
        logic[63:0] data;
        logic[7:0] strb;
        logic last;
    } struct_1;
    typedef struct packed {
        logic[3:0] id;
        logic[1:0] resp;
    } struct_2;
    typedef struct packed {
        logic[3:0] id;
        logic[63:0] addr;
        logic[7:0] len;
        logic[2:0] size;
        logic[1:0] burst;
        logic lock;
        logic[3:0] cache;
        logic[2:0] prot;
        logic[3:0] qos;
        logic[3:0] region;
    } struct_3;
    typedef struct packed {
        logic[3:0] id;
        logic[63:0] data;
        logic[1:0] resp;
        logic last;
    } struct_4;
    typedef struct packed {
        logic[4:0] id;
        logic[63:0] addr;
        logic[7:0] len;
        logic[2:0] size;
        enum_0 burst;
        logic lock;
        logic[3:0] cache;
        logic[2:0] prot;
        logic[3:0] qos;
        logic[3:0] region;
        logic[0:0] user;
    } struct_5;
    typedef struct packed {
        logic[63:0] data;
        logic[7:0] strb;
        logic last;
        logic[0:0] user;
    } struct_6;
    typedef struct packed {
        logic[4:0] id;
        enum_1 resp;
        logic[0:0] user;
    } struct_7;
    typedef struct packed {
        logic[4:0] id;
        logic[63:0] addr;
        logic[7:0] len;
        logic[2:0] size;
        enum_0 burst;
        logic lock;
        logic[3:0] cache;
        logic[2:0] prot;
        logic[3:0] qos;
        logic[3:0] region;
        logic[0:0] user;
    } struct_8;
    typedef struct packed {
        logic[4:0] id;
        logic[63:0] data;
        enum_1 resp;
        logic last;
        logic[0:0] user;
    } struct_9;
    typedef struct packed {
        logic[3:0] id;
        logic[63:0] addr;
        logic[7:0] len;
        logic[2:0] size;
        enum_0 burst;
        logic lock;
        logic[3:0] cache;
        logic[2:0] prot;
        logic[3:0] qos;
        logic[3:0] region;
        logic[0:0] user;
    } struct_10;
    typedef struct packed {
        logic[63:0] data;
        logic[7:0] strb;
        logic last;
        logic[0:0] user;
    } struct_11;
    typedef struct packed {
        logic[3:0] id;
        enum_1 resp;
        logic[0:0] user;
    } struct_12;
    typedef struct packed {
        logic[3:0] id;
        logic[63:0] addr;
        logic[7:0] len;
        logic[2:0] size;
        enum_0 burst;
        logic lock;
        logic[3:0] cache;
        logic[2:0] prot;
        logic[3:0] qos;
        logic[3:0] region;
        logic[0:0] user;
    } struct_13;
    typedef struct packed {
        logic[3:0] id;
        logic[63:0] data;
        enum_1 resp;
        logic last;
        logic[0:0] user;
    } struct_14;
    typedef struct packed {
        logic[3:0] active_slave;
        logic[7:0] active_cnt;
    } struct_15;
endpackage

/* file: ../../axi/src/axi_pkg.sv */
/* file: ../../axi/src/axi_intf.sv */

/* file: axi_xbar_wrapper.sv */

/* file: axi_xbar_rework.sv */
module axi_xbar_rework (
    input wire logic clk,
    input wire logic rst_n,
    input wire logic test_en_i,
    AXI_BUS.Slave slave_0,
    AXI_BUS.Slave slave_1,
    AXI_BUS.Master master_0,
    AXI_BUS.Master master_1,
    AXI_BUS.Master master_2,
    AXI_BUS.Master master_3,
    AXI_BUS.Master master_4,
    AXI_BUS.Master master_5,
    AXI_BUS.Master master_6,
    AXI_BUS.Master master_7,
    AXI_BUS.Master master_8,
    input wire logic[8:0][63:0] start_addr_i,
    input wire logic[8:0][63:0] end_addr_i
);
    parameter integer NB_MASTER = 9;
    parameter integer NB_SLAVE = 2;
    parameter integer AXI_ADDR_WIDTH = 64;
    parameter integer AXI_DATA_WIDTH = 64;
    parameter integer AXI_ID_WIDTH = 4;
    parameter integer AXI_USER_WIDTH = 1;
    parameter integer MASTER_SLICE_DEPTH = 1;
    parameter integer SLAVE_SLICE_DEPTH = 1;
    localparam integer AXI_ID_OUT = 5;
    logic[8:0][63:0] start_addr;
    logic[8:0][63:0] mask_addr;
    axi_channel master_buf_0 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel master_buf_1 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel master_buf_2 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel master_buf_3 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel master_buf_4 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel master_buf_5 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel master_buf_6 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel master_buf_7 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel master_buf_8 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel_1 slave_buf_0 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel_1 slave_buf_1 (
        .clk(clk),
        .rstn(rst_n)
    );
    localparam integer genblk1_0_i = 0;
    from_if genblk1_0_from_if_adapter (
        .incoming_if(slave_0),
        .outgoing_openip(slave_buf_0)
    );
    localparam integer genblk1_1_i = 1;
    from_if genblk1_1_from_if_adapter (
        .incoming_if(slave_1),
        .outgoing_openip(slave_buf_1)
    );
    localparam integer genblk2_0_i = 0;
    to_if genblk2_0_to_if_adapter (
        .outgoing_if(master_0),
        .incoming_openip(master_buf_0)
    );
    assign mask_addr[0] = end_addr_i[0] - start_addr_i[0];
    assign start_addr[0] = start_addr_i[0];
    localparam integer genblk2_1_i = 1;
    to_if genblk2_1_to_if_adapter (
        .outgoing_if(master_1),
        .incoming_openip(master_buf_1)
    );
    assign mask_addr[1] = end_addr_i[1] - start_addr_i[1];
    assign start_addr[1] = start_addr_i[1];
    localparam integer genblk2_2_i = 2;
    to_if genblk2_2_to_if_adapter (
        .outgoing_if(master_2),
        .incoming_openip(master_buf_2)
    );
    assign mask_addr[2] = end_addr_i[2] - start_addr_i[2];
    assign start_addr[2] = start_addr_i[2];
    localparam integer genblk2_3_i = 3;
    to_if genblk2_3_to_if_adapter (
        .outgoing_if(master_3),
        .incoming_openip(master_buf_3)
    );
    assign mask_addr[3] = end_addr_i[3] - start_addr_i[3];
    assign start_addr[3] = start_addr_i[3];
    localparam integer genblk2_4_i = 4;
    to_if genblk2_4_to_if_adapter (
        .outgoing_if(master_4),
        .incoming_openip(master_buf_4)
    );
    assign mask_addr[4] = end_addr_i[4] - start_addr_i[4];
    assign start_addr[4] = start_addr_i[4];
    localparam integer genblk2_5_i = 5;
    to_if genblk2_5_to_if_adapter (
        .outgoing_if(master_5),
        .incoming_openip(master_buf_5)
    );
    assign mask_addr[5] = end_addr_i[5] - start_addr_i[5];
    assign start_addr[5] = start_addr_i[5];
    localparam integer genblk2_6_i = 6;
    to_if genblk2_6_to_if_adapter (
        .outgoing_if(master_6),
        .incoming_openip(master_buf_6)
    );
    assign mask_addr[6] = end_addr_i[6] - start_addr_i[6];
    assign start_addr[6] = start_addr_i[6];
    localparam integer genblk2_7_i = 7;
    to_if genblk2_7_to_if_adapter (
        .outgoing_if(master_7),
        .incoming_openip(master_buf_7)
    );
    assign mask_addr[7] = end_addr_i[7] - start_addr_i[7];
    assign start_addr[7] = start_addr_i[7];
    localparam integer genblk2_8_i = 8;
    to_if genblk2_8_to_if_adapter (
        .outgoing_if(master_8),
        .incoming_openip(master_buf_8)
    );
    assign mask_addr[8] = end_addr_i[8] - start_addr_i[8];
    assign start_addr[8] = start_addr_i[8];
    axi_crossbar openip_xbar (
        .master_0(slave_buf_0),
        .master_1(slave_buf_1),
        .slave_0(master_buf_0),
        .slave_1(master_buf_1),
        .slave_2(master_buf_2),
        .slave_3(master_buf_3),
        .slave_4(master_buf_4),
        .slave_5(master_buf_5),
        .slave_6(master_buf_6),
        .slave_7(master_buf_7),
        .slave_8(master_buf_8),
        .BASE(start_addr),
        .MASK(mask_addr)
    );
endmodule

/* file: ../axi/bram_ctrl.sv */
/* file: ../axi/buf.sv */
/* file: ../axi/channel.sv */
interface axi_channel (
    input wire logic clk,
    input wire logic rstn
);
    parameter integer ID_WIDTH = 5;
    parameter integer ADDR_WIDTH = 64;
    parameter integer DATA_WIDTH = 64;
    parameter integer AW_USER_WIDTH = 1;
    parameter integer W_USER_WIDTH = 1;
    parameter integer B_USER_WIDTH = 1;
    parameter integer AR_USER_WIDTH = 1;
    parameter integer R_USER_WIDTH = 1;
    localparam integer STRB_WIDTH = 8;
    logic[4:0] aw_id;
    logic[63:0] aw_addr;
    logic[7:0] aw_len;
    logic[2:0] aw_size;
    global_types::enum_0 aw_burst;
    logic aw_lock;
    logic[3:0] aw_cache;
    logic[2:0] aw_prot;
    logic[3:0] aw_qos;
    logic[3:0] aw_region;
    logic[0:0] aw_user;
    logic aw_valid;
    logic aw_ready;
    logic[63:0] w_data;
    logic[7:0] w_strb;
    logic w_last;
    logic[0:0] w_user;
    logic w_valid;
    logic w_ready;
    logic[4:0] b_id;
    global_types::enum_1 b_resp;
    logic[0:0] b_user;
    logic b_valid;
    logic b_ready;
    logic[4:0] ar_id;
    logic[63:0] ar_addr;
    logic[7:0] ar_len;
    logic[2:0] ar_size;
    global_types::enum_0 ar_burst;
    logic ar_lock;
    logic[3:0] ar_cache;
    logic[2:0] ar_prot;
    logic[3:0] ar_qos;
    logic[3:0] ar_region;
    logic[0:0] ar_user;
    logic ar_valid;
    logic ar_ready;
    logic[4:0] r_id;
    logic[63:0] r_data;
    global_types::enum_1 r_resp;
    logic r_last;
    logic[0:0] r_user;
    logic r_valid;
    logic r_ready;
    modport master (
        input clk,
        input rstn,
        output aw_id,
        output aw_addr,
        output aw_len,
        output aw_size,
        output aw_burst,
        output aw_lock,
        output aw_cache,
        output aw_prot,
        output aw_qos,
        output aw_region,
        output aw_user,
        output aw_valid,
        input aw_ready,
        output w_data,
        output w_strb,
        output w_last,
        output w_user,
        output w_valid,
        input w_ready,
        input b_id,
        input b_resp,
        input b_user,
        input b_valid,
        output b_ready,
        output ar_id,
        output ar_addr,
        output ar_len,
        output ar_size,
        output ar_burst,
        output ar_lock,
        output ar_cache,
        output ar_prot,
        output ar_qos,
        output ar_region,
        output ar_user,
        output ar_valid,
        input ar_ready,
        input r_id,
        input r_data,
        input r_resp,
        input r_last,
        input r_user,
        input r_valid,
        output r_ready
    );
    modport slave (
        input clk,
        input rstn,
        input aw_id,
        input aw_addr,
        input aw_len,
        input aw_size,
        input aw_burst,
        input aw_lock,
        input aw_cache,
        input aw_prot,
        input aw_qos,
        input aw_region,
        input aw_user,
        input aw_valid,
        output aw_ready,
        input w_data,
        input w_strb,
        input w_last,
        input w_user,
        input w_valid,
        output w_ready,
        output b_id,
        output b_resp,
        output b_user,
        output b_valid,
        input b_ready,
        input ar_id,
        input ar_addr,
        input ar_len,
        input ar_size,
        input ar_burst,
        input ar_lock,
        input ar_cache,
        input ar_prot,
        input ar_qos,
        input ar_region,
        input ar_user,
        input ar_valid,
        output ar_ready,
        output r_id,
        output r_data,
        output r_resp,
        output r_last,
        output r_user,
        output r_valid,
        input r_ready
    );
    typedef global_types::struct_5 aw_pack_t;
    typedef global_types::struct_6 w_pack_t;
    typedef global_types::struct_7 b_pack_t;
    typedef global_types::struct_8 ar_pack_t;
    typedef global_types::struct_9 r_pack_t;
endinterface
interface axi_channel_1 (
    input wire logic clk,
    input wire logic rstn
);
    parameter integer ID_WIDTH = 4;
    parameter integer ADDR_WIDTH = 64;
    parameter integer DATA_WIDTH = 64;
    parameter integer AW_USER_WIDTH = 1;
    parameter integer W_USER_WIDTH = 1;
    parameter integer B_USER_WIDTH = 1;
    parameter integer AR_USER_WIDTH = 1;
    parameter integer R_USER_WIDTH = 1;
    localparam integer STRB_WIDTH = 8;
    logic[3:0] aw_id;
    logic[63:0] aw_addr;
    logic[7:0] aw_len;
    logic[2:0] aw_size;
    global_types::enum_0 aw_burst;
    logic aw_lock;
    logic[3:0] aw_cache;
    logic[2:0] aw_prot;
    logic[3:0] aw_qos;
    logic[3:0] aw_region;
    logic[0:0] aw_user;
    logic aw_valid;
    logic aw_ready;
    logic[63:0] w_data;
    logic[7:0] w_strb;
    logic w_last;
    logic[0:0] w_user;
    logic w_valid;
    logic w_ready;
    logic[3:0] b_id;
    global_types::enum_1 b_resp;
    logic[0:0] b_user;
    logic b_valid;
    logic b_ready;
    logic[3:0] ar_id;
    logic[63:0] ar_addr;
    logic[7:0] ar_len;
    logic[2:0] ar_size;
    global_types::enum_0 ar_burst;
    logic ar_lock;
    logic[3:0] ar_cache;
    logic[2:0] ar_prot;
    logic[3:0] ar_qos;
    logic[3:0] ar_region;
    logic[0:0] ar_user;
    logic ar_valid;
    logic ar_ready;
    logic[3:0] r_id;
    logic[63:0] r_data;
    global_types::enum_1 r_resp;
    logic r_last;
    logic[0:0] r_user;
    logic r_valid;
    logic r_ready;
    modport master (
        input clk,
        input rstn,
        output aw_id,
        output aw_addr,
        output aw_len,
        output aw_size,
        output aw_burst,
        output aw_lock,
        output aw_cache,
        output aw_prot,
        output aw_qos,
        output aw_region,
        output aw_user,
        output aw_valid,
        input aw_ready,
        output w_data,
        output w_strb,
        output w_last,
        output w_user,
        output w_valid,
        input w_ready,
        input b_id,
        input b_resp,
        input b_user,
        input b_valid,
        output b_ready,
        output ar_id,
        output ar_addr,
        output ar_len,
        output ar_size,
        output ar_burst,
        output ar_lock,
        output ar_cache,
        output ar_prot,
        output ar_qos,
        output ar_region,
        output ar_user,
        output ar_valid,
        input ar_ready,
        input r_id,
        input r_data,
        input r_resp,
        input r_last,
        input r_user,
        input r_valid,
        output r_ready
    );
    modport slave (
        input clk,
        input rstn,
        input aw_id,
        input aw_addr,
        input aw_len,
        input aw_size,
        input aw_burst,
        input aw_lock,
        input aw_cache,
        input aw_prot,
        input aw_qos,
        input aw_region,
        input aw_user,
        input aw_valid,
        output aw_ready,
        input w_data,
        input w_strb,
        input w_last,
        input w_user,
        input w_valid,
        output w_ready,
        output b_id,
        output b_resp,
        output b_user,
        output b_valid,
        input b_ready,
        input ar_id,
        input ar_addr,
        input ar_len,
        input ar_size,
        input ar_burst,
        input ar_lock,
        input ar_cache,
        input ar_prot,
        input ar_qos,
        input ar_region,
        input ar_user,
        input ar_valid,
        output ar_ready,
        output r_id,
        output r_data,
        output r_resp,
        output r_last,
        output r_user,
        output r_valid,
        input r_ready
    );
    typedef global_types::struct_10 aw_pack_t;
    typedef global_types::struct_11 w_pack_t;
    typedef global_types::struct_12 b_pack_t;
    typedef global_types::struct_13 ar_pack_t;
    typedef global_types::struct_14 r_pack_t;
endinterface

/* file: ../axi/common.sv */
/* file: ../axi/crossbar.sv */
module axi_crossbar (
    axi_channel_1.slave master_0,
    axi_channel_1.slave master_1,
    axi_channel.master slave_0,
    axi_channel.master slave_1,
    axi_channel.master slave_2,
    axi_channel.master slave_3,
    axi_channel.master slave_4,
    axi_channel.master slave_5,
    axi_channel.master slave_6,
    axi_channel.master slave_7,
    axi_channel.master slave_8,
    input wire logic[8:0][63:0] BASE,
    input wire logic[8:0][63:0] MASK
);
    parameter integer MASTER_NUM = 2;
    parameter integer SLAVE_NUM = 9;
    parameter integer ADDR_WIDTH = 64;
    localparam integer demux_0_i = 0;
    axi_channel_1 demux_0_master_buf (
        .clk(master_0.clk),
        .rstn(master_0.rstn)
    );
    axi_channel_1 demux_0_channels_0 (
        .clk(master_0.clk),
        .rstn(master_0.rstn)
    );
    axi_channel_1 demux_0_channels_1 (
        .clk(master_0.clk),
        .rstn(master_0.rstn)
    );
    axi_channel_1 demux_0_channels_2 (
        .clk(master_0.clk),
        .rstn(master_0.rstn)
    );
    axi_channel_1 demux_0_channels_3 (
        .clk(master_0.clk),
        .rstn(master_0.rstn)
    );
    axi_channel_1 demux_0_channels_4 (
        .clk(master_0.clk),
        .rstn(master_0.rstn)
    );
    axi_channel_1 demux_0_channels_5 (
        .clk(master_0.clk),
        .rstn(master_0.rstn)
    );
    axi_channel_1 demux_0_channels_6 (
        .clk(master_0.clk),
        .rstn(master_0.rstn)
    );
    axi_channel_1 demux_0_channels_7 (
        .clk(master_0.clk),
        .rstn(master_0.rstn)
    );
    axi_channel_1 demux_0_channels_8 (
        .clk(master_0.clk),
        .rstn(master_0.rstn)
    );
    axi_demux_raw demux_0_demux (
        .master(demux_0_master_buf),
        .slave_0(demux_0_channels_0),
        .slave_1(demux_0_channels_1),
        .slave_2(demux_0_channels_2),
        .slave_3(demux_0_channels_3),
        .slave_4(demux_0_channels_4),
        .slave_5(demux_0_channels_5),
        .slave_6(demux_0_channels_6),
        .slave_7(demux_0_channels_7),
        .slave_8(demux_0_channels_8),
        .BASE(BASE),
        .MASK(MASK)
    );
    axi_regslice demux_0_master_slice (
        .master(master_0),
        .slave(demux_0_master_buf)
    );
    localparam integer demux_1_i = 1;
    axi_channel_1 demux_1_master_buf (
        .clk(master_1.clk),
        .rstn(master_1.rstn)
    );
    axi_channel_1 demux_1_channels_0 (
        .clk(master_1.clk),
        .rstn(master_1.rstn)
    );
    axi_channel_1 demux_1_channels_1 (
        .clk(master_1.clk),
        .rstn(master_1.rstn)
    );
    axi_channel_1 demux_1_channels_2 (
        .clk(master_1.clk),
        .rstn(master_1.rstn)
    );
    axi_channel_1 demux_1_channels_3 (
        .clk(master_1.clk),
        .rstn(master_1.rstn)
    );
    axi_channel_1 demux_1_channels_4 (
        .clk(master_1.clk),
        .rstn(master_1.rstn)
    );
    axi_channel_1 demux_1_channels_5 (
        .clk(master_1.clk),
        .rstn(master_1.rstn)
    );
    axi_channel_1 demux_1_channels_6 (
        .clk(master_1.clk),
        .rstn(master_1.rstn)
    );
    axi_channel_1 demux_1_channels_7 (
        .clk(master_1.clk),
        .rstn(master_1.rstn)
    );
    axi_channel_1 demux_1_channels_8 (
        .clk(master_1.clk),
        .rstn(master_1.rstn)
    );
    axi_demux_raw demux_1_demux (
        .master(demux_1_master_buf),
        .slave_0(demux_1_channels_0),
        .slave_1(demux_1_channels_1),
        .slave_2(demux_1_channels_2),
        .slave_3(demux_1_channels_3),
        .slave_4(demux_1_channels_4),
        .slave_5(demux_1_channels_5),
        .slave_6(demux_1_channels_6),
        .slave_7(demux_1_channels_7),
        .slave_8(demux_1_channels_8),
        .BASE(BASE),
        .MASK(MASK)
    );
    axi_regslice demux_1_master_slice (
        .master(master_1),
        .slave(demux_1_master_buf)
    );
    localparam integer mux_0_i = 0;
    axi_channel_1 mux_0_channels_0 (
        .clk(slave_0.clk),
        .rstn(slave_0.rstn)
    );
    axi_channel_1 mux_0_channels_1 (
        .clk(slave_0.clk),
        .rstn(slave_0.rstn)
    );
    axi_channel mux_0_slave_buf (
        .clk(slave_0.clk),
        .rstn(slave_0.rstn)
    );
    axi_mux_raw mux_0_mux (
        .master_0(mux_0_channels_0),
        .master_1(mux_0_channels_1),
        .slave(mux_0_slave_buf)
    );
    axi_regslice_1 mux_0_slice (
        .master(mux_0_slave_buf),
        .slave(slave_0)
    );
    localparam integer mux_0_genblk1_0_j = 0;
    axi_join_ mux_0_genblk1_0_joiner (
        .master(demux_0_channels_0),
        .slave(mux_0_channels_0)
    );
    localparam integer mux_0_genblk1_1_j = 1;
    axi_join_ mux_0_genblk1_1_joiner (
        .master(demux_1_channels_0),
        .slave(mux_0_channels_1)
    );
    localparam integer mux_1_i = 1;
    axi_channel_1 mux_1_channels_0 (
        .clk(slave_1.clk),
        .rstn(slave_1.rstn)
    );
    axi_channel_1 mux_1_channels_1 (
        .clk(slave_1.clk),
        .rstn(slave_1.rstn)
    );
    axi_channel mux_1_slave_buf (
        .clk(slave_1.clk),
        .rstn(slave_1.rstn)
    );
    axi_mux_raw mux_1_mux (
        .master_0(mux_1_channels_0),
        .master_1(mux_1_channels_1),
        .slave(mux_1_slave_buf)
    );
    axi_regslice_1 mux_1_slice (
        .master(mux_1_slave_buf),
        .slave(slave_1)
    );
    localparam integer mux_1_genblk1_0_j = 0;
    axi_join_ mux_1_genblk1_0_joiner (
        .master(demux_0_channels_1),
        .slave(mux_1_channels_0)
    );
    localparam integer mux_1_genblk1_1_j = 1;
    axi_join_ mux_1_genblk1_1_joiner (
        .master(demux_1_channels_1),
        .slave(mux_1_channels_1)
    );
    localparam integer mux_2_i = 2;
    axi_channel_1 mux_2_channels_0 (
        .clk(slave_2.clk),
        .rstn(slave_2.rstn)
    );
    axi_channel_1 mux_2_channels_1 (
        .clk(slave_2.clk),
        .rstn(slave_2.rstn)
    );
    axi_channel mux_2_slave_buf (
        .clk(slave_2.clk),
        .rstn(slave_2.rstn)
    );
    axi_mux_raw mux_2_mux (
        .master_0(mux_2_channels_0),
        .master_1(mux_2_channels_1),
        .slave(mux_2_slave_buf)
    );
    axi_regslice_1 mux_2_slice (
        .master(mux_2_slave_buf),
        .slave(slave_2)
    );
    localparam integer mux_2_genblk1_0_j = 0;
    axi_join_ mux_2_genblk1_0_joiner (
        .master(demux_0_channels_2),
        .slave(mux_2_channels_0)
    );
    localparam integer mux_2_genblk1_1_j = 1;
    axi_join_ mux_2_genblk1_1_joiner (
        .master(demux_1_channels_2),
        .slave(mux_2_channels_1)
    );
    localparam integer mux_3_i = 3;
    axi_channel_1 mux_3_channels_0 (
        .clk(slave_3.clk),
        .rstn(slave_3.rstn)
    );
    axi_channel_1 mux_3_channels_1 (
        .clk(slave_3.clk),
        .rstn(slave_3.rstn)
    );
    axi_channel mux_3_slave_buf (
        .clk(slave_3.clk),
        .rstn(slave_3.rstn)
    );
    axi_mux_raw mux_3_mux (
        .master_0(mux_3_channels_0),
        .master_1(mux_3_channels_1),
        .slave(mux_3_slave_buf)
    );
    axi_regslice_1 mux_3_slice (
        .master(mux_3_slave_buf),
        .slave(slave_3)
    );
    localparam integer mux_3_genblk1_0_j = 0;
    axi_join_ mux_3_genblk1_0_joiner (
        .master(demux_0_channels_3),
        .slave(mux_3_channels_0)
    );
    localparam integer mux_3_genblk1_1_j = 1;
    axi_join_ mux_3_genblk1_1_joiner (
        .master(demux_1_channels_3),
        .slave(mux_3_channels_1)
    );
    localparam integer mux_4_i = 4;
    axi_channel_1 mux_4_channels_0 (
        .clk(slave_4.clk),
        .rstn(slave_4.rstn)
    );
    axi_channel_1 mux_4_channels_1 (
        .clk(slave_4.clk),
        .rstn(slave_4.rstn)
    );
    axi_channel mux_4_slave_buf (
        .clk(slave_4.clk),
        .rstn(slave_4.rstn)
    );
    axi_mux_raw mux_4_mux (
        .master_0(mux_4_channels_0),
        .master_1(mux_4_channels_1),
        .slave(mux_4_slave_buf)
    );
    axi_regslice_1 mux_4_slice (
        .master(mux_4_slave_buf),
        .slave(slave_4)
    );
    localparam integer mux_4_genblk1_0_j = 0;
    axi_join_ mux_4_genblk1_0_joiner (
        .master(demux_0_channels_4),
        .slave(mux_4_channels_0)
    );
    localparam integer mux_4_genblk1_1_j = 1;
    axi_join_ mux_4_genblk1_1_joiner (
        .master(demux_1_channels_4),
        .slave(mux_4_channels_1)
    );
    localparam integer mux_5_i = 5;
    axi_channel_1 mux_5_channels_0 (
        .clk(slave_5.clk),
        .rstn(slave_5.rstn)
    );
    axi_channel_1 mux_5_channels_1 (
        .clk(slave_5.clk),
        .rstn(slave_5.rstn)
    );
    axi_channel mux_5_slave_buf (
        .clk(slave_5.clk),
        .rstn(slave_5.rstn)
    );
    axi_mux_raw mux_5_mux (
        .master_0(mux_5_channels_0),
        .master_1(mux_5_channels_1),
        .slave(mux_5_slave_buf)
    );
    axi_regslice_1 mux_5_slice (
        .master(mux_5_slave_buf),
        .slave(slave_5)
    );
    localparam integer mux_5_genblk1_0_j = 0;
    axi_join_ mux_5_genblk1_0_joiner (
        .master(demux_0_channels_5),
        .slave(mux_5_channels_0)
    );
    localparam integer mux_5_genblk1_1_j = 1;
    axi_join_ mux_5_genblk1_1_joiner (
        .master(demux_1_channels_5),
        .slave(mux_5_channels_1)
    );
    localparam integer mux_6_i = 6;
    axi_channel_1 mux_6_channels_0 (
        .clk(slave_6.clk),
        .rstn(slave_6.rstn)
    );
    axi_channel_1 mux_6_channels_1 (
        .clk(slave_6.clk),
        .rstn(slave_6.rstn)
    );
    axi_channel mux_6_slave_buf (
        .clk(slave_6.clk),
        .rstn(slave_6.rstn)
    );
    axi_mux_raw mux_6_mux (
        .master_0(mux_6_channels_0),
        .master_1(mux_6_channels_1),
        .slave(mux_6_slave_buf)
    );
    axi_regslice_1 mux_6_slice (
        .master(mux_6_slave_buf),
        .slave(slave_6)
    );
    localparam integer mux_6_genblk1_0_j = 0;
    axi_join_ mux_6_genblk1_0_joiner (
        .master(demux_0_channels_6),
        .slave(mux_6_channels_0)
    );
    localparam integer mux_6_genblk1_1_j = 1;
    axi_join_ mux_6_genblk1_1_joiner (
        .master(demux_1_channels_6),
        .slave(mux_6_channels_1)
    );
    localparam integer mux_7_i = 7;
    axi_channel_1 mux_7_channels_0 (
        .clk(slave_7.clk),
        .rstn(slave_7.rstn)
    );
    axi_channel_1 mux_7_channels_1 (
        .clk(slave_7.clk),
        .rstn(slave_7.rstn)
    );
    axi_channel mux_7_slave_buf (
        .clk(slave_7.clk),
        .rstn(slave_7.rstn)
    );
    axi_mux_raw mux_7_mux (
        .master_0(mux_7_channels_0),
        .master_1(mux_7_channels_1),
        .slave(mux_7_slave_buf)
    );
    axi_regslice_1 mux_7_slice (
        .master(mux_7_slave_buf),
        .slave(slave_7)
    );
    localparam integer mux_7_genblk1_0_j = 0;
    axi_join_ mux_7_genblk1_0_joiner (
        .master(demux_0_channels_7),
        .slave(mux_7_channels_0)
    );
    localparam integer mux_7_genblk1_1_j = 1;
    axi_join_ mux_7_genblk1_1_joiner (
        .master(demux_1_channels_7),
        .slave(mux_7_channels_1)
    );
    localparam integer mux_8_i = 8;
    axi_channel_1 mux_8_channels_0 (
        .clk(slave_8.clk),
        .rstn(slave_8.rstn)
    );
    axi_channel_1 mux_8_channels_1 (
        .clk(slave_8.clk),
        .rstn(slave_8.rstn)
    );
    axi_channel mux_8_slave_buf (
        .clk(slave_8.clk),
        .rstn(slave_8.rstn)
    );
    axi_mux_raw mux_8_mux (
        .master_0(mux_8_channels_0),
        .master_1(mux_8_channels_1),
        .slave(mux_8_slave_buf)
    );
    axi_regslice_1 mux_8_slice (
        .master(mux_8_slave_buf),
        .slave(slave_8)
    );
    localparam integer mux_8_genblk1_0_j = 0;
    axi_join_ mux_8_genblk1_0_joiner (
        .master(demux_0_channels_8),
        .slave(mux_8_channels_0)
    );
    localparam integer mux_8_genblk1_1_j = 1;
    axi_join_ mux_8_genblk1_1_joiner (
        .master(demux_1_channels_8),
        .slave(mux_8_channels_1)
    );
endmodule

/* file: ../axi/demux.sv */
module axi_demux_raw (
    axi_channel_1.slave master,
    axi_channel_1.master slave_0,
    axi_channel_1.master slave_1,
    axi_channel_1.master slave_2,
    axi_channel_1.master slave_3,
    axi_channel_1.master slave_4,
    axi_channel_1.master slave_5,
    axi_channel_1.master slave_6,
    axi_channel_1.master slave_7,
    axi_channel_1.master slave_8,
    input wire logic[8:0][63:0] BASE,
    input wire logic[8:0][63:0] MASK
);
    parameter integer SLAVE_NUM = 9;
    parameter integer ADDR_WIDTH = 64;
    parameter integer ACTIVE_CNT_WIDTH = 8;
    localparam integer SLAVE_WIDTH = 4;
    logic clk;
    logic rstn;
    assign clk = master.clk;
    assign rstn = master.rstn;
    typedef global_types::struct_12 b_pack_t;
    typedef global_types::struct_14 r_pack_t;
    logic[8:0] slave_aw_ready;
    logic[8:0] slave_w_ready;
    global_types::struct_12[8:0] slave_b;
    logic[8:0] slave_b_valid;
    logic[8:0] slave_ar_ready;
    global_types::struct_14[8:0] slave_r;
    logic[8:0] slave_r_valid;
    localparam integer pack_0_i = 0;
    assign slave_aw_ready[0] = slave_0.aw_ready;
    assign slave_w_ready[0] = slave_0.w_ready;
    assign slave_b[0] = global_types::struct_12'{slave_0.b_id, slave_0.b_resp, slave_0.b_user};
    assign slave_b_valid[0] = slave_0.b_valid;
    assign slave_ar_ready[0] = slave_0.ar_ready;
    assign slave_r[0] = global_types::struct_14'{slave_0.r_id, slave_0.r_data, slave_0.r_resp, slave_0.r_last, slave_0.r_user};
    assign slave_r_valid[0] = slave_0.r_valid;
    localparam integer pack_1_i = 1;
    assign slave_aw_ready[1] = slave_1.aw_ready;
    assign slave_w_ready[1] = slave_1.w_ready;
    assign slave_b[1] = global_types::struct_12'{slave_1.b_id, slave_1.b_resp, slave_1.b_user};
    assign slave_b_valid[1] = slave_1.b_valid;
    assign slave_ar_ready[1] = slave_1.ar_ready;
    assign slave_r[1] = global_types::struct_14'{slave_1.r_id, slave_1.r_data, slave_1.r_resp, slave_1.r_last, slave_1.r_user};
    assign slave_r_valid[1] = slave_1.r_valid;
    localparam integer pack_2_i = 2;
    assign slave_aw_ready[2] = slave_2.aw_ready;
    assign slave_w_ready[2] = slave_2.w_ready;
    assign slave_b[2] = global_types::struct_12'{slave_2.b_id, slave_2.b_resp, slave_2.b_user};
    assign slave_b_valid[2] = slave_2.b_valid;
    assign slave_ar_ready[2] = slave_2.ar_ready;
    assign slave_r[2] = global_types::struct_14'{slave_2.r_id, slave_2.r_data, slave_2.r_resp, slave_2.r_last, slave_2.r_user};
    assign slave_r_valid[2] = slave_2.r_valid;
    localparam integer pack_3_i = 3;
    assign slave_aw_ready[3] = slave_3.aw_ready;
    assign slave_w_ready[3] = slave_3.w_ready;
    assign slave_b[3] = global_types::struct_12'{slave_3.b_id, slave_3.b_resp, slave_3.b_user};
    assign slave_b_valid[3] = slave_3.b_valid;
    assign slave_ar_ready[3] = slave_3.ar_ready;
    assign slave_r[3] = global_types::struct_14'{slave_3.r_id, slave_3.r_data, slave_3.r_resp, slave_3.r_last, slave_3.r_user};
    assign slave_r_valid[3] = slave_3.r_valid;
    localparam integer pack_4_i = 4;
    assign slave_aw_ready[4] = slave_4.aw_ready;
    assign slave_w_ready[4] = slave_4.w_ready;
    assign slave_b[4] = global_types::struct_12'{slave_4.b_id, slave_4.b_resp, slave_4.b_user};
    assign slave_b_valid[4] = slave_4.b_valid;
    assign slave_ar_ready[4] = slave_4.ar_ready;
    assign slave_r[4] = global_types::struct_14'{slave_4.r_id, slave_4.r_data, slave_4.r_resp, slave_4.r_last, slave_4.r_user};
    assign slave_r_valid[4] = slave_4.r_valid;
    localparam integer pack_5_i = 5;
    assign slave_aw_ready[5] = slave_5.aw_ready;
    assign slave_w_ready[5] = slave_5.w_ready;
    assign slave_b[5] = global_types::struct_12'{slave_5.b_id, slave_5.b_resp, slave_5.b_user};
    assign slave_b_valid[5] = slave_5.b_valid;
    assign slave_ar_ready[5] = slave_5.ar_ready;
    assign slave_r[5] = global_types::struct_14'{slave_5.r_id, slave_5.r_data, slave_5.r_resp, slave_5.r_last, slave_5.r_user};
    assign slave_r_valid[5] = slave_5.r_valid;
    localparam integer pack_6_i = 6;
    assign slave_aw_ready[6] = slave_6.aw_ready;
    assign slave_w_ready[6] = slave_6.w_ready;
    assign slave_b[6] = global_types::struct_12'{slave_6.b_id, slave_6.b_resp, slave_6.b_user};
    assign slave_b_valid[6] = slave_6.b_valid;
    assign slave_ar_ready[6] = slave_6.ar_ready;
    assign slave_r[6] = global_types::struct_14'{slave_6.r_id, slave_6.r_data, slave_6.r_resp, slave_6.r_last, slave_6.r_user};
    assign slave_r_valid[6] = slave_6.r_valid;
    localparam integer pack_7_i = 7;
    assign slave_aw_ready[7] = slave_7.aw_ready;
    assign slave_w_ready[7] = slave_7.w_ready;
    assign slave_b[7] = global_types::struct_12'{slave_7.b_id, slave_7.b_resp, slave_7.b_user};
    assign slave_b_valid[7] = slave_7.b_valid;
    assign slave_ar_ready[7] = slave_7.ar_ready;
    assign slave_r[7] = global_types::struct_14'{slave_7.r_id, slave_7.r_data, slave_7.r_resp, slave_7.r_last, slave_7.r_user};
    assign slave_r_valid[7] = slave_7.r_valid;
    localparam integer pack_8_i = 8;
    assign slave_aw_ready[8] = slave_8.aw_ready;
    assign slave_w_ready[8] = slave_8.w_ready;
    assign slave_b[8] = global_types::struct_12'{slave_8.b_id, slave_8.b_resp, slave_8.b_user};
    assign slave_b_valid[8] = slave_8.b_valid;
    assign slave_ar_ready[8] = slave_8.ar_ready;
    assign slave_r[8] = global_types::struct_14'{slave_8.r_id, slave_8.r_data, slave_8.r_resp, slave_8.r_last, slave_8.r_user};
    assign slave_r_valid[8] = slave_8.r_valid;
    logic[8:0] aw_match;
    logic[8:0] ar_match;
    logic[3:0] aw_match_bin;
    logic[3:0] ar_match_bin;
    localparam integer genblk3_0_i = 0;
    assign aw_match[0] = MASK[0] != 64'd0 && (master.aw_addr & ~MASK[0]) == BASE[0];
    assign ar_match[0] = MASK[0] != 64'd0 && (master.ar_addr & ~MASK[0]) == BASE[0];
    localparam integer genblk3_1_i = 1;
    assign aw_match[1] = MASK[1] != 64'd0 && (master.aw_addr & ~MASK[1]) == BASE[1];
    assign ar_match[1] = MASK[1] != 64'd0 && (master.ar_addr & ~MASK[1]) == BASE[1];
    localparam integer genblk3_2_i = 2;
    assign aw_match[2] = MASK[2] != 64'd0 && (master.aw_addr & ~MASK[2]) == BASE[2];
    assign ar_match[2] = MASK[2] != 64'd0 && (master.ar_addr & ~MASK[2]) == BASE[2];
    localparam integer genblk3_3_i = 3;
    assign aw_match[3] = MASK[3] != 64'd0 && (master.aw_addr & ~MASK[3]) == BASE[3];
    assign ar_match[3] = MASK[3] != 64'd0 && (master.ar_addr & ~MASK[3]) == BASE[3];
    localparam integer genblk3_4_i = 4;
    assign aw_match[4] = MASK[4] != 64'd0 && (master.aw_addr & ~MASK[4]) == BASE[4];
    assign ar_match[4] = MASK[4] != 64'd0 && (master.ar_addr & ~MASK[4]) == BASE[4];
    localparam integer genblk3_5_i = 5;
    assign aw_match[5] = MASK[5] != 64'd0 && (master.aw_addr & ~MASK[5]) == BASE[5];
    assign ar_match[5] = MASK[5] != 64'd0 && (master.ar_addr & ~MASK[5]) == BASE[5];
    localparam integer genblk3_6_i = 6;
    assign aw_match[6] = MASK[6] != 64'd0 && (master.aw_addr & ~MASK[6]) == BASE[6];
    assign ar_match[6] = MASK[6] != 64'd0 && (master.ar_addr & ~MASK[6]) == BASE[6];
    localparam integer genblk3_7_i = 7;
    assign aw_match[7] = MASK[7] != 64'd0 && (master.aw_addr & ~MASK[7]) == BASE[7];
    assign ar_match[7] = MASK[7] != 64'd0 && (master.ar_addr & ~MASK[7]) == BASE[7];
    localparam integer genblk3_8_i = 8;
    assign aw_match[8] = MASK[8] != 64'd0 && (master.aw_addr & ~MASK[8]) == BASE[8];
    assign ar_match[8] = MASK[8] != 64'd0 && (master.ar_addr & ~MASK[8]) == BASE[8];
    onehot_to_binary aw_one2bin (
        .onehot(aw_match),
        .binary(aw_match_bin)
    );
    onehot_to_binary ar_one2bin (
        .onehot(ar_match),
        .binary(ar_match_bin)
    );
    logic b_arb_enable;
    logic[8:0] b_arb_grant;
    logic[3:0] b_arb_grant_bin;
    logic r_arb_enable;
    logic[8:0] r_arb_grant;
    logic[3:0] r_arb_grant_bin;
    round_robin_arbiter b_arb (
        .clk(clk),
        .rstn(rstn),
        .enable(b_arb_enable),
        .request(slave_b_valid),
        .grant(b_arb_grant)
    );
    round_robin_arbiter r_arb (
        .clk(clk),
        .rstn(rstn),
        .enable(r_arb_enable),
        .request(slave_r_valid),
        .grant(r_arb_grant)
    );
    onehot_to_binary b_one2bin (
        .onehot(b_arb_grant),
        .binary(b_arb_grant_bin)
    );
    onehot_to_binary r_one2bin (
        .onehot(r_arb_grant),
        .binary(r_arb_grant_bin)
    );
    typedef global_types::struct_15 mapping_t;
    global_types::struct_15[15:0] write_map;
    global_types::struct_15 aw_lookup;
    assign aw_lookup = write_map[master.aw_id];
    logic aw_forward;
    assign aw_forward = master.aw_valid && (32'(aw_lookup.active_cnt) == 32'd0 || (aw_lookup.active_slave == aw_match_bin && 32'(aw_lookup.active_cnt) != 32'd2 ** 8 - 32'd1));
    logic[15:0] w_cnt_incr;
    logic[15:0] w_cnt_decr;
    localparam integer genblk4_0_i = 0;
    assign w_cnt_decr[0] = 32'(master.b_id) == 32'd0 && master.b_valid && master.b_ready;
    assign w_cnt_incr[0] = 32'(master.aw_id) == 32'd0 && master.aw_valid && master.aw_ready;
    localparam integer genblk4_1_i = 1;
    assign w_cnt_decr[1] = 32'(master.b_id) == 32'd1 && master.b_valid && master.b_ready;
    assign w_cnt_incr[1] = 32'(master.aw_id) == 32'd1 && master.aw_valid && master.aw_ready;
    localparam integer genblk4_2_i = 2;
    assign w_cnt_decr[2] = 32'(master.b_id) == 32'd2 && master.b_valid && master.b_ready;
    assign w_cnt_incr[2] = 32'(master.aw_id) == 32'd2 && master.aw_valid && master.aw_ready;
    localparam integer genblk4_3_i = 3;
    assign w_cnt_decr[3] = 32'(master.b_id) == 32'd3 && master.b_valid && master.b_ready;
    assign w_cnt_incr[3] = 32'(master.aw_id) == 32'd3 && master.aw_valid && master.aw_ready;
    localparam integer genblk4_4_i = 4;
    assign w_cnt_decr[4] = 32'(master.b_id) == 32'd4 && master.b_valid && master.b_ready;
    assign w_cnt_incr[4] = 32'(master.aw_id) == 32'd4 && master.aw_valid && master.aw_ready;
    localparam integer genblk4_5_i = 5;
    assign w_cnt_decr[5] = 32'(master.b_id) == 32'd5 && master.b_valid && master.b_ready;
    assign w_cnt_incr[5] = 32'(master.aw_id) == 32'd5 && master.aw_valid && master.aw_ready;
    localparam integer genblk4_6_i = 6;
    assign w_cnt_decr[6] = 32'(master.b_id) == 32'd6 && master.b_valid && master.b_ready;
    assign w_cnt_incr[6] = 32'(master.aw_id) == 32'd6 && master.aw_valid && master.aw_ready;
    localparam integer genblk4_7_i = 7;
    assign w_cnt_decr[7] = 32'(master.b_id) == 32'd7 && master.b_valid && master.b_ready;
    assign w_cnt_incr[7] = 32'(master.aw_id) == 32'd7 && master.aw_valid && master.aw_ready;
    localparam integer genblk4_8_i = 8;
    assign w_cnt_decr[8] = 32'(master.b_id) == 32'd8 && master.b_valid && master.b_ready;
    assign w_cnt_incr[8] = 32'(master.aw_id) == 32'd8 && master.aw_valid && master.aw_ready;
    localparam integer genblk4_9_i = 9;
    assign w_cnt_decr[9] = 32'(master.b_id) == 32'd9 && master.b_valid && master.b_ready;
    assign w_cnt_incr[9] = 32'(master.aw_id) == 32'd9 && master.aw_valid && master.aw_ready;
    localparam integer genblk4_10_i = 10;
    assign w_cnt_decr[10] = 32'(master.b_id) == 32'd10 && master.b_valid && master.b_ready;
    assign w_cnt_incr[10] = 32'(master.aw_id) == 32'd10 && master.aw_valid && master.aw_ready;
    localparam integer genblk4_11_i = 11;
    assign w_cnt_decr[11] = 32'(master.b_id) == 32'd11 && master.b_valid && master.b_ready;
    assign w_cnt_incr[11] = 32'(master.aw_id) == 32'd11 && master.aw_valid && master.aw_ready;
    localparam integer genblk4_12_i = 12;
    assign w_cnt_decr[12] = 32'(master.b_id) == 32'd12 && master.b_valid && master.b_ready;
    assign w_cnt_incr[12] = 32'(master.aw_id) == 32'd12 && master.aw_valid && master.aw_ready;
    localparam integer genblk4_13_i = 13;
    assign w_cnt_decr[13] = 32'(master.b_id) == 32'd13 && master.b_valid && master.b_ready;
    assign w_cnt_incr[13] = 32'(master.aw_id) == 32'd13 && master.aw_valid && master.aw_ready;
    localparam integer genblk4_14_i = 14;
    assign w_cnt_decr[14] = 32'(master.b_id) == 32'd14 && master.b_valid && master.b_ready;
    assign w_cnt_incr[14] = 32'(master.aw_id) == 32'd14 && master.aw_valid && master.aw_ready;
    localparam integer genblk4_15_i = 15;
    assign w_cnt_decr[15] = 32'(master.b_id) == 32'd15 && master.b_valid && master.b_ready;
    assign w_cnt_incr[15] = 32'(master.aw_id) == 32'd15 && master.aw_valid && master.aw_ready;
    always_ff @(posedge clk or negedge rstn) if (!rstn) begin
        for (int i = 0; i < 2 ** 4; i++) write_map[i] <= global_types::struct_15'(1'd0);
    end else begin
        for (int i = 0; i < 2 ** 4; i++) begin
            if (w_cnt_incr[i]) begin
                write_map[i].active_slave <= aw_match_bin;
                if (!w_cnt_decr[i]) write_map[i].active_cnt <= 32'(write_map[i].active_cnt) + 32'd1;
            end else if (w_cnt_decr[i]) begin
                write_map[i].active_cnt <= 32'(write_map[i].active_cnt) - 32'd1;
            end
        end
    end
    logic aw_locked;
    logic w_locked;
    logic[3:0] aw_selected;
    always_ff @(posedge clk or negedge rstn) if (!rstn) begin
        aw_locked <= 1'd0;
        w_locked <= 1'd0;
        aw_selected <= 4'd0;
    end else begin
        if (aw_locked || w_locked) begin
            if (master.aw_ready) begin
                aw_locked <= 1'd0;
            end
            if (master.w_last && master.w_valid && master.w_ready) begin
                w_locked <= 1'd0;
            end
        end else if (aw_forward) begin
            aw_locked <= 1'd1;
            w_locked <= 1'd1;
            aw_selected <= aw_match_bin;
        end
    end
    localparam integer genblk5_0_i = 0;
    assign slave_0.aw_id = master.aw_id;
    assign slave_0.aw_addr = master.aw_addr;
    assign slave_0.aw_len = master.aw_len;
    assign slave_0.aw_size = master.aw_size;
    assign slave_0.aw_burst = master.aw_burst;
    assign slave_0.aw_lock = master.aw_lock;
    assign slave_0.aw_cache = master.aw_cache;
    assign slave_0.aw_prot = master.aw_prot;
    assign slave_0.aw_qos = master.aw_qos;
    assign slave_0.aw_region = master.aw_region;
    assign slave_0.aw_user = master.aw_user;
    assign slave_0.aw_valid = aw_locked && 32'(aw_selected) == 32'd0;
    assign slave_0.w_data = master.w_data;
    assign slave_0.w_strb = master.w_strb;
    assign slave_0.w_last = master.w_last;
    assign slave_0.w_user = master.w_user;
    assign slave_0.w_valid = w_locked && 32'(aw_selected) == 32'd0 && master.w_valid;
    localparam integer genblk5_1_i = 1;
    assign slave_1.aw_id = master.aw_id;
    assign slave_1.aw_addr = master.aw_addr;
    assign slave_1.aw_len = master.aw_len;
    assign slave_1.aw_size = master.aw_size;
    assign slave_1.aw_burst = master.aw_burst;
    assign slave_1.aw_lock = master.aw_lock;
    assign slave_1.aw_cache = master.aw_cache;
    assign slave_1.aw_prot = master.aw_prot;
    assign slave_1.aw_qos = master.aw_qos;
    assign slave_1.aw_region = master.aw_region;
    assign slave_1.aw_user = master.aw_user;
    assign slave_1.aw_valid = aw_locked && 32'(aw_selected) == 32'd1;
    assign slave_1.w_data = master.w_data;
    assign slave_1.w_strb = master.w_strb;
    assign slave_1.w_last = master.w_last;
    assign slave_1.w_user = master.w_user;
    assign slave_1.w_valid = w_locked && 32'(aw_selected) == 32'd1 && master.w_valid;
    localparam integer genblk5_2_i = 2;
    assign slave_2.aw_id = master.aw_id;
    assign slave_2.aw_addr = master.aw_addr;
    assign slave_2.aw_len = master.aw_len;
    assign slave_2.aw_size = master.aw_size;
    assign slave_2.aw_burst = master.aw_burst;
    assign slave_2.aw_lock = master.aw_lock;
    assign slave_2.aw_cache = master.aw_cache;
    assign slave_2.aw_prot = master.aw_prot;
    assign slave_2.aw_qos = master.aw_qos;
    assign slave_2.aw_region = master.aw_region;
    assign slave_2.aw_user = master.aw_user;
    assign slave_2.aw_valid = aw_locked && 32'(aw_selected) == 32'd2;
    assign slave_2.w_data = master.w_data;
    assign slave_2.w_strb = master.w_strb;
    assign slave_2.w_last = master.w_last;
    assign slave_2.w_user = master.w_user;
    assign slave_2.w_valid = w_locked && 32'(aw_selected) == 32'd2 && master.w_valid;
    localparam integer genblk5_3_i = 3;
    assign slave_3.aw_id = master.aw_id;
    assign slave_3.aw_addr = master.aw_addr;
    assign slave_3.aw_len = master.aw_len;
    assign slave_3.aw_size = master.aw_size;
    assign slave_3.aw_burst = master.aw_burst;
    assign slave_3.aw_lock = master.aw_lock;
    assign slave_3.aw_cache = master.aw_cache;
    assign slave_3.aw_prot = master.aw_prot;
    assign slave_3.aw_qos = master.aw_qos;
    assign slave_3.aw_region = master.aw_region;
    assign slave_3.aw_user = master.aw_user;
    assign slave_3.aw_valid = aw_locked && 32'(aw_selected) == 32'd3;
    assign slave_3.w_data = master.w_data;
    assign slave_3.w_strb = master.w_strb;
    assign slave_3.w_last = master.w_last;
    assign slave_3.w_user = master.w_user;
    assign slave_3.w_valid = w_locked && 32'(aw_selected) == 32'd3 && master.w_valid;
    localparam integer genblk5_4_i = 4;
    assign slave_4.aw_id = master.aw_id;
    assign slave_4.aw_addr = master.aw_addr;
    assign slave_4.aw_len = master.aw_len;
    assign slave_4.aw_size = master.aw_size;
    assign slave_4.aw_burst = master.aw_burst;
    assign slave_4.aw_lock = master.aw_lock;
    assign slave_4.aw_cache = master.aw_cache;
    assign slave_4.aw_prot = master.aw_prot;
    assign slave_4.aw_qos = master.aw_qos;
    assign slave_4.aw_region = master.aw_region;
    assign slave_4.aw_user = master.aw_user;
    assign slave_4.aw_valid = aw_locked && 32'(aw_selected) == 32'd4;
    assign slave_4.w_data = master.w_data;
    assign slave_4.w_strb = master.w_strb;
    assign slave_4.w_last = master.w_last;
    assign slave_4.w_user = master.w_user;
    assign slave_4.w_valid = w_locked && 32'(aw_selected) == 32'd4 && master.w_valid;
    localparam integer genblk5_5_i = 5;
    assign slave_5.aw_id = master.aw_id;
    assign slave_5.aw_addr = master.aw_addr;
    assign slave_5.aw_len = master.aw_len;
    assign slave_5.aw_size = master.aw_size;
    assign slave_5.aw_burst = master.aw_burst;
    assign slave_5.aw_lock = master.aw_lock;
    assign slave_5.aw_cache = master.aw_cache;
    assign slave_5.aw_prot = master.aw_prot;
    assign slave_5.aw_qos = master.aw_qos;
    assign slave_5.aw_region = master.aw_region;
    assign slave_5.aw_user = master.aw_user;
    assign slave_5.aw_valid = aw_locked && 32'(aw_selected) == 32'd5;
    assign slave_5.w_data = master.w_data;
    assign slave_5.w_strb = master.w_strb;
    assign slave_5.w_last = master.w_last;
    assign slave_5.w_user = master.w_user;
    assign slave_5.w_valid = w_locked && 32'(aw_selected) == 32'd5 && master.w_valid;
    localparam integer genblk5_6_i = 6;
    assign slave_6.aw_id = master.aw_id;
    assign slave_6.aw_addr = master.aw_addr;
    assign slave_6.aw_len = master.aw_len;
    assign slave_6.aw_size = master.aw_size;
    assign slave_6.aw_burst = master.aw_burst;
    assign slave_6.aw_lock = master.aw_lock;
    assign slave_6.aw_cache = master.aw_cache;
    assign slave_6.aw_prot = master.aw_prot;
    assign slave_6.aw_qos = master.aw_qos;
    assign slave_6.aw_region = master.aw_region;
    assign slave_6.aw_user = master.aw_user;
    assign slave_6.aw_valid = aw_locked && 32'(aw_selected) == 32'd6;
    assign slave_6.w_data = master.w_data;
    assign slave_6.w_strb = master.w_strb;
    assign slave_6.w_last = master.w_last;
    assign slave_6.w_user = master.w_user;
    assign slave_6.w_valid = w_locked && 32'(aw_selected) == 32'd6 && master.w_valid;
    localparam integer genblk5_7_i = 7;
    assign slave_7.aw_id = master.aw_id;
    assign slave_7.aw_addr = master.aw_addr;
    assign slave_7.aw_len = master.aw_len;
    assign slave_7.aw_size = master.aw_size;
    assign slave_7.aw_burst = master.aw_burst;
    assign slave_7.aw_lock = master.aw_lock;
    assign slave_7.aw_cache = master.aw_cache;
    assign slave_7.aw_prot = master.aw_prot;
    assign slave_7.aw_qos = master.aw_qos;
    assign slave_7.aw_region = master.aw_region;
    assign slave_7.aw_user = master.aw_user;
    assign slave_7.aw_valid = aw_locked && 32'(aw_selected) == 32'd7;
    assign slave_7.w_data = master.w_data;
    assign slave_7.w_strb = master.w_strb;
    assign slave_7.w_last = master.w_last;
    assign slave_7.w_user = master.w_user;
    assign slave_7.w_valid = w_locked && 32'(aw_selected) == 32'd7 && master.w_valid;
    localparam integer genblk5_8_i = 8;
    assign slave_8.aw_id = master.aw_id;
    assign slave_8.aw_addr = master.aw_addr;
    assign slave_8.aw_len = master.aw_len;
    assign slave_8.aw_size = master.aw_size;
    assign slave_8.aw_burst = master.aw_burst;
    assign slave_8.aw_lock = master.aw_lock;
    assign slave_8.aw_cache = master.aw_cache;
    assign slave_8.aw_prot = master.aw_prot;
    assign slave_8.aw_qos = master.aw_qos;
    assign slave_8.aw_region = master.aw_region;
    assign slave_8.aw_user = master.aw_user;
    assign slave_8.aw_valid = aw_locked && 32'(aw_selected) == 32'd8;
    assign slave_8.w_data = master.w_data;
    assign slave_8.w_strb = master.w_strb;
    assign slave_8.w_last = master.w_last;
    assign slave_8.w_user = master.w_user;
    assign slave_8.w_valid = w_locked && 32'(aw_selected) == 32'd8 && master.w_valid;
    assign master.aw_ready = aw_locked && slave_aw_ready[aw_selected];
    assign master.w_ready = w_locked && slave_w_ready[aw_selected];
    logic b_locked;
    logic[3:0] b_selected;
    assign b_arb_enable = !b_locked;
    always_ff @(posedge clk or negedge rstn) if (!rstn) begin
        b_locked <= 1'd0;
        b_selected <= 4'd0;
    end else begin
        if (b_locked) begin
            if (master.b_ready) begin
                b_locked <= 1'd0;
            end
        end
        if (b_arb_enable && b_arb_grant) begin
            b_locked <= 1'd1;
            b_selected <= b_arb_grant_bin;
        end
    end
    global_types::struct_12 master_b;
    assign master_b = slave_b[b_selected];
    assign master.b_id = master_b.id;
    assign master.b_resp = master_b.resp;
    assign master.b_user = master_b.user;
    assign master.b_valid = b_locked;
    localparam integer b_0_i = 0;
    assign slave_0.b_ready = b_locked && 32'(b_selected) == 32'd0 && master.b_ready;
    localparam integer b_1_i = 1;
    assign slave_1.b_ready = b_locked && 32'(b_selected) == 32'd1 && master.b_ready;
    localparam integer b_2_i = 2;
    assign slave_2.b_ready = b_locked && 32'(b_selected) == 32'd2 && master.b_ready;
    localparam integer b_3_i = 3;
    assign slave_3.b_ready = b_locked && 32'(b_selected) == 32'd3 && master.b_ready;
    localparam integer b_4_i = 4;
    assign slave_4.b_ready = b_locked && 32'(b_selected) == 32'd4 && master.b_ready;
    localparam integer b_5_i = 5;
    assign slave_5.b_ready = b_locked && 32'(b_selected) == 32'd5 && master.b_ready;
    localparam integer b_6_i = 6;
    assign slave_6.b_ready = b_locked && 32'(b_selected) == 32'd6 && master.b_ready;
    localparam integer b_7_i = 7;
    assign slave_7.b_ready = b_locked && 32'(b_selected) == 32'd7 && master.b_ready;
    localparam integer b_8_i = 8;
    assign slave_8.b_ready = b_locked && 32'(b_selected) == 32'd8 && master.b_ready;
    global_types::struct_15[15:0] read_map;
    global_types::struct_15 ar_lookup;
    assign ar_lookup = read_map[master.ar_id];
    logic ar_forward;
    assign ar_forward = master.ar_valid && (32'(ar_lookup.active_cnt) == 32'd0 || (ar_lookup.active_slave == ar_match_bin && 32'(ar_lookup.active_cnt) != 32'd2 ** 8 - 32'd1));
    logic[15:0] r_cnt_incr;
    logic[15:0] r_cnt_decr;
    localparam integer genblk7_0_i = 0;
    assign r_cnt_decr[0] = 32'(master.r_id) == 32'd0 && master.r_valid && master.r_ready && master.r_last;
    assign r_cnt_incr[0] = 32'(master.ar_id) == 32'd0 && master.ar_valid && master.ar_ready;
    localparam integer genblk7_1_i = 1;
    assign r_cnt_decr[1] = 32'(master.r_id) == 32'd1 && master.r_valid && master.r_ready && master.r_last;
    assign r_cnt_incr[1] = 32'(master.ar_id) == 32'd1 && master.ar_valid && master.ar_ready;
    localparam integer genblk7_2_i = 2;
    assign r_cnt_decr[2] = 32'(master.r_id) == 32'd2 && master.r_valid && master.r_ready && master.r_last;
    assign r_cnt_incr[2] = 32'(master.ar_id) == 32'd2 && master.ar_valid && master.ar_ready;
    localparam integer genblk7_3_i = 3;
    assign r_cnt_decr[3] = 32'(master.r_id) == 32'd3 && master.r_valid && master.r_ready && master.r_last;
    assign r_cnt_incr[3] = 32'(master.ar_id) == 32'd3 && master.ar_valid && master.ar_ready;
    localparam integer genblk7_4_i = 4;
    assign r_cnt_decr[4] = 32'(master.r_id) == 32'd4 && master.r_valid && master.r_ready && master.r_last;
    assign r_cnt_incr[4] = 32'(master.ar_id) == 32'd4 && master.ar_valid && master.ar_ready;
    localparam integer genblk7_5_i = 5;
    assign r_cnt_decr[5] = 32'(master.r_id) == 32'd5 && master.r_valid && master.r_ready && master.r_last;
    assign r_cnt_incr[5] = 32'(master.ar_id) == 32'd5 && master.ar_valid && master.ar_ready;
    localparam integer genblk7_6_i = 6;
    assign r_cnt_decr[6] = 32'(master.r_id) == 32'd6 && master.r_valid && master.r_ready && master.r_last;
    assign r_cnt_incr[6] = 32'(master.ar_id) == 32'd6 && master.ar_valid && master.ar_ready;
    localparam integer genblk7_7_i = 7;
    assign r_cnt_decr[7] = 32'(master.r_id) == 32'd7 && master.r_valid && master.r_ready && master.r_last;
    assign r_cnt_incr[7] = 32'(master.ar_id) == 32'd7 && master.ar_valid && master.ar_ready;
    localparam integer genblk7_8_i = 8;
    assign r_cnt_decr[8] = 32'(master.r_id) == 32'd8 && master.r_valid && master.r_ready && master.r_last;
    assign r_cnt_incr[8] = 32'(master.ar_id) == 32'd8 && master.ar_valid && master.ar_ready;
    localparam integer genblk7_9_i = 9;
    assign r_cnt_decr[9] = 32'(master.r_id) == 32'd9 && master.r_valid && master.r_ready && master.r_last;
    assign r_cnt_incr[9] = 32'(master.ar_id) == 32'd9 && master.ar_valid && master.ar_ready;
    localparam integer genblk7_10_i = 10;
    assign r_cnt_decr[10] = 32'(master.r_id) == 32'd10 && master.r_valid && master.r_ready && master.r_last;
    assign r_cnt_incr[10] = 32'(master.ar_id) == 32'd10 && master.ar_valid && master.ar_ready;
    localparam integer genblk7_11_i = 11;
    assign r_cnt_decr[11] = 32'(master.r_id) == 32'd11 && master.r_valid && master.r_ready && master.r_last;
    assign r_cnt_incr[11] = 32'(master.ar_id) == 32'd11 && master.ar_valid && master.ar_ready;
    localparam integer genblk7_12_i = 12;
    assign r_cnt_decr[12] = 32'(master.r_id) == 32'd12 && master.r_valid && master.r_ready && master.r_last;
    assign r_cnt_incr[12] = 32'(master.ar_id) == 32'd12 && master.ar_valid && master.ar_ready;
    localparam integer genblk7_13_i = 13;
    assign r_cnt_decr[13] = 32'(master.r_id) == 32'd13 && master.r_valid && master.r_ready && master.r_last;
    assign r_cnt_incr[13] = 32'(master.ar_id) == 32'd13 && master.ar_valid && master.ar_ready;
    localparam integer genblk7_14_i = 14;
    assign r_cnt_decr[14] = 32'(master.r_id) == 32'd14 && master.r_valid && master.r_ready && master.r_last;
    assign r_cnt_incr[14] = 32'(master.ar_id) == 32'd14 && master.ar_valid && master.ar_ready;
    localparam integer genblk7_15_i = 15;
    assign r_cnt_decr[15] = 32'(master.r_id) == 32'd15 && master.r_valid && master.r_ready && master.r_last;
    assign r_cnt_incr[15] = 32'(master.ar_id) == 32'd15 && master.ar_valid && master.ar_ready;
    always_ff @(posedge clk or negedge rstn) if (!rstn) begin
        for (int i = 0; i < 2 ** 4; i++) read_map[i] <= global_types::struct_15'(1'd0);
    end else begin
        for (int i = 0; i < 2 ** 4; i++) begin
            if (r_cnt_incr[i]) begin
                read_map[i].active_slave <= ar_match_bin;
                if (!r_cnt_decr[i]) read_map[i].active_cnt <= 32'(read_map[i].active_cnt) + 32'd1;
            end else if (r_cnt_decr[i]) begin
                read_map[i].active_cnt <= 32'(read_map[i].active_cnt) - 32'd1;
            end
        end
    end
    logic ar_locked;
    logic[3:0] ar_selected;
    always_ff @(posedge clk or negedge rstn) if (!rstn) begin
        ar_locked <= 1'd0;
        ar_selected <= 4'd0;
    end else begin
        if (ar_locked) begin
            if (master.ar_ready) begin
                ar_locked <= 1'd0;
            end
        end else if (ar_forward) begin
            ar_locked <= 1'd1;
            ar_selected <= ar_match_bin;
        end
    end
    localparam integer genblk8_0_i = 0;
    assign slave_0.ar_id = master.ar_id;
    assign slave_0.ar_addr = master.ar_addr;
    assign slave_0.ar_len = master.ar_len;
    assign slave_0.ar_size = master.ar_size;
    assign slave_0.ar_burst = master.ar_burst;
    assign slave_0.ar_lock = master.ar_lock;
    assign slave_0.ar_cache = master.ar_cache;
    assign slave_0.ar_prot = master.ar_prot;
    assign slave_0.ar_qos = master.ar_qos;
    assign slave_0.ar_region = master.ar_region;
    assign slave_0.ar_user = master.ar_user;
    assign slave_0.ar_valid = ar_locked && 32'(ar_match_bin) == 32'd0;
    localparam integer genblk8_1_i = 1;
    assign slave_1.ar_id = master.ar_id;
    assign slave_1.ar_addr = master.ar_addr;
    assign slave_1.ar_len = master.ar_len;
    assign slave_1.ar_size = master.ar_size;
    assign slave_1.ar_burst = master.ar_burst;
    assign slave_1.ar_lock = master.ar_lock;
    assign slave_1.ar_cache = master.ar_cache;
    assign slave_1.ar_prot = master.ar_prot;
    assign slave_1.ar_qos = master.ar_qos;
    assign slave_1.ar_region = master.ar_region;
    assign slave_1.ar_user = master.ar_user;
    assign slave_1.ar_valid = ar_locked && 32'(ar_match_bin) == 32'd1;
    localparam integer genblk8_2_i = 2;
    assign slave_2.ar_id = master.ar_id;
    assign slave_2.ar_addr = master.ar_addr;
    assign slave_2.ar_len = master.ar_len;
    assign slave_2.ar_size = master.ar_size;
    assign slave_2.ar_burst = master.ar_burst;
    assign slave_2.ar_lock = master.ar_lock;
    assign slave_2.ar_cache = master.ar_cache;
    assign slave_2.ar_prot = master.ar_prot;
    assign slave_2.ar_qos = master.ar_qos;
    assign slave_2.ar_region = master.ar_region;
    assign slave_2.ar_user = master.ar_user;
    assign slave_2.ar_valid = ar_locked && 32'(ar_match_bin) == 32'd2;
    localparam integer genblk8_3_i = 3;
    assign slave_3.ar_id = master.ar_id;
    assign slave_3.ar_addr = master.ar_addr;
    assign slave_3.ar_len = master.ar_len;
    assign slave_3.ar_size = master.ar_size;
    assign slave_3.ar_burst = master.ar_burst;
    assign slave_3.ar_lock = master.ar_lock;
    assign slave_3.ar_cache = master.ar_cache;
    assign slave_3.ar_prot = master.ar_prot;
    assign slave_3.ar_qos = master.ar_qos;
    assign slave_3.ar_region = master.ar_region;
    assign slave_3.ar_user = master.ar_user;
    assign slave_3.ar_valid = ar_locked && 32'(ar_match_bin) == 32'd3;
    localparam integer genblk8_4_i = 4;
    assign slave_4.ar_id = master.ar_id;
    assign slave_4.ar_addr = master.ar_addr;
    assign slave_4.ar_len = master.ar_len;
    assign slave_4.ar_size = master.ar_size;
    assign slave_4.ar_burst = master.ar_burst;
    assign slave_4.ar_lock = master.ar_lock;
    assign slave_4.ar_cache = master.ar_cache;
    assign slave_4.ar_prot = master.ar_prot;
    assign slave_4.ar_qos = master.ar_qos;
    assign slave_4.ar_region = master.ar_region;
    assign slave_4.ar_user = master.ar_user;
    assign slave_4.ar_valid = ar_locked && 32'(ar_match_bin) == 32'd4;
    localparam integer genblk8_5_i = 5;
    assign slave_5.ar_id = master.ar_id;
    assign slave_5.ar_addr = master.ar_addr;
    assign slave_5.ar_len = master.ar_len;
    assign slave_5.ar_size = master.ar_size;
    assign slave_5.ar_burst = master.ar_burst;
    assign slave_5.ar_lock = master.ar_lock;
    assign slave_5.ar_cache = master.ar_cache;
    assign slave_5.ar_prot = master.ar_prot;
    assign slave_5.ar_qos = master.ar_qos;
    assign slave_5.ar_region = master.ar_region;
    assign slave_5.ar_user = master.ar_user;
    assign slave_5.ar_valid = ar_locked && 32'(ar_match_bin) == 32'd5;
    localparam integer genblk8_6_i = 6;
    assign slave_6.ar_id = master.ar_id;
    assign slave_6.ar_addr = master.ar_addr;
    assign slave_6.ar_len = master.ar_len;
    assign slave_6.ar_size = master.ar_size;
    assign slave_6.ar_burst = master.ar_burst;
    assign slave_6.ar_lock = master.ar_lock;
    assign slave_6.ar_cache = master.ar_cache;
    assign slave_6.ar_prot = master.ar_prot;
    assign slave_6.ar_qos = master.ar_qos;
    assign slave_6.ar_region = master.ar_region;
    assign slave_6.ar_user = master.ar_user;
    assign slave_6.ar_valid = ar_locked && 32'(ar_match_bin) == 32'd6;
    localparam integer genblk8_7_i = 7;
    assign slave_7.ar_id = master.ar_id;
    assign slave_7.ar_addr = master.ar_addr;
    assign slave_7.ar_len = master.ar_len;
    assign slave_7.ar_size = master.ar_size;
    assign slave_7.ar_burst = master.ar_burst;
    assign slave_7.ar_lock = master.ar_lock;
    assign slave_7.ar_cache = master.ar_cache;
    assign slave_7.ar_prot = master.ar_prot;
    assign slave_7.ar_qos = master.ar_qos;
    assign slave_7.ar_region = master.ar_region;
    assign slave_7.ar_user = master.ar_user;
    assign slave_7.ar_valid = ar_locked && 32'(ar_match_bin) == 32'd7;
    localparam integer genblk8_8_i = 8;
    assign slave_8.ar_id = master.ar_id;
    assign slave_8.ar_addr = master.ar_addr;
    assign slave_8.ar_len = master.ar_len;
    assign slave_8.ar_size = master.ar_size;
    assign slave_8.ar_burst = master.ar_burst;
    assign slave_8.ar_lock = master.ar_lock;
    assign slave_8.ar_cache = master.ar_cache;
    assign slave_8.ar_prot = master.ar_prot;
    assign slave_8.ar_qos = master.ar_qos;
    assign slave_8.ar_region = master.ar_region;
    assign slave_8.ar_user = master.ar_user;
    assign slave_8.ar_valid = ar_locked && 32'(ar_match_bin) == 32'd8;
    assign master.ar_ready = ar_locked && slave_ar_ready[ar_match_bin];
    assign r_arb_enable = master.r_ready;
    global_types::struct_14 master_r;
    assign master_r = slave_r[r_arb_grant_bin];
    assign master.r_id = master_r.id;
    assign master.r_data = master_r.data;
    assign master.r_resp = master_r.resp;
    assign master.r_last = master_r.last;
    assign master.r_user = master_r.user;
    assign master.r_valid = r_arb_enable && 32'(r_arb_grant) != 32'd0;
    localparam integer r_0_i = 0;
    assign slave_0.r_ready = r_arb_enable && r_arb_grant[0];
    localparam integer r_1_i = 1;
    assign slave_1.r_ready = r_arb_enable && r_arb_grant[1];
    localparam integer r_2_i = 2;
    assign slave_2.r_ready = r_arb_enable && r_arb_grant[2];
    localparam integer r_3_i = 3;
    assign slave_3.r_ready = r_arb_enable && r_arb_grant[3];
    localparam integer r_4_i = 4;
    assign slave_4.r_ready = r_arb_enable && r_arb_grant[4];
    localparam integer r_5_i = 5;
    assign slave_5.r_ready = r_arb_enable && r_arb_grant[5];
    localparam integer r_6_i = 6;
    assign slave_6.r_ready = r_arb_enable && r_arb_grant[6];
    localparam integer r_7_i = 7;
    assign slave_7.r_ready = r_arb_enable && r_arb_grant[7];
    localparam integer r_8_i = 8;
    assign slave_8.r_ready = r_arb_enable && r_arb_grant[8];
endmodule

/* file: ../axi/dummy_master.sv */
/* file: ../axi/dummy_slave.sv */
/* file: ../axi/from_lite.sv */
/* file: ../axi/id_downsizer.sv */
/* file: ../axi/join.sv */
module axi_join_ (
    axi_channel_1.slave master,
    axi_channel_1.master slave
);
    assign slave.aw_id = master.aw_id;
    assign slave.aw_addr = master.aw_addr;
    assign slave.aw_len = master.aw_len;
    assign slave.aw_size = master.aw_size;
    assign slave.aw_burst = master.aw_burst;
    assign slave.aw_lock = master.aw_lock;
    assign slave.aw_cache = master.aw_cache;
    assign slave.aw_prot = master.aw_prot;
    assign slave.aw_qos = master.aw_qos;
    assign slave.aw_region = master.aw_region;
    assign slave.aw_user = master.aw_user;
    assign slave.aw_valid = master.aw_valid;
    assign master.aw_ready = slave.aw_ready;
    assign slave.w_data = master.w_data;
    assign slave.w_strb = master.w_strb;
    assign slave.w_last = master.w_last;
    assign slave.w_user = master.w_user;
    assign slave.w_valid = master.w_valid;
    assign master.w_ready = slave.w_ready;
    assign master.b_id = slave.b_id;
    assign master.b_resp = slave.b_resp;
    assign master.b_user = slave.b_user;
    assign master.b_valid = slave.b_valid;
    assign slave.b_ready = master.b_ready;
    assign slave.ar_id = master.ar_id;
    assign slave.ar_addr = master.ar_addr;
    assign slave.ar_len = master.ar_len;
    assign slave.ar_size = master.ar_size;
    assign slave.ar_burst = master.ar_burst;
    assign slave.ar_lock = master.ar_lock;
    assign slave.ar_cache = master.ar_cache;
    assign slave.ar_prot = master.ar_prot;
    assign slave.ar_qos = master.ar_qos;
    assign slave.ar_region = master.ar_region;
    assign slave.ar_user = master.ar_user;
    assign slave.ar_valid = master.ar_valid;
    assign master.ar_ready = slave.ar_ready;
    assign master.r_id = slave.r_id;
    assign master.r_data = slave.r_data;
    assign master.r_resp = slave.r_resp;
    assign master.r_last = slave.r_last;
    assign master.r_user = slave.r_user;
    assign master.r_valid = slave.r_valid;
    assign slave.r_ready = master.r_ready;
endmodule

/* file: ../axi/lite_bram_ctrl.sv */
/* file: ../axi/lite_buf.sv */
/* file: ../axi/lite_channel.sv */
/* file: ../axi/lite_dummy_master.sv */
/* file: ../axi/lite_dummy_slave.sv */
/* file: ../axi/lite_join.sv */
/* file: ../axi/mux.sv */
module axi_mux_raw (
    axi_channel_1.slave master_0,
    axi_channel_1.slave master_1,
    axi_channel.master slave
);
    parameter integer MASTER_NUM = 2;
    localparam integer MASTER_WIDTH = 1;
    logic clk;
    logic rstn;
    assign clk = slave.clk;
    assign rstn = slave.rstn;
    typedef global_types::struct_5 aw_pack_t;
    typedef global_types::struct_6 w_pack_t;
    typedef global_types::struct_8 ar_pack_t;
    global_types::struct_5[1:0] master_aw;
    logic[1:0] master_aw_valid;
    global_types::struct_6[1:0] master_w;
    logic[1:0] master_w_valid;
    logic[1:0] master_b_ready;
    global_types::struct_8[1:0] master_ar;
    logic[1:0] master_ar_valid;
    logic[1:0] master_r_ready;
    localparam integer pack_0_i = 0;
    assign master_aw[0] = global_types::struct_5'{{32'sd0, master_0.aw_id}, master_0.aw_addr, master_0.aw_len, master_0.aw_size, master_0.aw_burst, master_0.aw_lock, master_0.aw_cache, master_0.aw_prot, master_0.aw_qos, master_0.aw_region, master_0.aw_user};
    assign master_aw_valid[0] = master_0.aw_valid;
    assign master_w[0] = global_types::struct_6'{master_0.w_data, master_0.w_strb, master_0.w_last, master_0.w_user};
    assign master_w_valid[0] = master_0.w_valid;
    assign master_b_ready[0] = master_0.b_ready;
    assign master_ar[0] = global_types::struct_8'{{32'sd0, master_0.ar_id}, master_0.ar_addr, master_0.ar_len, master_0.ar_size, master_0.ar_burst, master_0.ar_lock, master_0.ar_cache, master_0.ar_prot, master_0.ar_qos, master_0.ar_region, master_0.ar_user};
    assign master_ar_valid[0] = master_0.ar_valid;
    assign master_r_ready[0] = master_0.r_ready;
    localparam integer pack_1_i = 1;
    assign master_aw[1] = global_types::struct_5'{{32'sd1, master_1.aw_id}, master_1.aw_addr, master_1.aw_len, master_1.aw_size, master_1.aw_burst, master_1.aw_lock, master_1.aw_cache, master_1.aw_prot, master_1.aw_qos, master_1.aw_region, master_1.aw_user};
    assign master_aw_valid[1] = master_1.aw_valid;
    assign master_w[1] = global_types::struct_6'{master_1.w_data, master_1.w_strb, master_1.w_last, master_1.w_user};
    assign master_w_valid[1] = master_1.w_valid;
    assign master_b_ready[1] = master_1.b_ready;
    assign master_ar[1] = global_types::struct_8'{{32'sd1, master_1.ar_id}, master_1.ar_addr, master_1.ar_len, master_1.ar_size, master_1.ar_burst, master_1.ar_lock, master_1.ar_cache, master_1.ar_prot, master_1.ar_qos, master_1.ar_region, master_1.ar_user};
    assign master_ar_valid[1] = master_1.ar_valid;
    assign master_r_ready[1] = master_1.r_ready;
    logic[1:0] aw_arb_grant;
    logic[0:0] aw_arb_grant_bin;
    logic aw_locked;
    logic w_locked;
    logic[0:0] aw_selected;
    round_robin_arbiter_1 aw_arb (
        .clk(clk),
        .rstn(rstn),
        .enable(!aw_locked && !w_locked),
        .request(master_aw_valid),
        .grant(aw_arb_grant)
    );
    onehot_to_binary_1 aw_one2bin (
        .onehot(aw_arb_grant),
        .binary(aw_arb_grant_bin)
    );
    always_ff @(posedge clk or negedge rstn) if (!rstn) begin
        aw_locked <= 1'd0;
        w_locked <= 1'd0;
        aw_selected <= 1'd0;
    end else begin
        if (aw_locked || w_locked) begin
            if (slave.aw_ready) begin
                aw_locked <= 1'd0;
            end
            if (slave.w_last && slave.w_valid && slave.w_ready) begin
                w_locked <= 1'd0;
            end
        end else if (aw_arb_grant) begin
            aw_locked <= 1'd1;
            w_locked <= 1'd1;
            aw_selected <= aw_arb_grant_bin;
        end
    end
    global_types::struct_5 master_aw_selected;
    assign master_aw_selected = master_aw[aw_selected];
    assign slave.aw_id = master_aw_selected.id;
    assign slave.aw_addr = master_aw_selected.addr;
    assign slave.aw_len = master_aw_selected.len;
    assign slave.aw_size = master_aw_selected.size;
    assign slave.aw_burst = master_aw_selected.burst;
    assign slave.aw_lock = master_aw_selected.lock;
    assign slave.aw_cache = master_aw_selected.cache;
    assign slave.aw_prot = master_aw_selected.prot;
    assign slave.aw_qos = master_aw_selected.qos;
    assign slave.aw_region = master_aw_selected.region;
    assign slave.aw_user = master_aw_selected.user;
    assign slave.aw_valid = aw_locked && master_aw_valid[aw_selected];
    global_types::struct_6 master_w_selected;
    assign master_w_selected = master_w[aw_selected];
    assign slave.w_data = master_w_selected.data;
    assign slave.w_strb = master_w_selected.strb;
    assign slave.w_last = master_w_selected.last;
    assign slave.w_user = master_w_selected.user;
    assign slave.w_valid = w_locked && master_w_valid[aw_selected];
    localparam integer aw_0_i = 0;
    assign master_0.aw_ready = aw_locked && 32'(aw_selected) == 32'd0 && slave.aw_ready;
    assign master_0.w_ready = w_locked && 32'(aw_selected) == 32'd0 && slave.w_ready;
    localparam integer aw_1_i = 1;
    assign master_1.aw_ready = aw_locked && 32'(aw_selected) == 32'd1 && slave.aw_ready;
    assign master_1.w_ready = w_locked && 32'(aw_selected) == 32'd1 && slave.w_ready;
    localparam integer b_0_i = 0;
    assign master_0.b_id = slave.b_id;
    assign master_0.b_resp = slave.b_resp;
    assign master_0.b_user = slave.b_user;
    assign master_0.b_valid = slave.b_valid && 32'(slave.b_id[5 - 1-:1]) == 32'd0;
    localparam integer b_1_i = 1;
    assign master_1.b_id = slave.b_id;
    assign master_1.b_resp = slave.b_resp;
    assign master_1.b_user = slave.b_user;
    assign master_1.b_valid = slave.b_valid && 32'(slave.b_id[5 - 1-:1]) == 32'd1;
    assign slave.b_ready = master_b_ready[slave.b_id[5 - 1-:1]];
    logic[1:0] ar_arb_grant;
    logic[0:0] ar_arb_grant_bin;
    logic ar_locked;
    logic[0:0] ar_selected;
    round_robin_arbiter_1 ar_arb (
        .clk(clk),
        .rstn(rstn),
        .enable(!ar_locked),
        .request(master_ar_valid),
        .grant(ar_arb_grant)
    );
    onehot_to_binary_1 ar_one2bin (
        .onehot(ar_arb_grant),
        .binary(ar_arb_grant_bin)
    );
    always_ff @(posedge clk or negedge rstn) if (!rstn) begin
        ar_locked <= 1'd0;
        ar_selected <= 1'd0;
    end else begin
        if (ar_locked) begin
            if (slave.ar_ready) begin
                ar_locked <= 1'd0;
            end
        end else if (ar_arb_grant) begin
            ar_locked <= 1'd1;
            ar_selected <= ar_arb_grant_bin;
        end
    end
    global_types::struct_8 master_ar_selected;
    assign master_ar_selected = master_ar[ar_selected];
    assign slave.ar_id = master_ar_selected.id;
    assign slave.ar_addr = master_ar_selected.addr;
    assign slave.ar_len = master_ar_selected.len;
    assign slave.ar_size = master_ar_selected.size;
    assign slave.ar_burst = master_ar_selected.burst;
    assign slave.ar_lock = master_ar_selected.lock;
    assign slave.ar_cache = master_ar_selected.cache;
    assign slave.ar_prot = master_ar_selected.prot;
    assign slave.ar_qos = master_ar_selected.qos;
    assign slave.ar_region = master_ar_selected.region;
    assign slave.ar_user = master_ar_selected.user;
    assign slave.ar_valid = ar_locked && master_ar_valid[ar_selected];
    localparam integer ar_0_i = 0;
    assign master_0.ar_ready = ar_locked && 32'(ar_selected) == 32'd0 && slave.ar_ready;
    localparam integer ar_1_i = 1;
    assign master_1.ar_ready = ar_locked && 32'(ar_selected) == 32'd1 && slave.ar_ready;
    localparam integer r_0_i = 0;
    assign master_0.r_id = slave.r_id;
    assign master_0.r_data = slave.r_data;
    assign master_0.r_resp = slave.r_resp;
    assign master_0.r_last = slave.r_last;
    assign master_0.r_user = slave.r_user;
    assign master_0.r_valid = slave.r_valid && 32'(slave.r_id[5 - 1-:1]) == 32'd0;
    localparam integer r_1_i = 1;
    assign master_1.r_id = slave.r_id;
    assign master_1.r_data = slave.r_data;
    assign master_1.r_resp = slave.r_resp;
    assign master_1.r_last = slave.r_last;
    assign master_1.r_user = slave.r_user;
    assign master_1.r_valid = slave.r_valid && 32'(slave.r_id[5 - 1-:1]) == 32'd1;
    assign slave.r_ready = master_r_ready[slave.r_id[5 - 1-:1]];
endmodule

/* file: ../axi/regslice.sv */
module axi_regslice (
    axi_channel_1.slave master,
    axi_channel_1.master slave
);
    parameter integer AW_MODE = 0;
    parameter integer W_MODE = 0;
    parameter integer B_MODE = 0;
    parameter integer AR_MODE = 0;
    parameter integer R_MODE = 1;
    typedef global_types::struct_10 aw_pack_t;
    regslice awfifo (
        .clk(master.clk),
        .rstn(master.rstn),
        .w_valid(master.aw_valid),
        .w_ready(master.aw_ready),
        .w_data(global_types::struct_10'{master.aw_id, master.aw_addr, master.aw_len, master.aw_size, master.aw_burst, master.aw_lock, master.aw_cache, master.aw_prot, master.aw_qos, master.aw_region, master.aw_user}),
        .r_valid(slave.aw_valid),
        .r_ready(slave.aw_ready),
        .r_data({slave.aw_id, slave.aw_addr, slave.aw_len, slave.aw_size, slave.aw_burst, slave.aw_lock, slave.aw_cache, slave.aw_prot, slave.aw_qos, slave.aw_region, slave.aw_user})
    );
    typedef global_types::struct_11 w_pack_t;
    regslice_1 wfifo (
        .clk(master.clk),
        .rstn(master.rstn),
        .w_valid(master.w_valid),
        .w_ready(master.w_ready),
        .w_data(global_types::struct_11'{master.w_data, master.w_strb, master.w_last, master.w_user}),
        .r_valid(slave.w_valid),
        .r_ready(slave.w_ready),
        .r_data({slave.w_data, slave.w_strb, slave.w_last, slave.w_user})
    );
    typedef global_types::struct_12 b_pack_t;
    regslice_2 bfifo (
        .clk(master.clk),
        .rstn(master.rstn),
        .w_valid(slave.b_valid),
        .w_ready(slave.b_ready),
        .w_data(global_types::struct_12'{slave.b_id, slave.b_resp, slave.b_user}),
        .r_valid(master.b_valid),
        .r_ready(master.b_ready),
        .r_data({master.b_id, master.b_resp, master.b_user})
    );
    typedef global_types::struct_13 ar_pack_t;
    regslice_3 arfifo (
        .clk(master.clk),
        .rstn(master.rstn),
        .w_valid(master.ar_valid),
        .w_ready(master.ar_ready),
        .w_data(global_types::struct_13'{master.ar_id, master.ar_addr, master.ar_len, master.ar_size, master.ar_burst, master.ar_lock, master.ar_cache, master.ar_prot, master.ar_qos, master.ar_region, master.ar_user}),
        .r_valid(slave.ar_valid),
        .r_ready(slave.ar_ready),
        .r_data({slave.ar_id, slave.ar_addr, slave.ar_len, slave.ar_size, slave.ar_burst, slave.ar_lock, slave.ar_cache, slave.ar_prot, slave.ar_qos, slave.ar_region, slave.ar_user})
    );
    typedef global_types::struct_14 r_pack_t;
    regslice_4 rfifo (
        .clk(master.clk),
        .rstn(master.rstn),
        .w_valid(slave.r_valid),
        .w_ready(slave.r_ready),
        .w_data(global_types::struct_14'{slave.r_id, slave.r_data, slave.r_resp, slave.r_last, slave.r_user}),
        .r_valid(master.r_valid),
        .r_ready(master.r_ready),
        .r_data({master.r_id, master.r_data, master.r_resp, master.r_last, master.r_user})
    );
endmodule
module axi_regslice_1 (
    axi_channel.slave master,
    axi_channel.master slave
);
    parameter integer AW_MODE = 0;
    parameter integer W_MODE = 0;
    parameter integer B_MODE = 2;
    parameter integer AR_MODE = 0;
    parameter integer R_MODE = 2;
    typedef global_types::struct_5 aw_pack_t;
    regslice_5 awfifo (
        .clk(master.clk),
        .rstn(master.rstn),
        .w_valid(master.aw_valid),
        .w_ready(master.aw_ready),
        .w_data(global_types::struct_5'{master.aw_id, master.aw_addr, master.aw_len, master.aw_size, master.aw_burst, master.aw_lock, master.aw_cache, master.aw_prot, master.aw_qos, master.aw_region, master.aw_user}),
        .r_valid(slave.aw_valid),
        .r_ready(slave.aw_ready),
        .r_data({slave.aw_id, slave.aw_addr, slave.aw_len, slave.aw_size, slave.aw_burst, slave.aw_lock, slave.aw_cache, slave.aw_prot, slave.aw_qos, slave.aw_region, slave.aw_user})
    );
    typedef global_types::struct_6 w_pack_t;
    regslice_6 wfifo (
        .clk(master.clk),
        .rstn(master.rstn),
        .w_valid(master.w_valid),
        .w_ready(master.w_ready),
        .w_data(global_types::struct_6'{master.w_data, master.w_strb, master.w_last, master.w_user}),
        .r_valid(slave.w_valid),
        .r_ready(slave.w_ready),
        .r_data({slave.w_data, slave.w_strb, slave.w_last, slave.w_user})
    );
    typedef global_types::struct_7 b_pack_t;
    regslice_7 bfifo (
        .clk(master.clk),
        .rstn(master.rstn),
        .w_valid(slave.b_valid),
        .w_ready(slave.b_ready),
        .w_data(global_types::struct_7'{slave.b_id, slave.b_resp, slave.b_user}),
        .r_valid(master.b_valid),
        .r_ready(master.b_ready),
        .r_data({master.b_id, master.b_resp, master.b_user})
    );
    typedef global_types::struct_8 ar_pack_t;
    regslice_8 arfifo (
        .clk(master.clk),
        .rstn(master.rstn),
        .w_valid(master.ar_valid),
        .w_ready(master.ar_ready),
        .w_data(global_types::struct_8'{master.ar_id, master.ar_addr, master.ar_len, master.ar_size, master.ar_burst, master.ar_lock, master.ar_cache, master.ar_prot, master.ar_qos, master.ar_region, master.ar_user}),
        .r_valid(slave.ar_valid),
        .r_ready(slave.ar_ready),
        .r_data({slave.ar_id, slave.ar_addr, slave.ar_len, slave.ar_size, slave.ar_burst, slave.ar_lock, slave.ar_cache, slave.ar_prot, slave.ar_qos, slave.ar_region, slave.ar_user})
    );
    typedef global_types::struct_9 r_pack_t;
    regslice_9 rfifo (
        .clk(master.clk),
        .rstn(master.rstn),
        .w_valid(slave.r_valid),
        .w_ready(slave.r_ready),
        .w_data(global_types::struct_9'{slave.r_id, slave.r_data, slave.r_resp, slave.r_last, slave.r_user}),
        .r_valid(master.r_valid),
        .r_ready(master.r_ready),
        .r_data({master.r_id, master.r_data, master.r_resp, master.r_last, master.r_user})
    );
endmodule

/* file: ../axi/to_lite.sv */
/* file: onehot.sv */
module onehot_to_binary (
    input wire logic[8:0] onehot,
    output var logic[3:0] binary
);
    parameter integer ONEHOT_WIDTH = 9;
    parameter integer BINARY_WIDTH = 4;
    localparam integer bin_0_i = 0;
    logic[8:0] bin_0_bitmask;
    localparam integer bin_0_one_0_j = 0;
    logic[3:0] bin_0_one_0_logic_j;
    assign bin_0_one_0_logic_j = 0;
    assign bin_0_bitmask[0] = bin_0_one_0_logic_j[0] & onehot[0];
    localparam integer bin_0_one_1_j = 1;
    logic[3:0] bin_0_one_1_logic_j;
    assign bin_0_one_1_logic_j = 1;
    assign bin_0_bitmask[1] = bin_0_one_1_logic_j[0] & onehot[1];
    localparam integer bin_0_one_2_j = 2;
    logic[3:0] bin_0_one_2_logic_j;
    assign bin_0_one_2_logic_j = 2;
    assign bin_0_bitmask[2] = bin_0_one_2_logic_j[0] & onehot[2];
    localparam integer bin_0_one_3_j = 3;
    logic[3:0] bin_0_one_3_logic_j;
    assign bin_0_one_3_logic_j = 3;
    assign bin_0_bitmask[3] = bin_0_one_3_logic_j[0] & onehot[3];
    localparam integer bin_0_one_4_j = 4;
    logic[3:0] bin_0_one_4_logic_j;
    assign bin_0_one_4_logic_j = 4;
    assign bin_0_bitmask[4] = bin_0_one_4_logic_j[0] & onehot[4];
    localparam integer bin_0_one_5_j = 5;
    logic[3:0] bin_0_one_5_logic_j;
    assign bin_0_one_5_logic_j = 5;
    assign bin_0_bitmask[5] = bin_0_one_5_logic_j[0] & onehot[5];
    localparam integer bin_0_one_6_j = 6;
    logic[3:0] bin_0_one_6_logic_j;
    assign bin_0_one_6_logic_j = 6;
    assign bin_0_bitmask[6] = bin_0_one_6_logic_j[0] & onehot[6];
    localparam integer bin_0_one_7_j = 7;
    logic[3:0] bin_0_one_7_logic_j;
    assign bin_0_one_7_logic_j = 7;
    assign bin_0_bitmask[7] = bin_0_one_7_logic_j[0] & onehot[7];
    localparam integer bin_0_one_8_j = 8;
    logic[3:0] bin_0_one_8_logic_j;
    assign bin_0_one_8_logic_j = 8;
    assign bin_0_bitmask[8] = bin_0_one_8_logic_j[0] & onehot[8];
    assign binary[0] = |bin_0_bitmask;
    localparam integer bin_1_i = 1;
    logic[8:0] bin_1_bitmask;
    localparam integer bin_1_one_0_j = 0;
    logic[3:0] bin_1_one_0_logic_j;
    assign bin_1_one_0_logic_j = 0;
    assign bin_1_bitmask[0] = bin_1_one_0_logic_j[1] & onehot[0];
    localparam integer bin_1_one_1_j = 1;
    logic[3:0] bin_1_one_1_logic_j;
    assign bin_1_one_1_logic_j = 1;
    assign bin_1_bitmask[1] = bin_1_one_1_logic_j[1] & onehot[1];
    localparam integer bin_1_one_2_j = 2;
    logic[3:0] bin_1_one_2_logic_j;
    assign bin_1_one_2_logic_j = 2;
    assign bin_1_bitmask[2] = bin_1_one_2_logic_j[1] & onehot[2];
    localparam integer bin_1_one_3_j = 3;
    logic[3:0] bin_1_one_3_logic_j;
    assign bin_1_one_3_logic_j = 3;
    assign bin_1_bitmask[3] = bin_1_one_3_logic_j[1] & onehot[3];
    localparam integer bin_1_one_4_j = 4;
    logic[3:0] bin_1_one_4_logic_j;
    assign bin_1_one_4_logic_j = 4;
    assign bin_1_bitmask[4] = bin_1_one_4_logic_j[1] & onehot[4];
    localparam integer bin_1_one_5_j = 5;
    logic[3:0] bin_1_one_5_logic_j;
    assign bin_1_one_5_logic_j = 5;
    assign bin_1_bitmask[5] = bin_1_one_5_logic_j[1] & onehot[5];
    localparam integer bin_1_one_6_j = 6;
    logic[3:0] bin_1_one_6_logic_j;
    assign bin_1_one_6_logic_j = 6;
    assign bin_1_bitmask[6] = bin_1_one_6_logic_j[1] & onehot[6];
    localparam integer bin_1_one_7_j = 7;
    logic[3:0] bin_1_one_7_logic_j;
    assign bin_1_one_7_logic_j = 7;
    assign bin_1_bitmask[7] = bin_1_one_7_logic_j[1] & onehot[7];
    localparam integer bin_1_one_8_j = 8;
    logic[3:0] bin_1_one_8_logic_j;
    assign bin_1_one_8_logic_j = 8;
    assign bin_1_bitmask[8] = bin_1_one_8_logic_j[1] & onehot[8];
    assign binary[1] = |bin_1_bitmask;
    localparam integer bin_2_i = 2;
    logic[8:0] bin_2_bitmask;
    localparam integer bin_2_one_0_j = 0;
    logic[3:0] bin_2_one_0_logic_j;
    assign bin_2_one_0_logic_j = 0;
    assign bin_2_bitmask[0] = bin_2_one_0_logic_j[2] & onehot[0];
    localparam integer bin_2_one_1_j = 1;
    logic[3:0] bin_2_one_1_logic_j;
    assign bin_2_one_1_logic_j = 1;
    assign bin_2_bitmask[1] = bin_2_one_1_logic_j[2] & onehot[1];
    localparam integer bin_2_one_2_j = 2;
    logic[3:0] bin_2_one_2_logic_j;
    assign bin_2_one_2_logic_j = 2;
    assign bin_2_bitmask[2] = bin_2_one_2_logic_j[2] & onehot[2];
    localparam integer bin_2_one_3_j = 3;
    logic[3:0] bin_2_one_3_logic_j;
    assign bin_2_one_3_logic_j = 3;
    assign bin_2_bitmask[3] = bin_2_one_3_logic_j[2] & onehot[3];
    localparam integer bin_2_one_4_j = 4;
    logic[3:0] bin_2_one_4_logic_j;
    assign bin_2_one_4_logic_j = 4;
    assign bin_2_bitmask[4] = bin_2_one_4_logic_j[2] & onehot[4];
    localparam integer bin_2_one_5_j = 5;
    logic[3:0] bin_2_one_5_logic_j;
    assign bin_2_one_5_logic_j = 5;
    assign bin_2_bitmask[5] = bin_2_one_5_logic_j[2] & onehot[5];
    localparam integer bin_2_one_6_j = 6;
    logic[3:0] bin_2_one_6_logic_j;
    assign bin_2_one_6_logic_j = 6;
    assign bin_2_bitmask[6] = bin_2_one_6_logic_j[2] & onehot[6];
    localparam integer bin_2_one_7_j = 7;
    logic[3:0] bin_2_one_7_logic_j;
    assign bin_2_one_7_logic_j = 7;
    assign bin_2_bitmask[7] = bin_2_one_7_logic_j[2] & onehot[7];
    localparam integer bin_2_one_8_j = 8;
    logic[3:0] bin_2_one_8_logic_j;
    assign bin_2_one_8_logic_j = 8;
    assign bin_2_bitmask[8] = bin_2_one_8_logic_j[2] & onehot[8];
    assign binary[2] = |bin_2_bitmask;
    localparam integer bin_3_i = 3;
    logic[8:0] bin_3_bitmask;
    localparam integer bin_3_one_0_j = 0;
    logic[3:0] bin_3_one_0_logic_j;
    assign bin_3_one_0_logic_j = 0;
    assign bin_3_bitmask[0] = bin_3_one_0_logic_j[3] & onehot[0];
    localparam integer bin_3_one_1_j = 1;
    logic[3:0] bin_3_one_1_logic_j;
    assign bin_3_one_1_logic_j = 1;
    assign bin_3_bitmask[1] = bin_3_one_1_logic_j[3] & onehot[1];
    localparam integer bin_3_one_2_j = 2;
    logic[3:0] bin_3_one_2_logic_j;
    assign bin_3_one_2_logic_j = 2;
    assign bin_3_bitmask[2] = bin_3_one_2_logic_j[3] & onehot[2];
    localparam integer bin_3_one_3_j = 3;
    logic[3:0] bin_3_one_3_logic_j;
    assign bin_3_one_3_logic_j = 3;
    assign bin_3_bitmask[3] = bin_3_one_3_logic_j[3] & onehot[3];
    localparam integer bin_3_one_4_j = 4;
    logic[3:0] bin_3_one_4_logic_j;
    assign bin_3_one_4_logic_j = 4;
    assign bin_3_bitmask[4] = bin_3_one_4_logic_j[3] & onehot[4];
    localparam integer bin_3_one_5_j = 5;
    logic[3:0] bin_3_one_5_logic_j;
    assign bin_3_one_5_logic_j = 5;
    assign bin_3_bitmask[5] = bin_3_one_5_logic_j[3] & onehot[5];
    localparam integer bin_3_one_6_j = 6;
    logic[3:0] bin_3_one_6_logic_j;
    assign bin_3_one_6_logic_j = 6;
    assign bin_3_bitmask[6] = bin_3_one_6_logic_j[3] & onehot[6];
    localparam integer bin_3_one_7_j = 7;
    logic[3:0] bin_3_one_7_logic_j;
    assign bin_3_one_7_logic_j = 7;
    assign bin_3_bitmask[7] = bin_3_one_7_logic_j[3] & onehot[7];
    localparam integer bin_3_one_8_j = 8;
    logic[3:0] bin_3_one_8_logic_j;
    assign bin_3_one_8_logic_j = 8;
    assign bin_3_bitmask[8] = bin_3_one_8_logic_j[3] & onehot[8];
    assign binary[3] = |bin_3_bitmask;
endmodule
module onehot_to_binary_1 (
    input wire logic[1:0] onehot,
    output var logic[0:0] binary
);
    parameter integer ONEHOT_WIDTH = 2;
    parameter integer BINARY_WIDTH = 1;
    localparam integer bin_0_i = 0;
    logic[1:0] bin_0_bitmask;
    localparam integer bin_0_one_0_j = 0;
    logic[0:0] bin_0_one_0_logic_j;
    assign bin_0_one_0_logic_j = 0;
    assign bin_0_bitmask[0] = bin_0_one_0_logic_j[0] & onehot[0];
    localparam integer bin_0_one_1_j = 1;
    logic[0:0] bin_0_one_1_logic_j;
    assign bin_0_one_1_logic_j = 1;
    assign bin_0_bitmask[1] = bin_0_one_1_logic_j[0] & onehot[1];
    assign binary[0] = |bin_0_bitmask;
endmodule

/* file: regslice.sv */
module regslice (
    input wire logic clk,
    input wire logic rstn,
    input wire logic w_valid,
    output var logic w_ready,
    input wire global_types::struct_10 w_data,
    output var logic r_valid,
    input wire logic r_ready,
    output var global_types::struct_10 r_data
);
    parameter integer DATA_WIDTH = 1;
    typedef global_types::struct_10 TYPE;
    parameter logic[0:0] FORWARD = 1'd0;
    parameter logic[0:0] REVERSE = 1'd0;
    parameter logic[0:0] HIGH_PERFORMANCE = 1'd0;
    assign r_valid = w_valid;
    assign w_ready = r_ready;
    assign r_data = w_data;
endmodule
module regslice_1 (
    input wire logic clk,
    input wire logic rstn,
    input wire logic w_valid,
    output var logic w_ready,
    input wire global_types::struct_11 w_data,
    output var logic r_valid,
    input wire logic r_ready,
    output var global_types::struct_11 r_data
);
    parameter integer DATA_WIDTH = 1;
    typedef global_types::struct_11 TYPE;
    parameter logic[0:0] FORWARD = 1'd0;
    parameter logic[0:0] REVERSE = 1'd0;
    parameter logic[0:0] HIGH_PERFORMANCE = 1'd0;
    assign r_valid = w_valid;
    assign w_ready = r_ready;
    assign r_data = w_data;
endmodule
module regslice_2 (
    input wire logic clk,
    input wire logic rstn,
    input wire logic w_valid,
    output var logic w_ready,
    input wire global_types::struct_12 w_data,
    output var logic r_valid,
    input wire logic r_ready,
    output var global_types::struct_12 r_data
);
    parameter integer DATA_WIDTH = 1;
    typedef global_types::struct_12 TYPE;
    parameter logic[0:0] FORWARD = 1'd0;
    parameter logic[0:0] REVERSE = 1'd0;
    parameter logic[0:0] HIGH_PERFORMANCE = 1'd0;
    assign r_valid = w_valid;
    assign w_ready = r_ready;
    assign r_data = w_data;
endmodule
module regslice_3 (
    input wire logic clk,
    input wire logic rstn,
    input wire logic w_valid,
    output var logic w_ready,
    input wire global_types::struct_13 w_data,
    output var logic r_valid,
    input wire logic r_ready,
    output var global_types::struct_13 r_data
);
    parameter integer DATA_WIDTH = 1;
    typedef global_types::struct_13 TYPE;
    parameter logic[0:0] FORWARD = 1'd0;
    parameter logic[0:0] REVERSE = 1'd0;
    parameter logic[0:0] HIGH_PERFORMANCE = 1'd0;
    assign r_valid = w_valid;
    assign w_ready = r_ready;
    assign r_data = w_data;
endmodule
module regslice_4 (
    input wire logic clk,
    input wire logic rstn,
    input wire logic w_valid,
    output var logic w_ready,
    input wire global_types::struct_14 w_data,
    output var logic r_valid,
    input wire logic r_ready,
    output var global_types::struct_14 r_data
);
    parameter integer DATA_WIDTH = 1;
    typedef global_types::struct_14 TYPE;
    parameter logic[0:0] FORWARD = 1'd1;
    parameter logic[0:0] REVERSE = 1'd0;
    parameter logic[0:0] HIGH_PERFORMANCE = 1'd0;
    global_types::struct_14 genblk1_buffer;
    logic genblk1_valid;
    assign r_valid = genblk1_valid;
    assign w_ready = !genblk1_valid || r_ready;
    always_ff @(posedge clk or negedge rstn) if (!rstn) begin
        genblk1_valid <= 1'd0;
    end else begin
        if (r_ready) genblk1_valid <= 1'd0;
        if (w_valid) genblk1_valid <= 1'd1;
    end
    assign r_data = genblk1_buffer;
    always_ff @(posedge clk) if (w_valid && w_ready) genblk1_buffer <= w_data;
endmodule
module regslice_5 (
    input wire logic clk,
    input wire logic rstn,
    input wire logic w_valid,
    output var logic w_ready,
    input wire global_types::struct_5 w_data,
    output var logic r_valid,
    input wire logic r_ready,
    output var global_types::struct_5 r_data
);
    parameter integer DATA_WIDTH = 1;
    typedef global_types::struct_5 TYPE;
    parameter logic[0:0] FORWARD = 1'd0;
    parameter logic[0:0] REVERSE = 1'd0;
    parameter logic[0:0] HIGH_PERFORMANCE = 1'd0;
    assign r_valid = w_valid;
    assign w_ready = r_ready;
    assign r_data = w_data;
endmodule
module regslice_6 (
    input wire logic clk,
    input wire logic rstn,
    input wire logic w_valid,
    output var logic w_ready,
    input wire global_types::struct_6 w_data,
    output var logic r_valid,
    input wire logic r_ready,
    output var global_types::struct_6 r_data
);
    parameter integer DATA_WIDTH = 1;
    typedef global_types::struct_6 TYPE;
    parameter logic[0:0] FORWARD = 1'd0;
    parameter logic[0:0] REVERSE = 1'd0;
    parameter logic[0:0] HIGH_PERFORMANCE = 1'd0;
    assign r_valid = w_valid;
    assign w_ready = r_ready;
    assign r_data = w_data;
endmodule
module regslice_7 (
    input wire logic clk,
    input wire logic rstn,
    input wire logic w_valid,
    output var logic w_ready,
    input wire global_types::struct_7 w_data,
    output var logic r_valid,
    input wire logic r_ready,
    output var global_types::struct_7 r_data
);
    parameter integer DATA_WIDTH = 1;
    typedef global_types::struct_7 TYPE;
    parameter logic[0:0] FORWARD = 1'd0;
    parameter logic[0:0] REVERSE = 1'd1;
    parameter logic[0:0] HIGH_PERFORMANCE = 1'd0;
    global_types::struct_7 genblk1_buffer;
    logic genblk1_valid;
    assign r_valid = genblk1_valid || w_valid;
    assign w_ready = !genblk1_valid;
    always_ff @(posedge clk or negedge rstn) if (!rstn) begin
        genblk1_valid <= 1'd0;
    end else begin
        genblk1_valid <= genblk1_valid ? !r_ready : w_valid && !r_ready;
    end
    assign r_data = genblk1_valid ? genblk1_buffer : w_data;
    always_ff @(posedge clk) if (w_valid && w_ready) genblk1_buffer <= w_data;
endmodule
module regslice_8 (
    input wire logic clk,
    input wire logic rstn,
    input wire logic w_valid,
    output var logic w_ready,
    input wire global_types::struct_8 w_data,
    output var logic r_valid,
    input wire logic r_ready,
    output var global_types::struct_8 r_data
);
    parameter integer DATA_WIDTH = 1;
    typedef global_types::struct_8 TYPE;
    parameter logic[0:0] FORWARD = 1'd0;
    parameter logic[0:0] REVERSE = 1'd0;
    parameter logic[0:0] HIGH_PERFORMANCE = 1'd0;
    assign r_valid = w_valid;
    assign w_ready = r_ready;
    assign r_data = w_data;
endmodule
module regslice_9 (
    input wire logic clk,
    input wire logic rstn,
    input wire logic w_valid,
    output var logic w_ready,
    input wire global_types::struct_9 w_data,
    output var logic r_valid,
    input wire logic r_ready,
    output var global_types::struct_9 r_data
);
    parameter integer DATA_WIDTH = 1;
    typedef global_types::struct_9 TYPE;
    parameter logic[0:0] FORWARD = 1'd0;
    parameter logic[0:0] REVERSE = 1'd1;
    parameter logic[0:0] HIGH_PERFORMANCE = 1'd0;
    global_types::struct_9 genblk1_buffer;
    logic genblk1_valid;
    assign r_valid = genblk1_valid || w_valid;
    assign w_ready = !genblk1_valid;
    always_ff @(posedge clk or negedge rstn) if (!rstn) begin
        genblk1_valid <= 1'd0;
    end else begin
        genblk1_valid <= genblk1_valid ? !r_ready : w_valid && !r_ready;
    end
    assign r_data = genblk1_valid ? genblk1_buffer : w_data;
    always_ff @(posedge clk) if (w_valid && w_ready) genblk1_buffer <= w_data;
endmodule

/* file: fifo.sv */
/* file: from_if.sv */
module from_if (
    AXI_BUS.Slave incoming_if,
    axi_channel_1.master outgoing_openip
);
    parameter integer ID_WIDTH = 4;
    parameter integer ADDR_WIDTH = 64;
    parameter integer DATA_WIDTH = 64;
    parameter integer USER_WIDTH = 1;
    slave_adapter sadapt (
        .clk(outgoing_openip.clk),
        .rstn(outgoing_openip.rstn),
        .s_axi_awid(incoming_if.aw_id),
        .s_axi_awaddr(incoming_if.aw_addr),
        .s_axi_awlen(incoming_if.aw_len),
        .s_axi_awsize(incoming_if.aw_size),
        .s_axi_awburst(incoming_if.aw_burst),
        .s_axi_awlock(incoming_if.aw_lock),
        .s_axi_awcache(incoming_if.aw_cache),
        .s_axi_awprot(incoming_if.aw_prot),
        .s_axi_awregion(incoming_if.aw_region),
        .s_axi_awqos(incoming_if.aw_qos),
        .s_axi_awuser(incoming_if.aw_user),
        .s_axi_awvalid(incoming_if.aw_valid),
        .s_axi_awready(incoming_if.aw_ready),
        .s_axi_wdata(incoming_if.w_data),
        .s_axi_wstrb(incoming_if.w_strb),
        .s_axi_wlast(incoming_if.w_last),
        .s_axi_wuser(incoming_if.w_user),
        .s_axi_wvalid(incoming_if.w_valid),
        .s_axi_wready(incoming_if.w_ready),
        .s_axi_bid(incoming_if.b_id),
        .s_axi_bresp(incoming_if.b_resp),
        .s_axi_buser(incoming_if.b_user),
        .s_axi_bvalid(incoming_if.b_valid),
        .s_axi_bready(incoming_if.b_ready),
        .s_axi_arid(incoming_if.ar_id),
        .s_axi_araddr(incoming_if.ar_addr),
        .s_axi_arlen(incoming_if.ar_len),
        .s_axi_arsize(incoming_if.ar_size),
        .s_axi_arburst(incoming_if.ar_burst),
        .s_axi_arlock(incoming_if.ar_lock),
        .s_axi_arcache(incoming_if.ar_cache),
        .s_axi_arprot(incoming_if.ar_prot),
        .s_axi_arregion(incoming_if.ar_region),
        .s_axi_arqos(incoming_if.ar_qos),
        .s_axi_aruser(incoming_if.ar_user),
        .s_axi_arvalid(incoming_if.ar_valid),
        .s_axi_arready(incoming_if.ar_ready),
        .s_axi_rid(incoming_if.r_id),
        .s_axi_rdata(incoming_if.r_data),
        .s_axi_rresp(incoming_if.r_resp),
        .s_axi_rlast(incoming_if.r_last),
        .s_axi_ruser(incoming_if.r_user),
        .s_axi_rvalid(incoming_if.r_valid),
        .s_axi_rready(incoming_if.r_ready),
        .m_axi_awid(outgoing_openip.aw_id),
        .m_axi_awaddr(outgoing_openip.aw_addr),
        .m_axi_awlen(outgoing_openip.aw_len),
        .m_axi_awsize(outgoing_openip.aw_size),
        .m_axi_awburst(outgoing_openip.aw_burst),
        .m_axi_awlock(outgoing_openip.aw_lock),
        .m_axi_awcache(outgoing_openip.aw_cache),
        .m_axi_awprot(outgoing_openip.aw_prot),
        .m_axi_awregion(outgoing_openip.aw_region),
        .m_axi_awqos(outgoing_openip.aw_qos),
        .m_axi_awuser(outgoing_openip.aw_user),
        .m_axi_awvalid(outgoing_openip.aw_valid),
        .m_axi_awready(outgoing_openip.aw_ready),
        .m_axi_wdata(outgoing_openip.w_data),
        .m_axi_wstrb(outgoing_openip.w_strb),
        .m_axi_wlast(outgoing_openip.w_last),
        .m_axi_wuser(outgoing_openip.w_user),
        .m_axi_wvalid(outgoing_openip.w_valid),
        .m_axi_wready(outgoing_openip.w_ready),
        .m_axi_bid(outgoing_openip.b_id),
        .m_axi_bresp(outgoing_openip.b_resp),
        .m_axi_buser(outgoing_openip.b_user),
        .m_axi_bvalid(outgoing_openip.b_valid),
        .m_axi_bready(outgoing_openip.b_ready),
        .m_axi_arid(outgoing_openip.ar_id),
        .m_axi_araddr(outgoing_openip.ar_addr),
        .m_axi_arlen(outgoing_openip.ar_len),
        .m_axi_arsize(outgoing_openip.ar_size),
        .m_axi_arburst(outgoing_openip.ar_burst),
        .m_axi_arlock(outgoing_openip.ar_lock),
        .m_axi_arcache(outgoing_openip.ar_cache),
        .m_axi_arprot(outgoing_openip.ar_prot),
        .m_axi_arregion(outgoing_openip.ar_region),
        .m_axi_arqos(outgoing_openip.ar_qos),
        .m_axi_aruser(outgoing_openip.ar_user),
        .m_axi_arvalid(outgoing_openip.ar_valid),
        .m_axi_arready(outgoing_openip.ar_ready),
        .m_axi_rid(outgoing_openip.r_id),
        .m_axi_rdata(outgoing_openip.r_data),
        .m_axi_rresp(outgoing_openip.r_resp),
        .m_axi_rlast(outgoing_openip.r_last),
        .m_axi_ruser(outgoing_openip.r_user),
        .m_axi_rvalid(outgoing_openip.r_valid),
        .m_axi_rready(outgoing_openip.r_ready)
    );
endmodule

/* file: to_if.sv */
module to_if (
    AXI_BUS.Master outgoing_if,
    axi_channel.slave incoming_openip
);
    parameter integer ID_WIDTH = 5;
    parameter integer ADDR_WIDTH = 64;
    parameter integer DATA_WIDTH = 64;
    parameter integer USER_WIDTH = 1;
    slave_adapter_1 sadapt (
        .clk(incoming_openip.clk),
        .rstn(incoming_openip.rstn),
        .s_axi_awid(incoming_openip.aw_id),
        .s_axi_awaddr(incoming_openip.aw_addr),
        .s_axi_awlen(incoming_openip.aw_len),
        .s_axi_awsize(incoming_openip.aw_size),
        .s_axi_awburst(incoming_openip.aw_burst),
        .s_axi_awlock(incoming_openip.aw_lock),
        .s_axi_awcache(incoming_openip.aw_cache),
        .s_axi_awprot(incoming_openip.aw_prot),
        .s_axi_awregion(incoming_openip.aw_region),
        .s_axi_awqos(incoming_openip.aw_qos),
        .s_axi_awuser(incoming_openip.aw_user),
        .s_axi_awvalid(incoming_openip.aw_valid),
        .s_axi_awready(incoming_openip.aw_ready),
        .s_axi_wdata(incoming_openip.w_data),
        .s_axi_wstrb(incoming_openip.w_strb),
        .s_axi_wlast(incoming_openip.w_last),
        .s_axi_wuser(incoming_openip.w_user),
        .s_axi_wvalid(incoming_openip.w_valid),
        .s_axi_wready(incoming_openip.w_ready),
        .s_axi_bid(incoming_openip.b_id),
        .s_axi_bresp(incoming_openip.b_resp),
        .s_axi_buser(incoming_openip.b_user),
        .s_axi_bvalid(incoming_openip.b_valid),
        .s_axi_bready(incoming_openip.b_ready),
        .s_axi_arid(incoming_openip.ar_id),
        .s_axi_araddr(incoming_openip.ar_addr),
        .s_axi_arlen(incoming_openip.ar_len),
        .s_axi_arsize(incoming_openip.ar_size),
        .s_axi_arburst(incoming_openip.ar_burst),
        .s_axi_arlock(incoming_openip.ar_lock),
        .s_axi_arcache(incoming_openip.ar_cache),
        .s_axi_arprot(incoming_openip.ar_prot),
        .s_axi_arregion(incoming_openip.ar_region),
        .s_axi_arqos(incoming_openip.ar_qos),
        .s_axi_aruser(incoming_openip.ar_user),
        .s_axi_arvalid(incoming_openip.ar_valid),
        .s_axi_arready(incoming_openip.ar_ready),
        .s_axi_rid(incoming_openip.r_id),
        .s_axi_rdata(incoming_openip.r_data),
        .s_axi_rresp(incoming_openip.r_resp),
        .s_axi_rlast(incoming_openip.r_last),
        .s_axi_ruser(incoming_openip.r_user),
        .s_axi_rvalid(incoming_openip.r_valid),
        .s_axi_rready(incoming_openip.r_ready),
        .m_axi_awid(outgoing_if.aw_id),
        .m_axi_awaddr(outgoing_if.aw_addr),
        .m_axi_awlen(outgoing_if.aw_len),
        .m_axi_awsize(outgoing_if.aw_size),
        .m_axi_awburst(outgoing_if.aw_burst),
        .m_axi_awlock(outgoing_if.aw_lock),
        .m_axi_awcache(outgoing_if.aw_cache),
        .m_axi_awprot(outgoing_if.aw_prot),
        .m_axi_awregion(outgoing_if.aw_region),
        .m_axi_awqos(outgoing_if.aw_qos),
        .m_axi_awuser(outgoing_if.aw_user),
        .m_axi_awvalid(outgoing_if.aw_valid),
        .m_axi_awready(outgoing_if.aw_ready),
        .m_axi_wdata(outgoing_if.w_data),
        .m_axi_wstrb(outgoing_if.w_strb),
        .m_axi_wlast(outgoing_if.w_last),
        .m_axi_wuser(outgoing_if.w_user),
        .m_axi_wvalid(outgoing_if.w_valid),
        .m_axi_wready(outgoing_if.w_ready),
        .m_axi_bid(outgoing_if.b_id),
        .m_axi_bresp(outgoing_if.b_resp),
        .m_axi_buser(outgoing_if.b_user),
        .m_axi_bvalid(outgoing_if.b_valid),
        .m_axi_bready(outgoing_if.b_ready),
        .m_axi_arid(outgoing_if.ar_id),
        .m_axi_araddr(outgoing_if.ar_addr),
        .m_axi_arlen(outgoing_if.ar_len),
        .m_axi_arsize(outgoing_if.ar_size),
        .m_axi_arburst(outgoing_if.ar_burst),
        .m_axi_arlock(outgoing_if.ar_lock),
        .m_axi_arcache(outgoing_if.ar_cache),
        .m_axi_arprot(outgoing_if.ar_prot),
        .m_axi_arregion(outgoing_if.ar_region),
        .m_axi_arqos(outgoing_if.ar_qos),
        .m_axi_aruser(outgoing_if.ar_user),
        .m_axi_arvalid(outgoing_if.ar_valid),
        .m_axi_arready(outgoing_if.ar_ready),
        .m_axi_rid(outgoing_if.r_id),
        .m_axi_rdata(outgoing_if.r_data),
        .m_axi_rresp(outgoing_if.r_resp),
        .m_axi_rlast(outgoing_if.r_last),
        .m_axi_ruser(outgoing_if.r_user),
        .m_axi_rvalid(outgoing_if.r_valid),
        .m_axi_rready(outgoing_if.r_ready)
    );
endmodule

/* file: round_robin_arbiter.sv */
module round_robin_arbiter (
    input wire logic clk,
    input wire logic rstn,
    input wire logic enable,
    input wire logic[8:0] request,
    output var logic[8:0] grant
);
    parameter integer WIDTH = 9;
    logic[8:0] last_grant;
    logic[8:0] masked_request;
    assign masked_request = {~(32'(last_grant) - 32'd1), 1'd0} & 33'(request);
    logic[8:0] masked_grant;
    priority_arbiter masked_arbiter (
        .request(masked_request),
        .grant(masked_grant)
    );
    logic[8:0] unmasked_grant;
    priority_arbiter unmasked_arbiter (
        .request(request),
        .grant(unmasked_grant)
    );
    assign grant = 32'(masked_request) != 32'd0 ? masked_grant : unmasked_grant;
    always_ff @(posedge clk or negedge rstn) if (!rstn) begin
        last_grant <= 9'd0;
    end else if (enable) begin
        last_grant <= grant;
    end
endmodule
module round_robin_arbiter_1 (
    input wire logic clk,
    input wire logic rstn,
    input wire logic enable,
    input wire logic[1:0] request,
    output var logic[1:0] grant
);
    parameter integer WIDTH = 2;
    logic[1:0] last_grant;
    logic[1:0] masked_request;
    assign masked_request = {~(32'(last_grant) - 32'd1), 1'd0} & 33'(request);
    logic[1:0] masked_grant;
    priority_arbiter_1 masked_arbiter (
        .request(masked_request),
        .grant(masked_grant)
    );
    logic[1:0] unmasked_grant;
    priority_arbiter_1 unmasked_arbiter (
        .request(request),
        .grant(unmasked_grant)
    );
    assign grant = 32'(masked_request) != 32'd0 ? masked_grant : unmasked_grant;
    always_ff @(posedge clk or negedge rstn) if (!rstn) begin
        last_grant <= 2'd0;
    end else if (enable) begin
        last_grant <= grant;
    end
endmodule

/* file: priority_arbiter.sv */
module priority_arbiter (
    input wire logic[8:0] request,
    output var logic[8:0] grant
);
    parameter integer WIDTH = 9;
    assign grant = request & -request;
endmodule
module priority_arbiter_1 (
    input wire logic[1:0] request,
    output var logic[1:0] grant
);
    parameter integer WIDTH = 2;
    assign grant = request & -request;
endmodule

/* file: slave_adapter.sv */
module slave_adapter (
    input wire logic clk,
    input wire logic rstn,
    input wire logic[3:0] s_axi_awid,
    input wire logic[63:0] s_axi_awaddr,
    input wire logic[7:0] s_axi_awlen,
    input wire logic[2:0] s_axi_awsize,
    input wire logic[1:0] s_axi_awburst,
    input wire logic s_axi_awlock,
    input wire logic[3:0] s_axi_awcache,
    input wire logic[2:0] s_axi_awprot,
    input wire logic[3:0] s_axi_awregion,
    input wire logic[3:0] s_axi_awqos,
    input wire logic[0:0] s_axi_awuser,
    input wire logic s_axi_awvalid,
    output wire logic s_axi_awready,
    input wire logic[63:0] s_axi_wdata,
    input wire logic[7:0] s_axi_wstrb,
    input wire logic s_axi_wlast,
    input wire logic[0:0] s_axi_wuser,
    input wire logic s_axi_wvalid,
    output wire logic s_axi_wready,
    output wire logic[3:0] s_axi_bid,
    output wire logic[1:0] s_axi_bresp,
    output wire logic[0:0] s_axi_buser,
    output wire logic s_axi_bvalid,
    input wire logic s_axi_bready,
    input wire logic[3:0] s_axi_arid,
    input wire logic[63:0] s_axi_araddr,
    input wire logic[7:0] s_axi_arlen,
    input wire logic[2:0] s_axi_arsize,
    input wire logic[1:0] s_axi_arburst,
    input wire logic s_axi_arlock,
    input wire logic[3:0] s_axi_arcache,
    input wire logic[2:0] s_axi_arprot,
    input wire logic[3:0] s_axi_arregion,
    input wire logic[3:0] s_axi_arqos,
    input wire logic[0:0] s_axi_aruser,
    input wire logic s_axi_arvalid,
    output wire logic s_axi_arready,
    output wire logic[3:0] s_axi_rid,
    output wire logic[63:0] s_axi_rdata,
    output wire logic[1:0] s_axi_rresp,
    output wire logic s_axi_rlast,
    output wire logic[0:0] s_axi_ruser,
    output wire logic s_axi_rvalid,
    input wire logic s_axi_rready,
    output wire logic[3:0] m_axi_awid,
    output wire logic[63:0] m_axi_awaddr,
    output wire logic[7:0] m_axi_awlen,
    output wire logic[2:0] m_axi_awsize,
    output wire logic[1:0] m_axi_awburst,
    output wire logic[0:0] m_axi_awlock,
    output wire logic[3:0] m_axi_awcache,
    output wire logic[2:0] m_axi_awprot,
    output wire logic[3:0] m_axi_awregion,
    output wire logic[3:0] m_axi_awqos,
    output wire logic[0:0] m_axi_awuser,
    output wire logic m_axi_awvalid,
    input wire logic m_axi_awready,
    output wire logic[63:0] m_axi_wdata,
    output wire logic[7:0] m_axi_wstrb,
    output wire logic m_axi_wlast,
    output wire logic[0:0] m_axi_wuser,
    output wire logic m_axi_wvalid,
    input wire logic m_axi_wready,
    input wire logic[3:0] m_axi_bid,
    input wire logic[1:0] m_axi_bresp,
    input wire logic[0:0] m_axi_buser,
    input wire logic m_axi_bvalid,
    output wire logic m_axi_bready,
    output wire logic[3:0] m_axi_arid,
    output wire logic[63:0] m_axi_araddr,
    output wire logic[7:0] m_axi_arlen,
    output wire logic[2:0] m_axi_arsize,
    output wire logic[1:0] m_axi_arburst,
    output wire logic[0:0] m_axi_arlock,
    output wire logic[3:0] m_axi_arcache,
    output wire logic[2:0] m_axi_arprot,
    output wire logic[3:0] m_axi_arregion,
    output wire logic[3:0] m_axi_arqos,
    output wire logic[0:0] m_axi_aruser,
    output wire logic m_axi_arvalid,
    input wire logic m_axi_arready,
    input wire logic[3:0] m_axi_rid,
    input wire logic[63:0] m_axi_rdata,
    input wire logic[1:0] m_axi_rresp,
    input wire logic m_axi_rlast,
    input wire logic[0:0] m_axi_ruser,
    input wire logic m_axi_rvalid,
    output wire logic m_axi_rready
);
    parameter integer ID_WIDTH = 4;
    parameter integer ADDR_WIDTH = 64;
    parameter integer DATA_WIDTH = 64;
    parameter integer USER_WIDTH = 1;
    parameter integer LITE_MODE = 0;
    assign s_axi_awready = m_axi_awready;
    assign s_axi_wready = m_axi_wready;
    assign s_axi_bid = m_axi_bid;
    assign s_axi_bresp = m_axi_bresp;
    assign s_axi_buser = m_axi_buser;
    assign s_axi_bvalid = m_axi_bvalid;
    assign s_axi_arready = m_axi_arready;
    assign s_axi_rid = m_axi_rid;
    assign s_axi_rdata = m_axi_rdata;
    assign s_axi_rresp = m_axi_rresp;
    assign s_axi_rlast = m_axi_rlast;
    assign s_axi_ruser = m_axi_ruser;
    assign s_axi_rvalid = m_axi_rvalid;
    assign m_axi_awid = s_axi_awid;
    assign m_axi_awaddr = s_axi_awaddr;
    assign m_axi_awlen = s_axi_awlen;
    assign m_axi_awsize = s_axi_awsize;
    assign m_axi_awburst = s_axi_awburst;
    assign m_axi_awlock = s_axi_awlock;
    assign m_axi_awcache = s_axi_awcache;
    assign m_axi_awprot = s_axi_awprot;
    assign m_axi_awregion = s_axi_awregion;
    assign m_axi_awqos = s_axi_awqos;
    assign m_axi_awuser = s_axi_awuser;
    assign m_axi_awvalid = s_axi_awvalid;
    assign m_axi_wdata = s_axi_wdata;
    assign m_axi_wstrb = s_axi_wstrb;
    assign m_axi_wlast = s_axi_wlast;
    assign m_axi_wuser = s_axi_wuser;
    assign m_axi_wvalid = s_axi_wvalid;
    assign m_axi_bready = s_axi_bready;
    assign m_axi_arid = s_axi_arid;
    assign m_axi_araddr = s_axi_araddr;
    assign m_axi_arlen = s_axi_arlen;
    assign m_axi_arsize = s_axi_arsize;
    assign m_axi_arburst = s_axi_arburst;
    assign m_axi_arlock = s_axi_arlock;
    assign m_axi_arcache = s_axi_arcache;
    assign m_axi_arprot = s_axi_arprot;
    assign m_axi_arregion = s_axi_arregion;
    assign m_axi_arqos = s_axi_arqos;
    assign m_axi_aruser = s_axi_aruser;
    assign m_axi_arvalid = s_axi_arvalid;
    assign m_axi_rready = s_axi_rready;
`ifdef PROTO_CHECK   
    wire logic trig_out_axi;
    wire logic trig_out_ack_axi;
    wire logic trig_in_axi;
    wire logic trig_in_ack_axi;
    xlnx_ila_axi_0 ila_axi (
        .clk(clk),
        .trig_out(trig_out_axi),
        .trig_out_ack(trig_out_ack_axi),
        .trig_in(trig_in_axi),
        .trig_in_ack(trig_in_ack_axi),
        .probe0(s_axi_wready),
        .probe1(s_axi_awaddr),
        .probe2(s_axi_bresp),
        .probe3(s_axi_bvalid),
        .probe4(s_axi_bready),
        .probe5(s_axi_araddr),
        .probe6(s_axi_rready),
        .probe7(s_axi_wvalid),
        .probe8(s_axi_arvalid),
        .probe9(s_axi_arready),
        .probe10(s_axi_rdata),
        .probe11(s_axi_awvalid),
        .probe12(s_axi_awready),
        .probe13(s_axi_rresp),
        .probe14(s_axi_wdata),
        .probe15(s_axi_wstrb),
        .probe16(s_axi_rvalid),
        .probe17(s_axi_arprot),
        .probe18(s_axi_awprot),
        .probe19(s_axi_awid),
        .probe20(s_axi_bid),
        .probe21(s_axi_awlen),
        .probe22(s_axi_buser),
        .probe23(s_axi_awsize),
        .probe24(s_axi_awburst),
        .probe25(s_axi_arid),
        .probe26(s_axi_awlock),
        .probe27(s_axi_arlen),
        .probe28(s_axi_arsize),
        .probe29(s_axi_arburst),
        .probe30(s_axi_arlock),
        .probe31(s_axi_arcache),
        .probe32(s_axi_awcache),
        .probe33(s_axi_arregion),
        .probe34(s_axi_arqos),
        .probe35(s_axi_aruser),
        .probe36(s_axi_awregion),
        .probe37(s_axi_awqos),
        .probe38(s_axi_rid),
        .probe39(s_axi_awuser),
        .probe40(s_axi_wuser),
        .probe41(s_axi_rlast),
        .probe42(s_axi_ruser),
        .probe43(s_axi_wlast)
    );
    wire logic[159:0] pc_status;
    wire logic pc_asserted;
    xlnx_ila ila_proto (
        .clk(clk),
        .trig_out(trig_in_axi),
        .trig_out_ack(trig_in_ack_axi),
        .trig_in(trig_out_axi),
        .trig_in_ack(trig_out_ack_axi),
        .probe0(pc_status),
        .probe1(pc_asserted)
    );
    xlnx_proto_check proto1 (
        .pc_status(pc_status),
        .pc_asserted(pc_asserted),
        .aclk(clk),
        .aresetn(rstn),
        .pc_axi_awid(s_axi_awid),
        .pc_axi_awaddr(s_axi_awaddr),
        .pc_axi_awlen(s_axi_awlen),
        .pc_axi_awsize(s_axi_awsize),
        .pc_axi_awburst(s_axi_awburst),
        .pc_axi_awlock(s_axi_awlock),
        .pc_axi_awcache(s_axi_awcache),
        .pc_axi_awprot(s_axi_awprot),
        .pc_axi_awqos(s_axi_awqos),
        .pc_axi_awregion(s_axi_awregion),
        .pc_axi_awuser(s_axi_awuser),
        .pc_axi_awvalid(s_axi_awvalid),
        .pc_axi_awready(s_axi_awready),
        .pc_axi_wlast(s_axi_wlast),
        .pc_axi_wdata(s_axi_wdata),
        .pc_axi_wstrb(s_axi_wstrb),
        .pc_axi_wuser(s_axi_wuser),
        .pc_axi_wvalid(s_axi_wvalid),
        .pc_axi_wready(s_axi_wready),
        .pc_axi_bid(s_axi_bid),
        .pc_axi_bresp(s_axi_bresp),
        .pc_axi_buser(s_axi_buser),
        .pc_axi_bvalid(s_axi_bvalid),
        .pc_axi_bready(s_axi_bready),
        .pc_axi_arid(s_axi_arid),
        .pc_axi_araddr(s_axi_araddr),
        .pc_axi_arlen(s_axi_arlen),
        .pc_axi_arsize(s_axi_arsize),
        .pc_axi_arburst(s_axi_arburst),
        .pc_axi_arlock(s_axi_arlock),
        .pc_axi_arcache(s_axi_arcache),
        .pc_axi_arprot(s_axi_arprot),
        .pc_axi_arqos(s_axi_arqos),
        .pc_axi_arregion(s_axi_arregion),
        .pc_axi_aruser(s_axi_aruser),
        .pc_axi_arvalid(s_axi_arvalid),
        .pc_axi_arready(s_axi_arready),
        .pc_axi_rid(s_axi_rid),
        .pc_axi_rlast(s_axi_rlast),
        .pc_axi_rdata(s_axi_rdata),
        .pc_axi_rresp(s_axi_rresp),
        .pc_axi_ruser(s_axi_ruser),
        .pc_axi_rvalid(s_axi_rvalid),
        .pc_axi_rready(s_axi_rready)
    );
`endif   
endmodule
module slave_adapter_1 (
    input wire logic clk,
    input wire logic rstn,
    input wire logic[4:0] s_axi_awid,
    input wire logic[63:0] s_axi_awaddr,
    input wire logic[7:0] s_axi_awlen,
    input wire logic[2:0] s_axi_awsize,
    input wire logic[1:0] s_axi_awburst,
    input wire logic s_axi_awlock,
    input wire logic[3:0] s_axi_awcache,
    input wire logic[2:0] s_axi_awprot,
    input wire logic[3:0] s_axi_awregion,
    input wire logic[3:0] s_axi_awqos,
    input wire logic[0:0] s_axi_awuser,
    input wire logic s_axi_awvalid,
    output wire logic s_axi_awready,
    input wire logic[63:0] s_axi_wdata,
    input wire logic[7:0] s_axi_wstrb,
    input wire logic s_axi_wlast,
    input wire logic[0:0] s_axi_wuser,
    input wire logic s_axi_wvalid,
    output wire logic s_axi_wready,
    output wire logic[4:0] s_axi_bid,
    output wire logic[1:0] s_axi_bresp,
    output wire logic[0:0] s_axi_buser,
    output wire logic s_axi_bvalid,
    input wire logic s_axi_bready,
    input wire logic[4:0] s_axi_arid,
    input wire logic[63:0] s_axi_araddr,
    input wire logic[7:0] s_axi_arlen,
    input wire logic[2:0] s_axi_arsize,
    input wire logic[1:0] s_axi_arburst,
    input wire logic s_axi_arlock,
    input wire logic[3:0] s_axi_arcache,
    input wire logic[2:0] s_axi_arprot,
    input wire logic[3:0] s_axi_arregion,
    input wire logic[3:0] s_axi_arqos,
    input wire logic[0:0] s_axi_aruser,
    input wire logic s_axi_arvalid,
    output wire logic s_axi_arready,
    output wire logic[4:0] s_axi_rid,
    output wire logic[63:0] s_axi_rdata,
    output wire logic[1:0] s_axi_rresp,
    output wire logic s_axi_rlast,
    output wire logic[0:0] s_axi_ruser,
    output wire logic s_axi_rvalid,
    input wire logic s_axi_rready,
    output wire logic[4:0] m_axi_awid,
    output wire logic[63:0] m_axi_awaddr,
    output wire logic[7:0] m_axi_awlen,
    output wire logic[2:0] m_axi_awsize,
    output wire logic[1:0] m_axi_awburst,
    output wire logic[0:0] m_axi_awlock,
    output wire logic[3:0] m_axi_awcache,
    output wire logic[2:0] m_axi_awprot,
    output wire logic[3:0] m_axi_awregion,
    output wire logic[3:0] m_axi_awqos,
    output wire logic[0:0] m_axi_awuser,
    output wire logic m_axi_awvalid,
    input wire logic m_axi_awready,
    output wire logic[63:0] m_axi_wdata,
    output wire logic[7:0] m_axi_wstrb,
    output wire logic m_axi_wlast,
    output wire logic[0:0] m_axi_wuser,
    output wire logic m_axi_wvalid,
    input wire logic m_axi_wready,
    input wire logic[4:0] m_axi_bid,
    input wire logic[1:0] m_axi_bresp,
    input wire logic[0:0] m_axi_buser,
    input wire logic m_axi_bvalid,
    output wire logic m_axi_bready,
    output wire logic[4:0] m_axi_arid,
    output wire logic[63:0] m_axi_araddr,
    output wire logic[7:0] m_axi_arlen,
    output wire logic[2:0] m_axi_arsize,
    output wire logic[1:0] m_axi_arburst,
    output wire logic[0:0] m_axi_arlock,
    output wire logic[3:0] m_axi_arcache,
    output wire logic[2:0] m_axi_arprot,
    output wire logic[3:0] m_axi_arregion,
    output wire logic[3:0] m_axi_arqos,
    output wire logic[0:0] m_axi_aruser,
    output wire logic m_axi_arvalid,
    input wire logic m_axi_arready,
    input wire logic[4:0] m_axi_rid,
    input wire logic[63:0] m_axi_rdata,
    input wire logic[1:0] m_axi_rresp,
    input wire logic m_axi_rlast,
    input wire logic[0:0] m_axi_ruser,
    input wire logic m_axi_rvalid,
    output wire logic m_axi_rready
);
    parameter integer ID_WIDTH = 5;
    parameter integer ADDR_WIDTH = 64;
    parameter integer DATA_WIDTH = 64;
    parameter integer USER_WIDTH = 1;
    parameter integer LITE_MODE = 0;
    assign s_axi_awready = m_axi_awready;
    assign s_axi_wready = m_axi_wready;
    assign s_axi_bid = m_axi_bid;
    assign s_axi_bresp = m_axi_bresp;
    assign s_axi_buser = m_axi_buser;
    assign s_axi_bvalid = m_axi_bvalid;
    assign s_axi_arready = m_axi_arready;
    assign s_axi_rid = m_axi_rid;
    assign s_axi_rdata = m_axi_rdata;
    assign s_axi_rresp = m_axi_rresp;
    assign s_axi_rlast = m_axi_rlast;
    assign s_axi_ruser = m_axi_ruser;
    assign s_axi_rvalid = m_axi_rvalid;
    assign m_axi_awid = s_axi_awid;
    assign m_axi_awaddr = s_axi_awaddr;
    assign m_axi_awlen = s_axi_awlen;
    assign m_axi_awsize = s_axi_awsize;
    assign m_axi_awburst = s_axi_awburst;
    assign m_axi_awlock = s_axi_awlock;
    assign m_axi_awcache = s_axi_awcache;
    assign m_axi_awprot = s_axi_awprot;
    assign m_axi_awregion = s_axi_awregion;
    assign m_axi_awqos = s_axi_awqos;
    assign m_axi_awuser = s_axi_awuser;
    assign m_axi_awvalid = s_axi_awvalid;
    assign m_axi_wdata = s_axi_wdata;
    assign m_axi_wstrb = s_axi_wstrb;
    assign m_axi_wlast = s_axi_wlast;
    assign m_axi_wuser = s_axi_wuser;
    assign m_axi_wvalid = s_axi_wvalid;
    assign m_axi_bready = s_axi_bready;
    assign m_axi_arid = s_axi_arid;
    assign m_axi_araddr = s_axi_araddr;
    assign m_axi_arlen = s_axi_arlen;
    assign m_axi_arsize = s_axi_arsize;
    assign m_axi_arburst = s_axi_arburst;
    assign m_axi_arlock = s_axi_arlock;
    assign m_axi_arcache = s_axi_arcache;
    assign m_axi_arprot = s_axi_arprot;
    assign m_axi_arregion = s_axi_arregion;
    assign m_axi_arqos = s_axi_arqos;
    assign m_axi_aruser = s_axi_aruser;
    assign m_axi_arvalid = s_axi_arvalid;
    assign m_axi_rready = s_axi_rready;
`ifdef PROTO_CHECK
    wire logic trig_out_axi;
    wire logic trig_out_ack_axi;
    wire logic trig_in_axi;
    wire logic trig_in_ack_axi;
    xlnx_ila_axi_0 ila_axi (
        .clk(clk),
        .trig_out(trig_out_axi),
        .trig_out_ack(trig_out_ack_axi),
        .trig_in(trig_in_axi),
        .trig_in_ack(trig_in_ack_axi),
        .probe0(s_axi_wready),
        .probe1(s_axi_awaddr),
        .probe2(s_axi_bresp),
        .probe3(s_axi_bvalid),
        .probe4(s_axi_bready),
        .probe5(s_axi_araddr),
        .probe6(s_axi_rready),
        .probe7(s_axi_wvalid),
        .probe8(s_axi_arvalid),
        .probe9(s_axi_arready),
        .probe10(s_axi_rdata),
        .probe11(s_axi_awvalid),
        .probe12(s_axi_awready),
        .probe13(s_axi_rresp),
        .probe14(s_axi_wdata),
        .probe15(s_axi_wstrb),
        .probe16(s_axi_rvalid),
        .probe17(s_axi_arprot),
        .probe18(s_axi_awprot),
        .probe19(s_axi_awid),
        .probe20(s_axi_bid),
        .probe21(s_axi_awlen),
        .probe22(s_axi_buser),
        .probe23(s_axi_awsize),
        .probe24(s_axi_awburst),
        .probe25(s_axi_arid),
        .probe26(s_axi_awlock),
        .probe27(s_axi_arlen),
        .probe28(s_axi_arsize),
        .probe29(s_axi_arburst),
        .probe30(s_axi_arlock),
        .probe31(s_axi_arcache),
        .probe32(s_axi_awcache),
        .probe33(s_axi_arregion),
        .probe34(s_axi_arqos),
        .probe35(s_axi_aruser),
        .probe36(s_axi_awregion),
        .probe37(s_axi_awqos),
        .probe38(s_axi_rid),
        .probe39(s_axi_awuser),
        .probe40(s_axi_wuser),
        .probe41(s_axi_rlast),
        .probe42(s_axi_ruser),
        .probe43(s_axi_wlast)
    );
    wire logic[159:0] pc_status;
    wire logic pc_asserted;
    xlnx_ila ila_proto (
        .clk(clk),
        .trig_out(trig_in_axi),
        .trig_out_ack(trig_in_ack_axi),
        .trig_in(trig_out_axi),
        .trig_in_ack(trig_out_ack_axi),
        .probe0(pc_status),
        .probe1(pc_asserted)
    );
    xlnx_proto_check proto1 (
        .pc_status(pc_status),
        .pc_asserted(pc_asserted),
        .aclk(clk),
        .aresetn(rstn),
        .pc_axi_awid(s_axi_awid),
        .pc_axi_awaddr(s_axi_awaddr),
        .pc_axi_awlen(s_axi_awlen),
        .pc_axi_awsize(s_axi_awsize),
        .pc_axi_awburst(s_axi_awburst),
        .pc_axi_awlock(s_axi_awlock),
        .pc_axi_awcache(s_axi_awcache),
        .pc_axi_awprot(s_axi_awprot),
        .pc_axi_awqos(s_axi_awqos),
        .pc_axi_awregion(s_axi_awregion),
        .pc_axi_awuser(s_axi_awuser),
        .pc_axi_awvalid(s_axi_awvalid),
        .pc_axi_awready(s_axi_awready),
        .pc_axi_wlast(s_axi_wlast),
        .pc_axi_wdata(s_axi_wdata),
        .pc_axi_wstrb(s_axi_wstrb),
        .pc_axi_wuser(s_axi_wuser),
        .pc_axi_wvalid(s_axi_wvalid),
        .pc_axi_wready(s_axi_wready),
        .pc_axi_bid(s_axi_bid),
        .pc_axi_bresp(s_axi_bresp),
        .pc_axi_buser(s_axi_buser),
        .pc_axi_bvalid(s_axi_bvalid),
        .pc_axi_bready(s_axi_bready),
        .pc_axi_arid(s_axi_arid),
        .pc_axi_araddr(s_axi_araddr),
        .pc_axi_arlen(s_axi_arlen),
        .pc_axi_arsize(s_axi_arsize),
        .pc_axi_arburst(s_axi_arburst),
        .pc_axi_arlock(s_axi_arlock),
        .pc_axi_arcache(s_axi_arcache),
        .pc_axi_arprot(s_axi_arprot),
        .pc_axi_arqos(s_axi_arqos),
        .pc_axi_arregion(s_axi_arregion),
        .pc_axi_aruser(s_axi_aruser),
        .pc_axi_arvalid(s_axi_arvalid),
        .pc_axi_arready(s_axi_arready),
        .pc_axi_rid(s_axi_rid),
        .pc_axi_rlast(s_axi_rlast),
        .pc_axi_rdata(s_axi_rdata),
        .pc_axi_rresp(s_axi_rresp),
        .pc_axi_ruser(s_axi_ruser),
        .pc_axi_rvalid(s_axi_rvalid),
        .pc_axi_rready(s_axi_rready)
    );
`endif
endmodule

/* file: ../ram/simple_wr.sv */
/* file: xlnx_ila_axi_0_stub_edited.v */

/* file: xlnx_proto_check_stub_edited.v */

/* file: xlnx_ila_stub_edited.v */


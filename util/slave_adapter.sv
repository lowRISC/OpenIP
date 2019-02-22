module slave_adapter
  #(
    ID_WIDTH = 10,               // id width
    ADDR_WIDTH = 64,             // address width
    DATA_WIDTH = 64,             // width of data
    USER_WIDTH = 6,              // width of user field, must > 0, let synthesizer trim it if not in use
    LITE_MODE = 0                // whether work in Lite mode
    )
(
  input                    clk,
  input                    rstn,
  input [ID_WIDTH-1:0]     s_axi_awid,
  input [ADDR_WIDTH-1:0]   s_axi_awaddr,
  input [7:0]              s_axi_awlen,
  input [2:0]              s_axi_awsize,
  input [1:0]              s_axi_awburst,
  input                    s_axi_awlock,
  input [3:0]              s_axi_awcache,
  input [2:0]              s_axi_awprot,
  input [3:0]              s_axi_awregion,
  input [3:0]              s_axi_awqos,
  input [USER_WIDTH-1:0]   s_axi_awuser,
  input                    s_axi_awvalid,
  output                   s_axi_awready,
  input [DATA_WIDTH-1:0]   s_axi_wdata,
  input [DATA_WIDTH/8-1:0] s_axi_wstrb,
  input                    s_axi_wlast,
  input [USER_WIDTH-1:0]   s_axi_wuser,
  input                    s_axi_wvalid,
  output                   s_axi_wready,
  output [ID_WIDTH-1:0]    s_axi_bid,
  output [1:0]             s_axi_bresp,
  output [USER_WIDTH-1:0]  s_axi_buser,
  output                   s_axi_bvalid,
  input                    s_axi_bready,
  input [ID_WIDTH-1:0]     s_axi_arid,
  input [ADDR_WIDTH-1:0]   s_axi_araddr,
  input [7:0]              s_axi_arlen,
  input [2:0]              s_axi_arsize,
  input [1:0]              s_axi_arburst,
  input                    s_axi_arlock,
  input [3:0]              s_axi_arcache,
  input [2:0]              s_axi_arprot,
  input [3:0]              s_axi_arregion,
  input [3:0]              s_axi_arqos,
  input [USER_WIDTH-1:0]   s_axi_aruser,
  input                    s_axi_arvalid,
  output                   s_axi_arready,
  output [ID_WIDTH-1:0]    s_axi_rid,
  output [DATA_WIDTH-1:0]  s_axi_rdata,
  output [1:0]             s_axi_rresp,
  output                   s_axi_rlast,
  output [USER_WIDTH-1:0]  s_axi_ruser,
  output                   s_axi_rvalid,
  input                    s_axi_rready,

  output [ID_WIDTH-1:0]    m_axi_awid,
  output [ADDR_WIDTH-1:0]  m_axi_awaddr,
  output [7:0]             m_axi_awlen,
  output [2:0]             m_axi_awsize,
  output [1:0]             m_axi_awburst,
  output [0:0]             m_axi_awlock,
  output [3:0]             m_axi_awcache,
  output [2:0]             m_axi_awprot,
  output [3:0]             m_axi_awregion,
  output [3:0]             m_axi_awqos,
  output [USER_WIDTH-1:0]  m_axi_awuser,
  output                   m_axi_awvalid,
  input                    m_axi_awready,
  output [DATA_WIDTH-1:0]  m_axi_wdata,
  output [7:0]             m_axi_wstrb,
  output                   m_axi_wlast,
  output [USER_WIDTH-1:0]  m_axi_wuser,
  output                   m_axi_wvalid,
  input                    m_axi_wready,
  input [ID_WIDTH-1:0]     m_axi_bid,
  input [1:0]              m_axi_bresp,
  input [USER_WIDTH-1:0]   m_axi_buser,
  input                    m_axi_bvalid,
  output                   m_axi_bready,
  output [ID_WIDTH-1:0]    m_axi_arid,
  output [ADDR_WIDTH-1:0]  m_axi_araddr,
  output [7:0]             m_axi_arlen,
  output [2:0]             m_axi_arsize,
  output [1:0]             m_axi_arburst,
  output [0:0]             m_axi_arlock,
  output [3:0]             m_axi_arcache,
  output [2:0]             m_axi_arprot,
  output [3:0]             m_axi_arregion,
  output [3:0]             m_axi_arqos,
  output [USER_WIDTH-1:0]  m_axi_aruser,
  output                   m_axi_arvalid,
  input                    m_axi_arready,
  input [ID_WIDTH-1:0]     m_axi_rid,
  input [DATA_WIDTH-1:0]   m_axi_rdata,
  input [1:0]              m_axi_rresp,
  input                    m_axi_rlast,
  input [USER_WIDTH-1:0]   m_axi_ruser,
  input                    m_axi_rvalid,
  output                   m_axi_rready);
   
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

wire trig_out_axi, trig_out_ack_axi, trig_in_axi, trig_in_ack_axi;

xlnx_ila_axi_0 ila_axi (
	.clk(clk), // input wire clk
	.trig_out(trig_out_axi),// output wire trig_out 
	.trig_out_ack(trig_out_ack_axi),// input wire trig_out_ack 
	.trig_in(trig_in_axi),// input wire trig_in 
	.trig_in_ack(trig_in_ack_axi),// output wire trig_in_ack 
	.probe0(s_axi_wready),   // input wire [0:0] probe0  
	.probe1(s_axi_awaddr),   // input wire [63:0]  probe1 
	.probe2(s_axi_bresp),    // input wire [1:0]  probe2 
	.probe3(s_axi_bvalid),   // input wire [0:0]  probe3 
	.probe4(s_axi_bready),   // input wire [0:0]  probe4 
	.probe5(s_axi_araddr),   // input wire [63:0]  probe5 
	.probe6(s_axi_rready),   // input wire [0:0]  probe6 
	.probe7(s_axi_wvalid),   // input wire [0:0]  probe7 
	.probe8(s_axi_arvalid),  // input wire [0:0]  probe8 
	.probe9(s_axi_arready),  // input wire [0:0]  probe9 
	.probe10(s_axi_rdata),   // input wire [63:0]  probe10 
	.probe11(s_axi_awvalid), // input wire [0:0]  probe11 
	.probe12(s_axi_awready), // input wire [0:0]  probe12 
	.probe13(s_axi_rresp), // input wire [1:0]  probe13 
	.probe14(s_axi_wdata), // input wire [63:0]  probe14 
	.probe15(s_axi_wstrb), // input wire [7:0]  probe15 
	.probe16(s_axi_rvalid), // input wire [0:0]  probe16 
	.probe17(s_axi_arprot), // input wire [2:0]  probe17 
	.probe18(s_axi_awprot), // input wire [2:0]  probe18 
	.probe19(s_axi_awid), // input wire [4:0]  probe19 
	.probe20(s_axi_bid), // input wire [4:0]  probe20 
	.probe21(s_axi_awlen), // input wire [7:0]  probe21 
	.probe22(s_axi_buser), // input wire [0:0]  probe22 
	.probe23(s_axi_awsize), // input wire [2:0]  probe23 
	.probe24(s_axi_awburst), // input wire [1:0]  probe24 
	.probe25(s_axi_arid), // input wire [4:0]  probe25 
	.probe26(s_axi_awlock), // input wire [0:0]  probe26 
	.probe27(s_axi_arlen), // input wire [7:0]  probe27 
	.probe28(s_axi_arsize), // input wire [2:0]  probe28 
	.probe29(s_axi_arburst), // input wire [1:0]  probe29 
	.probe30(s_axi_arlock), // input wire [0:0]  probe30 
	.probe31(s_axi_arcache), // input wire [3:0]  probe31 
	.probe32(s_axi_awcache), // input wire [3:0]  probe32 
	.probe33(s_axi_arregion), // input wire [3:0]  probe33 
	.probe34(s_axi_arqos), // input wire [3:0]  probe34 
	.probe35(s_axi_aruser), // input wire [0:0]  probe35 
	.probe36(s_axi_awregion), // input wire [3:0]  probe36 
	.probe37(s_axi_awqos), // input wire [3:0]  probe37 
	.probe38(s_axi_rid), // input wire [4:0]  probe38 
	.probe39(s_axi_awuser), // input wire [0:0]  probe39 
	.probe40(s_axi_wuser), // input wire [0:0]  probe40 
	.probe41(s_axi_rlast), // input wire [0:0]  probe41 
	.probe42(s_axi_ruser), // input wire [0:0]  probe42  
	.probe43(s_axi_wlast) // input wire [0:0]  probe43
);

wire [159 : 0]          pc_status;
wire                    pc_asserted;
   
xlnx_ila ila_proto (
     .clk(clk),                      // input wire clk
     .trig_out(trig_in_axi),         // output wire trig_out 
     .trig_out_ack(trig_in_ack_axi), // input wire trig_out_ack 
     .trig_in(trig_out_axi),         // input wire trig_in 
     .trig_in_ack(trig_out_ack_axi), // output wire trig_in_ack 
     .probe0(pc_status),             // input wire [159:0]  probe0
     .probe1(pc_asserted));          // input wire [0:0]  probe1 

xlnx_proto_check proto1 (
  .pc_status(pc_status),             // output wire [159 : 0] pc_status
  .pc_asserted(pc_asserted),         // output wire pc_asserted
  .aclk(clk),                        // input wire aclk
  .aresetn(rstn),                    // input wire aresetn
  .pc_axi_awid(s_axi_awid),          // input wire [4 : 0] pc_axi_awid
  .pc_axi_awaddr(s_axi_awaddr),      // input wire [63 : 0] pc_axi_awaddr
  .pc_axi_awlen(s_axi_awlen),        // input wire [7 : 0] pc_axi_awlen
  .pc_axi_awsize(s_axi_awsize),      // input wire [2 : 0] pc_axi_awsize
  .pc_axi_awburst(s_axi_awburst),    // input wire [1 : 0] pc_axi_awburst
  .pc_axi_awlock(s_axi_awlock),      // input wire [0 : 0] pc_axi_awlock
  .pc_axi_awcache(s_axi_awcache),    // input wire [3 : 0] pc_axi_awcache
  .pc_axi_awprot(s_axi_awprot),      // input wire [2 : 0] pc_axi_awprot
  .pc_axi_awqos(s_axi_awqos),        // input wire [3 : 0] pc_axi_awqos
  .pc_axi_awregion(s_axi_awregion),  // input wire [3 : 0] pc_axi_awregion
  .pc_axi_awuser(s_axi_awuser),      // input wire [0 : 0] pc_axi_awuser
  .pc_axi_awvalid(s_axi_awvalid),    // input wire pc_axi_awvalid
  .pc_axi_awready(s_axi_awready),    // input wire pc_axi_awready
  .pc_axi_wlast(s_axi_wlast),        // input wire pc_axi_wlast
  .pc_axi_wdata(s_axi_wdata),        // input wire [63 : 0] pc_axi_wdata
  .pc_axi_wstrb(s_axi_wstrb),        // input wire [7 : 0] pc_axi_wstrb
  .pc_axi_wuser(s_axi_wuser),        // input wire [0 : 0] pc_axi_wuser
  .pc_axi_wvalid(s_axi_wvalid),      // input wire pc_axi_wvalid
  .pc_axi_wready(s_axi_wready),      // input wire pc_axi_wready
  .pc_axi_bid(s_axi_bid),            // input wire [4 : 0] pc_axi_bid
  .pc_axi_bresp(s_axi_bresp),        // input wire [1 : 0] pc_axi_bresp
  .pc_axi_buser(s_axi_buser),        // input wire [0 : 0] pc_axi_buser
  .pc_axi_bvalid(s_axi_bvalid),      // input wire pc_axi_bvalid
  .pc_axi_bready(s_axi_bready),      // input wire pc_axi_bready
  .pc_axi_arid(s_axi_arid),          // input wire [4 : 0] pc_axi_arid
  .pc_axi_araddr(s_axi_araddr),      // input wire [63 : 0] pc_axi_araddr
  .pc_axi_arlen(s_axi_arlen),        // input wire [7 : 0] pc_axi_arlen
  .pc_axi_arsize(s_axi_arsize),      // input wire [2 : 0] pc_axi_arsize
  .pc_axi_arburst(s_axi_arburst),    // input wire [1 : 0] pc_axi_arburst
  .pc_axi_arlock(s_axi_arlock),      // input wire [0 : 0] pc_axi_arlock
  .pc_axi_arcache(s_axi_arcache),    // input wire [3 : 0] pc_axi_arcache
  .pc_axi_arprot(s_axi_arprot),      // input wire [2 : 0] pc_axi_arprot
  .pc_axi_arqos(s_axi_arqos),        // input wire [3 : 0] pc_axi_arqos
  .pc_axi_arregion(s_axi_arregion),  // input wire [3 : 0] pc_axi_arregion
  .pc_axi_aruser(s_axi_aruser),      // input wire [0 : 0] pc_axi_aruser
  .pc_axi_arvalid(s_axi_arvalid),    // input wire pc_axi_arvalid
  .pc_axi_arready(s_axi_arready),    // input wire pc_axi_arready
  .pc_axi_rid(s_axi_rid),            // input wire [4 : 0] pc_axi_rid
  .pc_axi_rlast(s_axi_rlast),        // input wire pc_axi_rlast
  .pc_axi_rdata(s_axi_rdata),        // input wire [63 : 0] pc_axi_rdata
  .pc_axi_rresp(s_axi_rresp),        // input wire [1 : 0] pc_axi_rresp
  .pc_axi_ruser(s_axi_ruser),        // input wire [0 : 0] pc_axi_ruser
  .pc_axi_rvalid(s_axi_rvalid),      // input wire pc_axi_rvalid
  .pc_axi_rready(s_axi_rready)       // input wire pc_axi_rready
);
   
endmodule

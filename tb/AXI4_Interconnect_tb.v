`timescale  1ns / 1ns
`include "AXI4_Interconnect.v"
`include "AXI4_Write_BRAM.v"
`include "AXI4_Poly_Add.v"
`include "AXI4_BRAM_Controller.v"

module AXI4_Interconnect_tb;

// AXI4_Interconnect Parameters
parameter PERIOD         = 10;
parameter memWidth       = 8 ;
parameter memDepth       = 32;
parameter addressLength  = 5 ;

// AXI4_Interconnect Inputs
reg   clk                                = 0;
reg   rst                             = 1'b1; 
wire   [3:0]  M1_ARID                       ;
wire   [addressLength-1:0]  M1_ARADDR       ;
wire   [1:0]  M1_ARBURST                    ;
wire   [0:0]  M1_ARVALID                    ;
wire   [7:0]  M1_ARLEN                      ;
wire   [2:0]  M1_ARSIZE                     ;
wire   [0:0]  M1_RREADY                     ;
wire   [3:0]  M1_AWID                       ;
wire   [addressLength-1:0]  M1_AWADDR       ;
wire   [1:0]  M1_AWBURST                    ;
wire   [0:0]  M1_AWVALID                    ;
wire   [7:0]  M1_AWLEN                      ;
wire   [2:0]  M1_AWSIZE                     ;
wire   [3:0]  M1_WID                        ;
wire   [memWidth-1:0]  M1_WDATA             ;
wire   [0:0]  M1_WVALID                     ;
wire   [0:0]  M1_WLAST                      ;
wire   [0:0]  M1_BREADY                     ;
wire   [3:0]  M2_ARID                       ;
wire   [addressLength-1:0]  M2_ARADDR       ;
wire   [1:0]  M2_ARBURST                    ;
wire   [0:0]  M2_ARVALID                    ;
wire   [7:0]  M2_ARLEN                      ;
wire   [2:0]  M2_ARSIZE                     ;
wire   [0:0]  M2_RREADY                     ;
wire   [3:0]  M2_AWID                       ;
wire   [addressLength-1:0]  M2_AWADDR       ;
wire   [1:0]  M2_AWBURST                    ;
wire   [0:0]  M2_AWVALID                    ;
wire   [7:0]  M2_AWLEN                      ;
wire   [2:0]  M2_AWSIZE                     ;
wire   [3:0]  M2_WID                        ;
wire   [memWidth-1:0]  M2_WDATA             ;
wire   [0:0]  M2_WVALID                     ;
wire   [0:0]  M2_WLAST                      ;
wire   [0:0]  M2_BREADY                     ;
wire   [0:0]  S_ARREADY                     ;
wire   [3:0]  S_RID                         ;
wire   [memWidth-1:0]  S_RDATA              ;
wire   [0:0]  S_RLAST                       ;
wire   [0:0]  S_RVALID                      ;
wire   [1:0]  S_RRESP                       ;
wire   [0:0]  S_AWREADY                     ;
wire   [0:0]  S_WREADY                      ;
wire   [3:0]  S_BID                         ;
wire   [1:0]  S_BRESP                       ;
wire   [0:0]  S_BVALID                      ;
wire    [0:0]  Master_1_Release              ;
wire   [0:0]  Master_2_Release              ;

// AXI4_Interconnect Outputs
wire  M1_ACLK                              ;
wire  M1_ARESET                            ;
wire  [0:0]  M1_ARREADY                    ;
wire  [3:0]  M1_RID                        ;
wire  [memWidth-1:0]  M1_RDATA             ;
wire  [0:0]  M1_RLAST                      ;
wire  [0:0]  M1_RVALID                     ;
wire  [1:0]  M1_RRESP                      ;
wire  [0:0]  M1_AWREADY                    ;
wire  [0:0]  M1_WREADY                     ;
wire  [3:0]  M1_BID                        ;
wire  [1:0]  M1_BRESP                      ;
wire  [0:0]  M1_BVALID                     ;
wire  M2_ACLK                              ;
wire  M2_ARESET                            ;
wire  [0:0]  M2_ARREADY                    ;
wire  [3:0]  M2_RID                        ;
wire  [memWidth-1:0]  M2_RDATA             ;
wire  [0:0]  M2_RLAST                      ;
wire  [0:0]  M2_RVALID                     ;
wire  [1:0]  M2_RRESP                      ;
wire  [0:0]  M2_AWREADY                    ;
wire  [0:0]  M2_WREADY                     ;
wire  [3:0]  M2_BID                        ;
wire  [1:0]  M2_BRESP                      ;
wire  [0:0]  M2_BVALID                     ;
wire  S_ACLK                               ;
wire  S_ARESET                             ;
wire  [3:0]  S_ARID                        ;
wire  [addressLength-1:0]  S_ARADDR        ;
wire  [1:0]  S_ARBURST                     ;
wire  [0:0]  S_ARVALID                     ;
wire  [7:0]  S_ARLEN                       ;
wire  [2:0]  S_ARSIZE                      ;
wire  [0:0]  S_RREADY                      ;
wire  [3:0]  S_AWID                        ;
wire  [addressLength-1:0]  S_AWADDR        ;
wire  [1:0]  S_AWBURST                     ;
wire  [0:0]  S_AWVALID                     ;
wire  [7:0]  S_AWLEN                       ;
wire  [2:0]  S_AWSIZE                      ;
wire  [3:0]  S_WID                         ;
wire  [memWidth-1:0]  S_WDATA              ;
wire  [0:0]  S_WVALID                      ;
wire  [0:0]  S_WLAST                       ;
wire  [0:0]  S_BREADY                      ;
wire  [0:0]  Master_1_Set                  ;
wire  [0:0]  Master_2_Set                  ;

AXI4_Interconnect u_AXI4_Interconnect (
    .clk                     ( clk                                   ),
    .rst                     ( rst                                   ),
    .M1_ARID                 ( M1_ARID           [3:0]               ),
    .M1_ARADDR               ( M1_ARADDR         [addressLength-1:0] ),
    .M1_ARBURST              ( M1_ARBURST        [1:0]               ),
    .M1_ARVALID              ( M1_ARVALID        [0:0]               ),
    .M1_ARLEN                ( M1_ARLEN          [7:0]               ),
    .M1_ARSIZE               ( M1_ARSIZE         [2:0]               ),
    .M1_RREADY               ( M1_RREADY         [0:0]               ),
    .M1_AWID                 ( M1_AWID           [3:0]               ),
    .M1_AWADDR               ( M1_AWADDR         [addressLength-1:0] ),
    .M1_AWBURST              ( M1_AWBURST        [1:0]               ),
    .M1_AWVALID              ( M1_AWVALID        [0:0]               ),
    .M1_AWLEN                ( M1_AWLEN          [7:0]               ),
    .M1_AWSIZE               ( M1_AWSIZE         [2:0]               ),
    .M1_WID                  ( M1_WID            [3:0]               ),
    .M1_WDATA                ( M1_WDATA          [memWidth-1:0]      ),
    .M1_WVALID               ( M1_WVALID         [0:0]               ),
    .M1_WLAST                ( M1_WLAST          [0:0]               ),
    .M1_BREADY               ( M1_BREADY         [0:0]               ),
    .M2_ARID                 ( M2_ARID           [3:0]               ),
    .M2_ARADDR               ( M2_ARADDR         [addressLength-1:0] ),
    .M2_ARBURST              ( M2_ARBURST        [1:0]               ),
    .M2_ARVALID              ( M2_ARVALID        [0:0]               ),
    .M2_ARLEN                ( M2_ARLEN          [7:0]               ),
    .M2_ARSIZE               ( M2_ARSIZE         [2:0]               ),
    .M2_RREADY               ( M2_RREADY         [0:0]               ),
    .M2_AWID                 ( M2_AWID           [3:0]               ),
    .M2_AWADDR               ( M2_AWADDR         [addressLength-1:0] ),
    .M2_AWBURST              ( M2_AWBURST        [1:0]               ),
    .M2_AWVALID              ( M2_AWVALID        [0:0]               ),
    .M2_AWLEN                ( M2_AWLEN          [7:0]               ),
    .M2_AWSIZE               ( M2_AWSIZE         [2:0]               ),
    .M2_WID                  ( M2_WID            [3:0]               ),
    .M2_WDATA                ( M2_WDATA          [memWidth-1:0]      ),
    .M2_WVALID               ( M2_WVALID         [0:0]               ),
    .M2_WLAST                ( M2_WLAST          [0:0]               ),
    .M2_BREADY               ( M2_BREADY         [0:0]               ),
    .S_ARREADY               ( S_ARREADY         [0:0]               ),
    .S_RID                   ( S_RID             [3:0]               ),
    .S_RDATA                 ( S_RDATA           [memWidth-1:0]      ),
    .S_RLAST                 ( S_RLAST           [0:0]               ),
    .S_RVALID                ( S_RVALID          [0:0]               ),
    .S_RRESP                 ( S_RRESP           [1:0]               ),
    .S_AWREADY               ( S_AWREADY         [0:0]               ),
    .S_WREADY                ( S_WREADY          [0:0]               ),
    .S_BID                   ( S_BID             [3:0]               ),
    .S_BRESP                 ( S_BRESP           [1:0]               ),
    .S_BVALID                ( S_BVALID          [0:0]               ),
    .Master_1_Release        ( Master_1_Release  [0:0]               ),
    .Master_2_Release        ( Master_2_Release  [0:0]               ),

    .M1_ACLK                 ( M1_ACLK                               ),
    .M1_ARESET               ( M1_ARESET                             ),
    .M1_ARREADY              ( M1_ARREADY        [0:0]               ),
    .M1_RID                  ( M1_RID            [3:0]               ),
    .M1_RDATA                ( M1_RDATA          [memWidth-1:0]      ),
    .M1_RLAST                ( M1_RLAST          [0:0]               ),
    .M1_RVALID               ( M1_RVALID         [0:0]               ),
    .M1_RRESP                ( M1_RRESP          [1:0]               ),
    .M1_AWREADY              ( M1_AWREADY        [0:0]               ),
    .M1_WREADY               ( M1_WREADY         [0:0]               ),
    .M1_BID                  ( M1_BID            [3:0]               ),
    .M1_BRESP                ( M1_BRESP          [1:0]               ),
    .M1_BVALID               ( M1_BVALID         [0:0]               ),
    .M2_ACLK                 ( M2_ACLK                               ),
    .M2_ARESET               ( M2_ARESET                             ),
    .M2_ARREADY              ( M2_ARREADY        [0:0]               ),
    .M2_RID                  ( M2_RID            [3:0]               ),
    .M2_RDATA                ( M2_RDATA          [memWidth-1:0]      ),
    .M2_RLAST                ( M2_RLAST          [0:0]               ),
    .M2_RVALID               ( M2_RVALID         [0:0]               ),
    .M2_RRESP                ( M2_RRESP          [1:0]               ),
    .M2_AWREADY              ( M2_AWREADY        [0:0]               ),
    .M2_WREADY               ( M2_WREADY         [0:0]               ),
    .M2_BID                  ( M2_BID            [3:0]               ),
    .M2_BRESP                ( M2_BRESP          [1:0]               ),
    .M2_BVALID               ( M2_BVALID         [0:0]               ),
    .S_ACLK                  ( S_ACLK                                ),
    .S_ARESET                ( S_ARESET                              ),
    .S_ARID                  ( S_ARID            [3:0]               ),
    .S_ARADDR                ( S_ARADDR          [addressLength-1:0] ),
    .S_ARBURST               ( S_ARBURST         [1:0]               ),
    .S_ARVALID               ( S_ARVALID         [0:0]               ),
    .S_ARLEN                 ( S_ARLEN           [7:0]               ),
    .S_ARSIZE                ( S_ARSIZE          [2:0]               ),
    .S_RREADY                ( S_RREADY          [0:0]               ),
    .S_AWID                  ( S_AWID            [3:0]               ),
    .S_AWADDR                ( S_AWADDR          [addressLength-1:0] ),
    .S_AWBURST               ( S_AWBURST         [1:0]               ),
    .S_AWVALID               ( S_AWVALID         [0:0]               ),
    .S_AWLEN                 ( S_AWLEN           [7:0]               ),
    .S_AWSIZE                ( S_AWSIZE          [2:0]               ),
    .S_WID                   ( S_WID             [3:0]               ),
    .S_WDATA                 ( S_WDATA           [memWidth-1:0]      ),
    .S_WVALID                ( S_WVALID          [0:0]               ),
    .S_WLAST                 ( S_WLAST           [0:0]               ),
    .S_BREADY                ( S_BREADY          [0:0]               ),
    .Master_1_Set            ( Master_1_Set      [0:0]               ),
    .Master_2_Set            ( Master_2_Set      [0:0]               )
);

AXI4_Write_BRAM u_AXI4_Write_BRAM(
    .ACLK    (M1_ACLK    ),
    .ARESET  (M1_ARESET  ),
    .SET_ACCESS      (Master_1_Set),
    .RELEASE_ACCESS  (Master_1_Release),
    .ARID    (M1_ARID    ),
    .ARADDR  (M1_ARADDR  ),
    .ARBURST (M1_ARBURST ),
    .ARVALID (M1_ARVALID ),
    .ARREADY (M1_ARREADY ),
    .ARLEN   (M1_ARLEN   ),
    .ARSIZE  (M1_ARSIZE  ),
    .RID     (M1_RID     ),
    .RDATA   (M1_RDATA   ),
    .RLAST   (M1_RLAST   ),
    .RVALID  (M1_RVALID  ),
    .RREADY  (M1_RREADY  ),
    .RRESP   (M1_RRESP   ),
    .AWID    (M1_AWID    ),
    .AWADDR  (M1_AWADDR  ),
    .AWBURST (M1_AWBURST ),
    .AWVALID (M1_AWVALID ),
    .AWREADY (M1_AWREADY ),
    .AWLEN   (M1_AWLEN   ),
    .AWSIZE  (M1_AWSIZE  ),
    .WID     (M1_WID     ),
    .WDATA   (M1_WDATA   ),
    .WVALID  (M1_WVALID  ),
    .WREADY  (M1_WREADY  ),
    .WLAST   (M1_WLAST   ),
    .BID     (M1_BID     ),
    .BRESP   (M1_BRESP   ),
    .BVALID  (M1_BVALID  ),
    .BREADY  (M1_BREADY  )
);

AXI4_Poly_Add u_AXI4_Poly_Add(
    .ACLK    (M2_ACLK    ),
    .ARESET  (M2_ARESET  ),
    .SET_ACCESS      (Master_2_Set),
    .RELEASE_ACCESS  (Master_2_Release),
    .ARID    (M2_ARID    ),
    .ARADDR  (M2_ARADDR  ),
    .ARBURST (M2_ARBURST ),
    .ARVALID (M2_ARVALID ),
    .ARREADY (M2_ARREADY ),
    .ARLEN   (M2_ARLEN   ),
    .ARSIZE  (M2_ARSIZE  ),
    .RID     (M2_RID     ),
    .RDATA   (M2_RDATA   ),
    .RLAST   (M2_RLAST   ),
    .RVALID  (M2_RVALID  ),
    .RREADY  (M2_RREADY  ),
    .RRESP   (M2_RRESP   ),
    .AWID    (M2_AWID    ),
    .AWADDR  (M2_AWADDR  ),
    .AWBURST (M2_AWBURST ),
    .AWVALID (M2_AWVALID ),
    .AWREADY (M2_AWREADY ),
    .AWLEN   (M2_AWLEN   ),
    .AWSIZE  (M2_AWSIZE  ),
    .WID     (M2_WID     ),
    .WDATA   (M2_WDATA   ),
    .WVALID  (M2_WVALID  ),
    .WREADY  (M2_WREADY  ),
    .WLAST   (M2_WLAST   ),
    .BID     (M2_BID     ),
    .BRESP   (M2_BRESP   ),
    .BVALID  (M2_BVALID  ),
    .BREADY  (M2_BREADY  )
);

AXI4_BRAM_Controller u_AXI4_BRAM_Controller(
    .ACLK    (S_ACLK    ),
    .ARESET  (S_ARESET  ),
    .ARID    (S_ARID    ),
    .ARADDR  (S_ARADDR  ),
    .ARBURST (S_ARBURST ),
    .ARVALID (S_ARVALID ),
    .ARREADY (S_ARREADY ),
    .ARLEN   (S_ARLEN   ),
    .ARSIZE  (S_ARSIZE  ),
    .RID     (S_RID     ),
    .RDATA   (S_RDATA   ),
    .RLAST   (S_RLAST   ),
    .RVALID  (S_RVALID  ),
    .RREADY  (S_RREADY  ),
    .RRESP   (S_RRESP   ),
    .AWID    (S_AWID    ),
    .AWADDR  (S_AWADDR  ),
    .AWBURST (S_AWBURST ),
    .AWVALID (S_AWVALID ),
    .AWREADY (S_AWREADY ),
    .AWLEN   (S_AWLEN   ),
    .AWSIZE  (S_AWSIZE  ),
    .WID     (S_WID     ),
    .WDATA   (S_WDATA   ),
    .WVALID  (S_WVALID  ),
    .WREADY  (S_WREADY  ),
    .WLAST   (S_WLAST   ),
    .BID     (S_BID     ),
    .BRESP   (S_BRESP   ),
    .BVALID  (S_BVALID  ),
    .BREADY  (S_BREADY  )
);

initial
begin
    forever #(PERIOD/2) clk = ~clk;
end

initial
begin
    $dumpfile("AXI4_Interconnect_tb.vcd");
    $dumpvars(0, AXI4_Interconnect_tb);

    // Performing a reset.
    #5;
    rst = 1'b0;
    #10;
    rst = 1'b1;

    for (integer index = 0; index < 91; index = index + 1) 
    begin
        #10;    // Simulation Time = 910ns, will give 3 turns for each Master.
    end

    $finish;
end

endmodule

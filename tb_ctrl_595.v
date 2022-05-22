`timescale 1ns / 1ns
module tb_ctrl_595;

reg				clk			;		
reg				rst_n		;		
                        
reg		[7:0]	seg_data  	;		
reg		[5:0]	sel       	;		
                         
wire	       	oe_595		;		
wire			shcp_595	;		
wire			stcp_595	;		
wire			ds			;

initial begin
	clk = 0;
	rst_n = 0;
	seg_data = 8'b0101_1011;
	sel = 6'b001_000;
	#25
	rst_n = 1;
end
always#10 clk = ~clk;

ctrl_595			u_ctrl_595(
	.clk					(clk		),
	.rst_n					(rst_n		),
	                                    
	.seg_data  				(seg_data  	),
	.sel       				(sel       	),
	                                    
	.oe_595					(oe_595		),
	.shcp_595				(shcp_595	),
	.stcp_595				(stcp_595	),
	.ds			            (ds			)
);
endmodule 
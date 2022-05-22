`timescale 1ns / 1ns 

module tb_dynamic();

reg				clk		;	
reg				rst_n	;	
        
reg		[3:0]	dis1	;	
reg		[3:0]	dis2	;	
reg		[3:0]	dis3	;	
reg		[3:0]	dis4	;	
reg		[3:0]	dis5	;	
reg		[3:0]	dis6	;	

wire	[7:0]	seg_data;	
wire	[5:0]	sel     ;

initial begin
	clk 	= 0			;
	rst_n 	= 0			;
	dis1   	= 4'd1  	;
	dis2   	= 4'd2  	;
	dis3   	= 4'd3  	;
	dis4   	= 4'd4  	;
	dis5   	= 4'd5  	;
	dis6   	= 4'd6  	;
	#25
	rst_n 	= 1			;
end
always #10 clk = ~clk;
dynamic			u_dynamic(
	.clk			(clk			),
	.rst_n			(rst_n			),
                     
	.dis1			(dis1			),
	.dis2			(dis2			),
	.dis3			(dis3			),
	.dis4			(dis4			),
	.dis5			(dis5			),
	.dis6			(dis6			),
                     
	.seg_data		(seg_data		),
	.sel            (sel            )
);

endmodule 
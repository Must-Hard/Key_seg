/*
	Date 		: xxxx
	Description : xxx
	Author : xxx
*/
module seg_top(
	input					clk			,
	input					rst_n		,
//input data 
	input		[3:0]		dis1		,//the data you need 
	input		[3:0]		dis2		,
	input		[3:0]		dis3		,
	input		[3:0]		dis4		,
	input		[3:0]		dis5		,
	input		[3:0]		dis6		,
//74HC595 ctrl
	output					oe_595		,
	output					shcp_595	,
	output					stcp_595	,
	output					ds			
	
);

wire 	[7:0]	seg_data;
wire	[5:0]	sel		;

dynamic			u_dynamic(
	.clk			(clk	),
	.rst_n			(rst_n	),

	.dis1			(dis1),
	.dis2			(dis2),
	.dis3			(dis3),
	.dis4			(dis4),
	.dis5			(dis5),
	.dis6			(dis6),

	.seg_data		(seg_data	),
	.sel        	(sel		)
);
ctrl_595		u_ctrl_595(
	.clk			(clk	),
	.rst_n			(rst_n	),
	
	.seg_data  		(seg_data	),
	.sel       		(sel		),

	.oe_595			(oe_595	),
	.shcp_595		(shcp_595),
	.stcp_595		(stcp_595),
	.ds			    (ds		)
);
endmodule 
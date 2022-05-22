
module key_seg(
	input					clk			,
	input					rst_n		,
	input			[1:0]	key_in		,
	
	output			oe_595		,
	output			shcp_595	,
	output			stcp_595	,
	output			ds			
);
wire	key_out1;
wire	key_out2;

reg [6:0] score1;
reg [6:0] score2;

always@(posedge clk or negedge rst_n)begin
	if(~rst_n)begin
		score1 <= 20'd0;
	end
	else begin
		if(key_out1)begin
			score1 <= score1 + 1'b1;
		end
		else begin
			score1 <= score1;
		end
	end
end

always@(posedge clk or negedge rst_n)begin
	if(~rst_n)begin
		score2 <= 20'd0;
	end
	else begin
		if(key_out2)begin
			score2 <= score2 + 1'b1;
		end
		else begin
			score2 <= score2;
		end
	end
end


key			u1_key(	
	.clk			(clk)	,
	.rst_n			(rst_n)	,

	.key_in			(key_in[0]),
	.key_out        (key_out1)
);
key			u2_key(	
	.clk			(clk)	,
	.rst_n			(rst_n)	,

	.key_in			(key_in[1]),
	.key_out        (key_out2)
);
seg_top		u_seg_top(
	.clk			(clk		),
	.rst_n			(rst_n		),
		
	.dis1			(score1/10),//the data you need 
	.dis2			(score1%10),
	.dis3			(4'd10),      //"-"
	.dis4			(4'd10),      //
	.dis5			(score2/10),
	.dis6			(score2%10),
	
	.oe_595			(oe_595		),
	.shcp_595		(shcp_595	),
	.stcp_595		(stcp_595	),
	.ds				(ds			)

);
endmodule 

module ctrl_595(
	input	clk					,
	input	rst_n				,
	
	input 	[7:0]	seg_data  	,
	input   [5:0]	sel       	,
	
	output			oe_595		,
	output	reg		shcp_595	,
	output	reg		stcp_595	,
	output			ds			
);

wire	[13:0]	data_storge;//

reg		[3:0]	cnt_14;
reg		[1:0]	div_4;
assign data_storge = {seg_data[0],seg_data[1],seg_data[2],
					seg_data[3],seg_data[4],seg_data[5],
					seg_data[6],seg_data[7],sel};
					
assign ds = data_storge[cnt_14];

assign oe_595 = ~rst_n;//595 dont work when rst

always@(posedge clk or negedge rst_n)begin
	if(~rst_n)begin
		div_4 <= 2'd0;
	end
	else begin
		if(div_4 == 2'd3)begin
			div_4 <= 2'd0;
		end
		else begin
			div_4 <= div_4 + 2'd1;
		end
	end
end

always@(posedge clk or negedge rst_n)begin
	if(~rst_n)begin
		shcp_595 <= 1'b0;
	end
	else begin
		if(div_4 > 2'd1)begin
			shcp_595 <= 1'b1;
		end
		else begin
			shcp_595 <= 1'b0;
		end
	end
end
always@(posedge clk or negedge rst_n)begin
	if(~rst_n)begin
		cnt_14 <= 4'd0;
	end
	else begin
		if(div_4 == 2'd3)begin
			if(cnt_14 == 4'd13)begin
				cnt_14 <= 4'd0;
			end
			else begin
				cnt_14 <= cnt_14 + 4'd1;
			end
		end
		else begin
			cnt_14 <= cnt_14;
		end	
	end
end

always@(posedge clk or negedge rst_n)begin
	if(~rst_n)begin
		stcp_595 <= 1'b0;
	end
	else begin
		if(cnt_14 == 4'd13 && div_4 == 2'd3)begin
			stcp_595 <= 1'b1;
		end
		else begin
			stcp_595 <= 1'b0;
		end
	end
end
endmodule 
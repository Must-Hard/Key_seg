/*
	°´¼üÏû¶¶
*/
module key(
	input			clk			,
	input			rst_n		,
			
	input			key_in		,
	output	reg 	key_out
);

parameter CNT_MAX_20MS = 20'd1_000_000;

reg [19:0]	cnt_20ms;

always@(posedge clk or negedge rst_n)begin
	if(~rst_n)begin
		cnt_20ms <= 20'd0;
	end
	else begin
		if(~key_in)begin
			if(cnt_20ms < CNT_MAX_20MS)begin     // 10   0 1 2 3  9 10 10 10 10 10  0 0 0 0  00 0 0 1 0 0 00 0 
				cnt_20ms <= cnt_20ms + 1'b1;
			end
		end
		else begin
			cnt_20ms <= 20'd0;
		end
	end
end

always@(posedge clk or negedge rst_n)begin
	if(~rst_n)begin
		key_out <= 1'b0;
	end
	else begin
		if(cnt_20ms == CNT_MAX_20MS - 1)begin
			key_out <= 1'b1;
		end
		else begin
			key_out <= 1'b0;
		end
	end
end
endmodule 
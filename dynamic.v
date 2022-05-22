/*
	Date 		: 2022 05 22
	Description : seg dynamic
*/

module dynamic(
	input					clk,
	input					rst_n,
	
	input		[3:0]		dis1,
	input		[3:0]		dis2,
	input		[3:0]		dis3,
	input		[3:0]		dis4,
	input		[3:0]		dis5,
	input		[3:0]		dis6,
	
	output	reg	[7:0]		seg_data,
	output	reg	[5:0]		sel
);
//short time  sel[0] -> sel[1] 1ms  dynamic
parameter CNT_1MS_MAX = 16'd50_000;
reg [15:0] cnt_1ms;

reg [2:0] cnt_bit;

reg [3:0] data_decoder;//0 1 2 3 
always@(posedge clk or negedge rst_n)begin
	if(~rst_n)begin
		cnt_1ms <= 16'd0;
	end
	else begin
		if(cnt_1ms == CNT_1MS_MAX - 1)begin
			cnt_1ms <= 16'd0;
		end
		else begin
			cnt_1ms <= cnt_1ms + 1'b1;
		end
	end
end

always@(posedge clk or negedge rst_n)begin
	if(~rst_n)begin
		cnt_bit <= 3'd0;
	end
	else begin
		if(cnt_1ms == CNT_1MS_MAX - 1)begin
			if(cnt_bit == 3'd5)begin
				cnt_bit <= 3'd0;
			end
			else begin
				cnt_bit <= cnt_bit + 3'd1;
			end
		end
		else begin
			cnt_bit <= cnt_bit;
		end
	end
end
//0 dark
//1 light 
always@(posedge clk or negedge rst_n)begin
	if(~rst_n)begin
		sel <= 6'b0000_00;//6'd0;
	end
	else begin
		case(cnt_bit)
			3'd0:begin
				sel <= 6'b1000_00;
			end
			3'd1:begin
				sel <= 6'b0100_00;
			end
			3'd2:begin
				sel <= 6'b0010_00;
			end
			3'd3:begin
				sel <= 6'b0001_00;
			end
			3'd4:begin
				sel <= 6'b0000_10;
			end
			3'd5:begin
				sel <= 6'b0000_01;
			end
			default:begin
				sel <= 6'b0000_00;
			end
		endcase
	end
end

always@(posedge clk or negedge rst_n)begin
	if(~rst_n)begin
		data_decoder <= 4'd11;
	end
	else begin
		case(cnt_bit)
			3'd0:data_decoder <= dis1;
			3'd1:data_decoder <= dis2;
			3'd2:data_decoder <= dis3;
			3'd3:data_decoder <= dis4;
			3'd4:data_decoder <= dis5;
			3'd5:data_decoder <= dis6;
			default:data_decoder <= 4'd11;
		endcase
	end
end
//0xC0、0x0xF9、0xA4、0xB0、0x99、0x92、0x82、0xF8、0x80、0x90
always@(*)begin
	case(data_decoder)
		4'd0:begin
			seg_data = 8'hc0;
		end
		4'd1:begin
			seg_data = 8'hf9;
		end
		4'd2:begin
			seg_data = 8'ha4;
		end
		4'd3:begin
			seg_data = 8'hb0;
		end
		4'd4:begin
			seg_data = 8'h99;
		end
		4'd5:begin
			seg_data = 8'h92;
		end
		4'd6:begin
			seg_data = 8'h82;
		end
		4'd7:begin
			seg_data = 8'hf8;
		end
		4'd8:begin
			seg_data = 8'h80;
		end
		4'd9:begin
			seg_data = 8'h90;
		end
		4'd10:begin
			seg_data = 8'hbf;//"-"    
		end
		4'd11:begin
			seg_data = 8'hff;//dark  
		end
		default:begin
			seg_data = 8'hff;//dark  
		end
	endcase
end

endmodule 
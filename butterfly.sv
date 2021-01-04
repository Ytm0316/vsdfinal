//butterfly.sv
module butterfly(
	input clk,
	input rst,
	input en,
	input signed [31:0] xu_real,
	input signed [31:0] xu_imag,
	input signed [31:0] xb_real,
	input signed [31:0] xb_imag,
	input signed [16:0] w_real,
	input signed [16:0] w_imag,
	
	output valid,
	output signed [31:0] yu_real,
	output signed [31:0] yu_imag,
	output signed [31:0] yb_real,
	output signed [31:0] yb_imag,
	
	
);
	logic [4:0] en_r ;
	always@(posedge clk or posedge rst)begin
		if(rst)begin
			en_r <= 3'b000;
		end
		else begin
			en_r <= {en_r[3:0],en};
		end
	end
	
	logic signed [31:0] xb_w_real0;
	logic signed [31:0] xb_w_real1;
	logic signed [31:0] xb_w_imag0;
	logic signed [31:0] xb_w_imag1;
	logic signed [31:0] xu_real_d;
	logic signed [31:0] xu_imag_d;
	
	always@(posedge clk or posedge rst)begin
		if(rst)begin
			xb_w_real0 <= 32'd0;
			xb_w_real1 <= 32'd0;
			xb_w_imag0 <= 32'd0;
			xb_w_imag1 <= 32'd0;
			xu_real_d <= 32'd0;
			xu_imag_d <= 32'd0;
		end
		else if(en) begin
			xb_w_real0 <= xb_real * w_real;
			xb_w_real1 <= xb_imag * w_imag;
			xb_w_imag0 <= xb_real * w_imag;
			xb_w_imag1 <= xb_imag * w_real;
			xu_real_d <= xu_real;
			xu_imag_d <= xu_imag;
		end
	end
	
	logic signed [31:0] xu_real_d1;
	logic signed [31:0] xu_imag_d2;
	logic signed [31:0] xb_w_real;
	logic signed [31:0] xb_w_imag;
	
	always@(posedge clk or posedge rst)begin
		if(rst)begin
			xu_real_d1 <= 32'd0;
			xu_imag_d1 <= 32'd0;
			xb_w_real <= 32'd0;
			xb_w_imag <= 32'd0;
		end
		else if(en_r[0])begin
			xu_real_d1 <= xu_real_d;
			xu_imag_d1 <= xu_imag_d;
			xb_w_real <= xb_w_real0 - wb_w_real1;
			xb_w_imag <= xb_w_imag0 + xb_w_imag1;
		end
	end
	
	logic signed [31:0] yu_real_r;
	logic signed [31:0] yu_imag_r;
	logic signed [31:0] yb_real_r;
	logic signed [31:0] yb_imag_r;
	always@(posedge clk or posedge rst)begin
		if(rst)begin
			yu_real_d <= 32'd0;
			yu_imag_d <= 32'd0;
			yb_real_d <= 32'd0;
			yb_imag_d <= 32'd0;
		end
		else if(en_r[1])begin
			yu_real_d <= xu_real_d1 + xb_w_real;
			yu_imag_d <= xu_imag_d1 + xb_w_imag;
			yb_real_d <= xu_real_d1 - xb_w_real;
			yb_imag_d <= xu_imag_d1 - xb_w_imag;
		end
	end
	
	assign yu_real = yu_real_d;
	assign yu_imag = yu_imag_d;
	assign yb_real = yb_real_d;
	assign yb_imag = yb_imag_d;
	assign valid = en_r[2];
	

endmodule

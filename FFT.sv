//FFT.sv 8point
module FFT(
	input clk,
	input rst,
	input en,
	
	input signed [31:0] x0_real,
	input signed [31:0] x0_imag,
	input signed [31:0] x1_real,
	input signed [31:0] x1_imag,
	input signed [31:0] x2_real,
	input signed [31:0] x2_imag,
	input signed [31:0] x3_real,
	input signed [31:0] x3_imag,
	input signed [31:0] x4_real,
	input signed [31:0] x4_imag,
	input signed [31:0] x5_real,
	input signed [31:0] x5_imag,
	input signed [31:0] x6_real,
	input signed [31:0] x6_imag,
	input signed [31:0] x7_real,
	input signed [31:0] x7_imag,
	
	output valid,
	output signed [31:0] y0_real,
	output signed [31:0] y0_imag,
	output signed [31:0] y1_real,
	output signed [31:0] y1_imag,
	output signed [31:0] y2_real,
	output signed [31:0] y2_imag,
	output signed [31:0] y3_real,
	output signed [31:0] y3_imag,
	output signed [31:0] y4_real,
	output signed [31:0] y4_imag,
	output signed [31:0] y5_real,
	output signed [31:0] y5_imag,
	output signed [31:0] y6_real,
	output signed [31:0] y6_imag,
	output signed [31:0] y7_real,
	output signed [31:0] y7_imag
	
	 
);
	//data
	wire signed [31:0]             xm_real [3:0] [7:0];
    	wire signed [31:0]             xm_imag [3:0] [7:0];
    	wire                           en_connect [15:0] ;
    	assign                         en_connect[0] = en;
    	assign                         en_connect[1] = en;
    	assign                         en_connect[2] = en;
    	assign                         en_connect[3] = en;
    	
    	assign xm_real[0][0] = x0_real;
    	assign xm_real[0][1] = x4_real;
    	assign xm_real[0][2] = x2_real;
    	assign xm_real[0][3] = x6_real;
    	assign xm_real[0][4] = x1_real;
    	assign xm_real[0][5] = x5_real;
   	assign xm_real[0][6] = x3_real;
    	assign xm_real[0][7] = x7_real;
    	assign xm_imag[0][0] = x0_imag;
    	assign xm_imag[0][1] = x4_imag;
    	assign xm_imag[0][2] = x2_imag;
    	assign xm_imag[0][3] = x6_imag;
   	assign xm_imag[0][4] = x1_imag;
   	assign xm_imag[0][5] = x5_imag;
    	assign xm_imag[0][6] = x3_imag;
    	assign xm_imag[0][7] = x7_imag;
    	
    	//factor
	wire signed [15:0]             w_real [3:0] ;
    	wire signed [15:0]             w_imag [3:0];
    	assign w_real[0]        = 16'h2000; //1
    	assign w_imag[0]        = 16'h0000; //0
    	assign w_real[1]        = 16'h16a0; //sqrt(2)/2
    	assign w_imag[1]        = 16'he95f; //-sqrt(2)/2
    	assign w_real[2]        = 16'h0000; //0
    	assign w_imag[2]        = 16'he000; //-1
    	assign w_real[3]        = 16'he95f; //-sqrt(2)/2
    	assign w_imag[3]        = 16'he95f; //-sqrt(2)/2
	
	
	//stage 1;
	butterfly s1_btf_0
		.clk(clk),
		.rst(rst),
		.en(en_connect[0]),
		.xu_real(xm_real[0][0]),
		.xu_imag(xm_imag[0][0]),
		.xb_real(xm_real[0][1]),
		.xb_imag(xm_imag[0][1]),
		.w_real(w_real[0]),
		.w_imag(w_imag[0]),
		.valid(en_connect[4]),
		.yu_real(xm_real[1][0]),
		.yu_imag(xm_imag[1][0]),
		.yb_real(xm_real[1][1]),
		.yb_imag(xm_imag[1][1])
	);
	butterfly s1_btf_1
		.clk(clk),
		.rst(rst),
		.en(en_connect[1]),
		.xu_real(xm_real[0][2]),
		.xu_imag(xm_imag[0][2]),
		.xb_real(xm_real[0][3]),
		.xb_imag(xm_imag[0][3]),
		.w_real(w_real[0]),
		.w_imag(w_imag[0]),
		.valid(en_connect[5]),
		.yu_real(xm_real[1][2]),
		.yu_imag(xm_imag[1][2]),
		.yb_real(xm_real[1][3]),
		.yb_imag(xm_imag[1][3])
	);
	butterfly s1_btf_2
		.clk(clk),
		.rst(rst),
		.en(en_connect[2]),
		.xu_real(xm_real[0][4]),
		.xu_imag(xm_imag[0][4]),
		.xb_real(xm_real[0][5]),
		.xb_imag(xm_imag[0][5]),
		.w_real(w_real[0]),
		.w_imag(w_imag[0]),
		.valid(en_connect[6]),
		.yu_real(xm_real[1][4]),
		.yu_imag(xm_imag[1][4]),
		.yb_real(xm_real[1][5]),
		.yb_imag(xm_imag[1][5])
	);
	butterfly s1_btf_3
		.clk(clk),
		.rst(rst),
		.en(en_connect[3]),
		.xu_real(xm_real[0][6]),
		.xu_imag(xm_imag[0][6]),
		.xb_real(xm_real[0][7]),
		.xb_imag(xm_imag[0][7]),
		.w_real(w_real[0]),
		.w_imag(w_imag[0]),
		.valid(en_connect[7]),
		.yu_real(xm_real[1][6]),
		.yu_imag(xm_imag[1][6]),
		.yb_real(xm_real[1][7]),
		.yb_imag(xm_imag[1][7])
	);
	
	//stage 2;
	butterfly s2_btf_0
		.clk(clk),
		.rst(rst),
		.en(en_connect[4]),
		.xu_real(xm_real[1][0]),
		.xu_imag(xm_imag[1][0]),
		.xb_real(xm_real[1][2]),
		.xb_imag(xm_imag[1][2]),
		.w_real(w_real[0]),
		.w_imag(w_imag[0]),
		.valid(en_connect[8]),
		.yu_real(xm_real[2][0]),
		.yu_imag(xm_imag[2][0]),
		.yb_real(xm_real[2][2]),
		.yb_imag(xm_imag[2][2])
	);
	butterfly s2_btf_1
		.clk(clk),
		.rst(rst),
		.en(en_connect[5]),
		.xu_real(xm_real[1][1]),
		.xu_imag(xm_imag[1][1]),
		.xb_real(xm_real[1][3]),
		.xb_imag(xm_imag[1][3]),
		.w_real(w_real[2]),
		.w_imag(w_imag[2]),
		.valid(en_connect[9]),
		.yu_real(xm_real[2][1]),
		.yu_imag(xm_imag[2][1]),
		.yb_real(xm_real[2][3]),
		.yb_imag(xm_imag[2][3])
	);
	butterfly s2_btf_2
		.clk(clk),
		.rst(rst),
		.en(en_connect[6]),
		.xu_real(xm_real[1][4]),
		.xu_imag(xm_imag[1][4]),
		.xb_real(xm_real[1][6]),
		.xb_imag(xm_imag[1][6]),
		.w_real(w_real[0]),
		.w_imag(w_imag[0]),
		.valid(en_connect[10]),
		.yu_real(xm_real[2][4]),
		.yu_imag(xm_imag[2][4]),
		.yb_real(xm_real[2][6]),
		.yb_imag(xm_imag[2][6])
	);
	butterfly s2_btf_3
		.clk(clk),
		.rst(rst),
		.en(en_connect[7]),
		.xu_real(xm_real[1][5]),
		.xu_imag(xm_imag[1][5]),
		.xb_real(xm_real[1][7]),
		.xb_imag(xm_imag[1][7]),
		.w_real(w_real[2]),
		.w_imag(w_imag[2]),
		.valid(en_connect[11]),
		.yu_real(xm_real[2][5]),
		.yu_imag(xm_imag[2][5]),
		.yb_real(xm_real[2][7]),
		.yb_imag(xm_imag[2][7])
	);
	//stage 3;
	butterfly s3_btf_0
		.clk(clk),
		.rst(rst),
		.en(en_connect[8]),
		.xu_real(xm_real[2][0]),
		.xu_imag(xm_imag[2][0]),
		.xb_real(xm_real[2][4]),
		.xb_imag(xm_imag[2][4]),
		.w_real(w_real[0]),
		.w_imag(w_imag[0]),
		.valid(en_connect[12]),
		.yu_real(xm_real[3][0]),
		.yu_imag(xm_imag[3][0]),
		.yb_real(xm_real[3][4]),
		.yb_imag(xm_imag[3][4])
	);
	butterfly s3_btf_1
		.clk(clk),
		.rst(rst),
		.en(en_connect[9]),
		.xu_real(xm_real[2][1]),
		.xu_imag(xm_imag[2][1]),
		.xb_real(xm_real[2][5]),
		.xb_imag(xm_imag[2][5]),
		.w_real(w_real[1]),
		.w_imag(w_imag[1]),
		.valid(en_connect[13]),
		.yu_real(xm_real[3][1]),
		.yu_imag(xm_imag[3][1]),
		.yb_real(xm_real[3][5]),
		.yb_imag(xm_imag[3][5])
	);
	butterfly s3_btf_2
		.clk(clk),
		.rst(rst),
		.en(en_connect[10]),
		.xu_real(xm_real[2][2]),
		.xu_imag(xm_imag[2][2]),
		.xb_real(xm_real[2][6]),
		.xb_imag(xm_imag[2][6]),
		.w_real(w_real[2]),
		.w_imag(w_imag[2]),
		.valid(en_connect[14]),
		.yu_real(xm_real[3][2]),
		.yu_imag(xm_imag[3][2]),
		.yb_real(xm_real[3][6]),
		.yb_imag(xm_imag[3][6])
	);
	butterfly s3_btf_3
		.clk(clk),
		.rst(rst),
		.en(en_connect[11]),
		.xu_real(xm_real[2][3]),
		.xu_imag(xm_imag[2][3]),
		.xb_real(xm_real[2][7]),
		.xb_imag(xm_imag[2][7]),
		.w_real(w_real[3]),
		.w_imag(w_imag[3]),
		.valid(en_connect[15]),
		.yu_real(xm_real[3][3]),
		.yu_imag(xm_imag[3][3]),
		.yb_real(xm_real[3][7]),
		.yb_imag(xm_imag[3][7])
	);
	
	assign     valid = en_connect[12];
    	assign     y0_real = xm_real[3][0] ;
    	assign     y0_imag = xm_imag[3][0] ;
    	assign     y1_real = xm_real[3][1] ;
    	assign     y1_imag = xm_imag[3][1] ;
    	assign     y2_real = xm_real[3][2] ;
    	assign     y2_imag = xm_imag[3][2] ;
    	assign     y3_real = xm_real[3][3] ;
    	assign     y3_imag = xm_imag[3][3] ;
    	assign     y4_real = xm_real[3][4] ;
    	assign     y4_imag = xm_imag[3][4] ;
    	assign     y5_real = xm_real[3][5] ;
    	assign     y5_imag = xm_imag[3][5] ;
    	assign     y6_real = xm_real[3][6] ;
    	assign     y6_imag = xm_imag[3][6] ;
    	assign     y7_real = xm_real[3][7] ;
    	assign     y7_imag = xm_imag[3][7] ;
endmodule

module top
  #(parameter DELAY_BIT=15)
  (
   input  CLK,
   input  BTN_N,
   input  P2_1,
   input  P2_2,
   output P2_3,
   output P2_4,
   output P2_7,
   output P2_8,
   output P2_9,
   output P2_10,
   output P1A1,
   output P1A2,
   output P1A3,
   output P1A4,
   output P1A7,
   output P1A8,
   output P1A9,
   output P1A10,
   output P1B1,
   output P1B2,
   output P1B3,
   output P1B4,
   output P1B7,
   output P1B8,
   output P1B9,
   output P1B10
   );

  wire       clk_dut;
  wire [1:0] red;
  wire [1:0] blue;
  wire [1:0] green;
  wire       blank;
  wire       sclk;
  wire       latch;
  wire       a;
  wire       b;

  reg [15:0]   rst_delay_counter;
  wire         rst;
  wire         unused;
  reg          rst_delayed;

  wire         uart_data;
  wire [7:0]   uart_rx_data;
  wire         uart_rx_dv;

  wire         mode;

  // wire up the inputs and outputs
  assign rst = ~BTN_N;
  assign P1A1 = red[0];
  assign P1A2 = blue[0];
  assign P1A3 = b;
  assign P1A4 = blank;
  assign P1A7 = green[0];
  assign P1A8 = a;
  assign P1A9 = sclk;
  assign P1A10 = latch;
  assign P1B1 = red[1];
  assign P1B2 = blue[1];
  assign P1B7 = green[1];
  assign uart_data = P2_1;
  assign mode = 1'b0; // P2_2;
  assign clk_dut = CLK;

  // reset delay
  always @(posedge CLK) begin
    begin
      if (rst == 1'b1) begin
		rst_delayed <= 1'b1;
		rst_delay_counter <= 0;
	  end else if (rst_delay_counter[DELAY_BIT] == 1'b1) begin
		rst_delayed <= 1'b0;
      end else begin
		rst_delayed <= 1'b1;
        rst_delay_counter <= rst_delay_counter + 1;
      end
    end
  end

  // instantiate the component
  led_panel_single top(.clk(clk_dut),
                       .reset(rst_delayed),
                       .uart_data(uart_data),
                       .mode(mode),
                       .red_out(red),
                       .blue_out(blue),
                       .blank_out(blank),
                       .green_out(green),
                       .sclk_out(sclk),
                       .latch_out(latch),
                       .a_out(a),
                       .b_out(b),
                       .uart_rx_data_out(uart_rx_data),
                       .uart_rx_dv_out(uart_rx_dv)
                       );

endmodule

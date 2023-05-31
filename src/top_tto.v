`default_nettype none

module tomkeddie_top_tto_a
  #(parameter CLOCK_RATE=1000)
  (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
   );

  wire          rst;
  wire          red; 
  wire          blue;
  wire          blank;
  wire          green;
  wire          sclk;
  wire          latch;
  wire [2:0]    rowmax;
  wire          a;
  wire          b;
  wire          uart_data;
  wire          mode;

  assign uo_out[0] = red;
  assign uo_out[1] = blue;
  assign uo_out[2] = b;
  assign uo_out[3] = blank;
  assign uo_out[4] = green;
  assign uo_out[5] = a;
  assign uo_out[6] = sclk;
  assign uo_out[7] = latch;
  assign uio_out  = 8'b00000000;
  assign uio_oe   = 8'b00000000;

  assign rst       = !rst_n;
  assign uart_data = ui_in[0];
  assign mode      = ui_in[1];


  // instantiate the component
  led_panel_single top(.clk(clk),
                       .reset(rst),
                       .uart_data(uart_data),
                       .mode(mode),
                       .red_out(red),     
                       .blue_out(blue),    
                       .blank_out(blank),   
                       .green_out(green),  
                       .a_out(a),
                       .b_out(b),
                       .sclk_out(sclk),    
                       .latch_out(latch)
                       );              
  
endmodule

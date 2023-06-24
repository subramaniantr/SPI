module spi_slave_controller(
   input clk,
   input mosi,
   output reg miso,
   input cs_b
   );


/*------------------------------------------------------------------
  Registers and state declaration
------------------------------------------------------------------*/
reg [7:0] addressCounter;
reg [7:0] dataCounter;
reg addressCounterReset, dataCounterReset;
reg [1:0] currState, nextState;

parameter // 3 states are required for Moore
    idle = 2'b00,
    stateAddress = 2'b01, 
    stateData = 2'b10;



/*------------------------------------------------------------------
  Current state registers
------------------------------------------------------------------*/
always @(posedge clk or posedge cs_b) begin 
 if (cs_b == 1) begin
  currState <= idle;
 end else begin
  currState <= nextState;
 end
end //always_ff


/*------------------------------------------------------------------
  Next state logic
------------------------------------------------------------------*/
always@* begin
 nextState = currState; // default is to stay in current state
 case (currState)
  idle        : begin
                   addressCounterReset = 1'b1;
                   dataCounterReset = 1'b1;
                   nextState = stateAddress;
	        end   //state idle
  stateAddress : begin
                   addressCounterReset = 1'b0;    
		   if(addressCounter == 8'h08) 
		       nextState = stateData;
		end   //state Address
  stateData   : begin
		   addressCounterReset = 1'b0;
		   dataCounterReset = 1'b0;
                   if(dataCounter == 8'h08)
		       nextState = idle;
		end  //state Data
      endcase
end //always


/*------------------------------------------------------------------
  Address counter logic
------------------------------------------------------------------*/

always @(posedge clk or posedge cs_b) begin 
  if(cs_b || addressCounterReset)
    addressCounter <= 8'h00;
  else
    addressCounter <= addressCounter + 1'b1;
end //always_ff


/*------------------------------------------------------------------
  Address counter logic
------------------------------------------------------------------*/
always @(posedge clk or posedge cs_b) begin 
  if(cs_b || dataCounterReset)
    dataCounter <= 8'h00;
  else
    dataCounter <= dataCounter + 1'b1;
end //always_ff

endmodule

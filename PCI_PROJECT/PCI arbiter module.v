 module arbiter (clk,REQ,GNT,FRAME,IRDY,TRDY);
  input wire clk,FRAME,IRDY,TRDY;
  input wire [7:0] REQ;
  output reg [7:0] GNT;

  reg [2:0] FIFOcounter;
  reg [3:0] FIFO[0:7];
  reg RDY_GNT;
  reg NEED_GNT;

  initial begin

    $monitor($time,,"F0 = %d F1 = %d F2 = %d F3 = %d F4 = %d F5 = %d F6= %d F7 = %d FIFOcounter = %d REQ=%b",FIFO[0],FIFO[1],FIFO[2],FIFO[3],FIFO[4],FIFO[5],FIFO[6],FIFO[7],FIFOcounter,REQ);
    FIFOcounter<=0;
    RDY_GNT<=1;
    NEED_GNT<=0;
    GNT<=8'b11111111;
    FIFO[0]<=9;
    FIFO[1]<=9;
    FIFO[2]<=9;
    FIFO[3]<=9;
    FIFO[4]<=9;
    FIFO[5]<=9;
    FIFO[6]<=9;
    FIFO[7]<=9;
   
  end

  always @ (negedge FRAME) begin RDY_GNT<=1; end

  always @ (posedge clk) begin

      if (FIFO[0]!=9) begin
       NEED_GNT<=1;  // here we know that we have request needs to be granted
         	 end end

    always @ (negedge clk) begin
     
      if(NEED_GNT && RDY_GNT)
      begin
       case (FIFO[0])
          0:GNT<=8'b11111110;
          1:GNT<=8'b11111101;
          2:GNT<=8'b11111011;
          3:GNT<=8'b11110111;
          4:GNT<=8'b11101111;
          5:GNT<=8'b11011111;
          6:GNT<=8'b10111111;
          7:GNT<=8'b01111111;
          default:GNT<=8'b11111111;
        endcase
        NEED_GNT<=0;
        RDY_GNT<=0;
        FIFO[0]<=FIFO[1];
        FIFO[1]<=FIFO[2];
        FIFO[3]<=FIFO[4];
        FIFO[4]<=FIFO[5];
        FIFO[5]<=FIFO[6];
        FIFO[6]<=FIFO[7];
        FIFO[7]<=9;
        FIFOcounter<=FIFOcounter-1;
        end
    end

  always @ (negedge REQ[0]) begin
    FIFO[FIFOcounter]<=0;
    FIFOcounter<=FIFOcounter+1;
     end

  always @ (negedge REQ[1]) begin
    FIFO[FIFOcounter]<=1;
    FIFOcounter<=FIFOcounter+1;
    end

  always @ (negedge REQ[2]) begin
    FIFO[FIFOcounter]<=2;
    FIFOcounter<=FIFOcounter+1;
  end

  always @ (negedge REQ[3]) begin
    FIFO[FIFOcounter]<=3;
    FIFOcounter<=FIFOcounter+1;
   end

  always @ (negedge REQ[4]) begin
    FIFO[FIFOcounter]<=4;
    FIFOcounter<=FIFOcounter+1;
    end

  always @ (negedge REQ[5]) begin
    FIFO[FIFOcounter]<=5;
    FIFOcounter<=FIFOcounter+1;
    end

  always @ (negedge REQ[6]) begin
    FIFO[FIFOcounter]<=6;
    FIFOcounter<=FIFOcounter+1;
    end

  always @ (negedge REQ[7]) begin
    FIFO[FIFOcounter]<=7;
    FIFOcounter<=FIFOcounter+1;
    end

endmodule 

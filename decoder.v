module decoder(
  input wire [0:15] c_h,
  output reg [0:10] data_out,
	input wire enable,
    output reg error,
    output reg error_incorrectable
	);

  reg [3:0] error_index; // index of error bit in message
  reg [0:15]data_aux;
  reg bit_parity; 
  integer i;
  always @(*) begin
    if(enable == 1'b1) begin
      //c_h * parity check matrix      
      error_index[0] = c_h[0] + c_h[2] + c_h[4] + c_h[6] + c_h[8] + c_h[10] + c_h[12] + c_h[14];  
      error_index[1] = c_h[1] + c_h[2] + c_h[5] + c_h[6] + c_h[9] + c_h[10] + c_h[13] + c_h[14];
      error_index[2] = c_h[3] + c_h[4] + c_h[5] + c_h[6] + c_h[11] + c_h[12] + c_h[13] + c_h[14];
      error_index[3] = c_h[7] + c_h[8] + c_h[9] + c_h[10] + c_h[11] + c_h[12] + c_h[13] + c_h[14];
      bit_parity =  c_h[0] ^ c_h[1] ^ c_h[2] ^ c_h[3] ^ c_h[4] ^ c_h[5] ^ c_h[6] ^ c_h[7] ^ c_h[8] ^ c_h[9] ^ c_h[10] ^ c_h[11] ^ c_h[12] ^ c_h[13] ^ c_h[14]; 
      if(error_index == 4'b0000)begin 
         
        if(bit_parity == c_h[15])begin
          //there is no error
          	error = 0;
            error_incorrectable = 0;
          //data out
        	data_out[0] = c_h[2];
        	data_out[1] = c_h[4];
        	data_out[2] = c_h[5];
        	data_out[3] = c_h[6];
        	data_out[4] = c_h[8];
        	data_out[5] = c_h[9];
        	data_out[6] = c_h[10];
        	data_out[7] = c_h[11];
        	data_out[8] = c_h[12];
        	data_out[9] = c_h[13];
        	data_out[10] = c_h[14];
        end else begin
          //single error number of ones is even
          	error = 1;
            error_incorrectable = 0;
          //data out
            data_out[0] = c_h[2];
        	data_out[1] = c_h[4];
        	data_out[2] = c_h[5];
        	data_out[3] = c_h[6];
        	data_out[4] = c_h[8];
        	data_out[5] = c_h[9];
        	data_out[6] = c_h[10];
        	data_out[7] = c_h[11];
        	data_out[8] = c_h[12];
        	data_out[9] = c_h[13];
        	data_out[10] = c_h[14];
        end
        
      end else begin 
        
        if(bit_parity == c_h[15])begin
        	error = 1;
          //double error can't be corrected
            error_incorrectable = 1;
          
          	data_out[0] = c_h[2];
        	data_out[1] = c_h[4];
        	data_out[2] = c_h[5];
        	data_out[3] = c_h[6];
        	data_out[4] = c_h[8];
        	data_out[5] = c_h[9];
        	data_out[6] = c_h[10];
        	data_out[7] = c_h[11];
        	data_out[8] = c_h[12];
        	data_out[9] = c_h[13];
        	data_out[10] = c_h[14];
          
        end else begin
          //single error in error_index
          error = 1;
          error_incorrectable = 0;
          i=error_index-1;
          //data out
          data_aux = c_h; 
          data_aux[i]=!data_aux[i];
          #5
          data_out[0] = data_aux[2];
          data_out[1] = data_aux[4];
          data_out[2] = data_aux[5];
          data_out[3] = data_aux[6];
          data_out[4] = data_aux[8];
          data_out[5] = data_aux[9];
          data_out[6] = data_aux[10];
          data_out[7] = data_aux[11];
          data_out[8] = data_aux[12];
          data_out[9] = data_aux[13];
          data_out[10] = data_aux[14];
        end // else2
        
      end // else1
    end
  
  end// always

endmodule
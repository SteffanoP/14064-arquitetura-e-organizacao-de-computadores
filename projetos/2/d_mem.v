module d_mem(address, writeData, readData, memWrite, memRead);
   //declarar entradas e saídas
   input [31:0] address; 				//endereço de memória para leitura e gravação
   input [31:0] writeData; 			//dados a serem escritos na memória
   input memWrite, memRead;			//sinal de controle para escrever na memória | sinal de controle para ler da memória
   output reg [31:0] readData; 		//dados lidos da memória

   //declarar os elementos internos
   reg [31:0] memory [0:(2**32 - 1)];		//cria uma memória de 32 bits com 2^32 elementos, onde cada elemento pode ser acessado através de um endereço de 32 bits.

   //descrever o comportamento do circuito
   always @(*) begin
   // Lógica de gravação
      if (memWrite) begin					//se memWrite == 1 -> grava os dados fornecidos no endereço indicado.
         memory[address] = writeData;
      end

   // Lógica de leitura
      if (memRead) begin					//se memRead == 1 -> lê os dados do endereço indicado e manda esses dados p/ readData (saída)
         readData = memory[address];
      end

   end
	
endmodule

module d_mem #(parameter MEM_SIZE = 8) (address, writeData, readData, memWrite, memRead);

   //declarar entradas e saídas
   input wire [31:0] address; 				//endereço de memória para leitura e gravação
   input wire [31:0] writeData; 			//dados a serem escritos na memória
   input wire memWrite, memRead;			//sinal de controle para escrever na memória | sinal de controle para ler da memória
   output reg [31:0] readData; 		//dados lidos da memória
	

   //declarar os elementos internos
   reg [31:0] memory [0:(MEM_SIZE/4) - 1]; //Cria memória com tamanho definido pelo MEM_SIZE em bytes

   //descrever o comportamento do circuito
   always @(*) begin
   // Lógica de gravação
      if (memWrite) begin					//se memWrite == 1 -> grava os dados fornecidos no endereço indicado
         memory[address/(4)] = writeData;
      end

   // Lógica de leitura
	   readData = memRead ? memory[address/(4)] : 32'bz; // Se memRead == 1, ele lê os dados da memória no endereço dado pelo 'address', e armazena em 'readData'
		// Caso contrário, atribui '32'bz' a 'readData'
	end
	
endmodule
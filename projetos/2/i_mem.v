module i_mem (address, i_out);
    // Declaração dos parâmetros referentes À memória ROM
    parameter memory_size = 256;
    parameter address_data = 32;

    // Declaração de entradas e saída
    input [address_data-1:0] address;
    output reg [address_data-1:0] i_out;

    // Declaração da memória ROM
    reg [address_data-1:0] rom_mem [0:memory_size-1];

    // Inicializando o arquivo com as instruções MIPS
    // TODO: Completar arquivo com mais instruções
    initial begin
        $readmemb("tests/MIPS_teste.list", rom_mem);
    end

    // Leitura assíncrona. Apenas o address é considerado no always.
    // Nesse caso, a saída recebe a instrução presente no índice dado
    // pelos 5 últimos bits do address. Então, esse índice referencia
    // à localização da instrução no arquivo da rom_mem 
    always @(address) begin
        i_out = rom_mem[address[4:0]];
    end
    
endmodule
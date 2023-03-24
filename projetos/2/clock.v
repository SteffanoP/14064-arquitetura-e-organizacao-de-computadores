module Clock (clock);
    output reg clock;

    initial begin
        clock = 0;
    end

    always begin
        //O valor do clock varia de sinal a cada 20 tiques
        #20 clock = ~clock;
        #20 clock = ~clock;
    end
endmodule
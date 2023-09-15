/*
a) Diseñar el banco de 32 registros de 64 bits cada uno, con dos puertos de salida (rd1 y rd2) y un
puerto de escritura (wd3). Las señales de direccionamiento ra1 y ra2 determinan la posición de los
datos de salida rd1 y rd2, respectivamente. De forma análoga, el puerto wa3 selecciona el registro
en el que se almacenará el dato contenido de wd3.
Nota 1: El contenido del registro de dirección 31 (correspondiente a XZR) debe retornar siempre ‘0’.
La escritura en este registro no debe estar permitida.
Nota 2: El dato contenido en wd3 se guarda en la dirección determinada por wa3 siempre que la
señal we3 tenga valor ‘1’ y se detecte un flanco positivo de clock (escritura síncrona) .
Nota 3: La lectura de los datos de salida rd1 y rd2 es asíncrona.
Nota 4: Inicializar los registros X0 a X30 con los valores 0 a 30 respectivamente.
*/
module regfile (input logic clk, we3,
					input logic [4:0] ra1, ra2, wa3,
					input logic [63:0] wd3,
					output logic [63:0] rd1,
					output logic [63:0] rd2);
	logic [63:0] banco_registros [0:31] = '{
		64'd0 , 64'd1 , 64'd2 , 64'd3 , 64'd4 , 64'd5 , 64'd6 , 64'd7 , 64'd8 , 64'd9 ,
		64'd10, 64'd11, 64'd12, 64'd13, 64'd14, 64'd15, 64'd16, 64'd17, 64'd18, 64'd19,
		64'd20, 64'd21, 64'd22, 64'd23, 64'd24, 64'd25, 64'd26, 64'd27, 64'd28, 64'd29,
		64'd30, 64'd0
	};
	// Lectura asincrona.
	always_comb begin
		rd1 = banco_registros[ra1];
		rd2 = banco_registros[ra2];
	end
	/* Escribo en el registro wa3 el contenido de wd3 si es que me lo indica we3
		De lo contrario no. Escritura Sincrona
	*/
	always_ff @(posedge clk) begin
		// Mientras no escriba el registro XZR continuo sino no hago nada
		if (wa3 !== 5'b1_1111)begin
			if (we3 === 1'b1) banco_registros [wa3] = wd3;
		end
	end
	
endmodule
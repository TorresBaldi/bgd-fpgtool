# bgd-fpgtool

BennuGD tool to convert between folders of images and fpg files


## PARAMETROS:

	-c/-e (compilar/exportar)

	png folder

	fpg folder

	[color depth] ( 16/32 ) (solo en caso de compilar)


## EJEMPLOS

	compila todas las imagenes de fpg sources en fpg, a 16 bits
		fpg-tools -c fpg-sources fpg 16

	exporta todos los fpg de la carpeta fpg en exports
		fpg-tools -e exports fpg


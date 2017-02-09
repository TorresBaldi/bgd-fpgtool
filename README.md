# bgd-fpgtool

BennuGD tool to convert between folders of images and fpg files


## Parameters:

	-c/-e (compile / export)

	png folder

	fpg folder

	[color depth] ( 16/32 ) (solo en caso de compilar)


## Examples

	compiles into fpg files every folder of images from fpg-sources to fpg
		fpg-tools -c fpg-sources fpg 16

	exports every image of fpg files inside fpg folder out to exports folder
		fpg-tools -e exports fpg


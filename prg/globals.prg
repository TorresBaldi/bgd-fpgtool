//---------------------------------------------------------------------------------------

import "mod_draw";
import "mod_dir";
import "mod_map";
import "mod_proc";
import "mod_grproc";
import "mod_screen";
import "mod_say";
import "mod_text";
import "mod_file";
import "mod_video";
import "mod_string";
import "mod_debug";

//---------------------------------------------------------------------------------------

CONST

	ACTION_ERROR	= 0;
	ACTION_COMPILE	= 1;
	ACTION_EXPORT	= 2;

END

GLOBAL

	// accion elegida
	int action;

	// opciones, parametros
	int bits_depth = 32;
	string fpg_folder;
	string png_folder;

	// auxiliares de funciones
	int fpg;
	int i;
	int j;
	int result;
	string png_name;
	string fpg_name;
	string filename;
	string folder_name;

	// auxiliares de puntos de control
	string cp_name;
	string cp_line;
	int cp_handle;

	int point_x;
	int point_y;

	int first_comma_pos;
	int last_comma_pos;

END

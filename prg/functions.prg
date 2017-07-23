//---------------------------------------------------------------------------------------

FUNCTION compile_fpgs();

BEGIN

	LOOP

		// obtengo los nombres de las carpetas
		folder_name = glob ( png_folder + "*");

		// salgo del bucle al terminar
		if ( folder_name == "" )
			break;
		end

		// salteo el archivo si no es una carpeta
		if ( folder_name == "." or folder_name == ".." or fileinfo.directory == false )
			continue;
		end

		// creo el nuevo fpg vacio
		fpg = fpg_new();

		// agrego 1 a 1 los png
		FOR (i=1; i<= 999; i++)

			if ( file_exists ( png_folder + folder_name + "/" + i + ".png" ) )
				png_name = load_png( png_folder + folder_name + "/" + i + ".png" );
				fpg_add(fpg, i, 0, png_name);
				say("agregado " + i + ".png a fpg " + fpg + "(" + folder_name + ")");
			end

		END

		// cargo los puntos de control
		cp_name =  png_folder + folder_name + "/" + "cp.txt";

		if ( fexists(cp_name) )

			cp_handle = fopen( cp_name, O_READ );

			// "parseo" cada linea del archivo
			cp_line = fgets( cp_handle );
			WHILE ( cp_line <> "" )

				// grafico
				last_comma_pos = find(cp_line, ",");
				i = atoi(substr( cp_line, 0, last_comma_pos ));

				// punto de control
				first_comma_pos = last_comma_pos;
				last_comma_pos = find(cp_line, ",", first_comma_pos+1);
				j = atoi(substr( cp_line, first_comma_pos+1, last_comma_pos ));

				// posicion
				first_comma_pos = last_comma_pos;
				last_comma_pos = find(cp_line, ",", first_comma_pos+1);
				point_x = atoi( substr( cp_line, first_comma_pos+1, last_comma_pos ) );
				point_y = atoi( substr( cp_line, last_comma_pos+1) );

				//say("CP " + i + "-" + j + ": " + point_x + "," + point_y);

				if ( j )
					// establezco el punto de control
					point_set( fpg, i, j, point_x, point_y );
				else
					center_set( fpg, i, point_x, point_y );
				end

				// obtengo el siguiente punto
				cp_line = fgets( cp_handle );

			END

			fclose( cp_handle );

		end

		// guardo el fpg
		fpg_save(fpg, fpg_folder + folder_name + ".fpg");
		say ( "guardado: " + fpg_folder + folder_name + ".fpg" );

	END

END

//---------------------------------------------------------------------------------------

FUNCTION export_fpgs();

BEGIN

	LOOP

		// busco archivos FPG
		filename = glob ( fpg_folder + "*.fpg" );

		// si me quedo sin archivos salgo del bucle
		if ( filename == "" )
			break;
		end

		// sino, comienzo a exportar
		fpg = load_fpg( filename );

		say("----CARGADO " + filename + "...");

		// le saco la extension al filename
		folder_name = substr ( filename, 0, len(filename) - 4 );

		// creo una carpeta
		mkdir(png_folder);
		mkdir(png_folder + folder_name);

		// creo el archivo de puntos de control
		cp_name =  png_folder + folder_name + "/" + "cp.txt";
		cp_handle = fopen( cp_name, O_WRITE );

		// recorro el fpg y exporto todo como png
		FOR (i = 1; i <= 999; i++)

			if ( map_exists (fpg, i) )

				png_name =  png_folder + folder_name + "/" + i + ".png";

				png_save(fpg, i, png_name);

				say (png_name + " exportado...");

				// recorro los puntos de control
				for ( j=0; j<=999; j++ )

					if ( point_get( fpg, i, j, &point_x, &point_y ) )

						cp_line = i + ", " + j + ", " + point_x + ", " + point_y;
						fputs( cp_handle, cp_line );

					end

				end
			end

		END

		fclose( cp_handle );

		// descargo el fpg
		unload_fpg ( filename );

		say("");

	END

END

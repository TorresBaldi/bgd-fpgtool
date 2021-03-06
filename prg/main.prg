//---------------------------------------------------------------------------------------

BEGIN

	// say( "Current Directory: " + cd() );

	// establezco las opciones
	if ( argv[1] == "-e" )

		action = ACTION_EXPORT;

		png_folder = argv[2];
		fpg_folder = argv[3];

		if ( argv[4] <> "" )
			bits_depth = atoi( argv[4] );
		end

		say( "EXPORT, from " + fpg_folder + " to " + png_folder + ", color depth: " + bits_depth);

	else

		action = ACTION_COMPILE;

		if ( argv[1] == "-c" )
			i=1;
		end

		png_folder = argv[1+i];
		fpg_folder = argv[2+i];

		if ( argv[3+i] <> "" )
			bits_depth = atoi( argv[3+i] );
		end

		say( "COMPILE, from '" + png_folder + "/' to '" + fpg_folder + "/', color depth: " + bits_depth);

	end


	set_mode(320, 240, bits_depth, mode_window);

	png_folder += "/";
	fpg_folder += "/";

	// ejecuto las funciones
	SWITCH ( action )

		case ACTION_COMPILE:

			compile_fpgs();

		end

		case ACTION_EXPORT:

			export_fpgs();

		end

	END

END

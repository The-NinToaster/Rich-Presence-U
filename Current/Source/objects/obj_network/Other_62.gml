/// @description Baixar arquivo...
if(ds_map_find_value(async_load,"id") == network_file){

    //Se download finalizar (0) ou falhar (-1)...
    if(ds_map_find_value(async_load,"status") < 1){

        //Ler dados
        ini_open(folder+"dynamic.cfg");
	    global.redirect_plaforms = ini_read_string("URLS","platforms","hpps://");
	    global.redirect_about = ini_read_string("URLS","about","hpps://");
		global.update_version = ini_read_real("UPDATE","version",version);
		global.update_mandatory = ini_read_real("UPDATE","mandatory",0);
		global.update_download = ini_read_string("UPDATE","download","hpps://");
        ini_close();
		
        //Baixar plataformas
		event_user(0);
    }
}

if(ds_map_find_value(async_load,"id") == network_platform){

    //Se download finalizar (0) ou falhar (-1)...
    if(ds_map_find_value(async_load,"status") < 1){
		
        //Próxima...
		platform_index++;
		event_user(0);
    }
}
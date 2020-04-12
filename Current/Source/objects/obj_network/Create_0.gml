/// @description Checar networking
#macro version 51
#macro version_stg "0.5.1"
#macro folder game_save_id
if!(os_is_network_connected()){
	
	show_message("You need to be connected to the internet in order to use this application.");
	game_end();
}
else{

	network_file = noone;
	network_platform = noone;
	platform_index = 0;
	
	if(file_exists(program_directory+"\\redirect.cfg")){

	    //Redirecionamento customizado (Prioritario)
	    ini_open(program_directory+"\\redirect.cfg");
	    global.redirect_plaforms = ini_read_string("URLS","platforms","hpps://");
	    global.redirect_about = ini_read_string("URLS","about","hpps://");
		global.update_version = ini_read_real("UPDATE","version",version);
		global.update_mandatory = ini_read_real("UPDATE","mandatory",0);
		global.update_download = ini_read_string("UPDATE","download","hpps://");
	    ini_close();
		
		//Baixar plataformas
		event_user(0);
	}
	//Buscar por redirecionamento dinamico mais recente
	else
		network_file = http_get_file("https://github.com/MarioSilvaGH/Rich-Presence-U/raw/master/Assets/Network/dynamic.cfg",folder+"dynamic.cfg");
}
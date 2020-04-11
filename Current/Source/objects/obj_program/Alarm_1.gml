/// @description Atualizar RPC

//SE RPC estiver ligado...
if(richpresence_on == 1){

	//Desligar RPC se client tiver sido alterado
	if(gamelist_clientid != client_previous){

		discord_presence_shutdown();
		richpresence_wason = 0;
	}

	//Iniciar RPC se client for válido
	if(gamelist_clientid != "")
	&&(gamelist_clientid != "0"){
		
		//Ligar RPC
		if(richpresence_wason == 0){
			
			discord_presence_init(gamelist_clientid);
			richpresence_wason = 1;
		}
		
		//lembrar ultimo client
		client_previous = gamelist_clientid;
	}
	else{

		show_message("The client is not available, close the application and try again later.");
		exit;
	}
}
else
	exit;

//Status predefinido
if(gamelist_preset[global.rpc_gameindex] == "[DEFAULT]"){
	
	//Status + Online
	var _state, _andonline;
	if(global.rpc_statusonline == 1)
		_andonline = status_on;
	else
		_andonline = "";
	
	//Status (1P/2P)
	if(global.rpc_statusmode == 0)
		_state = status_1p+_andonline;
	else if(global.rpc_statusmode == 1)
		_state = status_2p+_andonline;
	else
		_state = global.rpc_statuscustom;

	//Incluir titulo (na descrição) e status predefinido
	discord_set_details(gamelist_title[global.rpc_gameindex]);
	discord_set_state(_state);
}
else{

	//SE predefinição de status for direcionada apenas ao titulo...
	if(gamelist_preset[global.rpc_gameindex] == "[TITLE]"){
		
		//Apenas incluir descrição customizada como título (se existir)
		if(global.rpc_statuscustom != "")
			discord_set_details(global.rpc_statuscustom);
		else
			discord_set_details("");
		
		//Não incluir status
		discord_set_state("");
	}
	else{
		
		//Inlcuir titulo (na descrição)
		discord_set_details(gamelist_title[global.rpc_gameindex]);
		
		//Incluir status customizado (se existir)
		if(global.rpc_statuscustom != "")
			discord_set_state(gamelist_preset[global.rpc_gameindex]+""+global.rpc_statuscustom);
		else
			discord_set_state("");
	}
}

//Icone grande (Jogo) + Versão
discord_set_image_large(string_add_zeros(global.rpc_gameindex,3));
discord_set_text_large("Rich Presence U - 0.5.0");

//Icone pequeno (User ID)
if(global.rpc_userid != ""){
	
	discord_set_image_small("nnid");
	
	//Formatação
	if(global.rpc_platform == 1)
		discord_set_text_small("SW-"+digits_to_friendcode(global.rpc_userid)); //Switch FC
	else if(global.rpc_platform == 2)
		discord_set_text_small(digits_to_friendcode(global.rpc_userid)); //3DS FC
	else
		discord_set_text_small(global.rpc_userid); //NNID
}
else{

	//Não incluir User ID se estiver vázio...
	discord_set_image_small("");
	discord_set_text_small("");
}

//Tempo de jogo
if(global.rpc_elapsedtime == 1)
	discord_set_timestamp_start(timestamp_saved);
else
	discord_set_timestamp_start(0);

//Lembrar ultimo jogo selecionado
game_previous = global.rpc_gameindex;

//Atualizar RPC
discord_presence_update();
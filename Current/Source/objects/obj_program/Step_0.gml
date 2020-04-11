/// @description Interatividade
#region Janelas

//Creditos
if(credits_display == 1){
	
	//Controles
	if(mouse_check_button_pressed(mb_any)){
		
		//Fechar
		if(point_in_rectangle(mouse_x,mouse_y,665,22,665+32,22+32))
			credits_display = 0;
	
		//Abrir página
		if(point_in_rectangle(mouse_x,mouse_y,129,14,129+433,14+92))
			url_open(global.redirect_about);
	}
}

//Plataformas
if(platforms_display == 1){

	//Controles
	if(mouse_check_button_pressed(mb_any)){
		
		var _choose = -1;
	
		if(point_in_rectangle(mouse_x,mouse_y,119,76,119+128,76+128)) _choose = 0; //Wii U
		if(point_in_rectangle(mouse_x,mouse_y,296,76,296+128,76+128)) _choose = 1; //Nintendo Switch
		if(point_in_rectangle(mouse_x,mouse_y,473,76,473+128,76+128)) _choose = 2; //Nintendo 3DS
		
		//Alterar
		if(_choose > -1){
			
			//Transição de cor
			uicolor_animation = 0;
			uicolor_a = global.rpc_platform;
			uicolor_b = _choose;
			
			//Salvar definições
			event_user(1);
		
			//Trocar de plataforma
			global.rpc_platform = _choose;
		
			//Carregar novas definições e lista de jogos
			event_user(2);
			event_user(0);
			
			platforms_display = 0;
		}
	}
}

//Exceções
if(credits_display != 0)||(credits_animation > 0)
||(platforms_display != 0)||(platforms_animation > 0)
	exit;

#endregion
#region Atalhos

//[ENTER] Atualizar RPC
if(keyboard_check_pressed(vk_enter))
&&(typing_gametitle == 0)
&&(updaterpc_animation == 0){
		
	//Forçar parada de digitação
	typing_customstatus = 0;
	typing_userid = 0;
	
	//Atualizar se estiver ligado
	updaterpc_animation = 3;
	if(richpresence_on == 1)
		alarm[1] = 1;
}

//[DELETE] Remover texto digitado
if(keyboard_check_pressed(vk_delete))
	keyboard_string = "";

//[ESCAPE] Fechar programa
if(keyboard_check_pressed(vk_escape))
	game_end();
	
#endregion
#region Cursor

if(mouse_check_button_released(mb_any))
&&(typing_gametitle == 0){

	//Forçar parada de digitação
	typing_customstatus = 0;
	typing_userid = 0;

	//Atualização
	if(point_in_rectangle(mouse_x,mouse_y,303,19,303+132,19+23))
	&&(global.update_version > version)
		url_open(global.update_download);

	//Creditos
	if(point_in_rectangle(mouse_x,mouse_y,446,19,446+23,19+23))
		credits_display = 1;
	
	//Plataforma
	if(point_in_rectangle(mouse_x,mouse_y,480,20,480+53,20+21))
		platforms_display = 1;

	//Jogo
	if(point_in_rectangle(mouse_x,mouse_y,27,52,27+512,52+38)){
		
		//Começar digitar título
		typing_gametitle = 2;
		typing_customstatus = 0;
		typing_userid = 0;

		//Limpar texto anterior existente
		keyboard_string = "";
	}

	//Status
	if(global.rpc_statusmode != 2)
	&&(gamelist_preset[global.rpc_gameindex] == "[DEFAULT]"){

		//Predefinidos
		if(point_in_rectangle(mouse_x,mouse_y,27,132,27+145,132+38)) global.rpc_statusmode = 0;
		if(point_in_rectangle(mouse_x,mouse_y,180,132,180+145,132+38)) global.rpc_statusmode = 1;
		if(point_in_rectangle(mouse_x,mouse_y,331,132,331+95,132+38)) global.rpc_statusonline =! global.rpc_statusonline;
	}
	else{
	
		//Custom
		if(point_in_rectangle(mouse_x,mouse_y,27,132,331+95,132+38)){
		
			//Começar digitar status
			typing_gametitle = 0;
			typing_customstatus = 1;
			typing_userid = 0;
			
			//Recuperar texto anterior existente
			keyboard_string = global.rpc_statuscustom;
		}
	}

	//Custom (Ativar / Desativar)
	if(point_in_rectangle(mouse_x,mouse_y,434,132,434+95,132+38))
	&&(gamelist_preset[global.rpc_gameindex] == "[DEFAULT]"){

		if(global.rpc_statusmode == 2)
			global.rpc_statusmode = 0;
		else
			global.rpc_statusmode = 2;
	}

	//Nintendo Network ID / Friend Code
	if(point_in_rectangle(mouse_x,mouse_y,21,206,21+355,206+38)){
		
		//Começar digitar user id
		typing_gametitle = 0;
		typing_customstatus = 0;
		typing_userid = 1;
		
		//Recuperar texto anterior existente
		keyboard_string = global.rpc_userid;
	}

	//Timestamp (Ativar / Desativar)
	if(point_in_rectangle(mouse_x,mouse_y,423,207,423+74,207+41))
		global.rpc_elapsedtime =! global.rpc_elapsedtime;
	
	//Desligar / Ligar RPC
	if(point_in_rectangle(mouse_x,mouse_y,546,190,546+70,190+70)){
		
		//Trocar
		richpresence_on =! richpresence_on;
		
		//Desligar quando necessário
		if(richpresence_wason == 1){
			
			discord_presence_shutdown();
			richpresence_wason = 0;
		}
	}
	
	//Atualizar RPC
	if(point_in_rectangle(mouse_x,mouse_y,628,190,628+70,190+70))
	&&(typing_gametitle == 0)
	&&(updaterpc_animation == 0){
	
		//Atualizar se estiver ligado
		updaterpc_animation = 3;
		if(richpresence_on == 1)
			alarm[1] = 1;
	}
}

#endregion
#region Digitar

//Clipboard
if(keyboard_check(vk_control)){

	//Colar
	if(keyboard_check_pressed(ord("V")))
		keyboard_string = clipboard_get_text();
	
	//Cópiar
	if(keyboard_check_pressed(ord("C")))
		clipboard_set_text(keyboard_string);
}

//Digitar custom status
if(typing_customstatus == 1){
	
	keyboard_string = string_copy(keyboard_string,0,64);
	global.rpc_statuscustom = keyboard_string;
}

//Digitar identificação
if(typing_userid == 1){

	//Nintendo Network ID / Friend Code
	if(global.rpc_platform == 1)
		keyboard_string = string_copy(string_digits(keyboard_string),0,12); //Switch FC
	else if(global.rpc_platform == 2)
		keyboard_string = string_copy(string_digits(keyboard_string),0,12); //3DS FC
	else
		keyboard_string = string_copy(keyboard_string,0,16); //NNID

	global.rpc_userid = keyboard_string;
}

#endregion
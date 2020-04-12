/// @description Interface
draw_set_font(fnt_default);

//Cor de fundo
uicolor_animation += (1-uicolor_animation)/8;
draw_set_color(merge_color(platform_color[uicolor_a],platform_color[uicolor_b],uicolor_animation));
draw_rectangle(0,0,720,280,0);
draw_set_color(c_white);

#region Layout Principal

//Base
draw_sprite(spr_layout,global.rpc_platform,0,0);

//Atualização
if(global.update_version > version)
	draw_sprite(spr_appupdate,0,303,19);

//Status (Custom)
var _custom;
if(global.rpc_statusmode == 2)||(gamelist_preset[global.rpc_gameindex] != "[DEFAULT]"){
	
	_custom = 1;

	//Exibir...
	if(global.rpc_statuscustom != "")
	||(typing_customstatus == 1){
		
		//Encaixar texto
		var _fit; 
		if(string_width(global.rpc_statuscustom) > 410)
			_fit = 410/string_width(global.rpc_statuscustom);
		else
			_fit = 1;
			
		//Texto + Blink
		var _txt;
		if(string_length(global.rpc_statuscustom) < 64)
		&&(typing_customstatus == 1)
			_txt = global.rpc_statuscustom+textblink_animation;
		else
			_txt = global.rpc_statuscustom;
	
		draw_text_transformed(21+8,129+10,_txt,_fit,1,0);
	}
	else{
	
		//Não definido
		draw_set_alpha(0.5);
		draw_text(21+8,129+10,"Type a custom status here.");	
		draw_set_alpha(1);
	}
}
else
	_custom = 0;

draw_sprite(spr_status,_custom,21,129);

//Status (Predefinido)
var _status;
if(global.rpc_statusmode == 1)
	_status = 299;
else
	_status = 152;

//1P / 2P
if(global.rpc_statusmode != 2)
&&(gamelist_preset[global.rpc_gameindex] == "[DEFAULT]")
	draw_sprite(spr_status_option,0,_status,144);

//Custom / Online
var _mode;
if(global.rpc_statusmode == 2)
||(gamelist_preset[global.rpc_gameindex] != "[DEFAULT]")
	_mode = 510;
else{
	
	if(global.rpc_statusonline == 1)
		_mode = 401;
	else
		_mode = -16;
}

//Apenas Custom
var _locked;
if(gamelist_preset[global.rpc_gameindex] != "[DEFAULT]")
	_locked = 1;
else
	_locked = 0;

draw_sprite(spr_status_option,1+_locked,_mode,143);
	
//Nintendo Network ID / Friend Code
var _userid;
if(typing_userid == 1)
&&(string_length(global.rpc_userid) < 16)
&&(global.rpc_platform == 0)
	_userid = global.rpc_userid+textblink_animation;
else{

	//Formatação
	if(global.rpc_platform == 1)
		_userid = "SW-"+digits_to_friendcode(global.rpc_userid); //Switch FC
	else if(global.rpc_platform == 2)
		_userid = digits_to_friendcode(global.rpc_userid); //3DS FC
	else
		_userid =  global.rpc_userid; //NNID
}

//Exibir
if(global.rpc_userid != "")
||(typing_userid == 1)
	draw_text(21+8,206+10,_userid);
else{

	//Não definido
	draw_set_alpha(0.5);
	draw_text(21+8,206+10,"Type your ID here.");	
	draw_set_alpha(1);
}

//Timestamp
draw_sprite(spr_elapsedtime,global.rpc_elapsedtime,423,207);

//Atualização do RPC
if(updaterpc_animation > 0)
	updaterpc_animation -= 0.05;
else
	updaterpc_animation = 0;

var _updated;
if(os_is_network_connected())
&&(richpresence_on == 1)
	_updated = 1; //Atualizado
else
	_updated = 0; //Não-atualizado

draw_sprite_ext(spr_rpcon,richpresence_on,546,186,1,1,0,c_white,1);
draw_sprite_ext(spr_rpcupdated,_updated,546,186,1,1,0,c_white,updaterpc_animation);

#endregion
#region Lista de jogos

//Icone
if(iconloading_display == 1){

	//Loading...
	iconloading_animation -= 8;
	draw_sprite_ext(spr_gameicon_loading,0,553+(139/2),27+(139/2),1,1,iconloading_animation,merge_color(platform_color[uicolor_a],platform_color[uicolor_b],uicolor_animation),1);
}
else{
	
	if(sprite_exists(game_icon))
		draw_sprite_stretched(game_icon,0,553,27,139,139);
}

//SE estiver digitando...
if(typing_gametitle != 0)
&&(credits_display == 0){
		
	//Nenhum jogo digitado
	if(keyboard_string == ""){
		
		draw_set_alpha(0.5)
		draw_text(21+16,52+10,"Keep typing to find a game.");
		draw_set_alpha(1);
	}
	
	//Encaixar texto
	var _fit; 
	if(string_width(keyboard_string) > 500)
		_fit = 500/string_width(keyboard_string);
	else
		_fit = 1;
	draw_text_transformed(21+8,52+10,keyboard_string+textblink_animation,_fit,1,0);
		
	//Buscar jogos
	_queue_total = 0;
	_queue_title[0] = "";
	_queue_pos[0] = 0;

	for(var i = 0; i < array_length_1d(gamelist_title); ++i){
	
		//SE encontrar um jogo que comece com as letras digitadas...
		if(string_pos(string_lower(keyboard_string),string_lower(gamelist_title[i])) > 0){
	
			//Parar se atingir máximo de 8 itens encontrados
			if(_queue_total == 8)
				break;
			
			//Adicionar a lista de encontrados
			_queue_title[_queue_total] = gamelist_title[i];
			_queue_pos[_queue_total] = i;
		
			//Próximo...
			_queue_total++;
		}
	}
		
	//Exibir títulos encotrados
	if(_queue_total > 0){
		
		//Fundo
		draw_rectangle(21,98,21+512,98+(20*_queue_total),0);
	
		//Selecionar o primeiro (atalho)
		if(keyboard_check_pressed(vk_enter)){
			
			//Carregar título
			global.rpc_gameindex = _queue_pos[0];
			game_titlecurrent = _queue_title[0];
			
			//Carregar icone
			iconloading_display = 1;
			if(sprite_exists(game_icon))
				sprite_delete(game_icon);
			game_icon = sprite_add(global.redirect_plaforms+target_titles+"/"+string_add_zeros(_queue_pos[0],3)+".png",0,0,0,0,0);
			
			//Gerar novo timestamp
			timestamp_getnew = 1;
			
			//Limpar texto digitado
			keyboard_string = "";
			
			//Finalizar
			typing_gametitle = 0;
		}
	}
	for(var j = 0; j < _queue_total; ++j){
		
		//Encaixar texto
		var _fit; 
		if(string_width(_queue_title[j]) > 490)
			_fit = 490/string_width(_queue_title[j]);
		else
			_fit = 1;
		
		//Exibir títulos
		draw_set_color(c_dkgray);
		draw_text_transformed(21+8,98+(20*j),_queue_title[j],_fit,1,0);
		draw_set_color(c_white);
		
		//Opções
		if(point_in_rectangle(mouse_x,mouse_y,21,98+(20*j),21+512,98+(20*j)+20)){
			
			//Fundo do item no cursor
			draw_set_color(c_lime);
			draw_set_alpha(0.3);
			draw_rectangle(21,98+(20*j),21+512,98+(20*j)+20,0);
			draw_set_color(c_white);
			draw_set_alpha(1);
		
			//Selecionar item no cursor
			if(mouse_check_button_released(mb_any))
			&&(typing_gametitle == 1){
				
				//Carregar título
				global.rpc_gameindex = _queue_pos[j];
				game_titlecurrent = _queue_title[j];
			
				//Carregar icone
				iconloading_display = 1;
				if(sprite_exists(game_icon))
					sprite_delete(game_icon);
				game_icon = sprite_add(global.redirect_plaforms+target_titles+"/"+string_add_zeros(_queue_pos[j],3)+".png",0,0,0,0,0);
			
				//Gerar novo timestamp
				timestamp_getnew = 1;
			
				//Limpar texto digitado
				keyboard_string = "";
			
				//Finalizar
				typing_gametitle = 0;
			}
		}
	}

	//Parar de digitar
	if(mouse_check_button_released(mb_any)){
	
		if(typing_gametitle == 1)
			typing_gametitle = 0;
	
		if(typing_gametitle == 2)
			typing_gametitle = 1;
	}
}
else{
	
	//Encaixar texto
	var _fit; 
	if(string_width(game_titlecurrent) > 490)
		_fit = 490/string_width(game_titlecurrent);
	else
		_fit = 1;
	draw_text_transformed(21+8,52+10,game_titlecurrent,_fit,1,0);
}

#endregion
#region Janela

//Fundo
draw_set_color(merge_color(platform_color[uicolor_a],platform_color[uicolor_b],uicolor_animation));
draw_set_alpha(clamp(credits_animation+platforms_animation,0,1));
draw_rectangle(0,0,720,280,0);
draw_set_color(c_white);
draw_set_alpha(1);
	
//Creditos
if(credits_display != 0)
	credits_animation += (1-credits_animation)/8;
else{
	
	if(credits_animation > 0)
		credits_animation -= 0.05;
	else
		credits_animation = 0;
}

draw_sprite(spr_credits,0,0,280+(-280*credits_animation));

//Plataformas
if(platforms_display != 0)
	platforms_animation += (1-platforms_animation)/8;
else{
	
	if(platforms_animation > 0)
		platforms_animation -= 0.05;
	else
		platforms_animation = 0;
}

draw_sprite(spr_platforms,0,0,280+(-280*platforms_animation));

#endregion
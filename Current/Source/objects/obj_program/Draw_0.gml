/// @description Interface
draw_set_font(fnt_default);

//Cor de fundo
if(global.rpc_platform == 0){
	
	//Wii U
	window_set_caption("Rich Presence U - Wii U mode");
	if(uicolor_animation > 0.05)
		uicolor_animation -= 0.05;
	else
		uicolor_animation = 0;	
}
else{
	
	//Nintendo Switch
	window_set_caption("Rich Presence U - Nintendo Switch mode");
	if(uicolor_animation < 1-0.05)
		uicolor_animation += 0.05;
	else
		uicolor_animation = 1;
}
var col1 = $C69400;
var col2 = $1A00F5;
draw_clear(merge_color(col1,col2,uicolor_animation));

#region Layout Principal

//Base
draw_sprite(spr_layout,global.rpc_platform,0,0);

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
	
//Nintendo Network ID / Swich Friend Code
var _userid;
if(typing_userid == 1)
&&(string_length(global.rpc_userid) < 16)
&&(global.rpc_platform == 0)
	_userid = global.rpc_userid+textblink_animation;
else{

	//Formatação
	if(global.rpc_platform == 0)
		_userid =  global.rpc_userid;
	else
		_userid = digits_to_switchfc(global.rpc_userid);
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
if(sprite_exists(spr_gameicon))
	draw_sprite_stretched(spr_gameicon,0,553,27,139,139);

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
			
			//Carregar título, icone e gerar novo timestamp
			global.rpc_gameindex = _queue_pos[0];
			game_titlecurrent = _queue_title[0];
			sprite_replace(spr_gameicon,folder+target_tiltes+"\\"+string_add_zeros(_queue_pos[0],3)+".jpg",0,0,0,0,0);
			timestamp_saved = discord_get_timestamp_now();
			
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
				
				//Carregar título, icone e gerar novo timestamp
				global.rpc_gameindex = _queue_pos[j];
				game_titlecurrent = _queue_title[j];
				sprite_replace(spr_gameicon,folder+target_tiltes+"\\"+string_add_zeros(_queue_pos[j],3)+".jpg",0,0,0,0,0);
				timestamp_saved = discord_get_timestamp_now();
			
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
#region Creditos

//Transição
if(credits_display == 0){
	
	//Fechar
	if(credits_animation > 0.10)
		credits_animation -= 0.10;
	else
		credits_animation = 0;	
}
else{
	
	//Abrir
	if(credits_animation < 1)
		credits_animation += (1-credits_animation)/10;
	else
		credits_animation = 1;
	
	//Controles
	if(mouse_check_button_pressed(mb_any)){
		
		//Abrir servidor no Discord
		if(point_in_rectangle(mouse_x,mouse_y,129,14,129+433,14+92))
			url_open("https://discordapp.com/invite/wZGW8DZ");
	
		//Fechar
		if(point_in_rectangle(mouse_x,mouse_y,665,22,665+32,22+32))
			credits_display = 0;
	}
}

//SE animação estiver se tornando vísivel...
if(credits_animation > 0){
	
	//Fundo
	draw_set_color(merge_color(col1,col2,uicolor_animation));
	draw_set_alpha(credits_animation);
	draw_rectangle(0,0,720,280,0);
	draw_set_color(c_white);
	draw_set_alpha(1);
	
	//Texto
	draw_sprite(spr_credits,0,0,280+(-280*credits_animation));
}

#endregion
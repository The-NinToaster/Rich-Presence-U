/// @description Carregar lista de jogos

//Plataforma
if(global.rpc_platform == 1) target_titles = "switch";
else if(global.rpc_platform == 2) target_titles = "3ds";
else target_titles = "wiiu";

//Carregar dados de títulos
ini_open(folder+target_titles+".ini");
gamelist_clientid = ini_read_string("RPU_CLIENT","CLIENT_ID",""); //Client do RPC
gamelist_total = 0;
for(var i = 0; i < 156; i++){

	//Buscar títulos encontrados
	gamelist_title[i] = ini_read_string("RPU_TITLE","TITLE_"+string_add_zeros(i,3),"");
	gamelist_preset[i] = ini_read_string("RPU_PRESET","PRESET_"+string_add_zeros(i,3),"[DEFAULT]");
	
	//SE não encontrar próximo... Parar
	if(gamelist_title[i] == "")
		break;
	else
		gamelist_total++;
}
ini_close();

//Pre-selecionar jogo na lista (se não ultrapassar limite)
if(global.rpc_gameindex > gamelist_total-1)
	game_titlecurrent = gamelist_title[gamelist_total-1];
else
	game_titlecurrent = gamelist_title[global.rpc_gameindex];

//Baixar icone do jogo selecionado
iconloading_display = 1;
if(sprite_exists(game_icon))
	sprite_delete(game_icon);
game_icon = sprite_add(global.redirect_plaforms+target_titles+"/"+string_add_zeros(global.rpc_gameindex,3)+".png",0,0,0,0,0);

//Gerar novo timestamp
timestamp_saved = discord_get_timestamp_now();
timestamp_getnew = 1;
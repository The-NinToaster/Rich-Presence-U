/// @description Carregar lista de jogos

//Plataforma
if(global.rpc_platform == 1)
	target_tiltes = "switch";
else
	target_tiltes = "wiiu";

//Carregar dados de títulos
ini_open(folder+target_tiltes+"\\titles.ini");
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

//Carregar icone do jogo selecionado
sprite_replace(spr_gameicon,folder+target_tiltes+"\\"+string_add_zeros(global.rpc_gameindex,3)+".jpg",0,0,0,0,0);
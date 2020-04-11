/// @description Boot

//Detalhes (Status) predefinidos
ini_open(working_directory+"preset_details.ini");
status_1p = ini_read_string("RPU_DETAILS","SINGLPLAYER","Single Player");
status_2p = ini_read_string("RPU_DETAILS","MULTIPLAYER","Multiplayer");
status_on = ini_read_string("RPU_DETAILS","ONLINE"," (Online)");
ini_close();

//Carregar definições
ini_open(folder+"rpc_settings.ini");
global.rpc_platform = ini_read_real("RPC_GLOBAL","platform",0);
ini_close();
event_user(2);

//Animações e elementos gráficos
uicolor_animation = 1;
uicolor_a = global.rpc_platform;
uicolor_b = global.rpc_platform;
credits_display = 0;
credits_animation = 0;
platforms_display = 0;
iconloading_display = 0;
iconloading_animation = 0;
platforms_animation = 0;
updaterpc_animation = 0;
textblink_animation = "|";
alarm[0] = 15;

//Cores
platform_color[0] = $C69400; //Wii U
platform_color[1] = $1A00F5; //Switch
platform_color[2] = $1F1F1F; //3DS

//Lembrar definições
richpresence_on = 1;
richpresence_wason = 0;
timestamp_saved = 0;
client_previous = "";
game_previous = 0;
game_titlecurrent = "";

//Digitar
typing_gametitle = 0;
typing_customstatus = 0; //64 digitos
typing_userid = 0; //12~16 digitos

//Carregar lista de jogos
game_icon = sprite_duplicate(spr_gameicon);
event_user(0);

//Gerar novo timestamp
timestamp_saved = discord_get_timestamp_now();
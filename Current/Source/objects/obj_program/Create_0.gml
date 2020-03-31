/// @description Boot
#macro folder working_directory
#macro version "0.4.3"

//Animações e elementos gráficos
credits_display = 0;
credits_animation = 0;
uicolor_animation = 0.5;
updaterpc_animation = 0;
textblink_animation = "|";
alarm[0] = 15;

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

//Detalhes (Status) predefinidos
ini_open(folder+"preset_details.ini");
status_1p = ini_read_string("RPU_DETAILS","SINGLPLAYER","Single Player");
status_2p = ini_read_string("RPU_DETAILS","MULTIPLAYER","Multiplayer");
status_on = ini_read_string("RPU_DETAILS","ONLINE"," (Online)");
ini_close();

//Carregar definições
ini_open(folder+"usersettings.ini");
global.rpc_platform = ini_read_real("RPC_GLOBAL","platform",0);
ini_close();
event_user(2);

//Carregar lista de jogos
event_user(0);

//Gerar novo timestamp
timestamp_saved = discord_get_timestamp_now();
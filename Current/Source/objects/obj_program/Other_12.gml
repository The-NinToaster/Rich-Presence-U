/// @description Definições | Carregar
ini_open(folder+"usersettings.ini");
if(global.rpc_platform == 1){

	//Nintendo Switch
	global.rpc_gameindex = ini_read_real("RPC_NS","gameindex",0);
	global.rpc_userid = ini_read_string("RPC_NS","nintendoid","");
	global.rpc_elapsedtime = ini_read_real("RPC_NS","elapsedtime",0);
	global.rpc_statusmode = ini_read_real("RPC_NS","status_singlemulti",2);
	global.rpc_statusonline = ini_read_real("RPC_NS","status_online",0);
	global.rpc_statuscustom = ini_read_string("RPC_NS","status_custom","");
	
}
else if(global.rpc_platform == 2){

	//3DS
	global.rpc_gameindex = ini_read_real("RPC_3DS","gameindex",0);
	global.rpc_userid = ini_read_string("RPC_3DS","nintendoid","");
	global.rpc_elapsedtime = ini_read_real("RPC_3DS","elapsedtime",0);
	global.rpc_statusmode = ini_read_real("RPC_3DS","status_singlemulti",0);
	global.rpc_statusonline = ini_read_real("RPC_3DS","status_online",0);
	global.rpc_statuscustom = ini_read_string("RPC_3DS","status_custom","");
}
else{

	//Wii U
	global.rpc_gameindex = ini_read_real("RPC_WIIU","gameindex",0);
	global.rpc_userid = ini_read_string("RPC_WIIU","nintendoid","");
	global.rpc_elapsedtime = ini_read_real("RPC_WIIU","elapsedtime",0);
	global.rpc_statusmode = ini_read_real("RPC_WIIU","status_singlemulti",0);
	global.rpc_statusonline = ini_read_real("RPC_WIIU","status_online",0);
	global.rpc_statuscustom = ini_read_string("RPC_WIIU","status_custom","");
}
ini_close();
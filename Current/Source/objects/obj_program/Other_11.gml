/// @description Definições | Salvar
ini_open(folder+"rpc_settings.ini")
ini_write_real("RPC_GLOBAL","platform",global.rpc_platform);
if(global.rpc_platform == 1){
	
	//Nintendo Switch
	ini_write_real("RPC_SWITCH","gameindex",global.rpc_gameindex);
	ini_write_string("RPC_SWITCH","nintendoid",global.rpc_userid);
	ini_write_real("RPC_SWITCH","elapsedtime",global.rpc_elapsedtime);
	ini_write_real("RPC_SWITCH","status_singlemulti",global.rpc_statusmode);
	ini_write_real("RPC_SWITCH","status_online",global.rpc_statusonline);
	ini_write_string("RPC_SWITCH","status_custom",global.rpc_statuscustom);
}
else if(global.rpc_platform == 2){

	//3DS
	ini_write_real("RPC_3DS","gameindex",global.rpc_gameindex);
	ini_write_string("RPC_3DS","nintendoid",global.rpc_userid);
	ini_write_real("RPC_3DS","elapsedtime",global.rpc_elapsedtime);
	ini_write_real("RPC_3DS","status_singlemulti",global.rpc_statusmode);
	ini_write_real("RPC_3DS","status_online",global.rpc_statusonline);
	ini_write_string("RPC_3DS","status_custom",global.rpc_statuscustom);
}
else{
	
	//Wii U
	ini_write_real("RPC_WIIU","gameindex",global.rpc_gameindex);
	ini_write_string("RPC_WIIU","nintendoid",global.rpc_userid);
	ini_write_real("RPC_WIIU","elapsedtime",global.rpc_elapsedtime);
	ini_write_real("RPC_WIIU","status_singlemulti",global.rpc_statusmode);
	ini_write_real("RPC_WIIU","status_online",global.rpc_statusonline);
	ini_write_string("RPC_WIIU","status_custom",global.rpc_statuscustom);	
}
ini_close();
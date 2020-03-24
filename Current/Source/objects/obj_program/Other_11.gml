/// @description Definições | Salvar
ini_open(folder+"usersettings.ini")
ini_write_real("RPC_GLOBAL","platform",global.rpc_platform);
if(global.rpc_platform == 0){
	
	//Wii U
	ini_write_real("RPC_WIIU","gameindex",global.rpc_gameindex);
	ini_write_string("RPC_WIIU","nintendoid",global.rpc_userid);
	ini_write_real("RPC_WIIU","elapsedtime",global.rpc_elapsedtime);
	ini_write_real("RPC_WIIU","status_singlemulti",global.rpc_statusmode);
	ini_write_real("RPC_WIIU","status_online",global.rpc_statusonline);
	ini_write_string("RPC_WIIU","status_custom",global.rpc_statuscustom);
}
else{

	//Nintendo Switch
	ini_write_real("RPC_NS","gameindex",global.rpc_gameindex);
	ini_write_string("RPC_NS","nintendoid",global.rpc_userid);
	ini_write_real("RPC_NS","elapsedtime",global.rpc_elapsedtime);
	ini_write_real("RPC_NS","status_singlemulti",global.rpc_statusmode);
	ini_write_real("RPC_NS","status_online",global.rpc_statusonline);
	ini_write_string("RPC_NS","status_custom",global.rpc_statuscustom);
}
ini_close();
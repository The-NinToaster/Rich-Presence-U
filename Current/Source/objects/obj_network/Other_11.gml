/// @description Iniciar programa

//Atualização obrigatória
if(global.update_version > version)
&&(global.update_mandatory == 1){

	var _getupdate = show_question("A new update is available, this update is necessary for the application to continue working. You will be redirected to the download page by pressing 'Yes'.");
	if(_getupdate == 1)
		url_open(global.update_download);
	game_end();
}
else
	room_goto(rm_program);
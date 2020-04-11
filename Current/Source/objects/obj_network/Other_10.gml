/// @description Baixar plataformas
var _target = "";
if(platform_index < 3){
	
	//Plataforma alvo
	if(platform_index == 2) _target = "switch";
	else if(platform_index == 0) _target = "3ds";
	else _target = "wiiu";
}

//Baixar arquivo
if(_target != "")
	network_platform = http_get_file(global.redirect_plaforms+_target+".ini",folder+_target+".ini");
else
	event_user(1);
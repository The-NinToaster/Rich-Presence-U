/// @description Icone | Loading...
if(ds_map_find_value(async_load, "id") == game_icon){
	
	if(ds_map_find_value(async_load, "status") >= 0){
	
		//Finalizado
		iconloading_display = 0;
		iconloading_animation = 0;
	}
}
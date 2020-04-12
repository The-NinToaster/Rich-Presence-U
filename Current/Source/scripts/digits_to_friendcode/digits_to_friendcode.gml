var _stg_base = "____-____-____";
for(var i = 0; i < 12; i++){
	
	if(i < string_length(argument0))
	&&(argument0 != "")
		_stg_base = string_replace(_stg_base,"_",string_char_at(argument0,i+1));
	else
		break;
}
return _stg_base;
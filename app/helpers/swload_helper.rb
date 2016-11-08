module SwloadHelper

 def ne_status ne
		if ne[:isOnline]
	  	raw '<span class="ne-status glyphicon glyphicon-ok">  </span>'
		else
	  	raw '<span class="ne-status glyphicon glyphicon-remove">  </span>'
		end
	end
end

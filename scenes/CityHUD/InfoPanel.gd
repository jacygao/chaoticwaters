extends Panel

func set_name(val:String):
	$Name.text = val

func set_economy(val:int):
	$Economy/Number.text = String(val)
	
func set_defence(val:int):
	$Defense/Number.text = String(val)

func set_population(val:int):
	$Population/Number.text = String(val)

func set_forces(forces:Dictionary):
	$ForcePanel.render(forces)

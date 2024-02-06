type tokenExchange = {
	[string]: string
}

export type UVSettings = {
	tokenExchange: tokenExchange?
}

export type Transition = {
	duration: number?,
	delay: number?,
	reverses: boolean?,
	repeatCount: number?,
	easingStyle: Enum.EasingStyle?,
	easingDirection: Enum.EasingDirection?,
}

export type UVAnim = {
	propertyChange: {[string]: any},
	transition: {
		duration: number?,
		delay: number?,
		reverses: boolean?,
		repeatCount: number?,
		easingStyle: Enum.EasingStyle?,
		easingDirection: Enum.EasingDirection?,
	},
	objects: {Instance},
}

export type Element = {
	Properties: {
		[string]: any
	}?,

	Children: {
		Element?
	}?,

	Events: {
		[string]: any
	}?,

	Animations: {
		
	}?,
	
	Arguments: {
		
	}?,
	
	onConstruction: (newObject: Instance) -> ()?
}

export type elementInternal = {
	Object: {
		className: string | {},
		object: Element,
	},

	Properties: {},
	Children: {},
	Events: {},
	Animations: {},
	Arguments: {},
	onConstruction: (newObject: Instance) -> ()
}

return nil
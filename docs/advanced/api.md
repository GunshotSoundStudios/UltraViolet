# Api Reference

This section contains a description and example code for every - single function, and type, in UltraViolet. Feel free to scroll and find the function you need.

# Engine:

## CreateElement

`UltraViolet.CreateElement()`

`(className: string | component, objectConfig: element)`

`-> META_DATA (Element Class)`

    - Creates an element. Takes either a className, or a component in,
     with a configuration file. Returns the element class.

## CreateFragmentation

`UltraViolet.CreateFragmentation()`

`(data: {className: string | component, objectConfig: element})`

`-> META_DATA (Element Class)`

    - Creates a fragment. Like Elements, but stored in an array.

    
## Setup

`UltraViolet.Setup()`

`(settings: uvSettings?)`

`-> META_DATA (Engine Class)`

    - Changes the configuration files.


# Element

## Construct

`Element:Construct()`

`(constructor: instance?)`

`-> instance?`

    - Renders the object to the screen.

## ConstructFragment

`Element:ConstructFragment()`

`(constructor: instance?)`

`-> instance?`

    - Renders the fragments to the screen.

# Animation

## TransitionNew

`Animation.Transition.new()`

`(data: transition?)`

`-> transition`

    - Creates a transition from the set data.

## AnimationNew

`Animation.new()`

`(data: {[string]: any}, transition: Transition)`

`-> animation`

    - Creates an animation from the set data.

## AnimationEdit

`Animation:Edit()`

`(replaceEntireOfPrevious: boolean, canUpdateValues: boolean, callbackArgs: {data: {[string]: any}?, transition: Transition?})`

`-> nil`

    - Edits the current animation during runtime.

## AnimationPlay

`Animation:Play()`

`()`

`-> nil`

    - Plays an animation.

## AndThen

`Animation:AndThen()`

`(callback: () -> ())`

`-> nil`

    - Creates a callback function that will be ran after Animation:Play().


# Component

## Create

`Component:Create()`

`(componentName: string)`

`-> component`

    - Creates a component.

## SetState

`Component:SetState()`

`(data: {[string]: any} | (state: any) -> ({[string]: any}))`

`-> {state}`

    - Creates states / Creates a new state.

## GetStates

`Component:GetStates()`

`()`

`-> {state}`

    - Returns all current appended states.


## GetStateFromName

`Component:GetStateFromName()`

`(stateName: string)`

`-> any | nil`

    - Returns the state given from the state name.

## GetStatesFromValue

`Component:GetStatesFromValue()`

`(stateValue: any)`

`-> {any} | nil`

    - Returns an array of states based on a value.


## RemoveState

`Component:RemoveState()`

`(stateName: string)`

`-> nil`

    - Removes a state based off the state name.

## Types

```lua
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
```






local composer = require( "composer" )
local scene = composer.newScene()

-- "scene:create()"
function scene:create( event )
	local sceneGroup = self.view
	-- Create the particle system
end

-- "scene:show()"
function scene:show( event )

	local sceneGroup = self.view
	--startTimer = timer.performWithDelay( 500, blink, 0 )

	if ( phase == "will" ) then
	-- Called when the scene is still off screen (but is about to come on screen).
	-- Add all physics objects
	
	elseif ( phase == "did" ) then
	-- Called when the scene is now on screen.
	-- Insert code here to make the scene come alive.
	-- Example: start timers, begin animation, play audio, etc.
	end
end

-- "scene:hide()"
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
	-- Called when the scene is on screen (but is about to go off screen).
	-- Insert code here to "pause" the scene.
	-- Example: stop timers, stop animation, stop audio, etc.
	elseif ( phase == "did" ) then
	-- Called immediately after scene goes off screen.
	end
end

-- "scene:destroy()"
function scene:destroy( event )

	local sceneGroup = self.view
-- Called prior to the removal of scene's view ("sceneGroup").
-- Insert code here to clean up the scene.
-- Example: remove display objects, save state, etc.
end

---------------------------------------------------------------------------------

local function onKeyPress( event )
	local phase = event.phase
	local keyName = event.keyName

	if (phase == "down" and sceneActive == true) then
		change_scene( scenes_directory .. ".story", 1000, {} )
	end

	return false
end
Runtime:addEventListener( "key", onKeyPress )
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene

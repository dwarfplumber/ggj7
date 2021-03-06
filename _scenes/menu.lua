local composer = require "composer"
local widget = require "widget"
local scene = composer.newScene()
local display_group = nil


local function handleButtonEvent( event )

    if ( "ended" == event.phase ) then
		composer.gotoScene( scenes_directory .. ".select")
    end
end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

local background
local title
local display_group

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    background = display.newImageRect( sceneGroup, "_gfx/action/backdrops/titleScreen.jpg", dcw, dch )
    background.x, background.y = dccx, dccy
    title = display.newImageRect( sceneGroup, "_gfx/ui/title.png", 724, 259 )
    title.x, title.y = dccx, dccy
    display_group = display.newGroup( )
    sceneGroup:insert( display_group )

end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        --display.newImage( display_group,  string, dcw/2, dch/2, true )
        local button = widget.newButton(
			{
				width =  300,
				height = 100,
				defaultFile = ui_gfx_directory.."buttons/go_button1.png",
				overFile = ui_gfx_directory.."buttons/go_button2.png",
				label = "",
				onEvent = handleButtonEvent
			}
		)
		button.x = dcw/2
		button.y = dch*3/4
		display_group:insert( button )
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		--display_group:removeSelf( )
		scene:destroy()

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene

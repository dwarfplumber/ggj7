
basicAttackSound = audio.loadSound("_audio/Basic Attack.ogg")
jumpSound = audio.loadSound("_audio/Jump.ogg")

local screams = {}
for i = 1, 5,1 do
	screams[i] = audio.loadSound("_audio/ManScream0"..i..".ogg")
end

function scream()
	audio.play(screams[math.random(5)])
end
-- All attacks should be under 1000 ms
function attack( attacker, attacked, attackType, direction )
	attackAnimation[attackType]( attacker, attacked, direction )
end



-- BASIC STRIKE ANIMATIONS

function basicStrike( obj, attacked, direction )
	local origin = obj.x

    transition.to( obj, { time = 500, x = 300*direction, delta = true, onComplete = function( )
        transition.to( obj, { time = 50, x = 300*direction, delta = true, onComplete = function( )
						audio.play(basicAttackSound)
            transition.to( obj, {time = 300, x = origin } )
            do_shake_obj( attacked, 3 )
						scream()
        end } )
    end } )
end

function leapAttack( obj, attacked, direction )
	local returnpoint = {obj.x,obj.y}
	local curve = generate_curve(8,{
																{x = obj.x, y = obj.y},
																{x = obj.x, y = obj.y-100},
																{x = obj.x+(100*direction), y = obj.y-300},
																{x = obj.x+(400*direction),y = obj.y-300} })
	audio.play(jumpSound)
  transition_curve(obj,curve,{ time = 400, speed = 0.1, onComplete = function()
		transition.to(obj,{time = 70, x = attacked.x,y = attacked.y,onComplete = function()
      transition.to( obj, { time = 300, x = returnpoint[1], y = returnpoint[2]})
			audio.play(basicAttackSound)
      do_shake_obj( attacked, 3 )
			scream()
		end } )
  end },1 )
end

function groundPound( obj, attacked, direction )

	local origin = obj.x
		poundSound = audio.loadSound("_audio/GroundPound.ogg")
		audio.play(poundSound)
    transition.to( obj, { time = 300, y = -200, delta = true, onComplete = function()
        transition.to( obj, { time = 50, y = 200, delta = true, onComplete = function()
            transition.to( obj, {time = 200, x = origin } )
            do_shake_obj( attacked, 5 )
						scream()
        end } )
    end } )
end

function dashAttack( obj, attacked, direction )

	local origin = obj.x

    transition.to( obj, { time = 200, x = 300*direction, delta = true, onComplete = function( )
        transition.to( obj, { time = 20, x = 300*direction, delta = true, onComplete = function( )
            transition.to( obj, {time = 200, x = origin } )
            do_shake_obj( attacked, 3 )
						scream()
        end } )
    end } )
end

function growthAttack( obj, attacked, direction )
	local origin = obj.x
		grunt = audio.loadSound("_audio/maleGrunt03.ogg")
		audio.play(grunt)
    transition.scaleTo( obj, { xScale = 1.2,yScale = 1.2,time = 200, onComplete = function( )
			transition.scaleTo(obj,{time = 200,xScale = 1,yScale = 1})
		end } )
end

function CHARGE(obj, attacked, direction)
	local origin = obj.x
	local lance = display.newImageRect(obj,"_gfx/action/players/lance"..1+direction..".png",544,56)
	lance.fill.effect = "filter.brightness"
	lance.fill.effect.intensity = 1
	lance.alpha = 0
	lance.anchorX = direction*-1
	lance.x = -66*direction
	lance.y = -56
	CHARGESOUND = audio.loadSound("_audio/CHARGE.ogg")
	audio.play(CHARGESOUND)
		transition.to(lance, {time = 200, alpha = 1, onComplete = function()
			transition.to(lance.fill.effect, {time = 200,intensity = 0 })
			end } )

		transition.to( obj, { time = 800, x = -100*direction, delta = true, onComplete = function( )
				transition.to( obj, { time = 100, x = 800*direction, delta = true, onComplete = function( )
						audio.play(basicAttackSound)
						transition.to( obj, {time = 200, x = origin } )
						do_shake_obj( attacked, 3 )
						scream()
						lance:removeSelf()
						lance = nil
				end } )
		end } )
end


function do_shake_obj( obj, count )
    if not count then count = 1 end

    if count > 0 then
        shake_obj( obj, function( ) do_shake_obj( obj, count-1 ) end )
    end
end

function shake_obj( obj, onComplete )

	local origin = obj.x

    transition.to( obj, { time = 20, x = 10, delta = true, onComplete = function( )
        transition.to( obj, { time = 40, x = -20, delta = true, onComplete = function( )
            transition.to( obj, {time = 20, x = origin, onComplete = onComplete } )
        end } )
    end } )
end

attackAnimation = {
	--LEAP ATTACK ANIMATION
	["Basic Strike"] = basicStrike,
	["Leap Attack"] = leapAttack,
	["Ground Pound"] = groundPound,
	["Dash"] = dashAttack,
	["Rage"] = growthAttack,
	["CHARGE"] = CHARGE
}

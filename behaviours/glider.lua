max = spec:get_float('glider/max')

function dispatch (event)
end

function update (ticks)
	if math.sqrt(math.pow(sprite.pos.x - projectile.origin.x, 2) + math.pow(sprite.pos.y - projectile.origin.y, 2)) > max then
		projectile:kill()
	end

	if sprite.pos.x >= world.width - sprite.width or sprite.pos.x <= 0 or sprite.pos.y >= world.height - sprite.height or sprite.pos.y <= 0 then
		projectile:kill()
	end
end

function create ()
end

function destroy ()
end
player = {}
player.angle = 0
player.map_x = 300
player.map_y = 400
player.screen_x = 0
player.screen_y = 0
player.sf_x = 0.1
player.sf_y = 0.1
player.imageno = 1
player.image_ctr = 0

function love.load()
    player.screen_x = love.graphics.getWidth() / 2
    player.screen_y = love.graphics.getHeight() / 2

    player.images = {}
    player.images[1] = love.graphics.newImage("bike-straight_1.png")
    player.images[2] = love.graphics.newImage("bike-straight_2.png")
    
end

function love.update(dt)
    if  player.image_ctr >= 30 then
        player.imageno = (player.imageno % 2) + 1
        player.image_ctr = 1
    else
        player.image_ctr = player.image_ctr + 1
    end

    if love.keyboard.isDown('up') or love.keyboard.isDown('w') then
        player.map_x = player.map_x - math.sin(player.angle)
        player.map_y = player.map_y - math.cos(player.angle)
    elseif love.keyboard.isDown('down') or love.keyboard.isDown('s') then
        player.map_x = player.map_x + math.sin(player.angle)
        player.map_y = player.map_y + math.cos(player.angle)
    end

    if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        player.angle = player.angle + 0.01
    elseif love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        player.angle = player.angle - 0.01
    end
end

function love.draw()

    -- Translate so player is at the origin
    love.graphics.translate(player.screen_x, player.screen_y)
    -- Rotate to map angle
    love.graphics.rotate(player.angle)
    -- Translate so player isn't at the origin
    love.graphics.translate(-player.screen_x, -player.screen_y)

    -- Translate to map coordinates
    love.graphics.translate(-player.map_x, -player.map_y)
    -- Draw everything else
    love.graphics.rectangle('fill', 300, 400, 30, 200)
    -- Translate from map coordinates
    love.graphics.translate(player.map_x, player.map_y)

    -- Translate so player is at the origin
    love.graphics.translate(player.screen_x, player.screen_y)
    -- Rotate to map angle
    love.graphics.rotate(-player.angle)
    -- Translate so player isn't at the origin
    love.graphics.translate(-player.screen_x, -player.screen_y)

    -- Draw player
    love.graphics.draw(player.images[player.imageno],
            player.screen_x - player.images[player.imageno]:getWidth() * player.sf_x / 2, 
            player.screen_y - player.images[player.imageno]:getHeight() * player.sf_y / 2,
            0,  player.sf_x, player.sf_y)

    -- Translate so player is at the origin
    love.graphics.translate(player.screen_x, player.screen_y)
    -- Rotate to map angle
    love.graphics.rotate(-player.angle)
    -- Translate so player isn't at the origin
    love.graphics.translate(-player.screen_x, -player.screen_y)



end


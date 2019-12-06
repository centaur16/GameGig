require 'tourism'

player = {}
player.angle = 0
player.actual_x = 300
player.actual_y = 400
player.map_x = 300
player.map_y = 400
player.screen_x = 0
player.screen_y = 0
player.sf_x = 0.1
player.sf_y = 0.1
player.imageno = 1
player.image_ctr = 0

player.f_speed = 3
player.b_speed = 1

player.score = 0

objects = {}
objects.circle_x = 300
objects.circle_y = 300
objects.circle_radius = 50

tourists = {}

function love.load()
    player.screen_x = love.graphics.getWidth() / 2
    player.screen_y = love.graphics.getHeight() / 2
    
    rotated_screen_vector = rotate_vector(player.screen_x, player.screen_y, player.angle )
    player.actual_x = player.map_x + rotated_screen_vector[1]
    player.actual_y = player.map_y + rotated_screen_vector[2]

    player.images = {}
    player.images[1] = love.graphics.newImage("bike-straight_1.png")
    player.images[2] = love.graphics.newImage("bike-straight_2.png")

    love.graphics.setBackgroundColor(0.96, 0.97, 0.86)

    for i=1, 50, 1 do
        t = new_tourist("tourist.png", player.map_x, player.map_y, player.map_x+300, player.map_y+300, 0.0)
        table.insert(tourists, t)
    end
    print(#tourists)
end

function rotate_vector(x, y, theta)
    new_x = x * math.cos(theta) - y * math.sin(theta)
    new_y = x * math.sin(theta) + y * math.cos(theta)
    return {x, y}
end

function collided_with_circle()
    dist = euclidean_distance(player.actual_x, player.actual_y, objects.circle_x, objects.circle_y) 
    return dist < objects.circle_radius
end 

function euclidean_distance(x1, y1, x2, y2)
    return math.sqrt(math.pow(x1-x2, 2) + math.pow(y1-y2, 2))
end

function love.update(dt)
    if  player.image_ctr >= 10 then
        player.imageno = (player.imageno % 2) + 1
        player.image_ctr = 1
    else
        player.image_ctr = player.image_ctr + 1
    end

    if love.keyboard.isDown('up') or love.keyboard.isDown('w') then
        player.map_x = player.map_x - player.f_speed * math.sin(player.angle)
        player.map_y = player.map_y - player.f_speed * math.cos(player.angle)
    elseif love.keyboard.isDown('down') or love.keyboard.isDown('s') then
        player.map_x = player.map_x + player.b_speed * math.sin(player.angle)
        player.map_y = player.map_y + player.b_speed * math.cos(player.angle)
    end

    if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        player.angle = player.angle + 0.01
    elseif love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        player.angle = player.angle - 0.01
    end


    -- Update actual coordinates for player
    rotated_screen_vector = rotate_vector(player.screen_x, player.screen_y, player.angle )
    player.actual_x = player.map_x + rotated_screen_vector[1]
    player.actual_y = player.map_y + rotated_screen_vector[2]

    for i=1, #tourists, 1 do
        tourist_shuffle(tourists[i], dt)
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
    love.graphics.circle('fill', objects.circle_x, objects.circle_y, objects.circle_radius)

    for i=1, #tourists, 1 do
        tourist_draw(tourists[i])
    end
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


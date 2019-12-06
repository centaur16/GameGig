function new_tourist(image, street_x, street_y, street_width, street_height, street_angle)
    local tourist = {}
    local x = math.random(0, street_width)
    local y = math.random(0, street_height)

    tourist.image = love.graphics.newImage(image)
    tourist.map_x = street_x + x * math.cos(street_angle) - y * math.sin(street_angle)
    tourist.map_y = street_y + x * math.sin(street_angle) + y * math.cos(street_angle)
    tourist.speed = 0.1
    tourist.direction = math.random(-3.0, 3.0)

    return tourist
end

function tourist_shuffle(tourist, dt)
    local num = math.random()
    if num < 0.1 then
        local angle = math.random(-0.001, 0.001)
        tourist.direction = tourist.direction + angle
    end
    tourist.map_x = tourist.map_x - tourist.speed * math.sin(tourist.direction)
    tourist.map_y = tourist.map_y - tourist.speed * math.cos(tourist.direction)
end

function tourist_draw(tourist)
    love.graphics.draw(tourist.image, tourist.map_x, tourist.map_y, tourist.direction, .3, .3)
end

function is_touching(tourist, player_x, player_y)
    return euclidian_distance(tourist.map_x, tourist.map_y, player_x, player_y) < 10
end

function teleport(tourist) 
    tourist.map_x = math.random(300, 500)
    tourist.map_y = math.random(300, 500)
end

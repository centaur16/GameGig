function new_tourist(image, street_x, street_y, street_width, street_height, street_angle)
    tourist = {}
    local x = math.random(0, street_width)
    local y = math.random(0, street_height)

    tourist.map_x = street_x + x * math.cos(angle) - y * math.sin(angle)
    tourist.map_y = street_y + x * math.sin(angle) + y * math.cos(angle)
    tourist.speed = 0.5
    tourist.direction = 0.0
end

function tourist_shuffle(tourist, dt)
    local angle = math.random(0.5, 0.5)

    tourist.map_x = tourist.map_x - tourist.speed * math.sin(tourist.angle)
    tourist.map_y = tourist.map_y - tourist.speed * math.cos(tourist.angle)
end


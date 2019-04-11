function result = decision_tree(features)
lakes = features(1);
bays = features(2);
direction = features(3);
result = -1;

if(bays == 0)
    if(lakes == 0)
        result = 1;
    else
        result = 0;
    end
elseif(bays == 1)
    if(lakes == 0)
        result = 7;
    else
        result = 6;
    end
elseif(bays == 2)
    if(direction == -1)
        result = 2;
    elseif(direction == 1)
        if(lakes == 0)
            result = 5;
        elseif(lakes == 1)
            result = 9;
        elseif(lakes == 2)
            result = 8;
        end
    end
elseif(bays == 3)
    if(direction == -1)
        if(lakes == 0)
            result = 3;
        elseif(lakes == 1)
            result = 2;
        end
    elseif(direction == 1)
        result = 4;
    end
elseif(bays == 4)
    result = 4;
end
end
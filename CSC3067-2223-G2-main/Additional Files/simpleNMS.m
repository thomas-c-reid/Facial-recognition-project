function Objects = simpleNMS(Objects,threshold)

count = 1;
boxesToRemove = zeros(35,1);
for box1Index=1:size(Objects,1)
%     if box1Index == 698
%         disp(box1Index)
%     end
    for box2Index=1:size(Objects,1)
%         if box2Index == 2689
%             disp(box2Index)
%         end
        if box1Index ~= box2Index 
            if ~ismember(box1Index,boxesToRemove) && ~ismember(box2Index,boxesToRemove)
                box1values = Objects(box1Index,:);
                bot1 = (box1values(2) + box1values(4));
                rect1 = [box1values(1), (box1values(2) + box1values(3)), box1values(4), box1values(4)];
                % rect1 = [box1values(1), box1values(2), box1values(3), box1values(4)];
                box2values = Objects(box2Index,:);
                bot2 = (box2values(2) + box2values(4));
                rect2 = [box2values(1), (box2values(2) + box2values(3)), box2values(4), box2values(4)];
                % rect2 = [box2values(1), box2values(2), box2values(3), box2values(4)];
                intersectionArea = rectint(rect1, rect2);
                squareArea = box1values(3)*box1values(4);
                value1 = (intersectionArea/squareArea);
                if value1 > threshold
                    box1confidence = box1values(5);
                    box2confidence = box2values(5);
                    if box1confidence < box2confidence
                        boxesToRemove(count) = box1Index;
                        count = count + 1;
                    else
                        boxesToRemove(count) = box2Index;
                        count = count + 1;
                    end
                end
            end


        end
    end
end

% disp(boxesToRemove)
boxesToKeep = [];


count = 1;
for i=1:size(Objects,1)
    if ~ismember(i,boxesToRemove)
        boxesToKeep(count) = i;
        count = count+1;
    end
end

tester = zeros(6,5);
for i=1:size(boxesToKeep,2)
    finalBoxIndex = boxesToKeep(i);
    testBox = Objects(finalBoxIndex,:);
    tester(i,:) = testBox;
end

Objects = tester;

end


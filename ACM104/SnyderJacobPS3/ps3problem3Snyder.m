
rng(2016);

groupings = zeros(600,1);
oldgroupings = zeros(600,1);
centers = datasample(x, 3, 'Replace', false);
c1history = centers(1,:);
c2history = centers(2,:);
c3history = centers(3,:);
pvals = [];

figure('Name', 'Iterations 1, 5, 10, final')
counter = 0;
while true
    counter = counter + 1;
    groupings = [];
    
    %CLASSIFY POINTS BY PROXIMITY TO CENTERS
    for i = 1:600
        [M,I] = min(vecnorm(transpose(x(i,:)-centers)));
        groupings = [groupings, I];
    end
    if groupings == oldgroupings
       break;
    end
    oldgroupings = groupings;
    if counter == 1
        subplot(2,2,1)
        scatter(x(:,1), x(:,2), [], groupings*5)
        title('First Iteration')
    end
    if counter == 5
        subplot(2,2,2)
        scatter(x(:,1), x(:,2), [], groupings*5)
        title('5th Iteration')
    end
    if counter == 10
        subplot(2,2,3)
        scatter(x(:,1), x(:,2), [], groupings*5)
        title('10th Iteration')
    end
    
    %CALCULATE P FOR THIS ITERATION
    p = 0;
    for i = 1:600
        distances = vecnorm(transpose(x(i,:)-centers));
        if groupings(i) == 1
            p = p + distances(1)^2;
        elseif groupings(i) == 2
            p = p + distances(2)^2;
        elseif groupings(i) == 3
            p = p + distances(3)^2;
        end
    end
    p=p/600;
    pvals = [pvals, p];
    
    %UPDATE THE CENTERS
    c1 = [];
    c2 = [];
    c3 = [];
    for i = 1:600
       if groupings(i) == 1
           c1 = [c1;x(i,:)];
       elseif groupings(i) == 2
           c2 = [c2;x(i,:)];
       elseif groupings(i) == 3
           c3 = [c3;x(i,:)];
       end
    end
    centers = [mean(c1); mean(c2); mean(c3)];
    c1history = [c1history; centers(1,:)];
    c2history = [c2history; centers(2,:)];
    c3history = [c3history; centers(3,:)];
    
end
subplot(2,2,4)
scatter(x(:,1), x(:,2), [], groupings*5)
title('Final Iteration')

disp('Iterations:');
disp(counter);

figure('Name', 'Representative Dynamics')
scatter(x(:,1), x(:,2),[],[0.7,0.7,0.7])
hold on;
scatter(c1history(:,1), c1history(:,2),[],[1,0,0])
scatter(c2history(:,1), c2history(:,2),[],[0,1,0])
scatter(c3history(:,1), c3history(:,2),[],[0,0,1])
hold off;

figure('Name', 'P Values vs Iteration Number')
plot(1:length(pvals), pvals)
xlabel('Iteration number')
ylabel('P value')

figure('Name', 'My Implementation vs kmeans')
subplot(2,1,1)
scatter(x(:,1), x(:,2), [], groupings*5)
title('My Implementation')
subplot(2,1,2)
scatter(x(:,1), x(:,2), [], kmeans(x,3)*5)
title('kmeans')
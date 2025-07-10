function demo = gameoflife_demo(status_init,T)
    status = status_init; %initialize status matrix with initial conditions
    figure; %create figure for visualization
    for a=1:T %loop through time steps
       imagesc(1-status); %populate figure with updated status
       axis equal; %equalize axis ratios
       axis off; %hide axes
       title(strcat('T=',int2str(a))); %add title for appropriate timestep
       pause(0.5); %delay for 0.5 seconds so as to see visualization of status
       status = gameoflife_update(status); % update status!
    end
end
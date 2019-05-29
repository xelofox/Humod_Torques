%clear
%6-RawMotion.mat;
for k=1:Motion_Squats.Frames
    hold off
    for i=1:36
        X(i)=Motion_Squats.Trajectories.Labeled.Data(i,1,k);
        Y(i)=Motion_Squats.Trajectories.Labeled.Data(i,2,k);
        Z(i)=Motion_Squats.Trajectories.Labeled.Data(i,3,k);
        
    end
    plot3(X,Y,Z,'*');
    axis equal
    hold on
end
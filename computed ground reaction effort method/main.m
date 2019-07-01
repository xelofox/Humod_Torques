% /!\  AJOUTER HuMoD-Master au path

%Motion="1.2";

'First_NE'
First_NE;
'Force_separation'
Force_separation;
'Moment_separation'
Moment_separation;
'Second_NE'
Second_NE;
'grf'



%% Ground reaction forces comparaison
filterHalfOrder = 2;
filterCutOff = 20;
cycleTime=motion.frames/motion.frameRate;
timeStep = cycleTime / force.frames;
forceTimeStep = 1 /force.frameRate;
forceStartIndex = 1 ;
forceEndIndex = round(cycleTime* force.frameRate) ;
forceFrames = forceEndIndex - forceStartIndex + 1;
filterPasses = 2;
filterCorrectedCutOff = filterCutOff / ((2^(1 / filterPasses) - 1)^(1 / 4));
[filterB, filterA] = butter(filterHalfOrder, (filterCorrectedCutOff / (0.5 / forceTimeStep)));

force.grfX_L=    filtfilt(filterB, filterA, force.grfX_L(forceStartIndex:forceEndIndex)); 
force.grfY_L=    filtfilt(filterB, filterA, force.grfY_L(forceStartIndex:forceEndIndex)); 
force.grfZ_L=    filtfilt(filterB, filterA, force.grfZ_L(forceStartIndex:forceEndIndex));

force.grfX_R=    filtfilt(filterB, filterA, force.grfX_R(forceStartIndex:forceEndIndex)); 
force.grfY_R=    filtfilt(filterB, filterA, force.grfY_R(forceStartIndex:forceEndIndex)); 
force.grfZ_R=    filtfilt(filterB, filterA, force.grfZ_R(forceStartIndex:forceEndIndex));

Fr=[force.grfX_R;force.grfY_R;force.grfZ_R];
Fr=Fr(1:3,1:2:length(Fr));
Fl=[force.grfX_L;force.grfY_L;force.grfZ_L];
Fl=Fl(1:3,1:2:length(Fl));
    
for i=1:length(mreactL)
    %i
    pos_LLJ=[motion.jointX.smoothed(7,i); motion.jointY.smoothed(7,i); motion.jointZ.smoothed(7,i)];
    if (isnan(force.grfX_L(2*i-1))||isnan(force.grfY_L(2*i-1))||isnan(force.grfZ_L(2*i-1))||isnan(force.copX_L(2*i-1))||isnan(force.copY_L(2*i-1))||isnan(force.copZ_L(2*i-1)))
        Ml(1:3,i)=zeros(3,1);
    else
        Ml(1:3,i)=-cross(pos_LLJ-[force.copX_L(2*i-1);force.copY_L(2*i-1);force.copZ_L(2*i-1)],Fl(1:3,i))*1e-3;
    end
    
        if (isnan(force.grfX_R(2*i-1))||isnan(force.grfY_R(2*i-1))||isnan(force.grfZ_R(2*i-1))||isnan(force.copX_R(2*i-1))||isnan(force.copY_R(2*i-1))||isnan(force.copZ_R(2*i-1)))
        Mr(1:3,i)=zeros(3,1);
    else
        Mr(1:3,i)=-cross(pos_LLJ-[force.copX_R(2*i-1);force.copY_R(2*i-1);force.copZ_R(2*i-1)],Fr(1:3,i))*1e-3;
    end
end

grf.label={'FX_L', 'FY_L', 'FZ_L', 'FX_R', 'FY_R', 'FZ_R', 'TX_L', 'TY_L', 'TZ_L', 'TX_R', 'TY_R', 'TZ_R'};
grf.calculated=[freactL; freactR; mreactL; mreactR];
grf.humod=[Fl; Fr; Ml; Mr];
save (strcat("grf_",Motion,".mat"), 'grf');
 % Estimate subject velocity from treadmill velocity and relative
        % velocity between the ASIS markers and the ground
        firstDerivativeWindowSize = 201;
        filteredTreadmillVelocity = force.treadmillVelocity;
        relativePosition = zeros(3, motion.frames);
        treadmillVelocity = zeros(1, motion.frames);
        for dataIndex = 1:motion.frames
            vectorASIS_L = getMarker('ASIS_L', 'marker', dataIndex);
            vectorASIS_R = getMarker('ASIS_R', 'marker', dataIndex);
            relativePosition(:, dataIndex) = (vectorASIS_L + (vectorASIS_R - vectorASIS_L) / 2) / 1000;
            treadmillVelocity(dataIndex) = mean(filteredTreadmillVelocity((2 * dataIndex - 1):(2 * dataIndex)));
        end
        relativeVelocity = savitzkyGolayFilter(relativePosition(1, :), '1st derivative', firstDerivativeWindowSize, (1 / motion.frameRate));
        subjectVelocity = treadmillVelocity + relativeVelocity;
        clear vectorASIS_L vectorASIS_R

% Separate forces during single support phase
mreactL = zeros(3, motion.frames);
mreactR = zeros(3, motion.frames);
singleSupport_L = logical(bitand(events.contactPhase_L, ~events.contactPhase_R));
singleSupport_L=singleSupport_L(1:2:force.frames);
mreactL(1:3,singleSupport_L) = Mreact(1:3,singleSupport_L);
singleSupport_R = logical(bitand(~events.contactPhase_L, events.contactPhase_R));
singleSupport_R=singleSupport_R(1:2:force.frames);
mreactR(1:3,singleSupport_R) = Mreact(1:3,singleSupport_R);

% Separate forces during double support phase according to [Villeger2014]
            doubleSupport = logical(bitand(events.contactPhase_L, events.contactPhase_R));
            doubleSupport=doubleSupport(1:2:force.frames);
            if any(doubleSupport)
                difference = diff([0, doubleSupport, 0]);
                doubleSupportStart = find(difference > 0);
                doubleSupportEnd = find(difference < 0) - 1;
                doubleSupportDuration = doubleSupportEnd - doubleSupportStart + 1;
                for doubleSupportIndex = 1:length(doubleSupportStart)
                    % Find involved events and force vectors
                    eventIndex_L = find(bitand((events.eventStart_L <= (doubleSupportEnd(doubleSupportIndex) / motion.frameRate)), (events.eventEnd_L >= (doubleSupportStart(doubleSupportIndex) / motion.frameRate))));
                    eventIndex_R = find(bitand((events.eventStart_R <= (doubleSupportEnd(doubleSupportIndex) / motion.frameRate)), (events.eventEnd_R >= (doubleSupportStart(doubleSupportIndex) / motion.frameRate))));
                    startIndex_L = round(events.eventStart_L(eventIndex_L) * motion.frameRate);
                    endIndex_L = round(events.eventEnd_L(eventIndex_L) * motion.frameRate);
                    startIndex_R = round(events.eventStart_R(eventIndex_R) * motion.frameRate);
                    endIndex_R = round(events.eventEnd_R(eventIndex_R) * motion.frameRate);
                    if events.eventStart_L(eventIndex_L) < events.eventStart_R(eventIndex_R)
                        FX1 = Mreact(1,startIndex_L:doubleSupportStart(doubleSupportIndex));
                        FX3 = Mreact(1,doubleSupportEnd(doubleSupportIndex):endIndex_R);
                        FY1 = Mreact(2,startIndex_L:doubleSupportStart(doubleSupportIndex));
                        FY3 = Mreact(2,doubleSupportEnd(doubleSupportIndex):endIndex_R);
                        FZ1 = Mreact(3,startIndex_L:doubleSupportStart(doubleSupportIndex));
                        FZ3 = Mreact(3,doubleSupportEnd(doubleSupportIndex):endIndex_R);
                    else
                        FX1 = Mreact(1,startIndex_R:doubleSupportStart(doubleSupportIndex));
                        FX3 = Mreact(1,doubleSupportEnd(doubleSupportIndex):endIndex_L);
                        FY1 = Mreact(2,startIndex_R:doubleSupportStart(doubleSupportIndex));
                        FY3 = Mreact(2,doubleSupportEnd(doubleSupportIndex):endIndex_L);
                        FZ1 = Mreact(3,startIndex_R:doubleSupportStart(doubleSupportIndex));
                        FZ3 = Mreact(3,doubleSupportEnd(doubleSupportIndex):endIndex_L);
                    end
                    
                    % Calculate shape coefficients
                    t = 0:(1 / motion.frameRate):((doubleSupportDuration(doubleSupportIndex) - 1) / motion.frameRate);
                    T_ds = doubleSupportDuration(doubleSupportIndex) / (2 * motion.frameRate);
                    V_F = median(subjectVelocity(round(doubleSupportStart(doubleSupportIndex) * motion.frameRate / motion.frameRate):round(doubleSupportEnd(doubleSupportIndex) * motion.frameRate / motion.frameRate)));
                    FX_i = abs(FX1(end)) / bodyMass;
                    FX_slope = abs(Mreact(1,doubleSupportStart(doubleSupportIndex))) / bodyMass;
                    FX_max = max(max(abs(FX1)), max(abs(FX3))) / bodyMass;
                    FY_i = abs(FY1(end)) / bodyMass;
                    FY_slope = abs(Mreact(2,doubleSupportStart(doubleSupportIndex))) / bodyMass;
                    FY_max = max(max(abs(FY1)), max(abs(FY3))) / bodyMass;
                    FZ_slope = abs(Mreact(3,doubleSupportStart(doubleSupportIndex))) / bodyMass;
                    FZ_max = max(max(abs(FZ1)), max(abs(FZ3))) / bodyMass;
                    SX = 0.283 - 1.248 * 2 * T_ds - 0.219 * FX_i - 0.003 * FX_slope + 0.04 * FX_max + 0.03 * FY_i + 0.002 * FY_slope + 0.034 * FY_max;
                    SY = -0.398 + 0.149 * V_F + 1.064 * 2 * T_ds + 0.043 * FX_i - 0.014 * FX_max + 0.036 * FZ_max + 0.011 * FY_i - 0.001 * FY_slope - 0.026 * FY_max;
                    SZ = 0.691 - 0.313 * V_F - 2.867 * 2 * T_ds - 0.121 * FX_i + 0.083 * FX_max + 0.007 * FZ_slope + 0.022 * FY_i - 0.002 * FY_slope;
                    
                    % Estimate forces during double support phase
                    FX21 = FX1(end) * (exp(SX^2) * exp(-((t - (SX * T_ds)) / T_ds).^2) - (0.5 * exp(SX^2) * exp(-(2 - SX)^2)) * t / T_ds);
                    FX22 = Mreact(1,doubleSupportStart(doubleSupportIndex):doubleSupportEnd(doubleSupportIndex)) - FX21;
                    FY21 = FY1(end) * (exp(SY^2) * exp(-((t - (SY * T_ds)) / T_ds).^2) - (0.5 * exp(SY^2) * exp(-(2 - SY)^2)) * t / T_ds);
                    FY22 = Mreact(2,doubleSupportStart(doubleSupportIndex):doubleSupportEnd(doubleSupportIndex)) - FY21;
                    FZ21 = FZ1(end) * (exp(SZ^2) * exp(-((t - (SZ * T_ds)) / T_ds).^2) - (0.5 * exp(SZ^2) * exp(-(2 - SZ)^2)) * t / T_ds);
                    FZ22 = Mreact(3,doubleSupportStart(doubleSupportIndex):doubleSupportEnd(doubleSupportIndex)) - FZ21;
                    
                    % Combine measured during single support phase and estimated forces during double support phase
                    if events.eventStart_L(eventIndex_L) < events.eventStart_R(eventIndex_R)
                        mreactL(1:3,doubleSupportStart(doubleSupportIndex):doubleSupportEnd(doubleSupportIndex)) = [FX21;  FY21; FZ21];
                        mreactR(1:3,doubleSupportStart(doubleSupportIndex):doubleSupportEnd(doubleSupportIndex)) = [FX22; FY22; FZ22];

                    else
                        mreactR(1:3,doubleSupportStart(doubleSupportIndex):doubleSupportEnd(doubleSupportIndex)) = [FX21;  FY21; FZ21];
                        mreactL(1:3,doubleSupportStart(doubleSupportIndex):doubleSupportEnd(doubleSupportIndex)) = [FX22; FY22; FZ22];
                    end
                end
            end
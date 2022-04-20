%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% computePiBulletWalking.m
%
% ALGORITHM DESCRIPTION
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function result = computePiBulletWalking(csv_left_crutch_file, csv_right_crutch_file, gait_phase_file, result_dir)
    
    disp(["Input parameters: ", csv_left_crutch_file, " ", csv_right_crutch_file, " ", gait_phase_file, " ", result_dir])
    isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
    
    if isOctave
        disp('Using Octave')
        pkg load signal
        % pkg load mapping
        pkg load statistics
    else
        disp('Using Matlab')
    end

    % load the force data
    leftForce = csv2cell(csv_left_crutch_file, ';');
    leftForceHeader = leftForce(1,:);
    leftForceTime = cell2mat(leftForce(2:end, 1));
    leftForce = cell2mat(leftForce(2:end, 2));
    
    rightForce = csv2cell(csv_right_crutch_file, ';');
    rightForceHeader = rightForce(1,:);
    rightForceTime = cell2mat(rightForce(2:end, 1));
    rightForce = cell2mat(rightForce(2:end, 2));
    
    % load the gait events data
    gaitEventsStruct = read_yaml(gait_phase_file);
    rightHeelStrike = gaitEventsStruct.r_heel_strike;
    leftHeelStrike = gaitEventsStruct.l_heel_strike;
    rightToeOff = gaitEventsStruct.r_toe_off;
    leftToeOff = gaitEventsStruct.l_toe_off;
    
    % PI computation
    display("PI computation")

    % Peak load
    % [leftFilteredForce, leftPeak, leftPeakLoc, leftPeakResults] = peakLoadExtraction_old(leftForce, filterWidth, interval);
    % [rightFilteredForce, rightPeak, rightPeakLoc, rightPeakResults] = peakLoadExtraction_old(rightForce, filterWidth, interval);
    [leftPeak, leftPeakResults] = peakLoadExtraction(leftForceTime, leftForce, leftHeelStrike);
    [rightPeak, rightPeakResults] = peakLoadExtraction(rightForceTime, rightForce, rightHeelStrike);
    
    % RMS load
    leftRmsLoad = rmsLoadExtraction(leftForce);
    rightRmsLoad = rmsLoadExtraction(rightForce);

    % Stance time
    [leftStanceTime, leftStepTime, leftStanceTimePerc, leftStanceTimeResults, leftAnalyzedStep] = stanceTimeExtraction(leftHeelStrike, leftToeOff);
    [rightStanceTime, rightStepTime, rightStanceTimePerc, rightStanceTimeResults, rightAnalyzedStep] = stanceTimeExtraction(rightHeelStrike, rightToeOff);
    
    % Storing results
    display("Store results")

    [filepath, name, ext] = fileparts(csv_left_crutch_file);
    filename = strcat(result_dir, "/", "peak_load_left", ".yaml");
    store_vector(filename, leftPeakResults);
    
    [filepath, name, ext] = fileparts(csv_right_crutch_file);
    filename = strcat(result_dir, "/", "peak_load_right", ".yaml");
    store_vector(filename, rightPeakResults);
    
    [filepath, name, ext] = fileparts(csv_left_crutch_file);
    filename = strcat(result_dir, "/", "rms_load_left", ".yaml");
    store_scalar(filename, leftRmsLoad);
    
    [filepath, name, ext] = fileparts(csv_right_crutch_file);
    filename = strcat(result_dir, "/", "rms_load_right", ".yaml");
    store_scalar(filename, rightRmsLoad);
    
    [filepath, name, ext] = fileparts(gait_phase_file);
    filename = strcat(result_dir, "/", "stance_time_left", ".yaml");
    store_vector(filename, leftStanceTimeResults);
    filename = strcat(result_dir, "/", "stance_time_right", ".yaml");
    store_vector(filename, rightStanceTimeResults);
    
    result = true; 
end
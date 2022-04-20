function shoulderDataStruct = loadShoulderForceData(csv_shoulder_file)
    
    shoulderData = csv2cell(csv_shoulder_file, ';');
    
    shoulderDataStruct.Header = shoulderData(1,:);
    
    shoulderDataStruct.Time = cell2mat(shoulderData(2:end, 1));
    
    shoulderDataStruct.ForceX = cell2mat(shoulderData(2:end, 2));
    shoulderDataStruct.ForceY = cell2mat(shoulderData(2:end, 3));
    shoulderDataStruct.ForceZ = cell2mat(shoulderData(2:end, 4));
    
    shoulderDataStruct.TorqueX = cell2mat(shoulderData(2:end, 5));
    shoulderDataStruct.TorqueY = cell2mat(shoulderData(2:end, 6));
    shoulderDataStruct.TorqueZ = cell2mat(shoulderData(2:end, 7));
    
end
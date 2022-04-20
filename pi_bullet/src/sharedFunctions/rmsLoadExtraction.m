function rmsResults = rmsLoadExtraction(forcesArray)
  for ii = 1:size(forcesArray, 2)
    rmsResults(ii) = rms(forcesArray(:,ii));
  end
end
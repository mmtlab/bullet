function [stanceTime, stepTime, stanceTimePerc, stanceTimeResults, analyzedStep] = stanceTimeExtraction(heelStrike, toeOff)
  
  stanceTime = [];
  stepTime = [];
  stanceTimePerc = [];
  analyzedStep = 0;
  for ii = 1:length(toeOff)
    diffValues = heelStrike - toeOff(ii);
    posValues = diffValues(diffValues>0);
    negValues = diffValues(diffValues<0);
    
    if ~isempty(posValues) && ~isempty(negValues)
      diffNegValues = diffValues;
      diffPosValues = diffValues;
      
      diffNegValues(diffValues>0) = NaN;
      diffPosValues(diffValues<0) = NaN;
      
      [diff_prev, heelStrike_prev_index] = max(diffNegValues);
      [diff_next, heelStrike_next_index] = min(diffPosValues);
      
      heelStrike_prev = heelStrike(heelStrike_prev_index);
      heelStrike_next = heelStrike(heelStrike_next_index);
            
      stanceTime = [stanceTime; toeOff(ii)-heelStrike_prev];
      stepTime = [stepTime; heelStrike_next-heelStrike_prev];
      stanceTimePerc = [stanceTimePerc; stanceTime(end)/stepTime(end)];
      
      analyzedStep = analyzedStep + 1;
    end
  end
  
  if ~isnan(stanceTimePerc)
    stanceTimeResults = [mean(stanceTimePerc) std(stanceTimePerc) analyzedStep];
  else
    disp("WARNING : Impossible computation");
    stanceTimeResults = [NaN NaN NaN];
end
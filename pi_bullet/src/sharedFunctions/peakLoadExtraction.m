function [peaks, peakResults] = peakLoadExtraction(time, force, heelStrike)
  
  peaks = [];
  for ii = 2:length(heelStrike)

    [minTimeEnd timeEndIndex] = min(abs(time - heelStrike(ii)));
    [minTimeStart timeStartIndex] = min(abs(time - heelStrike(ii-1)));
    
    timeEnd = time(timeEndIndex);
    timeStart = time(timeStartIndex);
    
    if timeEnd ~= timeStart
      peaks = [peaks; prctile(force(timeStartIndex:timeEndIndex), 99)];
    end
  end
  
  peakResults = [mean(peaks) std(peaks) length(peaks)];
end
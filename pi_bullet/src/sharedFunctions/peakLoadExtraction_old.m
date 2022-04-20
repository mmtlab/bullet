function [filteredForce, peaks, loc, peakResults] = peakLoadExtraction(forces, filterWidth, interval)
  
  filteredForce = filterSignal(forces, filterWidth);
  
  %[p, l, extra] = findpeaks(filteredForce, "MinPeakWidth", MinPeakWidth, "MinPeakDistance", MinPeakDistance);
  %[p, l, extra] = findpeaks(filteredForce);
  [p, l, extra] = findpeaks(filteredForce, "MinPeakDistance", 5);
  
  peaks = [];
  loc = [];
  for ii = 1:length(l)
    if l(ii)-interval<0
      if filteredForce(1)<filteredForce(l(ii)) && filteredForce(l(ii))>filteredForce(l(ii)+interval)
        loc = [loc; l(ii)];
        peaks = [peaks; prctile(forces(1:(l(ii)+interval)), 95)];
      end
    elseif l(ii)+interval>length(forces)
      if filteredForce(l(ii)-interval)<filteredForce(l(ii)) && filteredForce(l(ii))>filteredForce(end)
        loc = [loc; l(ii)];
        peaks = [peaks; prctile(forces((l(ii)-interval):end), 95)];
      end
    else
      if filteredForce(l(ii)-interval)<filteredForce(l(ii)) && filteredForce(l(ii))>filteredForce(l(ii)+interval)
        loc = [loc; l(ii)];
        peaks = [peaks; prctile(forces(l(ii)-interval:l(ii)+interval), 95)];
      end
    end
  end
  
  peakResults = [mean(peaks) std(peaks) length(loc)];
end
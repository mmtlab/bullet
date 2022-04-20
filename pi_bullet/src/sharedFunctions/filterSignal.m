function filteredSignal = filterSignal(signal, width)
  filteredSignal = signal;
  for ii = 1:width
    filteredSignal(ii) = mean(signal(1:ii+width));
  end
  for ii = (1+width):(length(signal)-width)
    filteredSignal(ii) = mean(signal(ii-width:ii+width));
  end
  for ii = (length(signal)-width+1):(length(signal))
    filteredSignal(ii) = mean(signal(ii-width:end));
  end
end
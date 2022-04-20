function shoulderPeakResults = shoulderPeakLoadExtraction(shoulderDataStruct, heelStrike)
  [shoulderPeakX, shoulderPeakXResults] = peakLoadExtraction(shoulderDataStruct.Time', shoulderDataStruct.ForceX', heelStrike);
  [shoulderPeakY, shoulderPeakYResults] = peakLoadExtraction(shoulderDataStruct.Time', shoulderDataStruct.ForceY', heelStrike);
  [shoulderPeakZ, shoulderPeakZResults] = peakLoadExtraction(shoulderDataStruct.Time', shoulderDataStruct.ForceZ', heelStrike);
  [shoulderPeakTx, shoulderPeakTxResults] = peakLoadExtraction(shoulderDataStruct.Time', shoulderDataStruct.TorqueX', heelStrike);
  [shoulderPeakTy, shoulderPeakTyResults] = peakLoadExtraction(shoulderDataStruct.Time', shoulderDataStruct.TorqueY', heelStrike);
  [shoulderPeakTz, shoulderPeakTzResults] = peakLoadExtraction(shoulderDataStruct.Time', shoulderDataStruct.TorqueZ', heelStrike);
  shoulderPeakResults = [shoulderPeakXResults(1:2) shoulderPeakYResults(1:2) shoulderPeakZResults(1:2) shoulderPeakTxResults(1:2) shoulderPeakTyResults(1:2) shoulderPeakTzResults];
end
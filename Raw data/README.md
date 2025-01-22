
Data structure:

_2022_Species_detections.rda_

- Species_detections (dataframe of individual species detection events)
-- Filename: Name of the file in which the detection occurs (format SITENAME_YYYYMMDD_hhmmss.wav). 
-- Channel: Channel number from input file for stereo recording (0=left; 1=right).
-- Offset: Time offset (in seconds) from the start of the recording (indicated by the filename, date, and time). 
-- Duration: Duration (in seconds) of detected vocalisation.
-- Fmin: Minimum frequency of detected vocalisation.
-- Fmean: Mean frequency of detected vocalisation.
-- Fmax: Maximum frequency of detected vocalisation.
-- Date: Date in YYYY-MM-DD.
-- Time: Time in hh:mm:ss.
-- Hour: Hour in number format (0-23).
-- Species_ID: Latin species name.
-- Cluster_dist: Kaleidoscope Pro's certainty value (how close is this detection to a perfect match with the detection algorithm?).
-- Vocalisations: Number of vocalisations detected at this time.
-- Site_ID: Name of field site.
-- Period: Delineation of typhoons in study period (Pre-typhoon; Trami; Post-trami; Kong-rey; Post-typhoon).



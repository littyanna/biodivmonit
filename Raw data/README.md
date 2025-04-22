
_2022_Species_detections.rda_

This raw dataset consists of individual detections of three bird species at half-hourly resolution, from 30/08/2018 to 04/11/2028, across 24 OKEON monitoring sites.

This data is also available at: https://doi.org/10.5281/zenodo.8133339, which is published as part of the work carried out in:
Ross, S. R. J., Friedman, N. R., Dudley, K. L., Yoshida, T., Yoshimura, M., Economo, E. P., ... & Donohue, I. (2024). Divergent ecological responses to typhoon disturbance revealed via landscape‐scale acoustic monitoring. Global Change Biology, 30(1), e17067.



Data structure of _2022_Species_detections.rda_: Dataframe of individual species detection events

Filename: Name of the file in which the detection occurs (format SITENAME_YYYYMMDD_hhmmss.wav). 

Channel: Channel number from input file for stereo recording (0=left; 1=right).

Offset: Time offset (in seconds) from the start of the recording (indicated by the filename, date, and time). 

Duration: Duration (in seconds) of detected vocalisation.

Fmin: Minimum frequency of detected vocalisation.

Fmean: Mean frequency of detected vocalisation.

Fmax: Maximum frequency of detected vocalisation.

Date: Date in YYYY-MM-DD.

Time: Time in hh:mm:ss.

Hour: Hour in number format (0-23).

Species_ID: Latin species name.

Cluster_dist: Kaleidoscope Pro's certainty value (how close is this detection to a perfect match with the detection algorithm?).

Vocalisations: Number of vocalisations detected at this time.

Site_ID: Name of field site.

Period: Delineation of typhoons in study period (Pre-typhoon; Trami; Post-trami; Kong-rey; Post-typhoon).



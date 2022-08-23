# fSEAD
fSEAD: a Composable FPGA-based Streaming Ensemble Anomaly Detection Library

--------------------------------------------------------------------------------
Introduction
--------------------------------------------------------------------------------

fSEAD is a HLS-based module generator for ensemble-centric streaming anomaly detection.
Three detectors are supported: Loda, RS-Hash and xStream.

--------------------------------------------------------------------------------
Build
--------------------------------------------------------------------------------
**In Linux environment**

For params creation: (optional, for the same parameters used for fSEAD paper, this command is not needed)
```
bash run_python.sh 
```
For gcc project generation:
```
bash run_gcc.sh 
```
For hls project generation:
```
bash run_hls.sh 
```
After genreating the HLS IPs, the following Vivado project is executated on Windows environment.

**In Windows environment**

(For the same BIT/HWH files used for fSEAD paper, this command is not needed)
go to fpga/vivado/ in Vivado command terminal
```
make all
```

**In PYNQ environment**

The image version is v2.6
1. replace the overlay.py to the original one.
2. upload the fSEAD.ipynb, BIT_HWH folder, and dataset to the jupyter environment.
3. execute the fSEAD.ipynb

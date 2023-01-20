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

For environment configuration:
```
conda env create -f environment.yml
conda activate fsead-test
```
For params creation: (it spends about 2.5h in a Intel(R) Core(TM) i7-10700F @2.9GHz and 64GB memory PC; optional, for the same parameters used for fSEAD paper, this command is not needed)
```
bash run_python.sh 
```
For gcc project generation: (the run_gcc.sh works on gcc-7.5.0; the run_gcc11.sh is tested on gcc-11.3.0; the only difference is the '-O3' flag didn't work on gcc11 for the existing project, so this flag is deleted in the run_gcc11.sh)
```
bash run_gcc.sh 
```
or
```
bash run_gcc11.sh 
```
For hls project generation:
```
bash run_fpga.sh 
```
After genreating the HLS IPs, copy the extire path to a windows environment with Vivado v2020.1 installed. The following Vivado project is executated on Windows environment. In the future, we will fix this inconvenience by integrating all the processes in Linux environment.

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

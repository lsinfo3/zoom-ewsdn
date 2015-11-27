# ZOOM Module analysis scripts
The scripts provided in this repository were created in context of the evaluation of the [ZOOM ODL Module](https://github.com/lsinfo3/zoom-odl) using [Matlab](http://de.mathworks.com/products/matlab/).

#### Provided result files
The tcp and udp conversation files provided within the respective `results` directories have been generated during the evaluation of the [ZOOM ODL Module](https://github.com/lsinfo3/zoom-odl) and have been used for its evaluation.

#### Provided conversation files
The files provided within the respective `results` directory were used during the evaluation to establish a baseline to which the generated results have been compared. Further information on the conversation files can be found in a seperate [readme file](https://github.com/lsinfo3/zoom-netsoft/tree/master/conversations).

#### Provided functionality
The scripts provided deliver all functionality that is needed to reproduce the figures used in [LINK THE PAPER](...).

In order to run the script, result files that need to be analyzed have to be placed within the `results` directory while the correct directory structure has to be mantained. Results are organised in the following manner.
```
./results/[algorithm name]/[n_flows]/[n_top]/[t_wait]/*
```
The [ZOOM ODL Module](https://github.com/lsinfo3/zoom-odl) automatically generates the correct folder structure so that obtained results can simply be copied into the script root directory.
Once the result files are in place the script has to be setup by specifying the parameter combinations that need to be analysed. This is done in [start.m](https://github.com/lsinfo3/zoom-netsoft/blob/master/start.m#L42-L86).
After all parameter combinations are correctly set up simply execute the start.m script and all figures will be plotted and saved into the `figures` subdirectory.

# License

The Zoom Module analysis scripts are published under the [MIT license](http://opensource.org/licenses/MIT).

#!/bin/bash
 
# --------------------------------------------------------------
### PART 1: Requests resources to run your job.
# --------------------------------------------------------------
#SBATCH --job-name=AB12_pert
#SBATCH --output=%x.out
#SBATCH --account=jrussell
#SBATCH --qos=user_qos_jrussell
#SBATCH --mail-type=ALL
#SBATCH --mail-user=swierczek@email.arizona.edu
#SBATCH --partition=standard
### SBATCH --mem=470gb
#SBATCH --time=200:00:00 
#SBATCH --ntasks=336
#SBATCH --ntasks-per-node=84
#SBATCH --nodes=4
#SBATCH --mem-per-cpu=5gb

cd /xdisk/jrussell/mig2020/rsgrps/jrussell/swierczek/MITgcm/verification/AB12_03_pert/

cp build/makescript_AB12_03.sh run/
cp build/makescript_AB12_03oce.sh run/

rm -rf build/*

mv run/makescript_AB12_03.sh build/
mv run/makescript_AB12_03oce.sh build/

cd run

rm -rf out*
rm -rf scratch*
rm -rf STD*
rm -rf Rho*
rm -rf wunit*
rm -rf XC*
rm -rf XG*
rm -rf DX*
rm -rf DY*
rm -rf mask*
rm -rf hFa*
rm -rf meta*
rm -rf RA*
rm -rf RF*
rm -rf RC*
rm -rf mitgcmuv
rm -rf DRF*
rm -rf Depth*
cd ..

cp input/* run/

cd build

module purge
module load phdf5-intel
module swap intel/2020.4 intel/2020.1
module load netcdf-fortran/intel
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so

./makescript_AB12_03.sh

cd ..
cp build/mitgcmuv run/

### set directory for job execution, ~netid = home directory path
cd /xdisk/jrussell/mig2020/rsgrps/jrussell/swierczek/MITgcm/verification/AB12_03_pert/run

###
### setenv MPI_DSM_DISTRIBUTE

### date
### /usr/bin/time mpirun -np 336 ./mitgcmuv > output.txt
### date

ulimit -n 4096

srun --ntasks 336 ./mitgcmuv > output.txt




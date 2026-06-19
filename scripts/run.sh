DATE=$(date +"%Y-%m-%d-%H%M%S")
NTHREADS="$2"
CMD_LIST="$1"
CMD_LIST_BASE=${CMD_LIST%.*}
CMD_LIST_BASE=${CMD_LIST_BASE##*/}
#OUTNAME="results/${CMD_LIST_BASE}_${HOSTNAME}_${DATE}.txt"
OUTNAME="results/${CMD_LIST_BASE}.txt"
LOGNAME="results/logs/${CMD_LIST_BASE}.log"
ERRNAME="results/logs/${CMD_LIST_BASE}_err.log"

echo "Writing results to $OUTNAME"
echo "Writing logs to    $LOGNAME"
echo "Running the $(cat $CMD_LIST | wc -l) tasks in parallel"

#python experiments.py commands $DATASETS | ./parallel --group --dryrun --slr | tee $OUTNAME


WDIR=$(pwd)

export OPENBLAS_NUM_THREADS=1
export MKL_NUM_THREADS=1
export OMP_NUM_THREADS=1
export PYTHONUNBUFFERED=1

#python experiments.py commands $DATASETS | parallel --slf cluster --env PATH --wd $WDIR --joblog task.log --resume --progress | tee $OUTNAME


# if [ "${HOSTNAME}" = "laurens-hp" ]; then
#     NTHREADS=4
# elif [ "${HOSTNAME}" = "himec05" ]; then
#     NTHREADS=8
# elif [ "${HOSTNAME}" = "himec01" ]; then
#     NTHREADS=20
# elif [ "${HOSTNAME}" = "himec03" ]; then
#     NTHREADS=6
# elif [ "${HOSTNAME}" = "himec04" ]; then
#     NTHREADS=6
# elif [ "${HOSTNAME}" = "himec08" ]; then
#     NTHREADS=1
# elif [ "${HOSTNAME}" = "himec07" ]; then
#     NTHREADS=1
# elif [ "${HOSTNAME}" = "pinac44" ]; then
#     NTHREADS=20
# elif [ "${HOSTNAME}" = "himec10" ]; then
#     NTHREADS=2
# elif [ "${HOSTNAME}" = "himec12" ]; then
#     NTHREADS=2
# else
#     NTHREADS=1  # assuming new
# fi

echo "###################################################"  | tee --append $OUTNAME
echo "  ${HOSTNAME}  ${DATE}" ${NTHREADS} THREADS           | tee --append $OUTNAME
echo "###################################################"  | tee --append $OUTNAME

cat $CMD_LIST |
    /home/timo/bin/parallel --line-buffer -j${NTHREADS} \
    --env OPENBLAS_NUM_THREADS \
    --env MKL_NUM_THREADS \
    --env OMP_NUM_THREADS \
    --env PYTHONUNBUFFERED \
    --env PATH --wd $WDIR --joblog $LOGNAME --resume --progress 2>>$ERRNAME |
    tee --append $OUTNAME

echo "Written results to $OUTNAME"
echo "   Logs written to $LOGNAME"
echo "Started at $DATE"
echo "  Ended at $(date +"%Y-%m-%d-%H%M%S")"

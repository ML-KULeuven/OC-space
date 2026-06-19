This file explains how to run the experiments.
Using uv, you can simply run uv sync --all-groups, which installs all dependencies including those for the experiments and visualization.

Then, all experiments are in the oc_space_experiment.py file. It requires the compressed models file: data/raw/OC-space_paper_compression.txt.

Step 1 (Enumeration):

    Otherwise, one can run the command: uv run python experiments/oc_space_experiment.py list_pareto_models data/raw/main_paper_compression.txt $SAVE_DIRECTORY$
    With $SAVE_DIRECTORY$ the path where you'd like the enumerated models to be saved. Note: the models can be extremely large, so make sure you have plenty of storage space.

    This command prints a list of commands to enumerate all pareto front models. Ideally, you'd write this list to a file in the 'experiments/settings' folder.
    The list can then be run using a bash script: 'uv run bash run.sh settings/$SETTING_FILE$ $N_THREADS$'.

Step 2 (Verification: Closest adversarial example):
    The verification tasks are described in verification.py, but can be run in the same way as enumeration.

    First, use 'uv run python oc_space_experiment list_enumerated_models $ENUMERATION_RESULTS_FILE$ data/raw/main_paper_compression.txt
    with the $ENUMERATION_RESULTS_FILE$ probably being results/$SETTING_FILE$.

    Same way as above, you can save this list of commands to a file and use the bash script to parallellize these.

Step 3 (Fairness, hybrid norm):
    These use the same strategy as above, but with different entry points in oc_space_experiment -> check the file for specifics.

Step 4 (Lipschitz):
    Simply run 'uv run python oc_space_experiment lipschitz Vehicle'




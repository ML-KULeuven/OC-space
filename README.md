# OC-space: a Unifying Perspective on Verification of Tree Ensembles
This readme file explains how to run the experiments.

## Cloning the repository
Using uv, you can simply run `uv sync --all-groups`, which installs all dependencies including those for the experiments and visualization.
If you require only access to the algorithms and methods presented in the paper, a simple `uv sync` or `pip install .` will do.

## Running the experiments
All experiment scripts are in the oc_space_experiment.py file. It requires downloading the compressed models (110MB) file and placing it in the correct directory. 
```
mkdir -r data/raw
wget -O data/raw/OC-space_paper_compression.txt "https://zenodo.org/records/20758998/files/OC-space_paper_compression.txt?download=1"
```

### Step 1 (Enumeration):
```
uv run python experiments/oc_space_experiment.py list_pareto_models data/raw/main_paper_compression.txt $SAVE_DIRECTORY$
```

With `$SAVE_DIRECTORY$` the path where you'd like the enumerated models to be saved. Note: the models can be extremely large, so make sure you have plenty of storage space. 
    
This command prints a list of commands to enumerate all pareto front models. Ideally, you'd write this list to a file in the 'experiments/settings' folder.
    
The list can then be run using the provided bash script: 
```
uv run bash run.sh settings/$SETTING_FILE$ $N_THREADS$
```

### Step 2 (Verification: Closest adversarial example):
    
The verification tasks are described in verification.py, but can be run in the same way as enumeration.

```
uv run python oc_space_experiment list_enumerated_models $ENUMERATION_RESULTS_FILE$ data/raw/main_paper_compression.txt
```

with the `$ENUMERATION_RESULTS_FILE$` probably being `results/$SETTING_FILE$` if you've followed the enumeration commands above.

Same way as above, you can save this list of generated commands to a file and use the bash script to parallellize these.

### Step 3 (Fairness, hybrid norm):
These use the same strategy as above, but with different entry points in 'experiments/oc_space_experiment'. I recommend checking out this file for the respective commands to execute these experiments. 

### Step 4 (Lipschitz):
```
uv run python oc_space_experiment lipschitz Vehicle
```
### Notes
- A Gurobi license is required for running the verification experiments. A free academic license can be requested [here](https://www.gurobi.com/academics).
- The tree ensembles were compressed using [LOP](https://github.com/ML-KULeuven/lop_compress).
- We use [Prada](https://github.com/laudv/prada) for dataset downloading. It requires setting a download location in your environment variables. 
## Reference
Martens, T., Devos, L., Cascioli, L., Meert, W., Blockeel, H. and Davis, J. OC-space: a Unifying Perspective on Verification of Tree Ensembles. In: Proceedings of the 43rd International Conference on Machine Learning (2026)






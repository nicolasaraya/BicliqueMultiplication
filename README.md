# Biclique Multiplication

A lightweight guide to building the biclique extractor and matrix multiplicator,
creating the bundled datasets, and running the provided experiments.

## Setup

| Command | Description |
| --- | --- |
| `make` | Builds `modules/BicliqueExtraction` and `modules/Multiplicator`. |
| `make sync` | Synchronizes external repositories used by the project. |
| `make build_cnr` | Generates `datasets/cnr-2000-hc.txt`. |
| `make run_cnr` | Runs the squared-power experiment with bicliques on `cnr-2000-hc.txt`. |

## Biclique Extractor

```bash
./biclique_extractor --file <path/to/input.(txt|bin)> [options]
```

Useful flags:

- `--saveTxt`: store the output in a human-readable text file.
- `--saveBin`: store the output in binary format (enabled by default).

Running the extractor will produce `<input>_compressed` and `<input>_bicliques`
files that serve as inputs for the `ng` multiplicator.

Refer to `modules/BicliqueExtraction/README.md` for the full list of parameters
and tuning tips.

## Matrix Multiplicator

```bash
./ng <compressed_graph> <bicliques>   # multiply with bicliques
./ng <compressed_graph>               # multiply without bicliques
```

The tool accepts either a compressed graph plus its biclique representation, or
only the compressed graph when bicliques are not required.

.PHONY: all biclique_extraction build_cnr matrix_multiplication sync

# --------------------------
#  DATASETS
# --------------------------

# Compressed file
CNR_TAR = datasets/cnr-2000-hc.bin.tar.gz

# Output directory
CNR_DIR = $(CURDIR)/datasets

all: biclique_extraction matrix_multiplication
	@echo "All modules compiled successfully."
	@echo "Execute './biclique_extractor' for biclique extraction and './ng' for matrix multiplication."

build_cnr:
	@echo "Decompressing $(CNR_TAR)..."
	tar -xzvf $(CNR_TAR) -C $(CNR_DIR)/
	@echo "Decompression completed."

run_cnr:
	@echo "Running biclique extraction on CNR dataset..."
	./biclique_extractor --file $(CNR_DIR)/cnr-2000-hc.txt
	@echo "Biclique extraction completed."

	# Running matrix multiplication on CNR dataset
	@echo "Running matrix multiplication on CNR dataset..."
	./ng $(CNR_DIR)/cnr-2000-hc_compressed.bin $(CNR_DIR)/cnr-2000-hc_bicliques.bin
	@echo "Matrix multiplication completed."

# --------------------------
#  MODULE COMPILATION
# --------------------------

biclique_extraction:
	@echo "Building BicliqueExtraction module..."
	$(MAKE) -C modules/BicliqueExtraction
	@echo "BicliqueExtraction build completed."
	@if [ ! -e biclique_extractor ]; then \
		echo "Creating symlink..."; \
		ln -s modules/BicliqueExtraction/biclique_extractor; \
	fi

matrix_multiplication:
	@echo "Building Multiplicator module..."
	$(MAKE) -C modules/Multiplicator
	@echo "Multiplicator build completed."
	@if [ ! -e ng ]; then \
		echo "Creating symlink..."; \
		ln -s modules/Multiplicator/ng; \
	fi

sync:
	git subtree pull --prefix=modules/BicliqueExtraction BicliqueExtraction main --squash
	git subtree pull --prefix=modules/Multiplicator Multiplicator ng --squash
	@echo "Subtrees synchronized."


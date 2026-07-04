#============================================================
# Makefile: PENS Proyek Akhir LaTeX Template
#
# Usage:
#   make proposal   -> kompilasi Proposal PA
#   make progres    -> kompilasi Progres PA
#   make buku       -> kompilasi Buku PA
#   make all        -> kompilasi ketiganya
#   make clean      -> hapus folder build/ (aux sementara)
#   make cleanall   -> hapus build/ + output/
#============================================================

BUILD  = build
OUTPUT = output

# Ambil nama dan NRP dari config/variables.tex
NAMA := $(shell awk -F'[{}]' '/\\NamaMahasiswa/ {gsub(/ /, "_", $$4); print $$4}' config/variables.tex)
NRP  := $(shell awk -F'[{}]' '/\\NRP/ {print $$4}' config/variables.tex)
DATETIME := $(shell date +%Y%m%d_%H%M%S)

.PHONY: all proposal progres buku clean cleanall

all: proposal progres buku

proposal:
	@echo "==> Kompilasi Proposal PA..."
	@mkdir -p $(BUILD) $(OUTPUT)/proposal
	latexmk -pdf main_proposal.tex
	@cp $(BUILD)/main_proposal.pdf "$(OUTPUT)/proposal/Proposal_PA_$(NAMA)_$(NRP)_$(DATETIME).pdf"
	@echo "==> Output: $(OUTPUT)/proposal/Proposal_PA_$(NAMA)_$(NRP)_$(DATETIME).pdf"

progres:
	@echo "==> Kompilasi Progres PA..."
	@mkdir -p $(BUILD) $(OUTPUT)/progres
	latexmk -pdf main_progres.tex
	@cp $(BUILD)/main_progres.pdf "$(OUTPUT)/progres/Progres_PA_$(NAMA)_$(NRP)_$(DATETIME).pdf"
	@echo "==> Output: $(OUTPUT)/progres/Progres_PA_$(NAMA)_$(NRP)_$(DATETIME).pdf"

buku:
	@echo "==> Kompilasi Buku PA..."
	@mkdir -p $(BUILD) $(OUTPUT)/buku
	latexmk -pdf main_buku.tex
	@cp $(BUILD)/main_buku.pdf "$(OUTPUT)/buku/Buku_PA_$(NAMA)_$(NRP)_$(DATETIME).pdf"
	@echo "==> Output: $(OUTPUT)/buku/Buku_PA_$(NAMA)_$(NRP)_$(DATETIME).pdf"

clean:
	@rm -rf $(BUILD)
	@rm -f main_proposal.aux main_proposal.log main_proposal.pdf \
	       main_proposal.fdb_latexmk main_proposal.fls main_proposal.synctex.gz \
	       main_proposal.bbl main_proposal.blg main_proposal.out \
	       main_progres.aux main_progres.log main_progres.pdf \
	       main_progres.fdb_latexmk main_progres.fls main_progres.synctex.gz \
	       main_progres.bbl main_progres.blg main_progres.out \
	       main_buku.aux main_buku.log main_buku.pdf \
	       main_buku.fdb_latexmk main_buku.fls main_buku.synctex.gz \
	       main_buku.bbl main_buku.blg main_buku.out
	@echo "==> Folder build/ dan file sementara di root dihapus."

cleanall: clean
	@rm -rf $(OUTPUT)
	@echo "==> Folder output/ juga dihapus."

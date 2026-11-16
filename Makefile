#============================================================
# Makefile: PENS Proyek Akhir LaTeX Template
#
# Usage:
#   make proposal     -> kompilasi Proposal PA (V1, default PENS)
#   make progres      -> kompilasi Progres PA (V1, default PENS)
#   make buku         -> kompilasi Buku PA
#   make all          -> kompilasi ketiganya (V1)
#
#   make proposal-v2  -> Proposal PA V2 (abstrak, daftar isi/gambar/tabel, halaman ganjil)
#   make progres-v2   -> Progres PA V2
#   make v2           -> keduanya (V2)
#
#   make digilib      -> Buku PA mode Digilib (watermark, tanpa halaman kosong)
#   make split        -> potong PDF digilib per bagian (config/split_yudisium.txt)
#
#   make watch        -> compile ulang otomatis setiap file disimpan (default: buku)
#                        pilih dokumen: make watch DOC=proposal | progres | buku
#                        hentikan dengan Ctrl+C; PDF ada di build/main_<DOC>.pdf
#
#   make clean        -> hapus folder build/ (aux sementara)
#   make cleanall     -> hapus build/ + output/
#============================================================

BUILD  = build
OUTPUT = output

# Ambil nama dan NRP dari config/variables.tex
NAMA := $(shell awk -F'[{}]' '/\\NamaMahasiswa/ {gsub(/ /, "_", $$4); print $$4}' config/variables.tex)
NRP  := $(shell awk -F'[{}]' '/\\NRP/ {print $$4}' config/variables.tex)
DATETIME := $(shell date +%Y%m%d_%H%M%S)

SPLIT_CONFIG = config/split_yudisium.txt
SPLIT_OUTPUT = $(OUTPUT)/berkas_yudisium

# compile <job> <folder output> <prefix nama file> <label>
define compile
	@echo "==> Kompilasi $(4)..."
	@mkdir -p $(BUILD) $(OUTPUT)/$(2)
	latexmk -pdf $(1).tex
	@rm -f $(1).fdb_latexmk $(1).fls
	@cp $(BUILD)/$(1).pdf "$(OUTPUT)/$(2)/$(3)_$(NAMA)_$(NRP)_$(DATETIME).pdf"
	@echo "==> Output: $(OUTPUT)/$(2)/$(3)_$(NAMA)_$(NRP)_$(DATETIME).pdf"
endef

.PHONY: all v2 proposal progres buku proposal-v2 progres-v2 digilib split watch clean cleanall

# Dokumen untuk `make watch` (proposal | progres | buku | proposal_v2 | progres_v2)
DOC ?= buku

all: proposal progres buku

v2: proposal-v2 progres-v2

proposal:
	$(call compile,main_proposal,proposal,Proposal_PA,Proposal PA)

progres:
	$(call compile,main_progres,progres,Progres_PA,Progres PA)

buku:
	$(call compile,main_buku,buku,Buku_PA,Buku PA)

proposal-v2:
	$(call compile,main_proposal_v2,proposal_v2,Proposal_PA_V2,Proposal PA V2)

progres-v2:
	$(call compile,main_progres_v2,progres_v2,Progres_PA_V2,Progres PA V2)

digilib:
	$(call compile,main_buku_digilib,digilib,Buku_PA_Digilib,Buku PA mode Digilib)

split:
	@test -f $(BUILD)/main_buku_digilib.pdf || $(MAKE) --no-print-directory digilib
	@scripts/split_pdf.sh $(BUILD)/main_buku_digilib.pdf $(SPLIT_CONFIG) $(SPLIT_OUTPUT)

watch:
	@test -f main_$(DOC).tex || { echo "DOC tidak dikenal: $(DOC) (pilih: proposal, progres, buku, proposal_v2, progres_v2)"; exit 1; }
	@echo "==> Watch main_$(DOC).tex (Ctrl+C untuk berhenti). PDF: $(BUILD)/main_$(DOC).pdf"
	latexmk -pdf -pvc -view=none main_$(DOC).tex

JOBS = main_proposal main_progres main_buku main_proposal_v2 main_progres_v2 main_buku_digilib
EXTS = aux log pdf fdb_latexmk fls synctex.gz bbl blg out toc lof lot

clean:
	@rm -rf $(BUILD)
	@rm -f $(foreach j,$(JOBS),$(foreach e,$(EXTS),$(j).$(e)))
	@echo "==> Folder build/ dan file sementara di root dihapus."

cleanall: clean
	@rm -rf $(OUTPUT)
	@echo "==> Folder output/ juga dihapus."

# .latexmkrc
# Konfigurasi latexmk: arahkan semua file sementara ke folder build/
# sehingga root project tetap bersih.

$out_dir = 'build';
$aux_dir = 'build';
$pdf_mode = 1;   # gunakan pdflatex
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';

# Jalankan bibtex dari dalam aux_dir agar .bbl/.blg tidak muncul di root.
# %B = basename (path lengkap tanpa ekstensi) dari aux file di aux_dir.
$bibtex = 'bibtex %O %B';

# Bersihkan file tambahan saat `latexmk -C`
$clean_ext = 'synctex.gz synctex(busy) aux bbl blg fdb_latexmk fls log out toc lof lot';




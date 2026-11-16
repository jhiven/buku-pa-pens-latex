#!/usr/bin/env bash
#============================================================
# Potong PDF Buku PA (mode Digilib) per bagian untuk berkas
# yudisium, memakai Ghostscript.
#
# Pemakaian : scripts/split_pdf.sh <input.pdf> <config.txt> <folder_output>
# Lewat make: make split   (input = PDF digilib terbaru)
#
# Format config (satu bagian per baris, '#' = komentar):
#   Nama_File.pdf:HalamanAwal:HalamanAkhir
# Nomor halaman = halaman FISIK di PDF (bukan nomor yang tercetak).
#============================================================
set -euo pipefail

INPUT_PDF="${1:?Pakai: $0 <input.pdf> <config.txt> <folder_output>}"
CONFIG="${2:?File config belum diisi}"
OUTPUT_DIR="${3:?Folder output belum diisi}"

command -v gs >/dev/null || { echo "Error: Ghostscript (gs) belum terpasang." >&2; exit 1; }
[ -f "$INPUT_PDF" ] || { echo "Error: '$INPUT_PDF' tidak ditemukan." >&2; exit 1; }
[ -f "$CONFIG" ]    || { echo "Error: config '$CONFIG' tidak ditemukan." >&2; exit 1; }

mkdir -p "$OUTPUT_DIR"
echo "Memotong '$INPUT_PDF' -> $OUTPUT_DIR/"

count=0
while IFS= read -r line || [ -n "$line" ]; do
  line="${line%%#*}"                       # buang komentar
  line="$(echo "$line" | tr -d '[:space:]')"
  [ -z "$line" ] && continue
  IFS=':' read -r name start end <<< "$line"
  if [ -z "${name:-}" ] || [ -z "${start:-}" ] || [ -z "${end:-}" ]; then
    echo "  Lewati baris tidak valid: $line" >&2; continue
  fi
  printf '  %-32s hal %s-%s ... ' "$name" "$start" "$end"
  # -dNO_PDFMARK_OUTLINES: buang bookmark (link-nya tidak valid di potongan PDF)
  gs -q -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dNO_PDFMARK_OUTLINES \
     -dFirstPage="$start" -dLastPage="$end" \
     -sOutputFile="$OUTPUT_DIR/$name" "$INPUT_PDF" \
     2> >(grep -v 'lies outside the valid page range' >&2) && echo OK
  count=$((count + 1))
done < "$CONFIG"

[ "$count" -eq 0 ] && echo "Belum ada bagian di '$CONFIG'. Isi dulu rentang halamannya." >&2
echo "Selesai: $count file."

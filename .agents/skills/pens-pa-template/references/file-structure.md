# File Structure Reference

## Entry Points

**Always compile a `main_*.tex` runner** (preferably via `make`), never an
individual chapter or page file. Each runner handles the input order, page
numbering resets, and list generation.

| Runner                  | Document                         | Make target        |
| ----------------------- | -------------------------------- | ------------------ |
| `main_proposal.tex`     | Proposal PA (V1, PENS default)   | `make proposal`    |
| `main_progres.tex`      | Progres PA (V1, PENS default)    | `make progres`     |
| `main_buku.tex`         | Buku PA                          | `make buku`        |
| `main_proposal_v2.tex`  | Proposal PA V2 (wrapper)         | `make proposal-v2` |
| `main_progres_v2.tex`   | Progres PA V2 (wrapper)          | `make progres-v2`  |
| `main_buku_digilib.tex` | Buku PA, Digilib mode (wrapper)  | `make digilib`     |

`make watch DOC=<proposal|progres|buku>` recompiles automatically on save.

## config/

| File                 | Purpose                                                    | Edit?                    |
| -------------------- | ---------------------------------------------------------- | ------------------------ |
| `variables.tex`      | All identity data (names, NIPs, title, year)               | Yes, always              |
| `toggles.tex`        | Boolean switches (front matter, PDF inserts, digilib, biodata) | Rarely; set toggles in `main_*.tex` |
| `fonts.tex`          | All font sizes, one macro per role (`\FontJudulBab`, ...)  | Only to change a size    |
| `packages.tex`       | LaTeX package declarations                                 | Only to add new packages |
| `formatting.tex`     | Shared layout/style definitions                            | No                       |
| `preset_v2.tex`      | Toggles enabled for Proposal/Progres V2                    | Only if an RG asks for more |
| `split_yudisium.txt` | Page ranges for `make split`                               | Yes, before `make split` |

## formats/

Per-document layout and fixed pages (cover, title page, approval page).

| File                                     | Content                                             |
| ---------------------------------------- | --------------------------------------------------- |
| `format_buku.tex`                        | Buku PA geometry, spacing, float spacing            |
| `format_proposal.tex`, `format_progres.tex` | Proposal/Progres geometry, spacing, 12pt font overrides |
| `cover_buku.tex`                         | Colored Buku PA cover                               |
| `cover_proposal.tex`, `cover_progres.tex` | White Proposal/Progres covers                      |
| `halaman_judul.tex`                      | Inner title page (black and white)                  |
| `pengesahan.tex`                         | Approval page, or the signed PDF if `\pengesahanpdftrue` |

## pages/

Preliminary and auxiliary pages. All files use variables from `variables.tex`.

| File                 | Content                                                         | Page # |
| -------------------- | --------------------------------------------------------------- | ------ |
| `orisinalitas.tex`   | Originality statement                                           | i      |
| `hak_cipta.tex`      | Copyright transfer statement (or stamped PDF if `\hakciptapdftrue`) | ii |
| `abstrak.tex`        | Indonesian abstract (300-500 words)                             | iii    |
| `abstract.tex`       | English abstract (300-500 words, italic)                        | iv     |
| `kata_pengantar.tex` | Preface                                                         | v      |
| `lampiran.tex`       | Appendix sections                                               | -      |
| `biodata.tex`        | Author biography, Buku PA only, off by default (`\showbiodatatrue`); photo at `assets/foto_penulis.jpg` | - |
| `sistematika_3bab.tex`, `sistematika_5bab.tex` | Writing outline for Bab 1 (Proposal / Progres & Buku) | - |

## Variants & build targets

| Target / file                                  | Purpose                                                                 |
| ---------------------------------------------- | ----------------------------------------------------------------------- |
| `make proposal` / `make progres`               | V1 (PENS default): cover then Bab 1, no front matter                    |
| `make proposal-v2` / `make progres-v2`         | V2 (some RGs): abstrak, daftar isi/gambar/tabel, odd-page starts. Toggles in `config/preset_v2.tex` |
| `make digilib` (`main_buku_digilib.tex`)       | Buku PA with PENS watermark from Abstrak, no blank pages                |
| `make split` (`scripts/split_pdf.sh`)          | Split the digilib PDF by ranges in `config/split_yudisium.txt`          |
| `make watch DOC=...`                           | Continuous build (`latexmk -pvc`) while editing                         |
| `\pengesahanpdftrue` / `\hakciptapdftrue`      | In `main_buku.tex`: replace generated pages with signed/stamped PDFs   |
| `\showbiodatatrue`                             | In `main_buku.tex`: add the Biodata Penulis page                        |

## chapters/

Main body content. Section headings follow the Rev05 structure.

| File       | Required Sections                                                                                                                           |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| `bab1.tex` | Latar Belakang, Permasalahan, Batasan Masalah (Buku PA only), Tujuan, Manfaat, Sistematika Penulisan                                         |
| `bab2.tex` | Deskripsi Permasalahan, Teori Penunjang, Penelitian Terkait                                                                                 |
| `bab3.tex` | Deskripsi Solusi, Perancangan Sistem                                                                                                        |
| `bab4.tex` | Parameter Eksperimen, Karakteristik Data, Tempat Ujicoba, Waktu Ujicoba, Spesifikasi Peralatan, Hasil Eksperimen, Analisis Hasil Eksperimen |
| `bab5.tex` | Kesimpulan, Saran                                                                                                                           |

## Images

| Location              | Content                                                          |
| --------------------- | ---------------------------------------------------------------- |
| `assets/pens/`        | Template assets (logos, approval-page background, Digilib watermark). Do not modify. |
| `assets/`             | Your own figures, referenced as `assets/<name>.png`              |
| `assets/foto_penulis.jpg` | Author photo for the optional Biodata page                   |

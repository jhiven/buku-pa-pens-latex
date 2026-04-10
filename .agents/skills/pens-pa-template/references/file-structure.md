# File Structure Reference

## Entry Point

**Always compile `main.tex`** — never compile individual chapter or page files.
`main.tex` handles the input order, page numbering resets, and list generation.

## config/

| File             | Purpose                                        | Edit?                    |
| ---------------- | ---------------------------------------------- | ------------------------ |
| `variables.tex`  | All identity data (names, NIPs, title, year)   | Yes — always             |
| `packages.tex`   | LaTeX package declarations                     | Only to add new packages |
| `formatting.tex` | All layout/style definitions (Rev05 compliant) | No                       |

## pages/

Preliminary and auxiliary pages. All files use variables from `variables.tex`.

| File                 | Content                                  | Page # |
| -------------------- | ---------------------------------------- | ------ |
| `cover.tex`          | Colored cover                            | —      |
| `halaman_judul.tex`  | Inner title page (black and white)       | —      |
| `pengesahan.tex`     | Approval page with signature table       | —      |
| `orisinalitas.tex`   | Originality statement                    | i      |
| `hak_cipta.tex`      | Copyright transfer statement             | ii     |
| `abstrak.tex`        | Indonesian abstract (300-500 words)      | iii    |
| `abstract.tex`       | English abstract (300-500 words, italic) | iv     |
| `kata_pengantar.tex` | Preface                                  | v      |
| `lampiran.tex`       | Appendix sections                        | —      |

## chapters/

Main body content. Section headings follow the Rev05 structure.

| File       | Required Sections                                                                                                                           |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| `bab1.tex` | Latar Belakang, Permasalahan, Batasan Masalah, Tujuan, Manfaat, Sistematika Penulisan                                                       |
| `bab2.tex` | Deskripsi Permasalahan, Teori Penunjang, Penelitian Terkait                                                                                 |
| `bab3.tex` | Deskripsi Solusi, Perancangan Sistem                                                                                                        |
| `bab4.tex` | Parameter Eksperimen, Karakteristik Data, Tempat Ujicoba, Waktu Ujicoba, Spesifikasi Peralatan, Hasil Eksperimen, Analisis Hasil Eksperimen |
| `bab5.tex` | Kesimpulan, Saran                                                                                                                           |

## Image Files (at project root)

| File                           | Used in                            |
| ------------------------------ | ---------------------------------- |
| `logo_pens.png`                | `pages/cover.tex`                  |
| `background_pens_repeated.png` | `pages/pengesahan.tex` (watermark) |

All other images (figures in chapters) should also be placed at the project
root or in an `images/` subfolder, then referenced by relative path.

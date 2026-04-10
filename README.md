# Template LaTeX Proyek Akhir — PENS

Template LaTeX untuk penulisan Buku Proyek Akhir (PA) Program Sarjana Terapan
Politeknik Elektronika Negeri Surabaya (PENS), berdasarkan Panduan Buku PA
Sarjana Terapan A4 Rev05.

---

## Persyaratan

- TeX distribution: [TeX Live](https://www.tug.org/texlive/) atau
  [MiKTeX](https://miktex.org/)
- Compiler: `pdflatex`
- Bibliography: `bibtex`
- Editor yang direkomendasikan: VS Code + LaTeX Workshop, atau Overleaf

---

## Struktur Folder

```
template-pa-pens/
├── main.tex # File utama, compile dari sini
├── references.bib # Daftar pustaka format BibTeX
│
├── config/
│ ├── variables.tex # <-- EDIT INI PERTAMA. Semua data identitas.
│ ├── packages.tex # Semua package LaTeX yang digunakan
│ └── formatting.tex # Layout, font, margin, caption, dll.
│
├── pages/
│ ├── cover.tex # Halaman sampul berwarna
│ ├── halaman_judul.tex # Halaman judul dalam (hitam-putih)
│ ├── pengesahan.tex # Halaman pengesahan + tanda tangan
│ ├── orisinalitas.tex # Pernyataan orisinalitas (hal. i)
│ ├── hak_cipta.tex # Pernyataan pengalihan hak cipta (hal. ii)
│ ├── abstrak.tex # Abstrak Bahasa Indonesia (hal. iii)
│ ├── abstract.tex # Abstract Bahasa Inggris (hal. iv)
│ ├── kata_pengantar.tex # Kata pengantar (hal. v)
│ └── lampiran.tex # Lampiran
│
└── chapters/
├── bab1.tex # Bab 1 - Pendahuluan
├── bab2.tex # Bab 2 - Kajian Pustaka
├── bab3.tex # Bab 3 - Desain Sistem
├── bab4.tex # Bab 4 - Eksperimen dan Analisis
└── bab5.tex # Bab 5 - Penutup
```

---

## Cara Penggunaan

### 1. Isi data identitas

Buka `config/variables.tex` dan isi semua variabel sesuai data Anda.
Ini adalah **satu-satunya file** yang perlu diedit untuk mengubah identitas
di seluruh dokumen (cover, judul, pengesahan, pernyataan, dll.).

```latex
\newcommand{\NamaMahasiswa}{Nama Lengkap Anda}
\newcommand{\NRP}{2324xxxxxxx}
\newcommand{\JudulPA}{Judul Proyek Akhir Anda}
\newcommand{\NamaPembimbingSatu}{Dr. Nama Pembimbing, S.T., M.T.}
% ... dan seterusnya
```

### 2. Tulis konten

Tulis isi setiap bab di folder `chapters/` dan halaman prelim di folder
`pages/`. Setiap file sudah berisi teks panduan dari Rev05 sebagai placeholder
yang bisa langsung diganti dengan konten Anda.

### 3. Tambahkan referensi

Masukkan semua referensi ke dalam `references.bib` menggunakan format BibTeX.
Template sudah dikonfigurasi menggunakan gaya sitasi IEEE (`IEEEtran`).

Contoh entri BibTeX:

```bibtex
@article{contoh_jurnal,
  author  = {Nama Pengarang},
  title   = {Judul Artikel},
  journal = {Nama Jurnal},
  volume  = {1},
  number  = {1},
  pages   = {1--10},
  year    = {2024}
}
```

### 6. Compile dokumen

Urutan compile yang benar untuk menghasilkan daftar isi, daftar pustaka, dan
nomor halaman yang tepat:

```bash
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

Jika menggunakan VS Code + LaTeX Workshop, recipe `pdflatex -> bibtex ->
pdflatex x2` sudah menangani urutan ini secara otomatis.

---

## Format Dokumen

Sesuai Panduan Buku PA Sarjana Terapan A4 Rev05:

| Elemen                    | Ketentuan                              |
| ------------------------- | -------------------------------------- |
| Kertas                    | A4, 80 gram                            |
| Font                      | Times New Roman                        |
| Ukuran font isi           | 12pt                                   |
| Ukuran font judul bab     | 14pt, kapital, tebal                   |
| Ukuran font subbab        | 12pt, kapital, tebal                   |
| Spasi                     | 1,5 spasi                              |
| Margin dalam (sisi jilid) | 4 cm                                   |
| Margin atas, bawah, luar  | 3 cm                                   |
| Cetak                     | Bolak-balik (twoside), mirror margin   |
| Nomor halaman prelim      | Romawi kecil (i, ii, iii, ...)         |
| Nomor halaman isi         | Arab (1, 2, 3, ...) dimulai dari Bab 1 |
| Warna sampul              | Biru PENS — RGB(0, 47, 167) / #002FA7  |

---

## Catatan Penting

- **Jangan compile file lain selain `main.tex`.** Semua file di `config/`,
  `pages/`, dan `chapters/` di-input oleh `main.tex` secara otomatis.
- Halaman kosong pada cetak bolak-balik akan otomatis diberi tulisan
  _"Halaman ini sengaja dikosongkan"_ sesuai panduan.
- Penomoran gambar, tabel, dan persamaan mengikuti format per-bab
  (contoh: Gambar 3.1, Tabel 4.2, Persamaan (3.1)).
- Untuk kutipan langsung panjang (lebih dari 2 baris), gunakan lingkungan
  `\begin{kutipanpanjang}...\end{kutipanpanjang}` yang sudah disediakan.

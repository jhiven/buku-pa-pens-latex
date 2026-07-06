# Template LaTeX Proyek Akhir PENS

Template LaTeX untuk penulisan dokumen Proyek Akhir (PA) Program Sarjana Terapan
Politeknik Elektronika Negeri Surabaya (PENS). Mendukung 3 jenis dokumen dari
satu sumber konten yang sama: **Proposal PA**, **Progres PA**, dan **Buku PA**.

> 📗 Butuh template untuk **Kerja Praktik (KP)**? → [ristekhimitpens/buku-kp-pens-latex](https://github.com/ristekhimitpens/buku-kp-pens-latex)

---

## Persyaratan

- TeX distribution: [TeX Live](https://www.tug.org/texlive/) atau [MiKTeX](https://miktex.org/)
- Compiler: `pdflatex`
- Bibliography: `bibtex`
- Build tool: `make` (direkomendasikan)
- Editor: VS Code + LaTeX Workshop, atau Overleaf

---

## Setup Editor: VS Code + LaTeX Workshop

Cara paling nyaman untuk menulis dokumen ini adalah menggunakan **VS Code** dengan
extension [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop).

### Instalasi

1. Install extension **LaTeX Workshop** (`James-Yu.latex-workshop`) di VS Code.
2. Pastikan `latexmk`, `pdflatex`, dan `bibtex` tersedia di PATH
   (sudah terpenuhi jika TeX Live atau MiKTeX terinstall).

### Mengapa perlu setup User Settings?

Setting LaTeX Workshop (`latex.tools`, `latex.recipes`, `latex.outDir`) bersifat **window-scoped** —
tidak bisa berbeda per-folder. File `.vscode/settings.json` di dalam project ini **tidak akan aktif**
jika VS Code dibuka dari folder parent. Satu-satunya cara agar config ini berlaku di semua kondisi
adalah menaruhnya di **User Settings** global (**satu kali saja**).

### Setup (satu kali, berlaku permanen)

1. Buka `Ctrl+Shift+P` → ketik **"Preferences: Open User Settings (JSON)"** → Enter.
2. Tambahkan konfigurasi berikut:

```json
{
  "latex-workshop.latex.tools": [
    {
      "name": "latexmk",
      "command": "latexmk",
      "args": [
        "-pdf",
        "-outdir=build",
        "-auxdir=build",
        "-interaction=nonstopmode",
        "-synctex=1",
        "%DOC%"
      ]
    }
  ],
  "latex-workshop.latex.recipes": [
    { "name": "latexmk (build/)", "tools": ["latexmk"] }
  ],
  "latex-workshop.latex.autoBuild.run": "onSave",
  "latex-workshop.latex.autoClean.run": "never",
  "latex-workshop.synctex.afterBuild.enabled": true,
  "latex-workshop.view.pdf.viewer": "tab",
  "latex-workshop.view.pdf.ref.viewer": "auto",
  "latex-workshop.latex.outDir": "build"
}
```

### Kompilasi Pertama Kali

Sebelum preview bisa dibuka, PDF harus ada terlebih dahulu. Jalankan sekali via terminal:

```bash
make proposal   # atau: make progres / make buku
```

### Live Preview (Watch Mode)

Setelah PDF pertama tersedia:

1. Buka salah satu file root (`main_proposal.tex`, `main_progres.tex`, atau `main_buku.tex`) di editor.
2. Buka PDF preview dengan shortcut:

   | Aksi                            | Shortcut           |
   | ------------------------------- | ------------------ |
   | Buka PDF preview di tab VS Code | `Ctrl+Alt+V`       |
   | Forward search (editor → PDF)   | `Ctrl+Alt+J`       |
   | Backward search (PDF → editor)  | `Ctrl+klik` di PDF |

3. Setiap kali file `.tex` disimpan (`Ctrl+S`), LaTeX Workshop akan **otomatis meng-compile** dan **merefresh PDF** di tab preview. File intermediate masuk ke `build/`, bukan root folder.

> **Penting**: Pastikan file yang aktif di editor adalah file `main_*.tex` (bukan
> file chapter atau pages), karena LaTeX Workshop menentukan root file dari file
> yang sedang aktif. Jika compile gagal karena root file salah, tambahkan magic
> comment berikut di bagian atas file chapter yang sedang diedit:
>
> ```latex
> %!TeX root = ../main_proposal.tex
> ```

### SyncTeX (Sinkronisasi Kursor Dua Arah)

SyncTeX memungkinkan navigasi langsung antara kode sumber dan PDF:

- **Editor → PDF**: Tekan `Ctrl+Alt+J` di editor untuk melompat ke posisi tersebut di PDF.
- **PDF → Editor**: `Ctrl+klik` di PDF viewer untuk melompat ke baris kode sumber yang sesuai.

---

## Struktur Folder

```
buku-pa-pens-latex/
|
+-- main_proposal.tex          <- Runner Proposal PA  (compile ini)
+-- main_progres.tex           <- Runner Progres PA   (compile ini)
+-- main_buku.tex              <- Runner Buku PA      (compile ini)
+-- Makefile                   <- Build tool
+-- .latexmkrc                 <- Konfigurasi latexmk (output ke build/)
|
+-- config/
|   +-- variables.tex          <- ** EDIT INI PERTAMA. Semua data identitas. **
|   +-- packages.tex           <- Semua package LaTeX yang digunakan
|   +-- formatting.tex         <- Layout, font, margin, caption, dll.
|   +-- toggles.tex            <- Boolean switch (front matter opsional, dll.)
|
+-- chapters/                  <- ISI BAB (ditulis 1x, dipakai 3 dokumen)
|   +-- bab1.tex  bab2.tex  bab3.tex  bab4.tex  bab5.tex
|
+-- pages/                     <- HALAMAN PRELIM
|   +-- abstrak.tex            <- Abstrak Bahasa Indonesia
|   +-- abstract.tex           <- Abstract Bahasa Inggris
|   +-- kata_pengantar.tex     <- Kata Pengantar
|   +-- orisinalitas.tex       <- Pernyataan Orisinalitas
|   +-- hak_cipta.tex          <- Pernyataan Pengalihan Hak Cipta
|   +-- lampiran.tex           <- Lampiran (Progres & Buku PA saja)
|   +-- sistematika_3bab.tex   <- Sistematika Proposal (Bab 1-3)
|   +-- sistematika_5bab.tex   <- Sistematika Progres/Buku (Bab 1-5)
|
+-- formats/                   <- FORMAT & COVER per jenis dokumen
|   +-- cover_buku.tex         <- Sampul Buku PA (biru PENS)
|   +-- cover_proposal.tex     <- Sampul Proposal PA (putih)
|   +-- cover_progres.tex      <- Sampul Progres PA (putih)
|   +-- format_buku.tex        <- Margin & spasi Buku PA
|   +-- format_proposal.tex    <- Margin & spasi Proposal PA
|   +-- format_progres.tex     <- Margin & spasi Progres PA
|   +-- halaman_judul.tex      <- Halaman judul dalam (hitam-putih)
|   +-- pengesahan.tex         <- Halaman pengesahan
|
+-- assets/
|   +-- pens/                  <- Aset template (jangan diubah)
|   +-- ...                    <- Gambar milik Anda di sini
|
+-- refs/
|   +-- references.bib         <- Daftar pustaka format BibTeX
|   +-- IEEEtranN.bst          <- Style sitasi IEEE
|
+-- build/                     <- File sementara LaTeX (auto, jangan diedit)
+-- output/
    +-- proposal/              <- PDF Proposal PA (dari `make proposal`)
    +-- progres/               <- PDF Progres PA  (dari `make progres`)
    +-- buku/                  <- PDF Buku PA     (dari `make buku`)
```

---

## Cara Penggunaan

### 1. Isi data identitas

Buka `config/variables.tex`, yaitu **satu-satunya file** yang perlu diedit untuk
mengubah identitas di seluruh dokumen (cover, judul, pengesahan, dll.).

```latex
\newcommand{\NamaMahasiswa}{Nama Lengkap Anda}
\newcommand{\NRP}{3122600052}
\newcommand{\JudulPA}{Judul Proyek Akhir Anda}
\newcommand{\NamaPembimbingSatu}{Dr. Nama Pembimbing, S.T., M.T.}
\newcommand{\NIPPembimbingSatu}{197404162000032003}
% ... dan seterusnya
```

### 2. Tulis konten

Tulis isi bab di `chapters/` dan halaman prelim di `pages/`.
Setiap file berisi teks panduan sebagai placeholder yang bisa langsung diganti.

### 3. Tambahkan gambar

Letakkan file gambar di `assets/`. Gunakan path `assets/nama_gambar.png` di
dalam `.tex`. Jangan mengubah isi `assets/pens/`.

### 4. Tambahkan referensi

Masukkan referensi ke `refs/references.bib` dalam format BibTeX:

```bibtex
@article{contoh_jurnal,
  author  = {Nama Pengarang},
  title   = {Judul Artikel},
  journal = {Nama Jurnal},
  year    = {2024}
}
```

### 5. Compile dokumen

**Menggunakan Makefile (sangat direkomendasikan):**

```bash
make proposal   # -> output/proposal/Proposal_PA_Nama_NRP_DATETIME.pdf
make progres    # -> output/progres/Progres_PA_Nama_NRP_DATETIME.pdf
make buku       # -> output/buku/Buku_PA_Nama_NRP_DATETIME.pdf
make all        # -> compile ketiganya
make clean      # -> hapus build/ (file sementara)
make cleanall   # -> hapus build/ + output/
```

Semua file sementara LaTeX (`.aux`, `.log`, `.bbl`, dll.) masuk ke `build/`
secara otomatis sehingga root project selalu bersih.

---

## Perbedaan 3 Jenis Dokumen

| Komponen                   |   Proposal PA    |    Progres PA    |        Buku PA        |
| -------------------------- | :--------------: | :--------------: | :-------------------: |
| Cover                      | Putih, grayscale | Putih, grayscale |       Biru PENS       |
| Halaman Judul & Pengesahan |        -         |        -         |          Ya           |
| Orisinalitas & Hak Cipta   |        -         |        -         |          Ya           |
| Abstrak, Kata Pengantar    |   toggle (off)   |   toggle (off)   |          Ya           |
| Daftar Isi/Gambar/Tabel    |   toggle (off)   |   toggle (off)   |          Ya           |
| Bab 1-3                    |        Ya        |        Ya        |          Ya           |
| Bab 4-5                    |        -         |        Ya        |          Ya           |
| Lampiran                   |        -         |        Ya        |          Ya           |
| Sistematika Bab 4-5        |        -         |        Ya        |          Ya           |
| Cetak                      | 1 muka (oneside) | 1 muka (oneside) | Bolak-balik (twoside) |
| Margin kiri                |      3,0 cm      |      3,0 cm      |    4,0 cm (jilid)     |
| Margin atas/bawah/kanan    |      2,5 cm      |      2,5 cm      |        3,0 cm         |
| Spasi baris                |    1,15 spasi    |    1,15 spasi    |       1,5 spasi       |
| Indentasi paragraf         |     0,75 cm      |     0,75 cm      |        1,27 cm        |

---

## Konfigurasi Opsional

### Toggle Front Matter (Proposal & Progres)

Front matter Proposal dan Progres default **semua off**. Aktifkan dengan
uncomment baris yang diinginkan di [main_proposal.tex](main_proposal.tex) atau [main_progres.tex](main_progres.tex):

```latex
% \showabstraktrue         % Tampilkan Abstrak Bahasa Indonesia
% \showabstracttrue        % Tampilkan Abstract Bahasa Inggris
% \showkatapengantartrue   % Tampilkan Kata Pengantar
% \showdaftarisitrue       % Tampilkan Daftar Isi
% \showdaftargambartrue    % Tampilkan Daftar Gambar
% \showdaftartabeltrue     % Tampilkan Daftar Tabel
```

### Paksa Konten Baru ke Halaman Ganjil

Untuk Proposal dan Progres (mode oneside), secara default setiap bab dan
seksi front matter dimulai di halaman berikutnya saja (tidak dipaksa ke
halaman ganjil). Untuk mengaktifkan perilaku ini (termasuk menyisipkan halaman
kosong bertulisan _"Halaman ini sengaja dikosongkan"_ jika diperlukan), tambahkan di
[main_proposal.tex](main_proposal.tex) atau [main_progres.tex](main_progres.tex):

```latex
% \showforceoddpagetrue
```

Buku PA tidak memerlukan ini karena mode `twoside` + `openright` sudah
menanganinya secara otomatis.

---

## Konfigurasi Pembimbing

Semua pembimbing di luar Pembimbing 1 dan 2 bersifat opsional dan diatur
di `config/variables.tex`. Kosongkan nama untuk menyembunyikan baris tersebut
di semua cover secara otomatis.

| Kondisi                         | Yang diisi                                                                                 |
| ------------------------------- | ------------------------------------------------------------------------------------------ |
| Hanya 2 pembimbing (standar)    | Kosongkan `NamaPembimbingTiga` dan `NamaPembimbingIndustri`                                |
| Ada Pembimbing Akademik ke-3    | Isi `NamaPembimbingTiga` + `NIPPembimbingTiga`                                             |
| Ada Pembimbing Tambahan (Dosen) | Isi `NamaPembimbingIndustri` + `NIPPembimbingIndustri`, kosongkan `NamaPerusahaanIndustri` |
| Ada Pembimbing dari Industri    | Isi `NamaPembimbingIndustri` + `NamaPerusahaanIndustri`, kosongkan `NIPPembimbingIndustri` |

Logika kondisional sudah ditangani otomatis di semua cover (Proposal, Progres, Buku PA).

---

## Pengaturan yang Dapat Disesuaikan

Berikut adalah daftar lengkap hal-hal yang dapat diubah tanpa merusak struktur template:

### Data Identitas (`config/variables.tex`)

Satu-satunya file yang perlu diedit untuk mengubah identitas. Semua cover,
halaman judul, pengesahan, dan pernyataan akan memperbarui diri secara otomatis.

| Variabel                                     | Keterangan                                   |
| -------------------------------------------- | -------------------------------------------- |
| `\NamaMahasiswa`, `\NRP`                     | Nama dan NRP penulis                         |
| `\JudulPA`                                   | Judul Proyek Akhir (muncul di semua cover)   |
| `\NamaPembimbingSatu/Dua` + `\NIP*`          | Dosen Pembimbing 1 dan 2 (wajib)             |
| `\NamaPembimbingTiga` + `\NIPPembimbingTiga` | Dosen Pembimbing ke-3, opsional              |
| `\NamaPembimbingIndustri`                    | Nama pembimbing tambahan/industri, opsional  |
| `\NIPPembimbingIndustri`                     | Diisi jika pembimbing tambahan adalah dosen  |
| `\NamaPerusahaanIndustri`                    | Diisi jika pembimbing tambahan dari industri |
| `\NamaProdi`, `\NamaDepartemen`              | Nama program studi dan departemen            |
| `\NamaKetuaProdi`                            | Nama Ketua Prodi (untuk halaman pengesahan)  |
| `\TahunLulus`, `\BulanLulus`                 | Tahun dan bulan kelulusan                    |
| `\Kota`                                      | Kota (default: Surabaya)                     |

### Toggle Front Matter ([main_proposal.tex](main_proposal.tex) / [main_progres.tex](main_progres.tex))

Semua seksi prelim pada Proposal dan Progres default nonaktif. Aktifkan
dengan uncomment baris berikut di file terkait:

```latex
% \showabstraktrue         % Tampilkan Abstrak Bahasa Indonesia
% \showabstracttrue        % Tampilkan Abstract Bahasa Inggris
% \showkatapengantartrue   % Tampilkan Kata Pengantar
% \showdaftarisitrue       % Tampilkan Daftar Isi
% \showdaftargambartrue    % Tampilkan Daftar Gambar
% \showdaftartabeltrue     % Tampilkan Daftar Tabel
```

### Paksa Halaman Ganjil ([main_proposal.tex](main_proposal.tex) / [main_progres.tex](main_progres.tex))

Default nonaktif karena Proposal dan Progres dicetak 1 muka. Jika diperlukan
(misalnya untuk dicetak bolak-balik secara mandiri), aktifkan dengan:

```latex
% \showforceoddpagetrue
```

Setiap bab dan seksi front matter akan dimulai di halaman ganjil, dengan
halaman kosong bertulisan _"Halaman ini sengaja dikosongkan"_ disisipkan bila perlu.

### Konten Bab (`chapters/` dan `pages/`)

| File                                | Keterangan                                   |
| ----------------------------------- | -------------------------------------------- |
| `chapters/bab1.tex` s.d. `bab5.tex` | Isi bab utama, langsung edit                 |
| `pages/abstrak.tex`                 | Abstrak Bahasa Indonesia                     |
| `pages/abstract.tex`                | Abstract Bahasa Inggris                      |
| `pages/kata_pengantar.tex`          | Kata Pengantar                               |
| `pages/orisinalitas.tex`            | Pernyataan Orisinalitas                      |
| `pages/hak_cipta.tex`               | Pernyataan Pengalihan Hak Cipta              |
| `pages/lampiran.tex`                | Lampiran (Progres dan Buku PA)               |
| `pages/sistematika_3bab.tex`        | Isi sistematika untuk Proposal (Bab 1-3)     |
| `pages/sistematika_5bab.tex`        | Isi sistematika untuk Progres/Buku (Bab 1-5) |
| `refs/references.bib`               | Daftar referensi BibTeX                      |

### Aset Gambar (`assets/`)

Letakkan gambar di folder `assets/`. Gunakan path relatif dari root:

```latex
\includegraphics[width=0.8\textwidth]{assets/nama_gambar.png}
```

Jangan mengubah atau menghapus isi `assets/pens/` karena berisi logo resmi.

---

## Format Dokumen

### Buku PA (Rev05)

| Elemen                   | Ketentuan                            |
| ------------------------ | ------------------------------------ |
| Kertas                   | A4, 80 gram                          |
| Font                     | Times New Roman, 12pt                |
| Judul bab                | 14pt, kapital, tebal                 |
| Spasi                    | 1,5 spasi                            |
| Indentasi paragraf       | 1,27 cm                              |
| Margin jilid (kiri)      | 4 cm                                 |
| Margin atas, bawah, luar | 3 cm                                 |
| Cetak                    | Bolak-balik (twoside), mirror margin |
| Nomor halaman prelim     | Romawi kecil (i, ii, iii, ...)       |
| Nomor halaman isi        | Arab, dimulai dari Bab 1             |
| Sampul                   | Biru PENS #002FA7                    |

### Proposal PA & Progres PA (PASPE-2022)

| Elemen                    | Ketentuan                                   |
| ------------------------- | ------------------------------------------- |
| Kertas                    | A4, 80 gram                                 |
| Font                      | Times New Roman, 12pt                       |
| Spasi                     | 1,15 spasi                                  |
| Indentasi paragraf        | 0,75 cm                                     |
| Margin kiri               | 3,0 cm                                      |
| Margin atas, bawah, kanan | 2,5 cm                                      |
| Cetak                     | 1 muka (oneside)                            |
| Nomor halaman             | Arab, di bawah tengah                       |
| Sampul                    | Putih, logo PENS grayscale                  |
| Font cover label          | 20pt (teks "PROPOSAL/PROGRES PROYEK AKHIR") |
| Font cover konten         | 18pt (judul, nama, dll.)                    |

---

## Catatan Penting

- **Jangan compile file selain `main_*.tex`.**
- Penomoran gambar, tabel, dan persamaan per-bab (contoh: Gambar 3.1).
- Untuk kutipan panjang (>2 baris), gunakan `\begin{kutipanpanjang}...\end{kutipanpanjang}`.
- Halaman kosong pada Buku PA otomatis diberi teks _"Halaman ini sengaja dikosongkan"_.
- Jika pernah compile manual (bukan via `make`), jalankan `make clean` sebelum compile berikutnya agar file cache tidak mengotori root.

## License and Copyright

The code for this template is released under the **MIT License** (see the `LICENSE` file for the full text).

**Important Note for Students:**
The open-source license applies **only to the structural template files** (such as the `.cls`, `.sty`, and skeleton `.tex` files) provided in this repository.

**You retain full copyright over your actual thesis.** The text, research, data, images, and any original content you generate while using this template are entirely your own intellectual property (or belong to your university, depending on your institutional guidelines). Using this template does not legally obligate you to open-source or publicly share your final thesis document.

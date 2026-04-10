---
name: pens-pa-template
description: >
  LaTeX template for writing a Final Project Report (Proyek Akhir / PA) at
  Politeknik Elektronika Negeri Surabaya (PENS), based on Panduan Buku PA
  Sarjana Terapan A4. Use this skill when the user asks to edit,
  refactor, compile, or add content to the PENS PA LaTeX template, or when
  they mention buku PA, proyek akhir, skripsi PENS, or panduan.
license: MIT
metadata:
  author: jhiven
  version: "1.0"
  institution: Politeknik Elektronika Negeri Surabaya
  guideline: Panduan Buku PA Sarjana Terapan A4
---

# PENS Final Project (PA) LaTeX Template

This skill covers how to use and maintain a structured LaTeX template for
PENS final project reports. The template follows Panduan Buku PA Sarjana
Terapan A4 Rev05 in terms of formatting, layout, and content structure.

## Project Structure

```
template-pa-pens/
├── main.tex                  # Entry point — compile ONLY this file
├── references.bib            # BibTeX references (IEEE style)
│
├── config/
│   ├── variables.tex         # All identity data — edit this first
│   ├── packages.tex          # All LaTeX packages
│   └── formatting.tex        # Layout, fonts, margins, captions
│
├── pages/
│   ├── cover.tex             # Colored cover page
│   ├── halaman_judul.tex     # Inner title page (black and white)
│   ├── pengesahan.tex        # Approval page with signatures
│   ├── orisinalitas.tex      # Originality statement (page i)
│   ├── hak_cipta.tex         # Copyright transfer statement (page ii)
│   ├── abstrak.tex           # Indonesian abstract (page iii)
│   ├── abstract.tex          # English abstract (page iv)
│   ├── kata_pengantar.tex    # Preface (page v)
│   └── lampiran.tex          # Appendix
│
└── chapters/
    ├── bab1.tex              # Chapter 1 — Pendahuluan
    ├── bab2.tex              # Chapter 2 — Kajian Pustaka
    ├── bab3.tex              # Chapter 3 — Desain Sistem
    ├── bab4.tex              # Chapter 4 — Eksperimen dan Analisis
    └── bab5.tex              # Chapter 5 — Penutup
```

For the full variable list, see [references/variables.md](references/variables.md).
For a detailed file structure guide, see [references/file-structure.md](references/file-structure.md).
For formatting rules, see [references/formatting-rules.md](references/formatting-rules.md).

## Core Principle

**Edit `config/variables.tex` once — all pages update automatically.**
Never hardcode the student's name, NRP, title, supervisor names, or NIPs
directly in any page file. Always reference the variables.

## Common Tasks

### 1. Update identity data

Open `config/variables.tex` and edit the relevant command:

```latex
\newcommand{\NamaMahasiswa}{Full Student Name}
\newcommand{\NRP}{2324xxxxxxx}
\newcommand{\JudulPA}{Full Title of the Final Project}
\newcommand{\NamaPembimbingSatu}{Dr. First Supervisor, S.T., M.T.}
\newcommand{\NIPPembimbingSatu}{197xxxxxxxxxx}
```

All pages that display this data — cover, title page, approval page,
originality statement, copyright transfer — will update on the next compile.

### 2. Write chapter content

Edit the relevant file in `chapters/`. The placeholder text in each file is
from the official Rev05 guideline — replace it with actual content while
keeping the section structure (`\chapter{}`, `\section{}`, `\subsection{}`).

### 3. Add a figure

```latex
\begin{figure}[H]
  \centering
  \includegraphics[width=0.8\textwidth]{filename.png}
  \caption{Caption text for the figure}
  \label{fig:your-label}
\end{figure}

% Always reference figures in the preceding paragraph:
Figure~\ref{fig:your-label} shows ...
```

For figures taken from external sources, add a source line between the image
and the caption:

```latex
{\fontsize{12}{15}\selectfont\itshape Source: http://source-url.com\par}
```

### 4. Add a table

Use `tblr` from the `tabularray` package for automatic formatting:

```latex
\begin{table}[H]
  \centering
  \begin{tblr}{colspec={c c c}}
    Column 1 & Column 2 & Column 3 \\
    Data 1   & Data 2   & Data 3   \\
  \end{tblr}
  \caption{Table caption}
  \label{tab:your-label}
\end{table}

% Always reference tables in the preceding paragraph:
Table~\ref{tab:your-label} shows ...
```

### 5. Add a citation

Add the BibTeX entry to `references.bib`, then cite in the body:

```latex
% Indirect citation (paraphrase) — cite at end of sentence
This method has been proven effective \cite{author2024}.

% Direct short citation (1-2 lines) — italic, quoted, cite at end
\textit{``This is the exact quoted text''}\cite{author2024}.

% Direct long citation (more than 2 lines) — use the custom environment
\begin{kutipanpanjang}
  ``This is a long quoted passage that spans more than two lines and
  requires the special formatting environment.'' \cite{author2024}
\end{kutipanpanjang}
```

### 6. Add a mathematical equation

```latex
% Inline equation
The formula \( E = mc^2 \) describes mass-energy equivalence.

% Block equation — always assign a label and reference it
\begin{equation}
  y = mx + c
  \label{eq:your-label}
\end{equation}

% Reference it in the paragraph:
Equation~(\ref{eq:your-label}) shows ...
```

### 7. Add an appendix section

In `pages/lampiran.tex`, uncomment and duplicate the section block:

```latex
\section{Appendix Title A}
Content for appendix A.

\section{Appendix Title B}
Content for appendix B.
```

### 8. Compile the document

Run in this exact order to resolve all cross-references and bibliography:

```bash
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

## Formatting Rules (Critical — Do Not Change)

These formatting rules are fixed by the Rev05 guideline. Do not modify
them in `config/formatting.tex` unless the guideline is updated.

| Element                     | Rule                                      |
| --------------------------- | ----------------------------------------- |
| Paper                       | A4, 80gsm                                 |
| Body font                   | Times New Roman, 12pt                     |
| Chapter title               | 14pt, bold, all caps, centered            |
| Section title               | 14pt, bold, all caps                      |
| Subsection title            | 12pt, bold                                |
| Line spacing                | 1.5                                       |
| Inner margin (binding)      | 4 cm                                      |
| Top / bottom / outer margin | 3 cm                                      |
| Page numbering (prelim)     | Lowercase Roman (i, ii, iii…)             |
| Page numbering (main)       | Arabic, starting at 1 from Chapter 1      |
| Figure/table numbering      | Per-chapter (e.g., Figure 3.1, Table 4.2) |
| Print mode                  | Double-sided, mirror margins              |
| Cover color                 | Blue PENS — RGB(0, 47, 167) / #002FA7     |

## What NOT to Do

- Do not compile any file other than `main.tex`.
- Do not hardcode names, NIPs, or titles in `pages/` or `chapters/` files.
- Do not change `\chapter`, `\section`, or `\subsection` formatting in
  `config/formatting.tex` — it is calibrated to the Rev05 specification.
- Do not use `\textbf{}` inside `\chapter{}` or `\section{}` arguments —
  they are already bold by the format definition.
- Do not put content inside the `\begin{titlepage}` block in `cover.tex`
  other than layout commands — use variables for all text.

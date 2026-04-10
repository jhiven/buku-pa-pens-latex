# LaTeX Writing Patterns — Rev05 Reference

This file documents the correct LaTeX patterns for every recurring element
in the PENS PA template. Follow these exactly — the formatting config in
`config/formatting.tex` is already calibrated to match these patterns.

---

## Tables

Use `tblr` from `tabularray` for all tables. The global `\SetTblrInner`
in `formatting.tex` automatically applies: box lines, bold centered header
row with gray background, and header repetition across page breaks.

### Standard table (no external source)

```latex
\begin{table}[H]
  \centering
  \caption{Table caption goes here}
  \label{tab:your-label}
  \begin{tblr}{colspec={c c c}}
    Column 1 & Column 2 & Column 3 \\
    Data 1-1 & Data 1-2 & Data 1-3 \\
    Data 2-1 & Data 2-2 & Data 2-3 \\
  \end{tblr}
\end{table}
```

**Key rules:**

- `\caption{}` and `\label{}` go **above** `\begin{tblr}` — not below.
- `\label{}` must always come immediately after `\caption{}`.
- First row is treated as header automatically (bold, gray, centered) by the global config.
- A table must not span more than one page. Split into separate tables if needed.

### Table with external source

When data is taken from an external source, add a source line **below**
`\end{tblr}` but still inside `\begin{table}`.

```latex
\begin{table}[H]
  \centering
  \caption{Contoh penulisan tabel otomatis}
  \label{tab:contoh1}
  \begin{tblr}{colspec={c c c}}
    Kolom 1  & Kolom 2  & Kolom 3  \\
    Data 1-1 & Data 1-2 & Data 1-3 \\
    Data 2-1 & Data 2-2 & Data 2-3 \\
  \end{tblr}

  \vspace{4pt}
  {\fontsize{12}{15}\selectfont Sumber: Badan Pusat Pengolahan Data, 2026 \cite{buku_contoh}\par}
\end{table}
```

**Key rules:**

- Source line: 12pt, not italic, centered implicitly by `\centering`.
- `\vspace{4pt}` separates the table body from the source line.
- Always include a `\cite{}` at the end of the source line.

### Column alignment options

```latex
% c = centered, l = left, r = right, X = flexible width
\begin{tblr}{colspec={l X c r}}
```

### Referencing a table in text

Always reference and discuss a table in the paragraph **before** it appears:

```latex
Tabel~\ref{tab:your-label} menunjukkan hasil perbandingan antara metode A dan B.

\begin{table}[H]
  ...
\end{table}
```

---

## Figures

Caption goes **below** the image. For external sources, the source line goes
between the image and the caption.

### Standard figure (no external source)

```latex
\begin{figure}[H]
  \centering
  \includegraphics[width=0.8\textwidth]{filename.png}
  \caption{Caption text for the figure}
  \label{fig:your-label}
\end{figure}
```

**Key rules:**

- `width=0.8\textwidth` is the recommended default. Adjust as needed.
- `\label{}` must come immediately after `\caption{}`.
- Use `[H]` to fix placement where it is declared.

### Figure with external source

```latex
\begin{figure}[H]
  \centering
  \includegraphics[width=0.8\textwidth]{filename.png}

  {\fontsize{12}{15}\selectfont\itshape Sumber: http://source-url.com\par}

  \caption{Caption text for the figure}
  \label{fig:your-label}
\end{figure}
```

**Key rules:**

- Source line: 12pt, **italic**, placed between the image and `\caption{}`.
- One blank line above and below the source line (for readability in source code).

### Referencing a figure in text

Always reference and discuss a figure in the paragraph **before** it appears:

```latex
Gambar~\ref{fig:your-label} menunjukkan arsitektur sistem secara keseluruhan.

\begin{figure}[H]
  ...
\end{figure}
```

---

## Mathematical Equations

### Single equation

```latex
\begin{equation}
  y = mx + c
  \label{eq:your-label}
\end{equation}
```

**Key rules:**

- Always assign `\label{}` — even if you think you won't reference it.
- The equation number is right-aligned and auto-formatted as bold italic `(3.1)`.
- Indentation from the left margin (10mm) is handled by `\mathindent` in the config.
- Leave one blank line in source above and below `\begin{equation}`.

### Multiple consecutive equations

```latex
\begin{equation}
  v = v_0 + at
  \label{eq:glbb1}
\end{equation}
\begin{equation}
  s = v_0 t + \frac{1}{2}at^2
  \label{eq:glbb2}
\end{equation}
```

Do not use `align` or `eqnarray` for separate numbered equations — use
individual `equation` environments, each with its own label.

### Inline equation

```latex
% Use \( ... \) — never use $ ... $
The value of \( E = mc^2 \) represents the energy-mass relationship.
```

### Referencing an equation in text

```latex
% Always discuss the equation in the paragraph after it appears
\begin{equation}
  F = m \cdot a
  \label{eq:newton}
\end{equation}

Persamaan~(\ref{eq:newton}) menunjukkan hubungan antara gaya, massa, dan percepatan.
```

---

## Citations

This template uses IEEE citation style (`IEEEtran` + `\cite{}`).

### Paraphrase (indirect citation)

The most common form. Cite at the end of the sentence, before the period.

```latex
Metode ini telah terbukti efektif dalam berbagai studi sebelumnya \cite{author2024}.
```

### Short direct quote (1–2 lines)

Italic text, wrapped in double quotes, citation directly after the closing quote.

```latex
\textit{``This is the exact quoted sentence from the source''}\cite{author2024}.
```

### Long direct quote (more than 2 lines)

Use the custom `kutipanpanjang` environment defined in `formatting.tex`.
This applies 10pt font and 10mm indent on both sides automatically.

```latex
\begin{kutipanpanjang}
  ``This is a long passage taken directly from a source. It spans more than
  two lines and therefore requires the special block quote formatting as
  defined in the Rev05 guideline.'' \cite{author2024}
\end{kutipanpanjang}
```

### Citing multiple sources

```latex
% Multiple sources in one cite
Penelitian ini didukung oleh beberapa studi \cite{source1, source2, source3}.

% Multiple sources for a direct short quote
\textit{``Quoted text''}\cite{source1, source2}.
```

### BibTeX entry types

```bibtex
% Journal article
@article{key,
  author  = {Last, First and Last2, First2},
  title   = {Article Title},
  journal = {Journal Name},
  volume  = {1},
  number  = {1},
  pages   = {1--10},
  year    = {2024}
}

% Conference paper
@inproceedings{key,
  author    = {Last, First},
  title     = {Paper Title},
  booktitle = {Conference Name},
  pages     = {1--5},
  year      = {2024}
}

% Book
@book{key,
  author    = {Last, First},
  title     = {Book Title},
  publisher = {Publisher Name},
  edition   = {2},
  year      = {2023}
}

% Thesis / final project
@mastersthesis{key,
  author = {Last, First},
  title  = {Thesis Title},
  school = {Politeknik Elektronika Negeri Surabaya},
  year   = {2024}
}

% Website / online source
@misc{key,
  author  = {Last, First},
  title   = {Article Title},
  year    = {2024},
  url     = {https://example.com},
  note    = {Accessed: 2024-01-01}
}
```

---

## Lists

### Numbered list (batasan masalah, langkah-langkah)

```latex
\begin{enumerate}[label=\arabic*., leftmargin=*]
  \item First item.
  \item Second item.
  \item Third item.
\end{enumerate}
```

### Bullet list

```latex
\begin{itemize}[leftmargin=*]
  \item First item.
  \item Second item.
\end{itemize}
```

### Labeled list (sistematika penulisan)

Used in Chapter 1 for the Sistematika Penulisan section.

```latex
\begin{description}[leftmargin=2.2cm, labelsep=0cm, itemsep=0.1cm]
  \item[{\makebox[2.2cm][l]{\textbf{Bab 1}}}] \textbf{Pendahuluan}\\
    Brief description of what Chapter 1 covers.

  \item[{\makebox[2.2cm][l]{\textbf{Bab 2}}}] \textbf{Kajian Pustaka}\\
    Brief description of what Chapter 2 covers.
\end{description}
```

---

## Text Formatting

### Foreign terms and technical terms (italic)

```latex
% Always use \textit{} for foreign or technical terms
Metode \textit{deep learning} digunakan untuk klasifikasi gambar.
Arsitektur \textit{encoder-decoder} diterapkan pada model ini.
```

### Bold text (use sparingly)

```latex
% Only for key terms being defined, not for general emphasis
\textbf{Sistem pakar} adalah sistem yang meniru kemampuan pakar manusia.
```

### All-caps heading (automatic — do not force manually)

Chapter and section headings are automatically uppercased by the format config.
Write them in title case inside the command:

```latex
% CORRECT — title case in source, auto-uppercased in output
\chapter{Kajian Pustaka}
\section{Teori Penunjang}

% WRONG — do not force uppercase manually
\chapter{KAJIAN PUSTAKA}
\section{\MakeUppercase{Teori Penunjang}}
```

---

## Cross-referencing Rules

Follow this pattern consistently for every figure, table, and equation:

1. **Discuss it in the paragraph before the float** — introduce it, explain what it shows.
2. **Use `~` before `\ref{}`** — prevents a line break between the word and the number.
3. **Capitalize the element name** — `Gambar`, `Tabel`, `Persamaan`.

```latex
% Correct pattern for each type
Gambar~\ref{fig:label} menunjukkan ...
Tabel~\ref{tab:label} menunjukkan ...
Persamaan~(\ref{eq:label}) menunjukkan ...
```

---

## Spacing and Blank Lines

These rules apply to source code formatting for consistency:

- Leave **one blank line** above and below every float (`figure`, `table`, `equation`).
- Leave **one blank line** between paragraphs in source (this does not add visual spacing — `\parskip=0pt` is set in the config).
- Do **not** add `\\` at the end of regular paragraph text. Only use `\\` for intentional line breaks inside structured environments.
- Do **not** add `\vspace{}` between sections — section spacing is handled by `\titlespacing` in the config.

---

## Common Mistakes to Avoid

| Wrong                                     | Correct                                        |
| ----------------------------------------- | ---------------------------------------------- |
| `\caption{}` below `\end{tblr}`           | `\caption{}` above `\begin{tblr}`              |
| `$E = mc^2$` for inline math              | `\( E = mc^2 \)`                               |
| `\chapter{PENDAHULUAN}` (manual caps)     | `\chapter{Pendahuluan}`                        |
| `\label{}` before `\caption{}`            | `\label{}` always after `\caption{}`           |
| Referencing without `~` (`Gambar \ref{}`) | Always `Gambar~\ref{}`                         |
| Placing `\label{}` outside the float      | Always inside `figure`, `table`, or `equation` |
| Using `tabular` for new tables            | Use `tblr` from `tabularray`                   |
| Floating figure without `[H]`             | Always use `[H]` for consistent placement      |

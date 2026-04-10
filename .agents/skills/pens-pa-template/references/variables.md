# Variable Reference

All variables are defined in `config/variables.tex`.
Edit only that file to update identity data across the whole document.

## Student

| Variable         | Description                   | Example        |
| ---------------- | ----------------------------- | -------------- |
| `\NamaMahasiswa` | Full student name, title case | `Budi Santoso` |
| `\NRP`           | Student registration number   | `2324560001`   |

## Thesis Title

| Variable   | Description       | Notes                                                                                             |
| ---------- | ----------------- | ------------------------------------------------------------------------------------------------- |
| `\JudulPA` | Full thesis title | Write in title case. `\MakeUppercase` is applied automatically where the style requires all caps. |

## Supervisors

| Variable              | Description                                 |
| --------------------- | ------------------------------------------- |
| `\NamaPembimbingSatu` | Supervisor 1 full name with academic titles |
| `\NIPPembimbingSatu`  | Supervisor 1 NIP                            |
| `\NamaPembimbingDua`  | Supervisor 2 full name with academic titles |
| `\NIPPembimbingDua`   | Supervisor 2 NIP                            |

## Examiners

| Variable           | Description                               |
| ------------------ | ----------------------------------------- |
| `\NamaPengujiSatu` | Examiner 1 full name with academic titles |
| `\NIPPengujiSatu`  | Examiner 1 NIP                            |
| `\NamaPengujiDua`  | Examiner 2 full name with academic titles |
| `\NIPPengujiDua`   | Examiner 2 NIP                            |

## Program Head

| Variable          | Description                                  |
| ----------------- | -------------------------------------------- |
| `\NamaKetuaProdi` | Head of study program, full name with titles |
| `\NIPKetuaProdi`  | Head of study program NIP                    |

## Institution

| Variable          | Description                       | Example                                |
| ----------------- | --------------------------------- | -------------------------------------- |
| `\NamaProdi`      | Study program name                | `Teknologi Rekayasa Komputer`          |
| `\NamaDepartemen` | Department name                   | `Teknik Informatika dan Komputer`      |
| `\GelarLulus`     | Degree title earned               | `Sarjana Terapan Komputer (S.Tr.Kom.)` |
| `\TahunLulus`     | Graduation year                   | `2025`                                 |
| `\TanggalSidang`  | Defense date, shown on statements | `Surabaya, \today` or a fixed date     |

## Usage in Files

These variables can be used anywhere in `pages/` and `chapters/` files:

```latex
% Example usage
Penelitian ini ditulis oleh \NamaMahasiswa\ dengan NRP \NRP.
Dibimbing oleh \NamaPembimbingSatu\ (NIP. \NIPPembimbingSatu).
```

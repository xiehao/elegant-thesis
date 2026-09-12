# Copilot Instructions for Elegant Thesis

## Build and validation

- This is a XeLaTeX thesis template. Build from the repository root with:

  ```bash
  latexmk -xelatex main.tex
  ```

  The template uses CTeX (which loads `fontspec` and XeCJK) and Babel; do not compile it with pdfLaTeX.
- After changing the language package or font configuration, run `latexmk -C` once before rebuilding to discard incompatible auxiliary files from the previous typesetting stack.
- The bibliography is implemented with classic BibTeX commands (`\bibliographystyle{unsrt}` and `\bibliography{Bibliography}`), despite the README's reference to `biber`. Let `latexmk` run the necessary BibTeX and XeLaTeX passes.
- There is no automated test suite, lint command, or single-test target. Individual chapter, appendix, and front-matter files are not standalone documents; validate a change to any of them by compiling `main.tex`.

## Document architecture

- `main.tex` is the sole document entrypoint. It loads the two-sided `elegantthesis` class, inputs `ThesisInfo.tex`, calls `\maketitle`, and then inputs every content module in a deliberate order: front matter, thesis overview and introduction, numbered chapters, inline parts, conclusion, appendix divider and appendices, then bibliography. Add a new structural module to this input sequence.
- `elegantthesis.cls` owns the `report` base class plus the CTeX and Babel language setup. `elegantthesis.sty` owns the visual design: packages, fonts, geometry, colors, page styles, custom title pages, equation-reference formatting, and helper commands. Put base-document or language changes in the class and presentation changes in the style package.
- `ThesisInfo.tex` is the single user-editable metadata source. Set title-page fields there with the `\Thesis...` commands, including the Chinese and English titles, classification, security level, institution code, student ID, author, supervisor, discipline, major, research direction, college, submission date, academic year, committee, and logo. Do not hard-code these values in the class, style package, or content files.
- The title page renders textual metadata in centered, fixed-width underlined fields. Keep each value concise enough for its field; use `\\` in `\ThesisCommittee` to list multiple members.
- `FrontBackMatter/` contains dedication, acknowledgments, abstract, contents, nomenclature, and bibliography wrappers. `\maketitle` starts alphabetic page numbering, the abstract starts roman numbering, and `Chapters/Introduction.tex` switches to Arabic page 1 and establishes the two-sided inner/outer margins.
- `Chapters/` contains the thesis narrative. `Appendix/` uses distinct appendix presentation macros. `Bibliography.bib` is the citation database; `gfx/` holds graphics referenced by repository-relative paths.

## Template conventions

- Compile from the root and keep `\input{...}` paths root-relative and extensionless, matching `main.tex`.
- Start a numbered chapter with:

  ```tex
  \CustomChapter{<title>}
  \ChapterQuote{<quote>}{<author>}
  \label{ch:<identifier>}
  ```

- `\CustomChapter` advances the chapter counter and initializes dependent section, figure, table, equation, and footnote counters. It also creates the table-of-contents and running-header entries, so never supply a chapter number or duplicate those commands in the content file.
- Use `\CustomIntroduction`, `\CustomConclusion`, and `\CustomAppendix` for those nonstandard structural pages; their displayed numbers and associated entries are derived automatically. `\InlinePart` remains the template's dedicated inline part divider.
- Preserve reference prefixes used across modules: `ch:` for chapters, `ann:` for appendices, `eq:` for equations, `fig:` for figures, and `tab:` for tables. Use `\eqref{...}` for equations so the preamble's linked, colored equation style is retained.
- CTeX provides Chinese support and Babel loads English language rules. CTeX automatically uses the TeX Live-supplied `FandolSong-Regular.otf` for CJK glyphs while retaining TeX Gyre Pagella for Latin text, so normal Chinese-English prose does not require `\textenglish{...}`.
- Cite entries with `\cite{<key>}` from `Bibliography.bib`. Keep the bibliography inclusion in `FrontBackMatter/Bibliography.tex`; it applies the custom bibliography heading, page style, TOC entry, and back-reference presentation.
- Figures use `\includegraphics` with paths such as `gfx/figure1` (extension omitted) and are normally placed in `[H]` floats. Follow the nearby chapter's caption, label, and table formatting style for new content.

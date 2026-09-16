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

- `main.tex` is the sole document entrypoint. It loads the two-sided `elegantthesis` class, inputs `ThesisInfo.tex`, calls `\maketitle` and `\makedeclaration`, and then inputs every content module in a deliberate order: front matter, thesis overview and introduction, numbered chapters, inline parts, conclusion, appendix divider and appendices, then bibliography. Add a new structural module to this input sequence.
- `elegantthesis.cls` owns the `book` base class, metadata setters, `\maketitle`, and `\makedeclaration`. `elegantthesis.sty` owns CTeX/Babel setup and the visual design: packages, fonts, geometry, paragraph layout, colors, page styles, equation-reference formatting, and helper commands. Put base-document or metadata changes in the class and presentation changes in the style package.
- `ThesisInfo.tex` is the single user-editable metadata source. Set title-page fields there with the `\Thesis...` commands, including the Chinese and English titles, classification, security level, institution code, student ID, author, supervisor, discipline, major, research direction, college, submission date, academic year, committee, and logo. It also configures the declaration and authorization pages: signature-image paths, the declaration date, author authorization date, supervisor authorization date, declassification year, and `public` or `confidential` status (default `public`). The declassification year is shown only for confidential theses. Leave a signature path empty to reserve blank signing space. Do not hard-code these values in the class, style package, or content files.
- `ThesisInfo.tex` also centralizes structural interface labels through `\ThesisHeading{<key>}{<text>}`. The supplied values are Chinese; replace them to use another language. Use `\ThesisHeadingText{<key>}` rather than hard-coding a template-controlled heading in a content module, page style, or table-of-contents entry.
- The title page renders textual metadata in centered, fixed-width underlined fields. Long title and committee values wrap automatically, and every resulting line receives a fixed-width underline.
- `FrontBackMatter/` contains dedication, acknowledgments, abstract, contents, nomenclature, and bibliography wrappers. `main.tex` uses the `book` class's `\frontmatter`, `\mainmatter`, and `\backmatter`: front matter begins after the declaration page, the main matter begins before the introduction, and back matter begins before the bibliography. Do not reset page numbering inside content modules.
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
- The global paragraph layout is a 2em first-line indent, 1.2 line stretch, and a 0.4-baseline paragraph gap. Keep deliberate local exceptions (such as the thesis-overview callout boxes) scoped, and restore the global values afterward.
- Cite entries with `\cite{<key>}` from `Bibliography.bib`. Keep the bibliography inclusion in `FrontBackMatter/Bibliography.tex`; it applies the custom bibliography heading, page style, TOC entry, and back-reference presentation.
- Figures use `\includegraphics` with paths such as `gfx/figure1` (extension omitted) and are normally placed in `[H]` floats. Follow the nearby chapter's caption, label, and table formatting style for new content.

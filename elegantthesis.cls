\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{elegantthesis}[2026/09/11 Elegant thesis document class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass{report}

\RequirePackage[UTF8,scheme=plain,fontset=none]{ctex}
\RequirePackage[english]{babel}
\RequirePackage{elegantthesis}

\endinput

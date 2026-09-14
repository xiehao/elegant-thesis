\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{elegantthesis}[2026/09/11 Elegant thesis document class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass{report}

\makeatletter
\def\thesis@classification{}
\def\thesis@securitylevel{}
\def\thesis@institutioncode{}
\def\thesis@studentid{}
\def\thesis@college{}
\def\thesis@degree{}
\def\thesis@title{}
\def\thesis@englishtitle{}
\def\thesis@author{}
\def\thesis@supervisor{}
\def\thesis@discipline{}
\def\thesis@researchdirection{}
\def\thesis@submissiondate{}
\def\thesis@logo{}

\newcommand{\ThesisClassification}[1]{\gdef\thesis@classification{#1}}
\newcommand{\ThesisSecurityLevel}[1]{\gdef\thesis@securitylevel{#1}}
\newcommand{\ThesisInstitutionCode}[1]{\gdef\thesis@institutioncode{#1}}
\newcommand{\ThesisStudentId}[1]{\gdef\thesis@studentid{#1}}
\newcommand{\ThesisCollege}[1]{\gdef\thesis@college{#1}}
\newcommand{\ThesisDegree}[1]{\gdef\thesis@degree{#1}}
\newcommand{\ThesisTitle}[1]{\gdef\thesis@title{#1}}
\newcommand{\ThesisEnglishTitle}[1]{\gdef\thesis@englishtitle{#1}}
\newcommand{\ThesisAuthor}[1]{\gdef\thesis@author{#1}}
\newcommand{\ThesisSupervisor}[1]{\gdef\thesis@supervisor{#1}}
\newcommand{\ThesisDiscipline}[1]{\gdef\thesis@discipline{#1}}
\newcommand{\ThesisResearchDirection}[1]{\gdef\thesis@researchdirection{#1}}
\newcommand{\ThesisSubmissionDate}[1]{\gdef\thesis@submissiondate{#1}}
\newcommand{\ThesisLogo}[1]{\gdef\thesis@logo{#1}}
\makeatother

\RequirePackage[UTF8,scheme=plain,fontset=none]{ctex}
\RequirePackage[english]{babel}
\RequirePackage{elegantthesis}

\endinput

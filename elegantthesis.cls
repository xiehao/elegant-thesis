\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{elegantthesis}[2026/09/11 Elegant thesis document class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass{book}

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
\def\thesis@authorsignature{}
\def\thesis@supervisorsignature{}
\def\thesis@declarationdate{}
\def\thesis@authorizationauthordate{}
\def\thesis@authorizationsupervisordate{}
\def\thesis@declassificationyear{}
\def\thesis@confidentiality{public}
\def\thesis@confidentialvalue{confidential}
\def\thesis@publicvalue{public}
\newif\ifthesis@confidential
\thesis@confidentialfalse

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
\newcommand{\ThesisAuthorSignature}[1]{\gdef\thesis@authorsignature{#1}}
\newcommand{\ThesisSupervisorSignature}[1]{\gdef\thesis@supervisorsignature{#1}}
\newcommand{\ThesisDeclarationDate}[1]{\gdef\thesis@declarationdate{#1}}
\newcommand{\ThesisAuthorizationAuthorDate}[1]{\gdef\thesis@authorizationauthordate{#1}}
\newcommand{\ThesisAuthorizationSupervisorDate}[1]{\gdef\thesis@authorizationsupervisordate{#1}}
\newcommand{\ThesisDeclassificationYear}[1]{\gdef\thesis@declassificationyear{#1}}
\newcommand{\ThesisConfidentiality}[1]{%
    \def\thesis@confidentiality{#1}%
    \ifx\thesis@confidentiality\thesis@confidentialvalue
        \thesis@confidentialtrue
    \else\ifx\thesis@confidentiality\thesis@publicvalue
        \thesis@confidentialfalse
    \else
        \ClassError{elegantthesis}{Unknown confidentiality value `#1'}{Use `public' or `confidential'.}%
    \fi\fi
}
\makeatother

\RequirePackage{elegantthesis}

% ==========================
% Title Page
% ==========================
\makeatletter
\newcommand{\thesis@field}[2]{%
    \underline{\makebox[#1][c]{#2}}%
}
\newsavebox{\thesis@multilinebox}
\newdimen\thesis@fieldheight
\newdimen\thesis@fieldoffset
\newcount\thesis@fieldlinecount
\newcount\thesis@fieldlineindex
\newcommand{\thesis@multilinefield}[2]{%
    \sbox{\thesis@multilinebox}{%
        \parbox[b]{#1}{\centering\strut #2\par}%
    }%
    \thesis@fieldheight=\ht\thesis@multilinebox
    \advance\thesis@fieldheight by \dp\thesis@multilinebox
    \advance\thesis@fieldheight by -\baselineskip
    \thesis@fieldlinecount=1
    \loop\ifdim\thesis@fieldheight>0pt
    \advance\thesis@fieldlinecount by 1
    \advance\thesis@fieldheight by -\baselineskip
    \repeat
    \begin{tikzpicture}[baseline=(text.base)]
        \node[inner sep=0pt, outer sep=0pt] (text) {\usebox{\thesis@multilinebox}};
        \thesis@fieldoffset=-0.65ex
        \thesis@fieldlineindex=1
        \loop
        \draw[line width=1pt]
        ([yshift=\thesis@fieldoffset]text.south west) --
            ([yshift=\thesis@fieldoffset]text.south east);
        \advance\thesis@fieldoffset by \baselineskip
        \advance\thesis@fieldlineindex by 1
        \ifnum\thesis@fieldlineindex<\numexpr\thesis@fieldlinecount+1\relax
        \repeat
    \end{tikzpicture}%
}

\renewcommand{\maketitle}{%
    \hypersetup{pdftitle={\thesis@title},pdfauthor={\thesis@author}}%
    \begin{titlepage}
        \thispagestyle{empty}%
        \begin{center}
            \vspace*{-12ex}
            \zihao{5}
            \begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}>{\bfseries}r@{\extracolsep{0pt}}>{\ttfamily}l@{}}
                & 密级： & \thesis@field{2.5cm}{\thesis@securitylevel} \\
                & 分类号： & \thesis@field{2.5cm}{\thesis@classification} \\
                & 学号： & \thesis@field{2.5cm}{\thesis@studentid} \\
                & 单位代码： & \thesis@field{2.5cm}{\thesis@institutioncode}
            \end{tabular*}

            \vspace{1.2cm}
            \includegraphics[width=0.618\textwidth]{\thesis@logo}\par

            \vspace{0.9cm}
            {\zihao{-1}\bfseries \thesis@degree\par}
            % \vspace{1.2cm}
            \vfill
            {\zihao{2} \ttfamily\bfseries \thesis@multilinefield{0.88\textwidth}{\thesis@title}\par}
            \vfill

            \zihao{-4}
            \renewcommand{\arraystretch}{1.7}
            \begin{tabular}{@{}>{\bfseries}r>{\ttfamily}l@{}}
                作者姓名： & \thesis@field{0.45\textwidth}{\thesis@author}            \\
                指导教师： & \thesis@field{0.45\textwidth}{\thesis@supervisor}        \\
                学科专业： & \thesis@field{0.45\textwidth}{\thesis@discipline}        \\
                研究方向： & \thesis@field{0.45\textwidth}{\thesis@researchdirection} \\
                所在学院： & \thesis@field{0.45\textwidth}{\thesis@college}
            \end{tabular}

            \vspace{8ex}
            \begin{tabular}{@{}>{\bfseries}rl@{}}
                提交日期： & \thesis@field{0.45\textwidth}{\ttfamily\thesis@submissiondate}
            \end{tabular}
        \end{center}
    \end{titlepage}%
    \newgeometry{
        top=2.5cm, bottom=5.4cm,
        left=2.5cm, right=2.5cm,
        headsep=0.8cm, includehead
    }%
}

\newcommand{\thesis@signatureplaceholder}{%
    \makebox[4.5cm][c]{%
        \rule{0pt}{1.0cm}%
    }%
}
\newcommand{\thesis@signatureimage}[1]{%
    \makebox[4.5cm][c]{\includegraphics[height=1.0cm,keepaspectratio]{#1}}%
}
\newcommand{\thesis@authorsignaturefield}{%
    \ifdefempty{\thesis@authorsignature}{\thesis@signatureplaceholder}{\thesis@signatureimage{\thesis@authorsignature}}%
}
\newcommand{\thesis@supervisorsignaturefield}{%
    \ifdefempty{\thesis@supervisorsignature}{\thesis@signatureplaceholder}{\thesis@signatureimage{\thesis@supervisorsignature}}%
}
\newcommand{\thesis@confidentialbox}{%
    \ifthesis@confidential\(\CheckedBox\)\else\(\Square\)\fi
}
\newcommand{\thesis@publicbox}{%
    \ifthesis@confidential\(\Square\)\else\(\CheckedBox\)\fi
}
\newcommand{\thesis@declassificationyearfield}{%
    \ifthesis@confidential
        \thesis@field{3em}{\thesis@declassificationyear}%
    \else
        \underline{\hspace{3em}}%
    \fi
}
\newcommand{\makedeclaration}{%
    \cleardoublepage
    \hypersetup{pageanchor=false}%
    \thispagestyle{empty}%

    \begin{center}
        \AutoTitleLines{浙江传媒学院学位论文原创性声明}
    \end{center}

    本人郑重声明：所提交的学位论文是本人在导师的指导下，独立进行研究所取得的研究成果。除文中已经加以标注引用的内容外，本论文不包含其他个人或集体已经发表或撰写过的研究成果，也不含为获得浙江传媒学院或其它教育机构的学位证书而使用过的材料。对本研究作出重要贡献的个人和集体，均已在文中以明确方式标明。本人承担本声明的法律责任。

    \begin{flushright}
        作者签名：\thesis@authorsignaturefield\hspace{2em}
        日期：\thesis@field{4.5cm}{\thesis@declarationdate}
    \end{flushright}

    \vspace*{\fill}

    \begin{center}
        \AutoTitleLines{浙江传媒学院学位论文版权使用授权书}
    \end{center}

    本学位论文作者完全了解学校有关保留、使用学位论文的规定，同意学校保留并向国家有关部门或机构送交论文的复印件和电子版，允许论文被查阅和借阅。本人授权浙江传媒学院可以将本学位论文的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本学位论文。

    本学位论文属于：
    \begin{flushright}
        \begin{varwidth}{\linewidth}
            \begin{enumerate}[noitemsep,topsep=0pt,leftmargin=*]
                \item 保密\thesis@confidentialbox，在\thesis@declassificationyearfield 年解密后适用本授权书。
                \item 不保密\thesis@publicbox。
            \end{enumerate}
            （请在以上相应方框内打“\(\checkmark\)”）
        \end{varwidth}
    \end{flushright}

    \begin{flushright}
        作者签名：\thesis@authorsignaturefield\hspace{2em}
        日期：\thesis@field{4.5cm}{\thesis@authorizationauthordate}\\
        导师签名：\thesis@supervisorsignaturefield\hspace{2em}
        日期：\thesis@field{4.5cm}{\thesis@authorizationsupervisordate}
    \end{flushright}
}
\makeatother

\endinput

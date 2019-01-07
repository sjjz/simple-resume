\ProvidesClass{simple-resume}[2018/12/31 v0.0.0 Simple Resume]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt, letterpaper]{article}

% Removes paragraph indentations
\RequirePackage{parskip}
\RequirePackage{array}
\RequirePackage{ifthen}
% Required for hyperlinks
\RequirePackage{hyperref}
% Required for modifying "section" style
\RequirePackage[explicit]{titlesec}
% Required for horizontal lines
\RequirePackage{xhfill}
% Required for helper functions
\RequirePackage{etextools}
% Required for customizing list environments
\RequirePackage{enumitem}
% Required for adjusting margins
\RequirePackage{changepage}
% Required for multiline cells
\RequirePackage{tabularx}
% Required for configuring fonts
\RequirePackage{fontspec}

% No header/footers are needed
\pagestyle{empty}

% COLUMN TYPES
% Multiline column (use with tabularx)
\newcolumntype{m}{>{\raggedright\arraybackslash}X}

% CONTACT INFO
\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\phone}[1]{\def\@phone{#1}}
\newcommand{\email}[1]{\def\@email{#1}}
\newcommand{\github}[1]{\def\@github{#1}}
\newcommand{\linkedin}[1]{\def\@linkedin{#1}}

% HEADER
\newcommand\@contactSep{\quad\textbar\quad}
\newcommand{\@headerVspace}{\vspace{5pt}}
\newcommand{\@nameVspace}{\vspace{10pt}}
\newcommand{\makeHeader}{
    \begin{center}
        {\fontsize{32pt}{38pt}\selectfont \@name\\}
        \@nameVspace
        % Contacts
        \ifdefined\@phone
            \@phone \@contactSep
        \fi
        \ifdefined\@email
            \@email \@contactSep
        \fi
        \ifdefined\@github
            \href{https://github.com/\@github}{github.com/\@github} \@contactSep
        \fi
        \ifdefined\@linkedin
            \href{https://linkedin.com/in/\@linkedin}{linkedin.com/in/\@linkedin}
        \fi
    \end{center}
    \@headerVspace
}

% SECTION
\newcommand{\@sectionAfterSep}{-5pt}
\newcommand{\@sectionBeforeSep}{0pt}
\titleformat{\section}{\Large\bfseries}{}{0pt}{#1\xhrulefill{black}{0.5pt}}
\titlespacing*{\section}{0pt}{\@sectionBeforeSep}{\@sectionAfterSep}

% RESUME ENTRY
\newcommand{\@entryIndent}{5pt}
\newcommand{\@entryBodyIndent}{5pt}

% entry{<title>}{<subtitle>}{<date>}{<location>}
\newenvironment{entry}[4]{
    \begin{adjustwidth}{\@entryIndent}{}
        \begin{tabular*}{\linewidth}{@{}l @{\extracolsep{\fill}} >{\itshape}r@{}}
            \textbf{#1} & \ifempty{#3}{#4}{#3}
            \ifempty{#2#4}{}{\ifempty{#2#3}{}{\\\textit{#2} & \ifempty{#3}{}{#4}}}
        \end{tabular*}
        \begin{adjustwidth}{\@entryBodyIndent}{}
            \vspace{-5pt}
}{
        \end{adjustwidth}
    \end{adjustwidth}
}

% Environment for lists in entry body
\newenvironment{entryItems}{
    \begin{itemize}[leftmargin=*, nosep, itemsep=3pt]
}{
    \end{itemize}
}

\newenvironment{skills}{
    \section{Skills}
    % Use tabularx to allow multiline cells
    \tabularx{\linewidth - \@entryIndent}{@{\hspace{\@entryIndent}} >{\bfseries}l m @{}}
}{
    \endtabularx
}
\ProvidesClass{simple-resume}[2018/12/31 v0.0.0 Simple Resume]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt, letterpaper]{article}

% Required for defining colors
\RequirePackage{xcolor}
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
% Required for fontawesome icons
\RequirePackage{fontawesome}

% COLORS
\definecolor{linkcolor}{HTML}{0000ff}

\hypersetup{
    ocgcolorlinks,
    colorlinks,
    linkcolor=linkcolor,
    urlcolor=linkcolor
}
% No header/footers are needed
\pagestyle{empty}

% HELPER COMMANDS
\newcommand{\@iftrueelse}[3]{\ifthenelse{\boolean{#1}}{#2}{#3}}

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
\newcommand\@contactSep{\hspace{4pt}\textbullet\hspace{4pt}}
\newcommand\@contactIconSep{\hspace{2pt}}
\newcommand{\@headerVspace}{\vspace{5pt}}
\newcommand{\@nameVspace}{\vspace{10pt}}
\newcommand{\makeHeader}{%
    \begin{center}%
        {\fontsize{32pt}{38pt}\selectfont \@name\\}
        % Contacts
        \newboolean{isFirstContact}
        \setboolean{isFirstContact}{true}
        \ifdefined\@phone
            \@nameVspace
            \setboolean{isFirstContact}{false}
            \faPhone\@contactIconSep\@phone%
        \fi
        \ifdefined\@email
            \@iftrueelse{isFirstContact}
                {\setboolean{isFirstContact}{false}\@nameVspace}
                {\@contactSep}
            \faEnvelope\@contactIconSep\@email%
        \fi
        \ifdefined\@github
            \@iftrueelse{isFirstContact}
                {\setboolean{isFirstContact}{false}\@nameVspace}
                {\@contactSep}
            \href{https://github.com/\@github}{\faGithub\@contactIconSep{github.com/\@github}}%
        \fi
        \ifdefined\@linkedin
            \@iftrueelse{isFirstContact}
                {\setboolean{isFirstContact}{false}\@nameVspace}
                {\@contactSep}
            \href{https://linkedin.com/in/\@linkedin}{\faLinkedin\@contactIconSep{linkedin.com/in/\@linkedin}}%
        \fi
    \end{center}
    \@headerVspace% Space between header and content
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
\newenvironment{entry}[4]{%
    \begin{adjustwidth}{\@entryIndent}{}%
        \begin{tabular*}{\linewidth}{@{}l @{\extracolsep{\fill}} >{\itshape}r@{}}%
            \textbf{#1} & \ifempty{#3}{#4}{#3}%
            \ifempty{#2#4}{}{\ifempty{#2#3}{}{\\\textit{#2} & \ifempty{#3}{}{#4}}}%
        \end{tabular*}
        \begin{adjustwidth}{\@entryBodyIndent}{}%
            \vspace{-5pt}%
}{%
        \end{adjustwidth}%
    \end{adjustwidth}%
}

% Environment for lists in entry body
\newenvironment{entryItems}{%
    \begin{itemize}[leftmargin=*, nosep, itemsep=3pt]%
}{%
    \end{itemize}%
}

\newenvironment{skills}{%
    \section{Skills}
    % Use tabularx to allow multiline cells
    \tabularx{\linewidth - \@entryIndent}{@{\hspace{\@entryIndent}} >{\bfseries}l m @{}}%
}{%
    \endtabularx%
}
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
% Required for fontawesome icons
\RequirePackage{fontawesome}

\hypersetup{
    hidelinks
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
                {\@contactSep}%
            \faEnvelope\@contactIconSep\@email%
        \fi
        \ifdefined\@github
            \@iftrueelse{isFirstContact}
                {\setboolean{isFirstContact}{false}\@nameVspace}
                {\@contactSep}%
            \href{https://github.com/\@github}{\faGithub\@contactIconSep{github.com/\@github}}%
        \fi
        \ifdefined\@linkedin
            \@iftrueelse{isFirstContact}
                {\setboolean{isFirstContact}{false}\@nameVspace}
                {\@contactSep}%
            \href{https://linkedin.com/in/\@linkedin}{\faLinkedin\@contactIconSep{linkedin.com/in/\@linkedin}}%
        \fi
    \end{center}
    \@headerVspace% Space between header and content
}

% SECTION

\newcommand{\@sectionAfterSep}{-5pt}
\newcommand{\@sectionBeforeSep}{0pt}
\newcommand{\@sectionBodyIndent}{5pt}
\titleformat{\section}{\Large\bfseries}{}{0pt}{#1\xhrulefill{black}{0.5pt}}
\titlespacing*{\section}{0pt}{\@sectionBeforeSep}{\@sectionAfterSep}
% Custom section environment for resume.
\newenvironment{rSection}[1]{%
    \section{#1}
    \begin{adjustwidth}{\@sectionBodyIndent}{}%
}{%
    \end{adjustwidth}%
}

% RESUME ENTRY

% Draws the header for the entry.
% entryHeader{<title>}{<subtitle>}{<date>}{<location>}
\newcommand{\@entryHeader}[4]{%
    \begin{tabular*}{\linewidth}{@{}l @{\extracolsep{\fill}} >{\itshape}r@{}}%
        \textbf{#1} & \ifempty{#3}{#4}{#3}%
        \ifempty{#2#4}{}{\ifempty{#2#3}{}{\\\textit{#2} & \ifempty{#3}{}{#4}}}
    \end{tabular*}%
}

\newcommand{\@entryBodyIndent}{5pt}

% Environment for a resume entry. The body of the environment is the description.
% entry{<title>}{<subtitle>}{<date>}{<location>}
\newenvironment{entry}[4]{%
    \@entryHeader{#1}{#2}{#3}{#4}
    \begin{adjustwidth}{\@entryBodyIndent}{}%
        \vspace{-5pt}%
}{%
    \end{adjustwidth}%
}

% Environment for lists in entry body
\newenvironment{entryItems}{%
    \begin{itemize}[leftmargin=*, nosep, itemsep=3pt, topsep=3pt]%
}{%
    \end{itemize}%
}

% SKILLS

% List environment for skills
% First column: Skillset category name
% Second column: Skills
\newenvironment{skills}{%
    % Use tabularx to allow multiline cells
    \tabularx{\linewidth}{@{} >{\bfseries}l m @{}}%
}{%
    \endtabularx%
}

% EDUCATION

% education{<school>}{<degree>}{<location>}{<gradutaion date>}{<description>}
\newcommand{\education}[5]{%
    \ifempty{#5}{%
        % If there is no body only draw a header
        \@entryHeader{#1}{#2}{#3}{#4}%
    }{% If there is a body then treat as normal entry
        \begin{entry}{#1}{#2}{#3}{#4}#5\end{entry}%
    }%
}


\ProvidesClass{simple-resume}[2018/12/31 v0.0.0 Simple Resume]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[12pt, letterpaper]{article}

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

% No header/footers are needed
\pagestyle{empty}

% CONTACT INFO
\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\phone}[1]{\def\@phone{#1}}
\newcommand{\email}[1]{\def\@email{#1}}
\newcommand{\github}[1]{\def\@github{#1}}
\newcommand{\linkedin}[1]{\def\@linkedin{#1}}

% HEADER
\newcommand\@contactSep{\quad\textbar\quad}
\newcommand{\makeHeader}{
    \begin{center}
        {\huge \@name\\}
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
}

% SECTION
\titleformat{\section}{\large\bfseries}{}{0pt}{#1\xhrulefill{black}{0.5pt}}
\titlespacing*{\section}{0pt}{0pt}{0pt}

% RESUME ENTRY
\newcommand{\@entryIndent}{5pt}
\newcommand{\@entryBodyIndent}{5pt}

% entry{<title>}{<subtitle[optional]>}{<location[optional]>}{<date[optional]>}
\newenvironment{entry}[4]{
    \begin{adjustwidth}{\@entryIndent}{}
        \begin{tabular*}{\linewidth}{@{}l @{\extracolsep{\fill}} r@{}}
            \textbf{#1} & \textit{\ifempty{#3}{#4}{#3}}\\
            \textit{#2} & \textit{\ifempty{#3}{}{#4}}
        \end{tabular*}
        \begin{adjustwidth}{\@entryBodyIndent}{}
}{
        \end{adjustwidth}
    \end{adjustwidth}
}

% Environment for lists in entry body
\newenvironment{entryItems}{
    \begin{itemize}[leftmargin=*]
}{
    \end{itemize}
}
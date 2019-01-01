\ProvidesClass{simple-resume}[2018/12/31 v0.0.0 Simple Resume]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[12pt, letterpaper]{article}

% Removes paragraph indentations
\RequirePackage[parfill]{parskip}
\RequirePackage{array}
\RequirePackage{ifthen}
% Required for hyperlinks
\RequirePackage{hyperref}

% No header/footers are needed
\pagestyle{empty}

% CONTACT INFO
\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\phone}[1]{\def\@phone{#1}}
\newcommand{\email}[1]{\def\@email{#1}}
\newcommand{\github}[1]{\def\@github{#1}}
\newcommand{\linkedin}[1]{\def\@linkedin{#1}}

% WHITESPACE/SEPERATORS
\def\@contactSep{\quad\textbar\quad}

% HEADER
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

#!/usr/bin/env perl

$pdflatex = 'pdflatex %O -synctex=1 -interaction=nonstopmode %S';
$lualatex = 'lualatex %O -synctex=1 -interaction=nonstopmode %S';
$xelatex = 'xelatex %O -no-pdf -synctex=1 -shell-escape -interaction=nonstopmode %S';
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$dvipdf = 'dvipdfmx %O -o %D %S';
$dvips = 'dvips %O -z -f %S | convbkmk -u > %D';
$pdf_mode = 4;
$pvc_view_file_via_temporary = 0;
$pdf_previewer = 'open -ga /System/Applications/Preview.app/';


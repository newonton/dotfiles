autoload -U colors && colors

typeset -A C

local -a color_names=(
  black red green yellow blue magenta cyan white
  brightblack brightred brightgreen brightyellow brightblue brightmagenta brightcyan brightwhite
)

for i in {0..15}; do
  C[${color_names[$((i+1))]}]="%F{$i}"
done

C[reset]="%f%k"

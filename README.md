# `select_inner.vim`

#### Reduce a selection to the inner block

See [this stack overflow
question](https://stackoverflow.com/questions/70937148/vi-increases-the-visual-selection-but-can-i-reduce-the-visual-selection-in-a)
for the initial question.

This plugin provides an opposite command to `va{` and friends, which instead of
selecting the `{}` block surrounding the cursor, it will select the largest
`{}` block fully contained in the current visual selection. For example:

If I've got a text block like:
```
if answer == 42 {                        #1
    if bugs == 'bunny' {                 #2
        if injury == 'but a scratch' {   #3
            // do the thing              #4
        }                                #5
    }                                    #6
}                                        #7
```
and I've got my cursor on `// do the thing` and do the `va{` command, then I'll
select the `{}` from lines 3 to 5, and if I do `a{` again then I'll select `{}`
from lines 2 to 6.

But oh no, I now realize that I actually only wanted to select the `{}` from
lines 3 to 5. To my horror, the usual vim method of `capitalisation =>
opposite` doesn't work and `A{` simply appends a `{` to the end of the line.


This plugin solves this problem

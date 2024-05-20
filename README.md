# matlab-latex-variables
Automatically update values from a matlab script in a latex document

## Motivation
When writing documentation of technical projects in latex, I often had to update values I got from calculations in Matlab (due to miscalculations or changed specifications). As this is boring and annoying work, I implemented these scripts/functions to be able to reference matlab variables directly in my documents so they update automatically.

## Usage
There are currently three parts:
### Matlab part
Put the function transfer.m into a folder in the Matlab PATH so Matlab can find it.
- For me (on Fedora 40 Linux) it is `/home/\[user]/Documents/MATLAB`

In your Matlab script use
```transfer(\[file path], var1, ..., varN)```
where the variables can be numerical or symbolical. Symbolical (and matrices) get parsed to LaTeX format. Even plain text is possible, as long as it is not including a comma or linebreak, which would break the csv-parsing.
Boolean variables are converted into `1` (true) or `0` (false).

### Transfer file
The file used by both parts. It is just a simple csv-file with `\[name],\[value]"` in each line.

### Latex part
Put the file `MLtransfer.tex` into your latex-projects folder (or use another path in the following command).
In a latex-file use
```\input{MLtransfer.tex}```
to access it. Variables can be imported from the file they have been saved to from Matlab using
```\loadvariables{\[namespace]}{\[file path]}```
- \[namespace] is a prefix added to each variable. Can be used to have multiple variables from different files/matlab-scripts with the same name.
- \[file path] includes the file extension (.txt) and can be relative path including changes in directory. e.g.:
	- example.txt if its in the same folder
	- /subfolder/example.txt if its in a sub folder
	- ../../otherfolder/example.txt goes two folders back from original directory and into than into the new subfolder
- Unlimited files can be loaded, as long as they are using different namespaces. 

Finally imported variables can be used as 
```\\mvar{\[namespace]}{\[var name]}```
- The var name must not include underscores or other special characters which lead to latex parsing problems. If the variable name in Matlab includes these, these characters are just deleted.
- Don't forget to put (especially symbolical values) in a math environment like `$...$`
- e.g.: 
	- given the file test.txt with the content `bar,123`
	- `\\loadvariables{foo}{test.txt}`
	- In the text: `mvar{foo}{bar}` gives `123`

Saved boolean variables can be used with
```\\mvaristrue{\[namepsace]}{\[var name]}{\[text if true]}{\[text if false]}```
where the used variable (from the given namespace) is checked to be 1. If it is 1, the expression evaluates as true and the correpsonding text is displayed (the text can include any latex code), if it is not 1, the other text repsectively is shown/returned. This can be useful for implementing an automatic documentation for used calculation "algorithms" (for me e.g. calculating screws after VDI 2230). 

## Credits
The basic csv-parser is copied from Stackexchange user's Phelype Oleinik answer (edited by Mensch) with a lot of own additions. https://tex.stackexchange.com/questions/474397/populate-information-from-a-csv-file-into-a-latex-document-specifically-into-th/474404#474404 , last accessed May 20, 2024

The parser for Matlab matrices to latex notation is from Matlab user Lu Ce with minimal changes.
Lu Ce (2024). Matlab matrix to LaTeX conversion example (https://www.mathworks.com/matlabcentral/fileexchange/80629-matlab-matrix-to-latex-conversion-example), MATLAB Central File Exchange. Retrieved May 20, 2024. 


## Planned features/ideas
- Add a function for exporting from other numeric tools, like python's numpy etc. Should be relatively simple :)
- Change from csv using comma as the separator to tab, allowing for more flexibility as what can be "transferred" (e.g. normal text).
- Access elements of matrices/arrays directly. Currently they have to be manually saved as scalar values, as matrices are always shown in pmatrix-environments.
- Allow for all Matlab evnironemt variables to be exported at once. It can get annoying with lots of variables, still less annoying than doing it by hand ;)
- Allow for specifying the number of significant/decimal figures to be shown, including scientific notation.

If you have ideas for more features, feel free to contact me.

There are likely better solutions (with cleaner code) out there, but I only wanted this to work easily :)
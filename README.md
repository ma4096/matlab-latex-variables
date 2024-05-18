# matlab-latex-variables
Automatically update values from a matlab script in a latex document

## Motivation
When writing documentation of technical projects in latex, I often had to update values I got from calculations in Matlab (due to miscalculations or changed specifications). As this is boring and annoying work, I implemented these scripts/functions to be able to reference matlab variables directly in my documents so they update automatically.

## Usage
There are currently three parts:
### Matlab part
Put the function transfer.m into a folder in the Matlab PATH so Matlab can find it.
- For me (on Fedora 40 linux) it is "/home/\[user]/Documents/MATLAB"

In your Matlab script use
transfer(\[file path], var1, ..., var2)
where the variables can be numerical or symbolical. Symbolical (and matrices) get parsed to LaTeX format. Even plain text is possible, as long as it is not including a comma or linebreak, which would break the csv-parsing.

### Transfer file
The file used by both parts. It is just a simple csv-file with "\[name],\[value]" in each line.

### Latex part
Put the file "MLtransfer.tex" into your latex-projects folder (or use another path in the following command).
In a latex-file use
\input{MLtransfer.tex}
to access it. Variables can be imported from the file they have been saved to from Matlab using
\loadvariables{\[namespace]}{\[file path]}
- \[namespace] is a prefix added to each variable. Can be used to have multiple variables from different files/matlab-scripts with the same name.
- \[file path] includes the file extension (.txt) and can be relative path including changes in directory. e.g.:
	- example.txt if its in the same folder
	- /subfolder/example.txt if its in a sub folder
	- ../../otherfolder/example.txt goes two folders back from original directory and into than into the new subfolder
- Unlimited files can be loaded, as long as they are using different namespaces. 

Finally imported variables can be used as 
"\\mvar{\[namespace]}{\[var name]}"
- The var name must not include underscores or other special characters which lead to latex parsing problems. If the variable name in Matlab includes these, these characters are just deleted.
- Don't forget to put (especially symbolical values) in a math environment like $...$
- e.g.: 
	- given the file test.txt with the content "bar,123"
	- \\loadvariables{foo}{test.txt}
	- In the text: "\mvar{foo}{bar}" gives "123"

## Planned features
- Add a function for exporting from other numeric tools, like python's numpy etc. Should be relatively simple :)
- Change from csv using comma as the separator to tab, allowing for more flexibility as what can be "transferred" (e.g. normal text).

If you have ideas for more features, feel free to contact me.
There are likely better solutions (with cleaner code) out there, but I only want this to work easily.
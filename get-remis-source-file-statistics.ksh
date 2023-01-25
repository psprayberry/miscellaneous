#! /usr/bin/ksh
# ******************************************************************************
#   File:  get-remis-source-file-statistics.ksh
#
#   Counts the number of certain types of files in a remis working tree.  This 
#   was originally used to get some rough counts to help scope the REMIS User 
#   Interface project, especially for implementing a new menu scheme.
#
#   TODO 2022-09-23 pcs Find a way to account for upper and lower case 
#                       characters in the file names
#   TODO 2022-09-23 pcs Allow the user to specify the root directory for the 
#                       search, or use the current directory if one is not
#                       specified.
#   TODO 2022-09-23 pcs Don't include RMMT files or files in or under a folder 
#                       named 'target'.  What about other folders?  Maybe use 
#                       a .gitignore or something like it?
#   TODO 2022-09-23 pcs Refactor the chain of grep commands
#   TODO 2022-09-23 pcs Refactor to get the labels, file patterns, etc. from an 
#                       external source (file, command line, etc.)
#
#   XXX 2022-09-23 pcs Allow the user to specify the file name patterns?
# ******************************************************************************
#
#   Configure some things
#
inHere="/home/paul.sprayberry/git/remis/Projects/Java/REMIS"
#
#   Define some arrays for the output labels and the corresponding file pattern.
#   Both arrays must have the same number of elements.
#
label[0]="Number of JavaScript files"
filePattern[0]="*.js"
#
label[1]="Number of JSPs"
filePattern[1]="*.jsp"
#
label[2]="Number of HTML files"
filePattern[2]="*.html"
#
label[3]="Number of '.inc' files"
filePattern[3]="*.inc"
#
label[4]="Number of Java files"
filePattern[4]="*.java"
#
label[5]="Number of tag definition files"
filePattern[5]="*.tld"
#
function countSomeFiles {
   find ${inHere} -name ${1} | grep -iv "Build" | grep -iv "REMIS_JUNITEE" | grep -iv "REMIS_JUNITEEWeb" | grep -iv "REMIS_R2T2" | grep -iv ".settings" | grep -iv "RMMT" | grep -iv "target" | wc -l
}
echo "Rummaging through REMIS files in ${inHere}"
#
#   Count some files
#
let i=0
while (( ${i} < ${#label[*]} )); do
   echo "${label[i]} in ${inHere}:" $(countSomeFiles ${filePattern[i]})
   let i="i + 1"
done
#
#   Count files in REMISAppWeb
#
inHere="${inHere}/REMISAppWeb"
let i=0
while (( ${i} < ${#label[*]} )); do
   echo "${label[i]} in ${inHere}:" $(countSomeFiles ${filePattern[i]})
   let i="i + 1"
done

## This Folder contains the script file  for the Project

### This file describes the methodology behind the script

* First, following the instructions of the project I have downloaded the required files. The data is also publicly available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

* The script loads  the traing set and traing labels ,and combines them into a single file called train .It does the same for the testing set and testing labels,and the new file is called test

* The values of the label columns are renamed on the basis of the file activity_labels ,which was provide in the dataset.The labels column is temporarily called "y" so as to enable appending.

* Subjects(A.K.A Volunteers) information is loaded and appended to train and test sets.

* The processed ,train and test set files are combined to form a file called dataset1, a duplicate dataset2 is created to maintain different versions.

* Meanwhile the names of the columns of the dataset2 are changed to names provided in the features file.

* Using the grep function  the measurements on the mean and standard deviation for each measurement are extracted into a file called df2.
In this case I have assumed only mean() and std() variables as the required ones.


* Activity (labels) and subject columns are appended.

* Using the reshape2 packages's melt function a independent tidy data set called Subdata, with the average of each variable for each activity and each subject was created.

* The Subdata file was written into a text file called tidydataset.txt.

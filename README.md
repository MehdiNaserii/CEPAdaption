# Adaptive and Personalized User Behavior Modeling in Complex Event Processing Platforms for Remote Health Monitoring Systems

Taking care of people who need constant care is essential and its cost is rising every day. Many intelligent remote health monitoring systems have been developed from the past till now. Intelligent systems explainability has become a necessity after the worldwide adoption of such systems, especially in the health domain to explain and justify decisions made by intelligent systems. Rule-based techniques are among the best in terms of explainability. However, there are several challenges associated with remote health monitoring systems in general and rule-based techniques, specifically. In this research, an adaptive platform based on Complex Event Processing (CEP) has been proposed for user behavior modeling to provide adaptive and personalized remote health monitoring. This system can manage a massive amount of data in real-time utilizing the CEP engine. It can also avoid human errors in setting rules thresholds by extracting thresholds from previous data using JRip rule-based classifier. Moreover, a feature selection method is proposed to decrease the high number of features while maintaining accuracy. Additionally, a rule adaption method has been proposed to cope with changes over time. Additionally, a personalized rule adaption method is proposed to address the need for responsiveness of the system to the special requirements of each user. The experimental results on both hospital and activity data sets showed that the proposed rule adaption method improves the accuracy by about 15% compared to non-adaptive systems. Additionally, the proposed personalized rule adaption method has an accuracy improvement of about 3% to 6% on both mentioned datasets. The current readme file is a complete documentation on how to implement and exploit the proposed platform for remote health monitoring. The main datasets used in this work include hospital and activity datasets. According to different platform requirements for these two different datasets, the readme file will be followed in two parts, each part for one dataset.

## Hospital dataset

### Access to dataset 

- The whole Hospital dataset can be downloaded from: https://outbox.eait.uq.edu.au/uqdliu3/uqvitalsignsdataset/index.html

## Data preparation

- We chose three cases 2, 3, 4 (each case refers to one surgery).
- We changed the format of each file from .txt to .arff (the WEKA data format) manually (by using Notepad++ (v 7.9.5)).
- The data file of the three cases exist in Hospital Data folder.

## Train the rule-based classifiers

- WEKA (v3.8) was used and can be downloaded from: https://waikato.github.io/weka-wiki/downloading_weka/
- Upload “Hospital_Case_2” by using “open file” button in the “processing” tab of WEKA.
-In “classify” tab press “choose” button and select “JRip” from “rules” folder.
- Then right click on “JRip” name in the box next to “choose” button and select “show properties”.
- In new window, select “open” button and choose “JRip_Config” file (Existed in Hospital/Machine Learning config/JRip) then select “OK”.
- Select “percentage spilt” check box and set it on 66% train set.
-  In the below list choose “class”.
- Finally, press “start” button and wait until the learning gets completed.
- In classifier output box, you can see the produced rules and the results of “Jrip” classifier.
- At the end, select the produced rules and copy and paste them in a notepad file and save it with .txt format for the next step.
- Follow all the above steps for “Hospital_Case_3_2” (the combination of case 2 and case 3).

**Note:** we used three kinds of rule-based classifiers (OneR, Part and JRipt) in our study. Other classifiers can be evaluated with above explained steps (related config files are existed in Hospital/Machine Learning config) . According to the better results of “JRip” in terms of accuracy and rules number, we chose this classifier and continued the rest with it.

### Rule mapping

- Rule_Mapper.m is a MATLAB code which was developed in MATLAB (v 2018b) in order to map JRip produced rules in WEKA to rule defining language of siddhi CEP engine.
- Upload the .txt file which contains the JRip produced rules (the last step of the previous part) in to the program.
- Then run the program for mapping the rules.
- Finally, the rules in the .txt file is changed to siddhi rule defining language and can be used directly into the engine rule set.

### Siddhi CEP engine (v5.1.0)

- The engine files can be download from: https://siddhi.io/en/v5.1/download/
- Additionally, for preparing the siddhi engine you can follow these steps (Using Siddhi for the first time) in: https://siddhi.io/en/v5.1/docs/quick-start/
- As it is explained in the siddhi query guide (https://siddhi.io/en/v5.1/docs/query-guide/), first you should define the inputs which refer to data features.
- After that, the output should be defined which refers to the class.
- For the rules we follow two approaches:
    - First:
        - Add the rules which were excluded from “Hospital_Case_2” file to the engine.
        - Add “Hospital_Case_4” file as input and compare the output with “Hospital_Case_4” class, for computing the accuracy.
    - Second:
        - Add the rules which were excluded from “Hospital_Case_3_2” (the combination of case 2 and case 3) file to the engine (It means that the case 3 data was added to case 2 and the rules were updated based on the new subset (the rule adaption manner)).
        - Add “Hospital_Case_4” file as input and compare the output with “Hospital_Case_4” class for computing the accuracy.
        - Compare the result with the first approach.

**Note:** for personalization in data preparation part select just one of the cases (as you wish) and divide it into three segments. Then, follow the above parts and steps, exactly.

## Activity dataset

### Access to dataset

- The whole Activity Dataset can be downloaded from: http://archive.ics.uci.edu/ml/datasets/mhealth+dataset

### Activity data preparation
- We chose subject 6, 10, 7 (each subject refers to one participate).
- We changed the format of each file from .txt to .arff (the WEKA data format) manually (by using Notepad++ (v 7.9.5)).
-The data files of the three subjects were existed in Activity Data folder.

### Feature selection (Because of the high number of features related to activity data, a feature selection phase is needed.)

- WEKA (v3.8) was used and can be downloaded from: https://waikato.github.io/weka-wiki/downloading_weka/
- Three approaches to feature selection were evaluated in this study.
    - Subset evaluation method:
	    - After uploading “mHealth_subject_6” choose “select attribute” tab.
	    - In “Attribute Evaluation” select “ConsistencySubsetEval” and in “Search Method” select “BestFirst” (use the “Consistency_Config” and “BestFirst_Config” (in Activity/Feature Selection/SubsetEval and in Activity/Feature Selection/Search Method) by right clicking on the name of them and clicking on “open” button and then choosing the file).
	    - The executed subset is “mHealth_Subject_6_Consistency_Best”.
	    - We compared consistency method with correlation feature selection method. The consistency method had better results.
	- Using from Pythagorean theorem:
	    - Formula F=√(X^2 + Y^2 + Z^2 )  was used for this feature selection method.
	    - The executed subset is “mHealth_Subject_6_Consistency_Pythagoras”.
	- Combination method
	    - Combination of seven attribute evaluator methods and the concept of subset evaluation.
	    - In this method top ten attributes of each attribute evaluator method were selected and seven batches were created.
	    - From each batch, attributes with at least three repetitions in each batch were added to new subset.
	    - Upload “mHealth_subject_6” choose “select attribute” tab
	    - Each time chose one of these methods (“chi-squareAttributeEval”, “correlationAttributeEval”, “OneRAttributeEval”, “filteredAttributeEval”, “gainratioAttributeEval”, “informationgainAttributeEval”, and “symmetricuncertaintyAttributeEval”) with “Ranker” search method (use each config file for each evaluator and “Ranker_Config” (in Activity/Feature Selection/AttributeEval and in Activity/Feature Selection/Search Method) by right clicking on the name of them and clicking on “open” Button and then choosing the file).
	    - Select top ten features from every attribute evaluation method and create seven batches, manually.
	    - Choose a feature with at least three repetitions in each batch, manually.
	    - Create the final subset
	    - The executed subset is “mHealth_Subject_6_Proposed”
- As the evaluation results have shown the Combination method had the best result in terms of accuracy and rule number by using JRip. Thus, the next steps will be continued with the executed subset of this method.
- Apply the combination method on mHealth_Subject_6_10 (the combination of subject 6 and subject 10) and mHealth_Subject_7 for the rest of process. The executed files are mHealth_subject_6_10_Proposed and mHealth_subject_7_Proposed, respectively.  

### Train the rule based classifiers

- The learning process was done in WEKA.
- Upload “mHealth_Subject_6_Proposed” by using “open file” Button in “processing” tab of WEKA.
- In “classify” tab press “choose” button and select “JRip” from “rules” folder.
- Then right click on “JRip” name in the box next to “choose” Button and select “show properties”.
- In the new window, select “open” Button and choose “JRip_Config” file (Existed in Activity/Machine Learning config/JRip) then select “OK”.
- Select “percentage spilt” check box and set it on 66% train set.
- In the below list choose “class”.
- Finally, press “start” Button and wait until the learning get completed.
- In classifier output box, you can see the produced rules and the results of “Jrip” classifier.
- At the end, select the produced rules and copy and paste them in a notepad file and save it with .txt format for the next step.
- Follow all the above steps for “mHealth_subject_6_10_Proposed” (the combination of subject 6 and subject 10).
**Note:** we used three kinds of rule-based classifiers (OneR, Part and JRipt) in our study. Other classifiers can be evaluated with above explained steps (related config files are existed in Activity/Machine Learning config). According to better results of “JRip” in terms of accuracy and rules number, we chose this classifier and continue the rest parts with it. 

### Rule mapping

- Rule_Maker.m a MATLAB code which was developed in MATLAB (v 2018b) in order to map JRip produced rules in WEKA to rule defining language of siddhi CEP engine.
- Upload the .txt file which contains the JRip produced rules (the last step of the previous part) in to the program.
- Then, run the program for mapping the rules.
- Finally, the rules in the .txt file is changed to siddhi rule defining language and can be used directly into the engine rule set.

### Siddhi CEP engine
- The engine files can be download from: https://siddhi.io/en/v5.1/download/
- Moreover, for preparing the siddhi engine you can follow these steps (Using Siddhi for the first time) in: https://siddhi.io/en/v5.1/docs/quick-start/ 
- As it is explained in the siddhi query guide (https://siddhi.io/en/v5.1/docs/query-guide/), first you should define the inputs which refer to data features.
- After that, the output should be defined which refers to the class.
- For the rules we follow two approaches:
    - First:
	    - Add the rules which were excluded from “mHealth_Subject_6_Proposed” file to the engine.
	    - Add “mHealth_subject_7_Proposed” file as input and compare the output with “mHealth_subject_7_Proposed” class for computing the accuracy.
	- Second
	    - Add the rules which were excluded from “mHealth_subject_6_10_Proposed” (the combination of subject 6 and case 10) file to the engine (It means that the subject 10 data was added to subject 6 and the rules was updated based on new subset (the rule adaption manner)).
	    - Add “mHealth_subject7_Proposed” file as input and compare the output with “mHealth_subject7_Proposed” class for computing the accuracy. 
	    - Compare the result with the first approach.

**Note:** for personalization in data preparation part, select just one of the cases (as you wish) and divided it into three segments. Then, follow the above parts and steps, exactly.

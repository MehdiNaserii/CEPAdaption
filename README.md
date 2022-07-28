# Adaptive and Personalized User Behavior Modeling in Complex Event Processing Platforms for Remote Health Monitoring Systems

Taking care of people who need constant care is essential and its cost is rising every day. Many intelligent remote health monitoring systems have been developed in the past till now. Intelligent systems explainability has become a necessity after the worldwide adoption of such systems, especially in the health domain to explain and justify decisions made by intelligent systems. Rule-based techniques are among the best in terms of explainability. However, there are several challenges associated with remote health monitoring systems in general and rule-based techniques, specifically. In this research, an adaptive platform based on Complex Event Processing (CEP) has been proposed for user behavior modeling to provide adaptive and personalized remote health monitoring. This system can manage a massive amount of data in real-time utilizing the CEP engine. It can also avoid human errors in setting rules thresholds by extracting thresholds from previous data using JRip rule-based classifier. Moreover, a feature selection method is proposed to decrease the high number of features while maintaining accuracy. Additionally, a rule adaption method has been proposed to cope with changes over time. Moreover, a personalized rule adaption method is proposed to address the need for responsiveness of the system to the special requirements of each user. The experimental results on both hospital and activity data sets showed that the proposed rule adaption method improves the accuracy by about 15% compared to non-adaptive systems. Additionally, the proposed personalized rule adaption method has an accuracy improvement of about 3% to 6% on both mentioned datasets. The current readme file is complete documentation on how to implement and exploit the proposed platform for remote health monitoring. The main datasets used in this work include hospital and activity datasets. According to different platform requirements for these two different datasets, the readme file is organized in two parts, each part for one dataset.

## Hospital Dataset

### Access to dataset 

- The whole Hospital Dataset [1] can be downloaded from: https://outbox.eait.uq.edu.au/uqdliu3/uqvitalsignsdataset/index.html

### Hospital Data preparation

- We chose three cases 2, 3, and 4 (each case refers to one surgery).
- We changed the format of each file from .txt to .arff (the WEKA data format) manually (by using Notepad++ (v 7.9.5)).
- The data file of the three cases exists in the Hospital Data folder.

### Train the rule-based classifiers

- WEKA (v3.8) was used and can be downloaded from: https://waikato.github.io/weka-wiki/downloading_weka/
- Upload “Hospital_Case_2” by using the “open file” button in the “processing” tab of WEKA.
- In the “classify” tab press the “choose” button and select the “JRip” from the “rules” folder.
- Then right-click on the “JRip” name in the box next to the “choose” button and select “show properties”.
- In the new window, select the “open” button and choose the “JRip_Config” file (Existed in Hospital/Machine Learning config/JRip) then select “OK”.
- Select the “percentage split” check box and set it to 66% for train set.
- In the blow list, choose “class” as the target attribute.
- Finally, press the “start” button and wait until the learning gets completed.
- In the classifier output box, you can see the produced rules and the results of the “Jrip” classifier.
- The produced rules are in the "Classifier output" part under the heading "JRIP Rules:".
- In the end, copy and paste rules into the "WekaExtractedRules.txt" (in the “Rule Mapper” folder) and save them for the next step. 
- Follow all of the above steps for “Hospital_Case_3_2” (the combination of case 2 and case 3).

**Note:** We used three kinds of rule-based classifiers (OneR, Part, and JRipt) in our study. Other classifiers can be evaluated in the following steps explained above. Please note related config files exist in Hospital/Machine Learning config. Since “JRip” is producing better results in terms of accuracy and rules number, we chose this classifier and continued the rest of our study with it.

### Rule mapping

- Rule_Mapper.m is a MATLAB code that was developed in MATLAB (v 2018b) in order to map the language of JRip-produced rules in WEKA to rule defining language of the Siddhi CEP engine.
- Copy the JRip produced rules (the last step of the previous part) in the "WekaExtractedRules.txt" file. (The produced rules are in the "Classifier output" part of WEKA under the heading "JRIP Rules:")
- Then run the program for mapping the rules.
- Finally, the rules in the "WekaExtractedRules.txt" file are changed to the Siddhi rule defining language (the new rules with new syntax are stored in the "Rule_Map.txt" file that will be created by the Rule_Mapper.m program.) and can be fed directly into the engine rule set.

### Siddhi CEP engine (v5.1.0)

- The engine files can be downloaded from: https://siddhi.io/en/v5.1/download/
- Additionally, for preparing the Siddhi engine you can follow these steps (Using Siddhi for the first time): https://siddhi.io/en/v5.1/docs/quick-start/
- As it is explained in the siddhi query guide (https://siddhi.io/en/v5.1/docs/query-guide/), first you should define the inputs which refer to data features.
- After that, the output should be defined which refers to the class.
- For the rules we follow two approaches:
	- First:
		- Add the rules which were extracted from the “Hospital_Case_2” file to the engine.
		- Add the “Hospital_Case_4” (manually by "Siddhi event simulation") file as input and compare the output with the “Hospital_Case_4” class, for computing the accuracy.
	- Second:
		- Add the rules which were extracted from the “Hospital_Case_3_2” (the combination of case 2 and case 3) file to the engine (It means that the case 3 data was added to case 2 (First approach) and the rules were updated based on the new subset, and it is the rule adaption approach).
		- Add the “Hospital_Case_4” (manually by "Siddhi event simulation") file as input and compare the output with the “Hospital_Case_4” class for computing the accuracy.
	- Compare the results of the first and second approaches.


**Note:** For personalization in the data preparation part select just one of the cases (as you wish) and divide it into three segments. Then, follow the above steps, exactly.

## Activity Dataset

### Access to dataset

- The whole Activity Dataset [2, 3] can be downloaded from: http://archive.ics.uci.edu/ml/datasets/mhealth+dataset 

### Activity data preparation

- We chose subjects 6, 10, and 7 (each subject refers to one participant).
- We changed the format of each file from .txt to .arff (the WEKA data format) manually (by using Notepad++ (v 7.9.5)).
- The data files of the three subjects existed in the Activity Data folder.

### Feature selection (Because of the high number of features related to activity data, a feature selection phase is needed.)

- WEKA (v3.8) was used and can be downloaded from: https://waikato.github.io/weka-wiki/downloading_weka/
- Three approaches to feature selection were evaluated in this study.
	- Subset evaluation method:
		- After uploading “mHealth_subject_6” choose the “select attribute” tab.
		- In “Attribute Evaluation” select “ConsistencySubsetEval” and in “Search Method” select “BestFirst” (use the “ConsistencySubsetEval” and “BestFirst” (in Activity/Feature Selection Config/SubsetEval and Activity/Feature Selection Config/Search Method) by right-clicking on the name of them and clicking on “open” button and then choosing the file).
		- The executed subset is “mHealth_Subject_6_Consistency_Best”.
		- We compared the consistency method with the correlation feature selection method. The consistency method had better results.
	- Using from Pythagorean theorem:
		- Formula F=√(X^2 + Y^2 + Z^2) was used for this feature selection method.
		- The executed subset is “mHealth_Subject_6_Consistency_Pythagoras”.
	- Combination method
		- Combination of seven attribute evaluator methods and the concept of subset evaluation.
		- In this method, the top ten attributes of each attribute evaluator method are selected and seven batches are created.
		- From each batch attributes with at least three repetitions in each batch are added to the new subset.
		- Upload “mHealth_subject_6” and choose the “select attribute” tab
		- Each time choose one of these methods (“chi-squareAttributeEval”, “correlationAttributeEval”, “OneRAttributeEval”, “filteredAttributeEval”, “gainratioAttributeEval”, “informationgainAttributeEval”, and “symmetricuncertaintyAttributeEval”) with “Ranker” search method (use each config file for each evaluator and “Ranker_Config” (in Activity/Feature Selection Config/AttributeEval and in Activity/Feature Selection Config/Search Method) by right clicking on the name of them and clicking on “open” Button and then choosing the file).
		- Select the top ten features from every attribute evaluation method and create seven batches, manually.
		- Choose a feature with at least three repetitions in each batch, manually.
		- Create the final subset
		- The executed subset is “mHealth_Subject_6_Proposed”
- As the evaluation results have shown, the Combination method had the best result in terms of accuracy and rule number by using JRip. Thus, the next steps will be continued with the executed subset of this method.
- Apply the combination method on mHealth_Subject_6_10 (the combination of subject 6 and subject 10) and mHealth_Subject_7 for the rest of the process. The executed files are mHealth_subject_6_10_Proposed and mHealth_subject_7_Proposed, respectively.

### Train the rule-based classifiers

- The learning process should be done in WEKA.
- Upload “mHealth_Subject_6_Proposed” by using the “open file” button in the “processing” tab of WEKA.
- In the “classify” tab press the “choose” button and select “JRip” from the “rules” folder.
- Then right-click on the “JRip” name in the box next to the “choose” Button and select “show properties”.
- In the new window, select the “open” button and choose the “JRip_Config” file (Existed in Activity/Machine Learning config/JRip) then select “OK”.
- Select the “percentage split” check box and set it to 66% for train set.
- In the blow list, choose “class” as the target attribute.
- Finally, press the “start” button and wait until the learning gets completed.
- In the classifier output box, you can see the produced rules and the results of the “Jrip” classifier.
- The produced rules are in the "Classifier output" part under the heading "JRIP Rules:".
- In the end, copy and paste rules into the "WekaExtractedRules.txt" (in the “Rule Mapper” folder) and save them for the next step. 
- Follow all of the above steps for “mHealth_subject_6_10_Proposed” (the combination of subject 6 and subject 10).

**Note:** We used three kinds of rule-based classifiers (OneR, Part, and JRip) in our study. Other classifiers can be evaluated in the following steps explained above. Please note related config files exist in Hospital/Machine Learning config. Since “JRip” is producing better results in terms of accuracy and rules number, we chose this classifier and continued the rest of our study with it.

### Rule mapping

- Rule_Mapper.m is a MATLAB code that was developed in MATLAB (v 2018b) in order to map the language of JRip-produced rules in WEKA to rule defining language of the Siddhi CEP engine.
- Copy the JRip produced rules (the last step of the previous part) in the "WekaExtractedRules.txt" file. (The produced rules are in the "Classifier output" part of WEKA under the heading "JRIP Rules:")
- Then run the program for mapping the rules.
- Finally, the rules in the "WekaExtractedRules.txt" file are changed to the Siddhi rule defining language (the new rules with new syntax are stored in the "Rule_Map.txt" file that will be created by the Rule_Mapper.m program.) and can be fed directly into the engine rule set.

### Siddhi CEP engine

- The engine files can be downloaded from: https://siddhi.io/en/v5.1/download/
- Moreover, for preparing the Siddhi engine you can follow these steps (Using Siddhi for the first time): https://siddhi.io/en/v5.1/docs/quick-start/
- As it is explained in the siddhi query guide (https://siddhi.io/en/v5.1/docs/query-guide/), first you should define the inputs which refer to data features.
- After that, the output should be defined which refers to the class.
- For the rules we follow two approaches:
	- First:
		- Add the rules which were extracted from the “mHealth_Subject_6_Proposed” file to the engine.
		- Add the “mHealth_subject_7_Proposed” file as input (manually by "Siddhi event simulation") and compare the output with the “mHealth_subject_7_Proposed” class for computing the accuracy.
	- Second
		- Add the rules which were extracted from the “mHealth_subject_6_10_Proposed” (the combination of subject 6 and case 10) file to the engine (It means that the subject 10 data was added to subject 6 (First approach) and the rules were updated based on a new subset, and it is the rule adaption approach).
		- Add the “mHealth_subject7_Proposed” file as input (manually by "Siddhi event simulation") and compare the output with the “mHealth_subject7_Proposed” class for computing the accuracy.
	- Compare the results of the first and second approaches.


**Note:** For personalization in the data preparation part, select just one of the cases (as you wish) and divided it into three segments. Then, follow the above steps, exactly.

## References

[1] Liu D, Gorges M, Jenkins, SA. The University of Queensland Vital Signs Dataset: Development of an Accessible Repository of Anesthesia Patient Monitoring Data for Research. Anesth Analg 2012;114(3):584-9. doi:10.1213/ANE.0b013e318241f7c0. Epub 2011 Dec 20.

[2] Banos, O., Garcia, R., Holgado, J. A., Damas, M., Pomares, H., Rojas, I., Saez, A., Villalonga, C. mHealthDroid: a novel framework for agile development of mobile health applications. Proceedings of the 6th International Work-conference on Ambient Assisted Living an Active Ageing (IWAAL 2014), Belfast, Northern Ireland, December 2-5, (2014).

[3] Banos, O., Villalonga, C., Garcia, R., Saez, A., Damas, M., Holgado, J. A., Lee, S., Pomares, H., Rojas, I. Design, implementation and validation of a novel open framework for agile development of mobile health applications. BioMedical Engineering OnLine, vol. 14, no. S2:S6, pp. 1-20 (2015).

# Final_Project_BioEng
Metabolic Exploration of Fibroblasts in Breast Cancer
Professor: Germán Andrés Preciat González
Bioengineering and Metabolic Systems, 2023B, MCBCI, CUCEI, University of Guadalajara.

## Team Members:
Rigoberto Rincón Ballesteros

Bruno Salvador Santana Campos

Ramyet Sotelo Rodríguez

Josué González Sandoval

Juan Carlos Kelly Naranjo

## How to Use This Repository

To effectively utilize this repository, follow the steps below to create context-specific genomic scale models and explore its metabolic behaviours:

Navigate to the XomicsGenerator directory and execute the XomicsGenerator.py code directly from the command line using the following structure: "currentpath\python XomicsGenerator.py (Dataset)". In this instance, the Dataset is the text file named "GSE196354_NFs_CAFs_RNAseq_FPKM". As a result, a folder named "results" will be generated, containing all the text files derived from the dataset.

Within the project folder, locate a MATLAB script named "ModelGenerationandIterador". Run this script in MATLAB, leading to the creation of a folder named "Specific_Models". Inside this folder, you will find subfolders, each housing specific models saved as .mat files.

Open the Experiments script (.mlx or .m file) in MATLAB and execute the code to observe the results. To accomplish this, utilize the barPlotComparison function, ensuring it is placed in the same path beforehand.

Note: When creating specific models, there is an option to incorporate bibliomic data, which can be directly downloaded from this repository. The duration of specific model creation may vary from hours to days, depending on computational power.


## Disclosure for Academic Purposes 

The content provided below is used exclusively for academic and learning activities.
This material is the intellectual property of the University of Guadalajara and is intended solely for the educational use of students and members of the academic community.
Any reproduction, distribution, or unauthorized use of this content is strictly prohibited.
This material is shared with the intention of facilitating learning and research in the context of educational programs offered by the University of Guadalajara.
Users are expected to respect intellectual property rights and use this content in an ethical and responsible manner.
The University of Guadalajara assumes no responsibility for the misuse or unauthorized use of this material by third parties.
Any inquiries or requests for additional permissions should be directed to the relevant academic authorities.

# Before Running the Code
Experiments.m: In order to use the Experiments.m file code, please download the barPlotComparison.m function as well.

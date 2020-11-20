# Recognition of hand-writing figures using MATLAB
## Image data to process  
The hand-writing figures that our classifiers learns from:![trainingFig](https://github.com/Tony-Yan2018/handwritingfigures_MATLAB/blob/master/app.tif)  
Containing 10 lines of 10 figures and 20 samples(columns) of each of them.   
The hand-writing figures that our classifiers will test upon:![testFig](https://github.com/Tony-Yan2018/handwritingfigures_MATLAB/blob/master/test.tif)  
Containing 10 lines of 10 figures and 10 samples(columns) of each of them.  
## Overview of classification approaches  
1. **Extract numbers with projection**  
    The first thing to do would be processing the training image from which we extract each figure and store its location. The general method is summed as follows:  
    - Get the profils of each figure by projecting them first horizontally and then vertically. The projcetion order must be followed due to this a little twisted figure arrange in the image, otherwise we may get very blurred boundaries.   
    - Now the embracing rectangles for each figure are appropriate on Left and Right side but have redundant space on the upper and lower side.  
    -  **Function Specifications:**    
    *getRows.m*: Project the image horizontally and returns 20 values(height of each projection line ).  
    *getColumns.m*: Project each horizontally-projected rectangle number block vertically and get the boundary of both L&R side.  
    *heightAdj.m*: adjusts the height of each figure  
    *extractShow.m*: draws the embracing rectangle for each figure
2. **The Euclidean Distance Classifier with profile sampling**  
    - First, we will measure the distance from the embracing boundary to the first non zero pixel of the figure by sampling both the Left and Right by a number, say, d/2=5. After having had 2 vectors of size 1\*5, we concatenate them and get a new profile distance vector of size 1\*10 which should be the feature vector of that figure. Logically, we shall have 200 feature vectors in total.  
    - Then, we calculate the average feature vector of each class simply by adding all feature vectors together and divide them by 20. So 10 average feature vectors in total.
    - Next, we do the same profile sampling for each figure in the test image. So we get 100 feature vectors of 1\*10. Note each of them as x.  
    - Finally, we calculate the posterior probability(![pi](https://latex.codecogs.com/gif.latex?p_1%28C_i%7Cx%29)) for each test sample x to each class using Euclidean Distance(![dist](https://latex.codecogs.com/gif.latex?dist%28x%2Cw_i%29)) with ![Ci](https://latex.codecogs.com/gif.latex?C_i) representing each class and ![](https://latex.codecogs.com/gif.latex?%5Comega_i) representing the average feature vector of each class using the equation below: ![equa](https://latex.codecogs.com/gif.latex?p_1%28C_i%7Cx%29%3D%5Cfrac%20%7Be%5E%7B-dist%28x%2C%5Comega_i%29%7D%7D%7B%5Csum_%7Bj%3D0%7D%5E9e%5E%7B-dist%28x%2C%5Comega_j%29%7D%7D)  
    - **Function Specifications:**  
    *vectN.m*: returns the feature vector of a number. Size of 1\*10 when taking 5 sampling points on each side.  
    *classCenters.m*: returns the average feature vector of each class. Size of 10\*10 when taking 5 sampling points on each side.  
    *posteriorProbs.m*: returns the probability vector of all test numbers to 10 classes. Size of 10\*10\*10 when taking 5 sampling points on each side.  
3. **The K - Nearest Neighbours Classifier with zoning**  
    - First, the zoning is done by dividing the extracted figure into m\*n rectangles where m is the vertical block number and n is the horizontal one.  
    - Then, we calculate the feature vector after zoning by counting the pixels of each zone with normalization(divided by area).  
    - After that, we calculate the posterior probability ![p2](https://latex.codecogs.com/gif.latex?p_2%28C_i%7Cx%29%3Dk_i/K) of each test figure x to its K nearest neighbours where ![ki](https://latex.codecogs.com/gif.latex?k_i) is the number of neighbours that belong to class ![Ci](https://latex.codecogs.com/gif.latex?C_i) among its K nearest neighbours. The default method uses Euclidean Distance.
    - **Function Specifications:**  
    *zoneVect.m*: returns the feature vector m\*n of a segmented figure.  
    *zoningVects.m*: returns feature vectors of all the numbers in the image.  
    *probKNN.m*: returns the probability vector of a test sample. Size of 10\*10\*10 when taking 5 sampling points on each side.  
4. **Combination of the 2 classifiers**  
We now have the output from the 2 classifiers which would all be the size of 10\*10\*10(the probability to 10 classes respectively). There are 2 kinds of combinations, sum and product. They can be described as follows:  
![sum](https://latex.codecogs.com/gif.latex?p_s%28C_i%7Cx%29%20%3D%20%5Cfrac%20%7Bp_1%28C_i%7Cx%29&plus;p_2%28C_i%7Cx%29%7D%7B%5Csum_%7Bj%3D0%7D%5E9p_1%28C_j%7Cx%29&plus;p_2%28C_j%7Cx%29%7D)![prod](https://latex.codecogs.com/gif.latex?p_p%28V_i%7Cx%29%20%3D%20%5Cfrac%20%7Bp_1%28C_i%7Cx%29p_2%28C_i%7Cx%29%7D%7B%5Csum_%7Bj%3D0%7D%5E9p_1%28C_j%7Cx%29p_2%28C_j%7Cx%29%7D)
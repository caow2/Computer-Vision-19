A simple 3 layer neural network that is trained to classify animal silhouettes (dog, bird, cat, dolphin).

A binary image is initially centered and morphological operations are applied to obtain the border pixels of the image.
The image is then partitioned into 32 equal intervals. (Each interval is defined by an angle from the center - i.e. interval 1 would be the region from theta = [0, pi/32])
In each interval, we obtain the pixels that have the minimum and maximum distance away from the image center to get a [64 x 1] feature vector.

generateData.m converts images to features vectors and saves them into 'data.mat' so this computation does not have to be done each time.

run.m loads the saved data, randomly partitions them into training and testing sets, and trains a new neural network that will be saved into 'nn.mat'

test.m evaluates the saved NN on the original image set and an additional test image set.

The remaining MATLAB files are for the neural network.

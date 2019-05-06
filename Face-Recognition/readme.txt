Facial Recognition program using a PCA and nearest neighbor approach for classifing new faces.
--- Algorithm ---
For 'training' images:
1. Convert each image to grayscale and resize to 100 x 100.
2. Vectorize the image into a 10,000 element vector and normalize to unit length.
3. Compute the mean image vector mu, and subtract mu from each training image.
4. Compute the covariance matrix, and compute the eigenvectors and eigenvalues for the covariance matrix.
   Let P be the matrix of eigenvectors and D be the diagonal matrix of corresponding eigenvalues.
   (If the eignevalues in D are not sorted, sort them in decreasing order and adjust P accordingly).
5. For each training image Xi, we then apply the transformation:
          Yi = P transpose x Xi
   and extract the top k elements from Yi. 
   These k elements represent the dimensions with the highest eigenvalues (and following that logic, variance) and
   are the most useful for distinguishing different faces.
   Based on previous literature, let k = 20.

For classifying 'testing' or new images:
1. Using the mean vector mu, P, and D from above, apply the same steps to a test image
   by subtracting mu from the normalized and vectorized test image.
   Apply the transformation in step 5 for each test image.
2. To classify a test image, compute a distance vector between the test image and each training image.
   Classify using the label of the closest neighbor (assuming the training image is labeled).
        label = min( || test image - Xi || )      for each training image Xi

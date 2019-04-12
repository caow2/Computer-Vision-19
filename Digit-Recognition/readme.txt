Naive digit recognition program using a decision tree.

The decision tree was based on several features in a binary digit image such as the number of lakes, bays, and the slope between the bays if there are any.

A lake are the holes within the image. For example, the an image of the digit 8 would typically have 2 holes and a 0 would have 1 hole.

A bay are the openings within the image. For example, the digit 3 would have 3 openings, 7 would have 1 opening, etc.
If there is more than one bay, the relative position of the leftmost bay and the rightmost bay is used as a feature.

import numpy as np
import cv2
import opts
import os
import glob
from feats import featdescriptor
from loss import lossfunction
from norm import blocknormer

opt = opts.myparser()

sketch_data = np.array([])
image_data = np.array([])
Y_sketch = np.array([])
Y_image = np.array([])

sclasses = [cl for cl in glob.glob("./datasets/sketchy/train/sketches/*")]
iclasses = [cl for cl in glob.glob("./datasets/sketchy/train/photos/*")]

i = 0
for cl in sclasses:
    imglist = glob.glob(cl + "/*")
    for img in imglist:
        print(img)
        sketch_data[i] = cv2.imread(img) #get how to store 4D data
        Y_sketch[i] = img.split('/')[-1].split('.')[0].split('-')[0]
        i += 1

i = 0
for cl in iclasses:
    imglist = glob.glob(cl + "/*")
    for img in imglist:
        image_data[i] = cv2.imread(img)
        Y_image[i] = img.split('/')[-1].split('.')[0].split('-')[0]
        i += 1

featX_sketch, featX_image = featdescriptor(sketch_data, image_data)
featX_sketch, featX_image = blocknormer(featX_sketch, featX_image)

preds = np.array([])

for i, query in enumerate(featX_sketch):
    for j, img in enumerate(featY_image):

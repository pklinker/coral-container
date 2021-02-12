# Running Google Coral TPU Machine Learning in Docker
This project provides Docker containers to run serveral [Google Coral USB TPU](https://coral.ai/products/accelerator) projects. These were tested on a 4 GB Raspberry Pi 4. To use these projects on the Pi, install the Edge TPU runtime following the step 1 directions on the Coral [page](https://coral.ai/docs/accelerator/get-started/#runtime-on-windows).

The projects are:   
   
- [coral-python](coral-python) - the is the base container, built on Debian Buster
- [classify-image](classify-image) - Google Coral TPU image classifier
- [posenet](posenet) - container to run the human pose estimator
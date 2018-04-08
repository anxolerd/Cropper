=======
Cropper
=======

This is a just-for-fun and proof of concept project for cropping panoramas for Instagram.

Dependencies
============

Install all dependencies using dart's ``pub`` utility:

.. code-block:: bash

    pub get


Usage
=====

.. code-block:: bash

    dart bin/cropper.dart /path/to/pano.jpg

Results will be written to ``/path/to/pano.part.jpg`` files, where ``part`` is 
the zero-based index of slice.

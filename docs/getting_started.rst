Getting started
===============

Requirements
------------

- Linux host with ``gcc`` and ``make``
- I2C device nodes available when running against hardware (for example ``/dev/i2c-1``)

Build
-----

From the repository root:

.. code-block:: bash

   make clean && make

The default target builds ``./runmag-26``.

Quick non-hardware checks
-------------------------

These commands are safe even without attached RM3100 hardware:

.. code-block:: bash

   ./runmag-26 -h
   ./runmag-26 -V
   ./runmag-26 -E

Hardware smoke check
--------------------

On a supported SBC with working I2C permissions:

.. code-block:: bash

   sudo ./runmag-26 -b 1 -s

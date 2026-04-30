Development
===========

Repository layout
-----------------

- ``src/``: C sources for runtime executable behavior.
- ``include/``: project headers.
- ``tests/``: simple C unit tests for deterministic logic.
- ``artifacts/``: historical board and setup reference material (images, schematics, documentation).

Build targets
-------------

.. code-block:: bash

   make          # release build
   make debug    # build with -g -Wall
   make tests    # build and execute local unit tests

RM3100 Technical Details
------------------------

Cycle Count, Gain, and Sensitivity
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The internal clock count of the RM3100 MagI2C ASIC establishes the number of sensor oscillation cycles, known as the "Cycle Count". Cycle count and gain are linearly related.

The default Cycle Count is **200**.

+-------------+---------------+---------------------+
| Cycle Count | Gain (LSB/uT) | Sensitivity (nT/LSB)|
+=============+===============+=====================+
| 50          | 20            | 50.000              |
+-------------+---------------+---------------------+
| 100         | 38            | 26.316              |
+-------------+---------------+---------------------+
| 200         | 75            | 13.333              |
+-------------+---------------+---------------------+
| 300         | 113           | 8.850               |
+-------------+---------------+---------------------+
| 400         | 150           | 6.667               |
+-------------+---------------+---------------------+

**Equation:** ``magnetic_field_in_uT = (RM3100_measurement_in_count / Gain)``

Sample Rate
~~~~~~~~~~~

The Cycle Count establishes the maximum sample rate. At the default cycle count of 200, the maximum 3-axis sample rate is ~430 Hz. Higher sample rates can be obtained by reducing the cycle count, but this diminishes gain and sensitivity.

Hardware Architecture
---------------------

The Magnetometer Support Board (MSB) supports two main use cases:

1. **Local Connection:** Sensor mounted directly to the board and attached to the SBC via a short cable.
2. **Extended Connection (MSBx):** Uses a local board and a remote board connected by shielded Cat 6 cable (up to 30m) using the NXP PCA9615 I2C differential extender. This reduces the noise floor by placing the sensor away from the host SBC.

.. figure:: ../artifacts/runMag-data\ architecture.png
   :alt: runMag data architecture
   :align: center

   Data Architecture for RM3100 MSB.

Board Layout
~~~~~~~~~~~~

.. figure:: ../artifacts/Top\ Side\ 2020-01-30.png
   :alt: MSB Top Side
   :width: 400px
   :align: center

   Magnetometer Support Board (MSB) Top Side.

.. figure:: ../artifacts/Back\ Side\ 2020-01-30.png
   :alt: MSB Back Side
   :width: 400px
   :align: center

   Magnetometer Support Board (MSB) Back Side.

Documentation build (local)
---------------------------

From project root:

.. code-block:: bash

   python3 -m pip install -r docs/requirements.txt
   python3 -m sphinx -b html docs docs/_build/html

Read the Docs
-------------

- RTD configuration is defined in ``.readthedocs.yaml``.
- Theme is configured as ``furo`` in ``docs/conf.py``.

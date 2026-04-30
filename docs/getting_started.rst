Getting started
===============

Requirements
------------

- Linux host with ``gcc`` and ``make``
- I2C device nodes available when running against hardware (for example ``/dev/i2c-1``)
- User should be in the ``i2c`` group or use ``sudo`` for hardware access.

Installation
------------

Clone the repository and build the utility:

.. code-block:: bash

   git clone https://github.com/wittend/runmag-2026.git
   cd runmag-2026
   make

The default target builds the ``runmag-26`` executable.

Hardware Setup
--------------

The ``runmag-26`` utility is designed to work with the RM3100 Geomagnetic Sensor, typically used with Single Board Computers (SBCs) like the Raspberry Pi, Odroid, or Nvidia Nano.

I2C Configuration (Raspberry Pi)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Enable I2C via ``raspi-config`` or the Raspberry Pi Configuration tool (Interfaces tab).
2. Reboot the Pi.
3. Verify the I2C bus is available:

   .. code-block:: bash

      ls /dev/i2c*

   You should see ``/dev/i2c-1`` (or similar).

4. (Optional) Install ``i2c-tools`` and scan the bus to confirm devices are detected:

   .. code-block:: bash

      sudo i2cdetect -y 1

   Expected addresses:
   - ``0x18``: MCP9808 precision temperature sensor.
   - ``0x20``: RM3100 magnetometer module.

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

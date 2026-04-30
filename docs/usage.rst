Usage
=====

``runmag-26`` takes all configuration parameters from the command line.

Command Line Options
--------------------

To display all supported options:

.. code-block:: bash

   ./runmag-26 -h

Full Parameters list:
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: text

   -a                     :  List known SBC I2C bus numbers.
   -A                     :  Set NOS (0x0A) register value.
   -B <reg mask>          :  Do built in self test (BIST). [ Not implemented ]
   -b <bus as integer>    :  I2C bus number as integer.
   -C                     :  Read back cycle count registers before sampling.
   -c <count>             :  Set cycle counts as integer. [ default 200 decimal]
   -D <rate>              :  Set magnetometer sample rate. [ TMRC reg 96 hex default ].
   -E                     :  Show cycle count/gain/sensitivity relationship.
   -f <filename>          :  Read configuration from file (JSON). [ Not implemented ]
   -F <filename>          :  Write configuration to file (JSON). [ Not implemented ]
   -g <mode>              :  Device sampling mode. [ POLL=0 (default), CONTINUOUS=1 ]
   -H                     :  Hide raw measurements.
   -j                     :  Format output as JSON.
   -k                     :  Create and roll log files. [ 00:00 UTC default ]
   -L <addr as integer>   :  Local temperature address. [ default 19 hex ]
   -l                     :  Read local temperature only.
   -M <addr as integer>   :  Magnetometer address. [ default 20 hex ]
   -m                     :  Read magnetometer only.
   -O <filename>          :  Output file path.
   -P                     :  Show Parameters.
   -q                     :  Quiet mode.
   -v                     :  Verbose output.
   -R <addr as integer>   :  Remote temperature address. [ default 18 hex ]
   -r                     :  Read remote temperature only.
   -s                     :  Return single reading.
   -S                     :  Site prefix string for log files.
   -T                     :  Raw timestamp in milliseconds.
   -V                     :  Display software version and exit.
   -Z                     :  Show total field.
   -h or -?               :  Display this help.

Common examples
---------------

- **Show software version:**

  .. code-block:: bash

     ./runmag-26 -V

- **Show current configuration parameters (using -P):**

  .. code-block:: bash

     ./runmag-26 -P

- **One-shot sample on I2C bus 1:**

  .. code-block:: bash

     sudo ./runmag-26 -b 1 -s

- **JSON output, including total field measurement, on I2C bus 2:**

  .. code-block:: bash

     sudo ./runmag-26 -j -Z -b 2

- **Logging to file with rotation and site ID:**
  Creates log files like ``./logs/kd0eag-20200624-runmag.log``. The log rolls at 00:00:00 UTC.

  .. code-block:: bash

     ./runmag-26 -k -S kd0eag -j

- **Recommended settings for TAPR/PSWS projects:**

  .. code-block:: bash

     ./runmag-26 -b 1 -j -R 1f -r -H -M 23 -c 400 -S <site_id>

Output and logs
---------------

- **stdout:** Without ``-O`` or ``-k``, output is written to standard output.
- **JSON format:** Enabled with ``-j``, each sample is a single-line JSON object.
- **Log Files:** Enabled with ``-k``, files are written under ``./logs/`` (unless specified otherwise) and rolled daily at UTC midnight.

Data Format
-----------

Example JSON output:

.. code-block:: json

   { "ts":"03 May 2020 23:56:55", "lt":"24.62", "x":"14", "y":"-11", "z":"49", "rx":"1109", "ry":"-844", "rz":"3707", "Tm": "52" }

Fields:
- ``ts``: Timestamp (UTC or epoch ms with ``-T``).
- ``lt``/``rt``: Local/Remote temperature in Celsius.
- ``x``, ``y``, ``z``: Magnetic field components.
- ``rx``, ``ry``, ``rz``: Raw measurements.
- ``Tm``: Total magnetic field magnitude (if ``-Z`` is used).

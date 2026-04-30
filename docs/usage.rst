Usage
=====

CLI help
--------

To display all supported options:

.. code-block:: bash

   ./runmag-26 -h

Common examples
---------------

- Show software version:

  .. code-block:: bash

     ./runmag-26 -V

- Show cycle count/gain/sensitivity table:

  .. code-block:: bash

     ./runmag-26 -E

- One-shot sample on I2C bus 1:

  .. code-block:: bash

     sudo ./runmag-26 -b 1 -s

- JSON output with log rolling enabled and site prefix:

  .. code-block:: bash

     ./runmag-26 -k -S kd0eag -j

Output and logs
---------------

- Without ``-O``/``-k``, output is written to stdout.
- With ``-k``, files are written under ``./logs/`` and rolled at UTC day boundaries.

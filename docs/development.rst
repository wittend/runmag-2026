Development
===========

Repository layout
-----------------

- ``src/``: C sources for runtime executable behavior.
- ``include/``: project headers.
- ``tests/``: simple C unit tests for deterministic logic.
- ``artifacts/``: historical board and setup reference material.

Build targets
-------------

.. code-block:: bash

   make          # release build
   make debug    # build with -g -Wall
   make tests    # build and execute local unit tests

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

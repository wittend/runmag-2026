## Project Notes for Future Development (`runmag-2026`)

### Build & Configuration (project-specific)

- Build system is a plain `Makefile` (no CMake, no test framework).
- Default build target is `release`, producing `./runmag-26`:

```bash
make
```

- Debug target uses `-g -Wall` and compiles `runMag.c`, `cmdmgr.c`, `i2c.c` as objects, then links with `main.c`:

```bash
make debug
```

- Cleanup:

```bash
make clean
```

- Runtime hardware dependency: meaningful runtime data collection requires Linux I2C device nodes (for example `/dev/i2c-1`) and access permissions (often via `sudo` on SBC targets).
- This repo currently stores board/documentation assets under `artifacts/`; commands/scripts/docs may still reference older `docs/` naming from project history.

### Testing & Verification

This project does not include an automated unit/integration test suite. Current practical verification is command-level smoke testing plus hardware-backed runs.

#### Verified smoke test (executed)

The following was run successfully during documentation update:

```bash
make
./runmag-26 -h
```

Observed result: binary built successfully and `-h` printed the full CLI options/help text (safe check that does not require live sensor reads).

#### Recommended verification workflow

1. Build from clean state:

```bash
make clean && make
```

2. Run non-hardware-dependent checks first:

```bash
./runmag-26 -h
./runmag-26 -V
./runmag-26 -E
```

3. If running on SBC with I2C hardware enabled, do one hardware smoke run (single read):

```bash
sudo ./runmag-26 -b 1 -s
```

4. For logging behavior validation, use:

```bash
./runmag-26 -k -S <site_id>
```

and confirm log creation/rotation behavior under `./logs/`.

#### Guidelines for adding new tests

- There is no existing test harness; for now, add repeatable shell-based checks (documented command + expected output/exit code) before introducing a framework.
- If you add parsing/format behavior, prefer deterministic checks (`-h`, `-V`, `-E`, and argument validation paths) that do not require sensor hardware.
- If introducing a formal test suite later, keep it separate from production build target (for example, add a dedicated `test` target in `Makefile` rather than changing default `make` behavior).

### Additional Development Notes

- Code style in this repo is straightforward C with light comments and macro-driven constants; keep additions consistent with existing naming and formatting patterns.
- CLI and defaults are centralized in `cmdmgr.c` (`getCommandLine` and `showSettings`); sensor loop behavior is driven from `main.c`.
- Build links only against `libm` (`-lm`), so avoid unnecessary new dependencies unless justified.
- Typical debugging entry points:
  - Build warnings/errors: `make debug`
  - Parameter/path issues: `./runmag-26 -P ...` and `./runmag-26 -h`
  - I2C permission/device issues: verify `/dev/i2c-*` availability and runtime privileges.
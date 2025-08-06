# Go Boilerplate Template

This is a boilerplate template for Go projects, designed to provide a clean and organized folder structure. It includes a Makefile and shell scripts for common development tasks.

## Folder Structure

The folder structure is organized as follows:

- **`/api`**: Contains API specifications, such as OpenAPI/Swagger files.
- **`/cmd`**: Main applications for your project. The directory name for each application should match the name of the executable you want to have.
- **`/internal`**: Private application and library code. This is the code you don't want others importing in their applications or libraries.
- **`/internal/adapter`**: Adapters for connecting to external services and infrastructure.
- **`/internal/core`**: Core application logic.
- **`/internal/domain`**: Domain models and business logic.
- **`/internal/infra`**: Infrastructure code, such as database connections and external API clients.
- **`/package`**: Public library code that can be imported by other projects.
- **`/script`**: Scripts to support the project (e.g., release scripts).
- **`/test`**: Test files and data.

## Prerequisites

- [Go](https://golang.org/doc/install)
- [Make](https://www.gnu.org/software/make/) (optional, for using the Makefile)

## Usage

This template includes a `Makefile` to simplify common development tasks. To use it, you will need to have `make` installed on your system.

### Makefile Commands

- **`make build`**: Compiles the application.
- **`make test`**: Runs the tests.
- **`make run`**: Runs the application.
- **`make clean`**: Removes build artifacts.
- **`make format`**: Formats the source code.
- **`make check`**: Runs static analysis checks.
- **`make dev`**: Runs the application in development mode with hot-reloading.
- **`make build-all`**: Builds the application for all supported platforms.

### Shell Scripts

If you don't have `make` installed, you can use the individual shell scripts located in the root directory:

- **`build.sh`**: Compiles the application.
- **`test.sh`**: Runs the tests.
- **`run.sh`**: Runs the application.
- **`clean.sh`**: Removes build artifacts.
- **`format.sh`**: Formats the source code.
- **`check.sh`**: Runs static analysis checks.
- **`dev.sh`**: Runs the application in development mode with hot-reloading.
- **`build-all.sh`**: Builds the application for all supported platforms.

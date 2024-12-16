# Examples

The `ballerinax/spotify` connector provides practical examples illustrating usage in various scenarios.

1. [Get markets in Spotify](https://github.com/ballerina-platform/module-ballerinax-spotify/tree/main/examples/get-markets) - get spotify markets

## Prerequisites

1. Generate Spotify access token to authenticate the connector as described in the [Setup guide](https://central.ballerina.io/ballerinax/spotify/latest#setup-guide).
2. For each example, create a `Config.toml` file to add the configuration parameters. Here's an example of how your `Config.toml` file should look like:

```toml
token = "<Access Token>"
```

## Running an example

Execute the following commands to build an example from the source:
Explore these [examples](https://github.com/module-ballerinax-spotify/tree/main/examples/), covering the following use cases:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```

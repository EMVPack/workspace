# Workspaces for EVMPack

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Workspaces is a package for EVMPack that helps to structure, manage, and deploy collections of smart contract applications.**

This package provides a `Workspace` contract that acts as a container for other EVM packages, allowing you to manage them as a single unit. It simplifies the process of deploying and upgrading applications using EVMPack's proxy infrastructure.

## Core Concepts

*   **Workspace**: A central contract that groups together multiple applications. It controls access and manages the deployment of new applications within the workspace.
*   **Application**: An instance of an EVM package deployed as an upgradeable proxy. Each application within a workspace is managed by the workspace's `EVMPackProxyAdmin`.
*   **EVMPackProxyFactory**: The factory contract responsible for deploying new proxy instances for your applications.
*   **EVMPackProxyAdmin**: The contract that manages the admin rights for all the proxies within a workspace, allowing for controlled upgrades and administration.

## Features

*   Group multiple applications into a single workspace.
*   Deploy new applications using `usePackage` which leverages `EVMPackProxyFactory`.
*   Centralized administration of all applications in the workspace via `EVMPackProxyAdmin`.
*   Role-based access control for managing the workspace.

## Prerequisites

*   [Foundry](https://getfoundry.sh/)
*   [EVMPack CLI](https://evmpack.tech/)

## Installation

To add the `workspaces` package to your project, you can use the EVMPack CLI:

```bash
evmpack install workspaces@evmpack
```

### Deploying a new application

To deploy a new application into your workspace, you would call the `usePackage` function on your deployed `Workspace` contract.

`usePackage(string calldata namePackage, string calldata versionPackage, bytes calldata initData, string calldata appName)`

*   `namePackage`: The name of the EVMPack package to deploy.
*   `versionPackage`: The version of the package to deploy.
*   `initData`: The initialization data for the proxy's `initialize` function.
*   `appName`: A local name for the application instance within the workspace.

## Author

Mikhail Ivantsov

## License

This project is licensed under the MIT License.
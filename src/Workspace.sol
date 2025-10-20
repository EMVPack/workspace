// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;


import "@evmpack/contracts-upgrade@openzeppelin-5.4.0/proxy/utils/Initializable.sol";
import { IEVMPackProxyFactory } from "@evmpack/core@evmpack-1.0.0-beta.2/src/EVMPackProxyFactory.sol";
import { IWorkspaceFactory } from "@evmpack/workspaces@evmpack-1.0.0/src/IWorkspaceFactory.sol";
import { EVMPackProxyAdmin } from "@evmpack/core@evmpack-1.0.0-beta.2/src/EVMPackProxyAdmin.sol";
import "@evmpack/core@evmpack-1.0.0-beta.2/src/EVMPackAddreses.sol";
import "@evmpack/contracts@openzeppelin-5.4.0/utils/ReentrancyGuard.sol";

contract Workspace is Initializable, ReentrancyGuard {

    struct Info {
        uint256 id;
        address factory;
        string name;
        string meta; 
    }

    struct App {
        address proxy;
        string appName;
    }

    Info _info;

    uint256 _counter;

    mapping(uint256 appId => App) _apps;


    error Workspace__AccessDenied();

    modifier onlyOwner(){
        EVMPackProxyAdmin admin = EVMPackProxyAdmin(_workspace().proxyAdmin);
        
        if(!admin.hasRole(0x00, msg.sender)){
            revert Workspace__AccessDenied();
        }

        _;
    }

    function initialize(string calldata name, string calldata meta, uint256 id,  address factory) public initializer {
        _info = Info(id, factory, name, meta);
    }


    function usePackage(string calldata namePackage, string calldata versionPackage, bytes calldata initData, string calldata appName) public onlyOwner nonReentrant {
        (address proxy, ) = IEVMPackProxyFactory(EVMPackAddreses.PROXY_FACTORY).usePackageRelease(namePackage, versionPackage, _workspace().proxyAdmin, initData, appName);
        _counter++;
        _apps[_counter] = App(proxy, appName);
    }

    
    function _workspace() internal returns(IWorkspaceFactory.WorkspaceInfo memory) {
        IWorkspaceFactory.WorkspaceInfo memory workspace = IWorkspaceFactory(_info.factory).getWorkspace(_info.id);
    }
}
pragma solidity ^0.4.17;

import './Identity.sol';
import './IdentityRegistry.sol';

contract IdentityFactory {
  event IdentityCreated(bytes32 centrifugeId, address identity);

  address registry;

  function IdentityFactory(address _registry) public {
    registry = _registry;
  }

  function createIdentity(bytes32 _centrifugeId) public {
    require(_centrifugeId != 0x0);
    IdentityRegistry identityRegistry = IdentityRegistry(registry);
    // Require that the centrifugeId is not already registered in the IdentityRegistry
    require(identityRegistry.getIdentityByCentrifugeId(_centrifugeId) == 0x0);

    Identity identity = new Identity(_centrifugeId);
    identity.transferOwnership(msg.sender);

    IdentityCreated(_centrifugeId, identity);

    identityRegistry.registerIdentity(_centrifugeId, identity);
  }

}
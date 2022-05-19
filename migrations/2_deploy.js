const { SSL_OP_LEGACY_SERVER_CONNECT } = require("constants");

const marketplace = artifacts.require("marketplace")
const mytoken = artifacts.require("mytoken");

module.exports = function (deployer) {
    // for my token
    deployer.deploy(mytoken);

    //for nft
    deployer.deploy(marketplace)
};

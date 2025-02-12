
require("@nomiclabs/hardhat-waffle");

module.exports = {
    solidity: "0.8.12",
    networks: {
        // Configure your network settings here
        // For example, for local development:
        localhost: {
            url: "http://127.0.0.1:8545"
        }
    }
};
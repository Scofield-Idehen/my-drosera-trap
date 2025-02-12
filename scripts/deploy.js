
async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    // Deploy HelloWorldTrap
    const HelloWorldTrap = await ethers.getContractFactory("HelloWorldTrap");
    const helloWorldTrap = await HelloWorldTrap.deploy();
    await helloWorldTrap.deployed();
    console.log("HelloWorldTrap deployed to:", helloWorldTrap.address);

    // Deploy VulnerableContract
    const VulnerableContract = await ethers.getContractFactory("VulnerableContract");
    const vulnerableContract = await VulnerableContract.deploy(deployer.address);
    await vulnerableContract.deployed();
    console.log("VulnerableContract deployed to:", vulnerableContract.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
import { ethers } from "hardhat";

async function main() {
  const Multicall3 = await ethers.getContractFactory("Multicall3");
  const multicall3 = await Multicall3.deploy();

  await multicall3.deployed();

  console.log(`deployed to ${multicall3.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

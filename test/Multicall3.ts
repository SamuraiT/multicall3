import { expect } from "chai";
import { ethers, waffle } from 'hardhat'
import { MockStaking__factory, Multicall3, Multicall3__factory } from "../typechain-types";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { Contract } from "ethers";
import { MockStaking, MockStakingInterface } from "../typechain-types/Mock/MockStaking";
import { deployContract } from "@nomiclabs/hardhat-ethers/types";
describe("Multicall3",  () => {
  let multicall3: Multicall3,
    owner: SignerWithAddress,
    alice: SignerWithAddress,
    bob: SignerWithAddress,
    mock: MockStaking,
    _mockInterface: MockStakingInterface

  beforeEach(async () => {
    ;[owner, alice, bob] = await ethers.getSigners()
    console.log('address', owner.address)
    const Multicall3 = await ethers.getContractFactory("Multicall3");
    multicall3 = await Multicall3.deploy();
    await multicall3.deployed()

    const MockStaking = await ethers.getContractFactory("MockStaking");
    mock = await MockStaking.deploy();
    await mock.deployed()
    _mockInterface = MockStaking__factory.createInterface()

    // const Multicall3 = new Multicall3__factory()
    // multicall3 = await Multicall3.deploy()
    // await multicall3.deployed()
  })

  describe("aggregate", () => {
    it("succesfully aggregated with original msg.sender", async () => {
      await mock.increment()
      await mock.increment()
      expect(await mock.getCounter()).to.be.eq(2)

      const calls = [{
        target: mock.address,
        callData: _mockInterface.encodeFunctionData('getCounter')
      }]
      const x = await multicall3.aggregate(calls)
      console.log('result', x.value)

      const calls2 = [{
        target: mock.address,
        callData: 'getCounter()'
      }]
      const y = await multicall3.aggregate2(calls2)
      console.log('result', y.value)
      // const result = _mockInterface.decodeFunctionResult(
      //   "getCounter",
      //   returnData[0]
      // )
      // expect(result.toString()).to.be.eq(1)
    })
  })
});

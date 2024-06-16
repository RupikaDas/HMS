Running the Application

1. Compile and Deploy Contracts:

 Use a tool like Truffle or Hardhat to compile and deploy your contracts to a local blockchain like Ganache or a testnet/mainnet.

2. Set Up Front-end:

Place your HTML, CSS, and JavaScript files in the appropriate folders.

Make sure to replace the ABI and contract addresses in the app.js file with the actual values from your deployed contracts.

3. Serve the Application:

You can use a simple HTTP server like http-server to serve your front-end files.

Navigate to the project directory and run npx http-server ./src or use any other method to serve the static files.

4. Interact with the DApp:

Open your web browser and go to http://localhost:8080 (or whichever port your server is running on).

Use the provided forms to interact with your smart contracts.


Note:

Ensure you have MetaMask or another Ethereum wallet browser extension installed and connected to the same network your contracts are deployed on.

By following these steps, you will have a functional front-end that can interact with your Ethereum smart contracts.
const Web3 = require('web3');
const web3 = new Web3(Web3.givenProvider || 'http://localhost:7545');

const hospitalAbi = [/* ABI from Hospital contract */];
const patientAbi = [/* ABI from Patient contract */];
const recordsAbi = [/* ABI from Records contract */];

const hospitalAddress = '0x...'; // Address of deployed Hospital contract
const patientAddress = '0x...'; // Address of deployed Patient contract
const recordsAddress = '0x...'; // Address of deployed Records contract

const hospitalContract = new web3.eth.Contract(hospitalAbi, hospitalAddress);
const patientContract = new web3.eth.Contract(patientAbi, patientAddress);
const recordsContract = new web3.eth.Contract(recordsAbi, recordsAddress);

document.getElementById('hospital-form').addEventListener('submit', async (event) => {
    event.preventDefault();
    const id = document.getElementById('hospital-id').value;
    const name = document.getElementById('hospital-name').value;
    const address = document.getElementById('hospital-address').value;
    const spec = document.getElementById('hospital-spec').value;

    const accounts = await web3.eth.getAccounts();
    await hospitalContract.methods.store_hospital_details(id, name, address, spec).send({ from: accounts[0] });
    alert('Hospital added successfully!');
});

document.getElementById('patient-form').addEventListener('submit', async (event) => {
    event.preventDefault();
    const id = document.getElementById('patient-id').value;
    const name = document.getElementById('patient-name').value;
    const age = document.getElementById('patient-age').value;
    const gender = document.getElementById('patient-gender').value;
    const height = document.getElementById('patient-height').value;
    const weight = document.getElementById('patient-weight').value;
    const address = document.getElementById('patient-address').value;
    const phone = document.getElementById('patient-phone').value;
    const email = document.getElementById('patient-email').value;
    const date = document.getElementById('patient-date').value;

    const accounts = await web3.eth.getAccounts();
    await patientContract.methods.store_patient_details(id, name, age, gender, height, weight, address, phone, email, date).send({ from: accounts[0] });
    alert('Patient added successfully!');
});

document.getElementById('record-form').addEventListener('submit', async (event) => {
    event.preventDefault();
    const id = document.getElementById('record-id').value;

    const accounts = await web3.eth.getAccounts();
    await recordsContract.methods.medical_record(id).send({ from: accounts[0] });
    alert('Medical record created successfully!');
});

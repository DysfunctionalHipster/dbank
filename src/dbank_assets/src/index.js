import { UpdateCallRejectedError } from "@dfinity/agent";
import { dbank } from "../../declarations/dbank";

window.addEventListener("load", update()); // -ok- Checks the account balance

document.querySelector('form').addEventListener('submit', async function(event) {
    event.preventDefault();

    const button = event.target.querySelector("#submit-btn");

    const inputAmount = parseFloat(document.getElementById('input-amount').value); // -this- Takes the user's input and transforms it into a float
    const outputAmount = parseFloat(document.getElementById('withdraw-amount').value); // -this- Takes the user's input and transforms it into a float

    button.setAttribute('disabled', true); // -this- disables the submit button

    if (document.getElementById('input-amount').value.length != 0) {
    await dbank.topUp(inputAmount);
    }; // -this- Checks if the "add to account" field is empty
 
    if (document.getElementById('withdraw-amount').value.length != 0) {
    await dbank.withdraw(outputAmount);
    }; // -this- Checks if the "remove from account" field is empty

    await dbank.compound(); // -this- Compounds the current balance

    update();

    document.getElementById('input-amount').value = ""; // -ok- Resets the value to empty after function
    document.getElementById('withdraw-amount').value = ""; // -ok- Resets the value to empty after function
    button.removeAttribute('disabled'); // -this- Re-ables the submit button after the functions are over
});

async function update() {
    const currentAmount = await dbank.checkBalance();
    document.getElementById('value').innerText = Math.round(currentAmount * 100) / 100;
}; // -this- Checks the current balance
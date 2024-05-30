// app/javascript/controllers/calculate_price.js

document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById("item-price");
  if (priceInput) {
    priceInput.addEventListener('input', () => {
      const inputValue = priceInput.value;
      const tax = Math.floor(inputValue * 0.1);
      const profit = inputValue - tax;

      const addTaxPrice = document.getElementById('add-tax-price');
      const profitDom = document.getElementById('profit');

      addTaxPrice.innerHTML = tax;
      profitDom.innerHTML = profit;
    });
  }
});

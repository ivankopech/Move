const appId = "sandbox-sq0idb-1nbetFUXtAYw13HgMPx0HA";
const locationId = "LR5V3Z9C7WJA0";

async function initializeCard(payments) {
  const card = await payments.card();
  await card.attach("#card-container");
  return card;
}

async function main() {
  const payments = window.Square.payments(appId, locationId);
  const card = await initializeCard(payments);

  const button = document.getElementById("pay-button");
  const message = document.getElementById("message");
  const spinner = document.getElementById("spinner");

  button.addEventListener("click", async () => {
    button.classList.add("hidden");
    spinner.classList.remove("hidden");
    let result;
    try {
      result = await card.tokenize();
      if (result.status === "OK") {
        message.textContent = "✅ Token generado con éxito";
        window.SquareChannel?.postMessage(
          JSON.stringify({ token: result.token })
        );
      } else {
        message.textContent = `❌ Error: ${result.errors[0].message}`;
      }
    } catch (err) {
      message.textContent = `❗ Excepción: ${err.message}`;
    } finally {
      spinner.classList.add("hidden");
      if (result?.status !== "OK") {
        button.classList.remove("hidden");
      }
    }
  });
}

main();

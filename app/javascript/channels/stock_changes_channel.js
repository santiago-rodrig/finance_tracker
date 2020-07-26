import consumer from "./consumer"

consumer.subscriptions.create("StockChangesChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    data.stocks.forEach(stock => {
      const stockRow = document.getElementById(stock.ticker);
      const stockTicker = document.getElementById(`${stock.ticker}-ticker`);
      const stockName = document.getElementById(`${stock.ticker}-name`);
      const stockPrice = document.getElementById(`${stock.ticker}-price`);
      if (stockRow) {
        stockTicker.textContent = stock.ticker;
        stockName.textContent = stock.name;
        stockPrice.textContent = stock.last_price;
        stockRow.classList.add('updated');
        window.setTimeout(() => {
          stockRow.classList.remove('updated');
        }, 2500);
      }
    });
  }
});

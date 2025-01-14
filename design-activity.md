- Implementation A uses `CartEntry`, `ShoppingCart`, and `Order`. Implementation B uses the same.
- `CartEntry` is responsble for holding a `unit_price`, a `quantity`, and caculating its price. `ShoppingCart` is responsble for holding an array of `CartEntry` objects, and calculating a total price for the items in the cart. `Order` is responsble for holding a sales tax value and a cart, and calculating a total price after tax.
- It doesn't differ between implementations.
- In implementation A, the logic to compute the price is retained in `Order`, where it accesses, but does not mutate, the state of other classes. In implementation B, the logic to compute the price is delegated to lower level classes, thus `Order` only expects an instance of `ShoppingCart` to respond to `:price`, and knows nothing else about lower level classes.
- If we decide items are cheaper if bought in bulk, implementation B would be easier to modify, because the new feature would be a responsibility of `ShoppingCart`. whereas implementation A would require modifying code whose original purpose was to calculate sales tax.
- Implementation B adheres to the single responsibility principle better.
- It is also more loosely coupled.

### Activity
- Move the logic handling local reservations from `Booker` to `Blocker`.
- The parent class should not have knowledge of the workings of child classes, so any new behavior should belong there.

# Cash Register Application

This is a simple Ruby on Rails command line application that simulates a cash register.

## System Requirements

- Ruby (version as specified in `.ruby-version` or `Gemfile`)
- Bundler (check Gemfile for the required version)
- Rails (version as specified in the `Gemfile`)

## Setup

To set up the project, follow these steps:

1. Clone the repository:
   ```
   git clone https://github.com/moonc4ke/cash-register.git
   cd cash-register
   ```

2. Install the required gems:
   ```
   bundle install
   ```

## Running the Application

To run the cash register application, use the following command:

```
ruby bin/run
```

Follow the prompts to add products to your cart and calculate the total price with applicable discounts.

## Testing

To run the tests for the project, execute:

```
rails test
```

This will run all the unit tests for the product, cart, and discount classes.

## Extending the Application

If you want to add more features or modify the existing logic:

- Add new product types or discount rules in the `app/models` directory.
- Update the `bin/run` file to include any new user interactions.
- Make sure to add corresponding tests in the `test/models` directory.

# Project Conventions

This document outlines the primary conventions used in the DinDin application.

## Framework & Core Technologies

*   **Backend:** Ruby on Rails 8.0+
*   **Frontend JS:** Stimulus, Turbo (`@hotwired/turbo-rails`), `@rails/request.js`, `current.js`
*   **JS Libraries:** `stimulus-use`, `@floating-ui/dom`
*   **CSS:** Tailwind CSS with DaisyUI 5 (See `.aider/DAISY_UI.md`)
*   **Build Tool:** Bun (`bun.config.js`)
*   **Database:** PostgreSQL (implied by `db/schema.rb`)
*   **Testing:** Minitest
*   **Caching:** Solid Cache (implied by migrations)
*   **WebSockets:** Action Cable / Solid Cable (implied by migrations)
*   **Error Reporting:** Solid Errors (implied by migrations)
*   **File Storage:** Active Storage (implied by `db/schema.rb`)

## Backend (Ruby/Rails)

*   **Directory Structure:** Follows standard Rails conventions.
*   **Controllers:**
    *   Inherit from `ApplicationController`.
    *   Use Concerns (`app/controllers/concerns`) for shared logic like `Authentication`, `Authorization`, `SetCurrentRequestDetails`.
    *   Authentication is generally required via `require_authentication`, opt-out using `allow_unauthenticated_access`.
*   **Models:**
    *   Inherit from `ApplicationRecord`.
    *   Use Concerns (e.g., `AppAccount::Joinable`, `User::Deactivatable`) for shared logic.
    *   Use `Current` (`app/models/current.rb`) for request-specific attributes (e.g., current user, account, locale).
*   **Helpers:**
    *   Organized by feature (e.g., `TransactionsHelper`) or UI component (`Components::ComboboxHelper`).
    *   Component helpers often render partials (`render partial: "shared/..."`).
*   **Views:**
    *   Standard Rails ERB templates.
    *   Partials located in `app/views/shared/` for common UI elements (e.g., `shared/combobox`).
    *   Leverage DaisyUI components and utility classes extensively.
*   **Jobs:** Inherit from `ApplicationJob`.
*   **Mailers:** Inherit from `ApplicationMailer`.
*   **Naming:** Standard Ruby conventions (snake\_case for methods/variables, CamelCase for classes/modules).

## Frontend (JavaScript/CSS)

*   **JavaScript Framework:** Stimulus (`app/javascript/controllers`).
    *   Initialized in `app/javascript/application.js`.
    *   Stimulus debug mode is enabled (`window.Stimulus.debug = true`).
    *   Uses a potentially custom Stimulus schema (`customSchema` in `application.js`).
    *   Controllers are named descriptively (e.g., `autocomplete_controller.js`, `money_input_controller.js`).
    *   Use Stimulus targets, actions, values, outlets, and classes.
    *   Leverage `stimulus-use` for utilities like `useDebounce`, `useClickOutside` (e.g., in `AutocompleteController`).
    *   Use `static debounces` for rate-limiting actions (e.g., in `AutocompleteController`).
    *   Utilize libraries like `@floating-ui/dom` for positioning dropdowns/popovers (e.g., in `AutocompleteController`).
    *   Shared JS functions can be placed in `app/javascript/helpers.js` (e.g., `observeMutations`).
*   **Turbo:**
    *   Uses `@hotwired/turbo-rails`.
    *   Custom Turbo Stream actions can be defined in `application.js` (e.g., `StreamActions.close_dialog`).
*   **Frontend Configuration:** Uses `current.js` to pass data/config from Rails to JS (configured in `application.js`).
*   **CSS Framework:** Tailwind CSS with DaisyUI 5.
    *   Adhere to DaisyUI component structure and class names (reference `.aider/DAISY_UI.md`).
    *   Use Tailwind utilities for custom styling where necessary.
    *   Theme colors (`primary`, `secondary`, `base-100`, etc.) should be preferred over hardcoded colors.
*   **Build:** Managed via `bun.config.js`, building `app/javascript/application.js` into `app/assets/builds`. Watch mode is supported via `bun run build --watch`.
*   **Naming:** Standard JavaScript conventions (camelCase for functions/variables, PascalCase for classes).

## Testing

*   **Framework:** Minitest (`test/test_helper.rb`).
*   **Structure:** Standard Rails test directories (`test/controllers`, `test/models`, `test/system`, `test/integration`, `test/helpers`, `test/channels`).
*   **Base Classes:** Use standard Rails test base classes (`ActiveSupport::TestCase`, `ActionDispatch::IntegrationTest`, `ApplicationSystemTestCase`).
*   **Fixtures:** Used for test data (`fixtures :all` in `test_helper.rb`).
*   **Helpers:** Custom test helpers are defined in `test/test_helpers` (e.g., `SessionTestHelper`) and included in `ActiveSupport::TestCase`.
*   **Parallelization:** Enabled via `parallelize` in `test_helper.rb`.

## Database

*   **Migrations:** Use ActiveRecord Migrations.
    *   Application schema changes in `db/migrate`.
    *   Separate migration paths for dependencies: Solid Cache (`db/cache/migrate`), Solid Cable & Solid Errors (`db/ops/migrate`).
*   **Schema:** Defined in `db/schema.rb` (auto-generated). Do not edit manually.
*   **Constraints:** Use database-level constraints where appropriate (e.g., `CHECK` constraints for `kind` and `role` columns, `NOT NULL`, `UNIQUE`).
*   **Indexing:** Add indexes for frequently queried columns (e.g., foreign keys, `due_on`, `title`, `email`).

## Git & Version Control

*   (Assumed) Follow standard Git practices: feature branches, meaningful commit messages.
*   Keep `db/schema.rb` checked into version control.
*   Keep `CONVENTIONS.md` and `DAISY_UI.md` up-to-date.

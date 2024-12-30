import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/request.js";
import { useDebounce, useClickOutside } from "stimulus-use";
import {
  autoUpdate,
  computePosition,
  offset,
  flip,
  shift,
} from "@floating-ui/dom";

export default class extends Controller {
  static targets = ["input", "results", "clearButton"];

  static debounces = ["search"];

  static values = {
    url: String,
    minLength: { type: Number, default: 2 },
    debounce: { type: Number, default: 500 },
  };

  connect() {
    useDebounce(this, { wait: this.debounceValue });
    useClickOutside(this);
  }

  search() {
    const query = this.inputTarget.value;

    if (query.length >= this.minLengthValue) {
      this.startSearch(query);
    } else {
      this.closeResults();
    }
  }

  choose(e) {
    this.inputTarget.value = e.currentTarget.dataset.title;
    this.closeResults();
    this.dispatch("choose", {
      detail: {
        category_id: e.currentTarget.dataset.category_id,
        account_id: e.currentTarget.dataset.account_id,
      },
    });
  }

  clickOutside() {
    this.closeResults();
  }

  async startSearch(query) {
    const response = await get(this.urlValue, {
      query: { q: encodeURIComponent(query) },
      responseKind: "turbo-stream",
    });

    if (response.statusCode === 200) {
      this.showResults();
    } else {
      this.closeResults();
    }
  }

  showResults() {
    if (this.cleanupFloating) {
      this.cleanupFloating();
    }

    this.cleanupFloating = autoUpdate(
      this.inputTarget.parentElement,
      this.resultsTarget,
      () => {
        computePosition(this.inputTarget.parentElement, this.resultsTarget, {
          placement: "bottom",
          middleware: [offset(5), flip(), shift()],
        }).then(({ x, y }) => {
          Object.assign(this.resultsTarget.style, {
            position: "absolute",
            left: `${x}px`,
            top: `${y}px`,
          });
        });
      },
    );

    this.resultsTarget.classList.remove("hidden");
  }

  closeResults() {
    this.resultsTarget.classList.add("hidden");

    if (this.cleanupFloating) {
      this.cleanupFloating();
    }
  }

  clear() {
    // Clear input
    this.inputTarget.value = "";

    // Hide clear button
    if (this.hasClearButtonTarget) {
      this.clearButtonTarget.classList.add(this.hiddenClass);
    }

    // Close results
    this.closeResults();

    // Focus input
    this.inputTarget.focus();
  }
}

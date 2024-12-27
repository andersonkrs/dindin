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
    debounce: { type: Number, default: 300 },
  };

  connect() {
    useDebounce(this, { wait: 300 });
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
  }

  clickOutside() {
    this.closeResults();
  }

  async startSearch(query) {
    // Add loading class
    //this.inputTarget.classList.add(this.loadingClass);

    const response = await get(this.urlValue, {
      query: { q: encodeURIComponent(query) },
      responseKind: "turbo-stream",
    });

    if (response.ok) {
      this.showResults();
    } else {
      console.error("Search failed:", error);
      this.closeResults();
    }

    //this.inputTarget.classList.remove(this.loadingClass);
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
    // Remove results
    this.resultsTarget.classList.add("hidden");

    // Cleanup floating positioning
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

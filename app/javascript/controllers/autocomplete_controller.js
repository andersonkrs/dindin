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
  static targets = ["input", "results", "item", "clearButton"];

  static debounces = ["search"];

  static classes = ["highlightedItem"];

  #highlightedIndex;

  static values = {
    url: String,
    minLength: { type: Number, default: 2 },
    debounce: { type: Number, default: 500 },
  };

  connect() {
    useDebounce(this, { wait: this.debounceValue });
    useClickOutside(this);
  }

  get isOpen() {
    return !this.resultsTarget.classList.contains("hidden");
  }

  set highlightedIndex(index) {
    this.itemTargets.forEach((item) => {
      item.classList.remove(...this.highlightedItemClasses);
    });

    const maxIndex = this.itemTargets.length - 1;
    this.#highlightedIndex = Math.max(Math.min(index, maxIndex), -1);

    if (
      this.#highlightedIndex >= 0 &&
      this.#highlightedIndex < this.itemTargets.length
    ) {
      const item = this.itemTargets[this.#highlightedIndex];
      item.classList.add(...this.highlightedItemClasses);
    }
  }

  get highlightedIndex() {
    return this.#highlightedIndex;
  }

  search() {
    const query = this.inputTarget.value;

    if (query.length >= this.minLengthValue) {
      this.#startSearch(query);
    } else {
      this.close();
    }
  }

  focusPrevious(e) {
    e.preventDefault();

    if (this.isOpen) {
      this.highlightedIndex = Math.max(this.highlightedIndex - 1, 0);
    }
  }

  focusNext(e) {
    e.preventDefault();

    if (this.isOpen) {
      this.highlightedIndex = Math.min(
        this.highlightedIndex + 1,
        this.itemTargets.length - 1,
      );
    }
  }

  highlight(e) {
    e.preventDefault();

    const index = this.itemTargets.findIndex(
      (el) => el.dataset.id == e.currentTarget.dataset.id,
    );

    this.highlightedIndex = index;
  }

  chooseFocused(e) {
    if (this.isOpen) {
      e.preventDefault();

      const focused = this.itemTargets[this.highlightedIndex];

      if (focused) {
        this.#internalChoose(focused);
      } else {
        this.close();
      }
    }
  }

  choose(e) {
    this.#internalChoose(e.currentTarget);
  }

  close() {
    this.resultsTarget.classList.add("hidden");

    if (this.cleanupFloating) {
      this.cleanupFloating();
    }
  }

  clickOutside() {
    this.close();
  }

  async #startSearch(query) {
    const response = await get(this.urlValue, {
      query: { q: encodeURIComponent(query) },
      responseKind: "turbo-stream",
    });

    if (response.statusCode === 200) {
      this.#showResults();
    } else {
      this.close();
    }
  }

  clear() {
    this.inputTarget.value = "";

    if (this.hasClearButtonTarget) {
      this.clearButtonTarget.classList.add(this.hiddenClass);
    }

    this.close();
    this.inputTarget.focus();
  }

  #showResults() {
    if (this.cleanupFloating) {
      this.cleanupFloating();
    }

    if (this.inputTarget != document.activeElement) {
      return;
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
    this.highlightedIndex = -1;
  }

  #internalChoose(itemElement) {
    this.inputTarget.value = itemElement.dataset.title;
    this.highlightedIndex = -1;

    this.close();
    this.dispatch("choose", { target: itemElement });
  }
}

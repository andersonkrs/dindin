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
    this._highlightedIndex = Math.max(Math.min(index, maxIndex), -1);

    if (
      this._highlightedIndex >= 0 &&
      this._highlightedIndex < this.itemTargets.length
    ) {
      const item = this.itemTargets[this._highlightedIndex];
      item.classList.add(...this.highlightedItemClasses);
    }
  }

  get highlightedIndex() {
    return this._highlightedIndex;
  }

  search() {
    const query = this.inputTarget.value;

    if (query.length >= this.minLengthValue) {
      this._startSearch(query);
    } else {
      this._closeResults();
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
    e.preventDefault();

    const focused = this.itemTargets[this.highlightedIndex];

    if (focused) {
      this._internalChoose(focused);
    }
  }

  choose(e) {
    this._internalChoose(e.currentTarget);
  }

  clickOutside() {
    this._closeResults();
  }

  async _startSearch(query) {
    const response = await get(this.urlValue, {
      query: { q: encodeURIComponent(query) },
      responseKind: "turbo-stream",
    });

    if (response.statusCode === 200) {
      this._showResults();
    } else {
      this._closeResults();
    }
  }

  clear() {
    this.inputTarget.value = "";

    if (this.hasClearButtonTarget) {
      this.clearButtonTarget.classList.add(this.hiddenClass);
    }

    this._closeResults();
    this.inputTarget.focus();
  }

  _showResults() {
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
    this.highlightedIndex = -1;
  }

  _closeResults() {
    this.resultsTarget.classList.add("hidden");

    if (this.cleanupFloating) {
      this.cleanupFloating();
    }
  }

  _internalChoose(itemElement) {
    this.inputTarget.value = itemElement.dataset.title;
    this.highlightedIndex = -1;

    this._closeResults();
    this.dispatch("choose", { target: itemElement });
  }
}

import { Controller } from "@hotwired/stimulus";
import { useClickOutside } from "stimulus-use";
import {
  autoUpdate,
  computePosition,
  offset,
  flip,
  shift,
} from "@floating-ui/dom";

export default class extends Controller {
  static targets = [
    "input",
    "label",
    "list",
    "selected",
    "selectedIcon",
    "item",
  ];

  static classes = ["highlightedItem", "highlightedCheck"];

  connect() {
    useClickOutside(this);

    if (this.inputTarget.value) {
      this.selectId(this.inputTarget.value);
      this.highlightedIndex = this.indexOfCurrentItem();
    } else {
      this.highlightedIndex = 0;
    }
  }

  set highlightedIndex(index) {
    this.itemTargets.forEach((item) => {
      item.classList.remove(...this.highlightedItemClasses);
      item
        .querySelector(`[data-attribute="check"]`)
        .classList.remove(...this.highlightedItemClasses);
    });

    const maxIndex = this.visibleItems.length - 1;
    this._highlightedIndex = Math.max(Math.min(index, maxIndex), -1);

    if (
      this._highlightedIndex >= 0 &&
      this._highlightedIndex < this.visibleItems.length
    ) {
      const item = this.visibleItems[this._highlightedIndex];
      item.classList.add(...this.highlightedItemClasses);
      item
        .querySelector(`[data-attribute="check"]`)
        .classList.add(...this.highlightedItemClasses);

      item.scrollIntoView({ block: "nearest" });
    }
  }

  get highlightedIndex() {
    return this._highlightedIndex;
  }

  get visibleItems() {
    return this.itemTargets.filter(
      (item) => !item.classList.contains("hidden"),
    );
  }

  get isClosed() {
    return this.listTarget.classList.contains("hidden");
  }

  selectId(value) {
    this.inputTarget.value = value;

    const selectedItem = this.currentItem();

    if (selectedItem) {
      this.selectedTarget.value = selectedItem.dataset.title;
      this.updateSelectedElement(selectedItem);
    }
  }

  clickOutside() {
    this.highlightedIndex = -1;

    if (this.selectedTarget.value && !this.inputTarget.value) {
      this.selectedTarget.value = null;
    }
    this.close();
  }

  toggle() {
    if (this.isClosed) {
      this.open();
    } else {
      this.close();
    }
  }

  handleSearch(e) {
    const typedText = e.target.value.toLowerCase();

    if (this.isClosed) {
      this.open();
    }

    this.inputTarget.value = null;
    this.showEmptyIcon();
    this.removeCheckMarks();

    this.itemTargets.forEach((item) => {
      const title = item.dataset.title.toLowerCase();
      if (title.includes(typedText)) {
        item.classList.remove("hidden");
      } else {
        item.classList.add("hidden");
      }
    });

    if (this.visibleItems.length > 0) {
      this.highlightedIndex = 0;
    } else {
      this.close();
      this.highlightedIndex = -1;
    }
  }

  open() {
    if (this.cleanup) {
      this.cleanup();
    }

    this.listTarget.classList.remove("hidden");
    this.itemTargets.forEach((element) => element.classList.remove("hidden"));

    if (this.indexOfCurrentItem() >= 0) {
      this.highlightedIndex = this.indexOfCurrentItem();
    } else {
      this.highlightedIndex = -1;
    }

    this.cleanup = autoUpdate(this.labelTarget, this.listTarget, () => {
      computePosition(this.labelTarget, this.listTarget, {
        placement: "bottom",
        middleware: [offset(5), flip(), shift()],
      }).then(({ x, y }) => {
        Object.assign(this.listTarget.style, {
          left: `${x}px`,
          top: `${y}px`,
        });

        this.currentItem()?.scrollIntoView();
      });
    });
  }

  close() {
    this.listTarget.classList.add("hidden");
  }

  currentItem() {
    return this.itemTargets.find(
      (item) => item.dataset.id === this.inputTarget.value,
    );
  }

  indexOfCurrentItem() {
    const item = this.currentItem();
    if (!item) return -1;

    return this.visibleItems.indexOf(item);
  }

  highlightPrevious(e) {
    e.preventDefault();

    if (this.isClosed) {
      this.open();
    } else {
      this.highlightedIndex = Math.max(this.highlightedIndex - 1, 0);
    }
  }

  highlightNext(e) {
    e.preventDefault();

    if (this.isClosed) {
      this.open();
    } else {
      this.highlightedIndex = Math.min(
        this.highlightedIndex + 1,
        this.itemTargets.length - 1,
      );

      console.log(this.highlightedIndex);
    }
  }

  highlight(e) {
    e.preventDefault();

    const index = this.visibleItems.findIndex(
      (el) => el.dataset.id == e.target.dataset.id,
    );

    this.highlightedIndex = index;
  }

  chooseHighlightedItem(e) {
    e.preventDefault();

    if (
      this.highlightedIndex < 0 ||
      this.highlightedIndex >= this.visibleItems.length
    ) {
      return;
    }

    const item = this.visibleItems[this.highlightedIndex];
    this.selectId(item.dataset.id);
    this.close();
  }

  clear(e) {
    e.preventDefault();
    this.inputTarget.value = null;
    this.selectedTarget.value = null;
    this.removeCheckMarks();
    this.showEmptyIcon();
  }

  cancel(e) {
    e.preventDefault();
    this.close();
  }

  choose(e) {
    const selectedItem = e.currentTarget;
    const id = selectedItem.dataset.id;
    const title = selectedItem.dataset.title;

    this.selectedTarget.value = title;
    this.inputTarget.value = id;

    this.updateSelectedElement(selectedItem);
    this.close();
  }

  updateSelectedElement(selectedItem) {
    this.showSelectedIcon(selectedItem);
    this.removeCheckMarks();

    selectedItem
      .querySelector(`[data-attribute="title"]`)
      .classList.remove("font-normal");

    selectedItem
      .querySelector(`[data-attribute="title"]`)
      .classList.add("font-semibold");

    selectedItem
      .querySelector(`[data-attribute="check"]`)
      .classList.remove("hidden");
  }

  removeCheckMarks() {
    this.itemTargets.forEach((itemTarget) => {
      itemTarget
        .querySelector(`[data-attribute="title"]`)
        .classList.remove("font-semibold");

      itemTarget
        .querySelector(`[data-attribute="title"]`)
        .classList.add("font-normal");

      itemTarget
        .querySelector(`[data-attribute="check"]`)
        .classList.add("hidden");
    });
  }

  showSelectedIcon(selectedElement) {
    if (!this.hasSelectedIconTarget) {
      return;
    }

    const iconElement = selectedElement.querySelector(
      `[data-attribute="icon"]`,
    );

    if (!iconElement) return;

    const selectedIcon = iconElement.cloneNode(true);

    this.selectedIconTarget
      .querySelector(`[data-attribute="icon"]`)
      .replaceWith(selectedIcon);

    this.selectedIconTarget
      .querySelector(`[data-attribute="icon-placeholder"]`)
      .classList.add("hidden");
  }

  showEmptyIcon() {
    if (!this.hasSelectedIconTarget) {
      return;
    }

    this.selectedIconTarget
      .querySelector(`[data-attribute="icon"]`)
      .classList.add("hidden");

    this.selectedIconTarget
      .querySelector(`[data-attribute="icon-placeholder"]`)
      .classList.remove("hidden");
  }
}

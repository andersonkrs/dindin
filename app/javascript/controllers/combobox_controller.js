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

  connect() {
    useClickOutside(this);

    if (this.inputTarget.value) {
      this.selectId(this.inputTarget.value);
    }
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
    this.close();
  }

  toggle() {
    if (this.isListHidden()) {
      this.open();
    } else {
      this.close();
    }
  }

  isListHidden() {
    return this.listTarget.classList.contains("hidden");
  }

  open() {
    if (this.cleanup) {
      this.cleanup();
    }

    this.listTarget.classList.remove("hidden");

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

  openModal() {
    this.modalTarget.classList.remove("hidden");
  }

  closeModal() {
    this.modalTarget.classList.add("hidden");
  }

  currentItem() {
    return this.itemTargets.find(
      (item) => item.dataset.id === this.inputTarget.value,
    );
  }

  handleKeyDown(e) {
    if (e.key === "Backspace") {
      e.preventDefault();
      this.inputTarget.value = null;
      this.selectedTarget.value = null;
      this.removeCheckMarks();
      this.showEmptyIcon();
    }
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

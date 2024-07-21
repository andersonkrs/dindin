import { Controller } from "@hotwired/stimulus";
import { observeMutations } from "../helpers";

// Connects to data-controller="divider"
export default class extends Controller {
  static dividerClasses = ["before:content-[attr(data-divider-content)]"];

  initialize() {
    observeMutations.bind(this)(this.update);
  }

  connect() {
    this.update();
  }

  update() {
    const { children } = this.element;

    for (let item of children) {
      this.toggleDivider(item);
    }
  }

  toggleDivider = (child) => {
    const previous = child.previousElementSibling;

    if (previous && previous.dataset.dividerKey === child.dataset.dividerKey) {
      child.classList.remove(...this.constructor.dividerClasses);
    } else {
      child.classList.add(...this.constructor.dividerClasses);
    }
  };
}

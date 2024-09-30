import { Controller } from "@hotwired/stimulus";
import { observeMutations } from "../helpers";

// Connects to data-controller="sorted"
export default class extends Controller {
  static values = {
    reverse: Boolean,
  };

  initialize() {
    observeMutations.bind(this)(this.sortChildren);
  }

  connect() {
    this.sortChildren();
  }

  sortChildren() {
    const { children } = this;

    if (elementsAreSorted(children, this.reverseValue)) return;

    children
      .sort((a, b) => compareElements(a, b, this.reverseValue))
      .forEach(this.append);
  }

  get children() {
    return Array.from(this.element.children);
  }

  append = (child) => this.element.append(child);
}

function elementsAreSorted([left, ...rights], reverse) {
  for (const right of rights) {
    if (compareElements(left, right, reverse) > 0) return false;
    left = right;
  }
  return true;
}

function compareElements(left, right, reverse) {
  if (reverse) {
    return getSortCode(right).localeCompare(getSortCode(left));
  } else {
    return getSortCode(left).localeCompare(getSortCode(right));
  }
}

function getSortCode(element) {
  return element.getAttribute("data-sort-key");
}

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["icon"];

  handleColorChanged(e) {
    let categoryColor = e.target.parentElement.querySelector(".category-color");
    let color = document.defaultView.getComputedStyle(categoryColor).background;

    this.iconTarget.style.background = color;
  }

  handleIconChanged(e) {
    let newCategoryIcon = e.target.parentElement
      .querySelector(".category-icon")
      .cloneNode(true);

    let oldCategoryIcon = this.iconTarget.querySelector(".category-icon");

    newCategoryIcon.classList = oldCategoryIcon.classList.toString();
    oldCategoryIcon.replaceWith(newCategoryIcon);
  }
}

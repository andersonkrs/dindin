import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["avatar"];

  handleColorChanged(e) {
    let categoryColor = e.target.parentElement.querySelector(".category-color");
    let color = document.defaultView.getComputedStyle(categoryColor).background;

    this.avatarTarget.style.background = color;
  }

  handleIconChanged(e) {
    let newCategoryIcon = e.target.parentElement
      .querySelector(".category-icon")
      .cloneNode(true);

    let oldCategoryIcon = this.avatarTarget.querySelector(".category-icon");

    newCategoryIcon.classList = oldCategoryIcon.classList.toString();
    oldCategoryIcon.replaceWith(newCategoryIcon);
  }
}

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["submit", "form", "card", "kindInput"];

  connect() {
    this.element.showModal();
    this.updateSubmitState();
  }

  submitEnd(e) {
    if (e.detail.success) {
      this.handleClose();
    }
  }

  handleClose() {
    this.element.remove();
  }

  flipCard() {
    this.cardTarget.classList.toggle("rotate-y-180");

    setTimeout(() => this.unflipCard(), 200);
  }

  unflipCard() {
    if (this.kindInputTarget.value == "income") {
      this.cardTarget.classList.remove("category-gradient--income");
      this.cardTarget.classList.add("category-gradient--expense");
      this.kindInputTarget.value = "expense";
    } else {
      this.cardTarget.classList.remove("category-gradient--expense");
      this.cardTarget.classList.add("category-gradient--income");
      this.kindInputTarget.value = "income";
    }

    this.cardTarget.classList.toggle("rotate-y-180");
  }

  updateSubmitState() {
    const selectedColor = this.formTarget["category[color]"].value;
    const selectedIcon = this.formTarget["category[icon]"].value;

    if (selectedIcon && selectedColor) {
      this.submitTarget.classList.remove("btn-disabled");
    } else {
      this.submitTarget.classList.add("btn-disabled");
    }
  }
}

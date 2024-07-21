import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "frame"];

  connect() { }

  open() {
    this.modalTarget.showModal();
  }

  close() {
    this.modalTarget.close();
  }

  submitEnd(e) {
    console.log(e);
    if (e.detail.success) {
      this.close();
    }
  }

  afterDelete(e) {
    console.log(e);
  }

  //updateSubmitState() {
  //  const selectedColor = this.formTarget["category[color]"].value;
  //  const selectedIcon = this.formTarget["category[icon]"].value;
  //
  //  if (selectedIcon && selectedColor) {
  //    this.submitTarget.classList.remove("btn-disabled");
  //  } else {
  //    this.submitTarget.classList.add("btn-disabled");
  //  }
  //}
}

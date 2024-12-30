import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static outlets = ["combobox"];
  static targets = ["modal"];

  connect() {
    this.open();
  }

  suggestionSelected(e) {
    this.comboboxOutlet.selectId(e.detail.dataset.category_id);
  }

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
}

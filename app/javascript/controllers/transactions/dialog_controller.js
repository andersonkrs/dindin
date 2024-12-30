import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static outlets = ["combobox"];
  static targets = ["modal"];

  connect() {
    this.open();
  }

  suggestionSelected(e) {
    this.comboboxOutlets.forEach((combobox) => {
      if (combobox.element.id === "form-category-id-combobox") {
        combobox.selectId(e.detail.category_id);
      }

      if (combobox.element.id === "form-account-id-combobox") {
        combobox.selectId(e.detail.account_id);
      }
    });
  }

  open() {
    this.modalTarget.showModal();
  }

  close() {
    this.modalTarget.close();
  }
}

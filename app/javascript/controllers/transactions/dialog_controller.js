import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static outlets = ["combobox"];

  connect() {
    this.element.addEventListener("close", () => {
      this.element.remove();
    });
  }

  suggestionSelected(e) {
    this.comboboxOutlets.forEach((combobox) => {
      if (combobox.element.id === "form-category-id-combobox") {
        combobox.selectId(e.target.dataset.category_id);
      }

      if (combobox.element.id === "form-account-id-combobox") {
        combobox.selectId(e.target.dataset.account_id);
      }
    });
  }

  open() {
    this.element.showModal();
  }

  close() {
    this.element.close();
  }
}

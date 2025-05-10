import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static outlets = ["combobox"];
  static targets = ["paidToggle"];
  static values = {
    transactionId: String,
  };

  connect() {
    this.element.addEventListener("close", () => {
      this.element.remove();
    });
    this.open();
  }

  get isNew() {
    return this.transactionIdValue === "";
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

  recurrenceChanged(e) {
    if (!this.isNew) return;

    const { recurrent } = e.detail;

    if (this.hasPaidToggleTarget && recurrent) {
      this.paidToggleTarget.checked = false;
    }
  }

  paidOnChanged(e) {
    if (!this.isNew) return;

    const selectedDate = new Date(e.target.value);
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    this.paidToggleTarget.checked = selectedDate <= today;
  }

  open() {
    this.element.showModal();
  }

  close() {
    this.element.close();
  }
}

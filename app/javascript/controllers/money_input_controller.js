import { Controller } from "@hotwired/stimulus";
import { Current } from "current.js";

export default class extends Controller {
  static targets = ["input"];

  handleFocus() {
    const currValue = this.inputTarget.value;
    this.inputTarget.setSelectionRange(currValue.length, currValue.length);
  }

  handleFormat(e) {
    e.preventDefault();

    const formatter = new Intl.NumberFormat(Current.locale, {
      roundingPriority: "lessPrecision",
      minimumIntegerDigits: 1,
      minimumFractionDigits: 2,
    });

    const value = e.target.value.replace(/\D/g, "");
    const oldValue = this.inputTarget.value.replace(/[^0-9.,]/, "");

    const numberValue = Number(value, 10);

    if (numberValue === 0) {
      e.target.value = formatter.format(0);
    } else if (!numberValue) {
      e.target.value = oldValue;
    } else {
      e.target.value = formatter.format(numberValue / 100);
    }
  }
}

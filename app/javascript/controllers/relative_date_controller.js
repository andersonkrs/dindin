import { Controller } from "@hotwired/stimulus";
import { Current } from "current.js";

// Connects to data-controller="relative-date"
export default class extends Controller {
  static values = {
    attribute: String,
  };

  connect() {
    this.update();
  }

  get currentDate() {
    return this.element.getAttribute(this.attributeValue);
  }

  set currentDate(value) {
    this.element.setAttribute(this.attributeValue, value);
  }

  update() {
    const givenDate = new Date(this.currentDate);

    const today = new Date();
    today.setHours(0, 0, 0, 0);
    givenDate.setHours(0, 0, 0, 0);

    // Calculate the difference in time
    let timeDifference = givenDate - today;
    let daysDifference = timeDifference / (1000 * 60 * 60 * 24);

    // Formatters for different parts of the output
    let shortDateFormatter = new Intl.DateTimeFormat(Current.locale, {
      month: "short",
      day: "numeric",
      year: "numeric",
    });
    let relativeDayFormatter = new Intl.RelativeTimeFormat(Current.locale, {
      numeric: "auto",
    });
    let dateWithWeekDayFormatter = new Intl.DateTimeFormat(Current.locale, {
      month: "short",
      day: "numeric",
      year: "numeric",
      weekday: "long",
    });

    let formattedDate;

    if (daysDifference >= -1 && daysDifference <= 1) {
      formattedDate = `${relativeDayFormatter.format(daysDifference, "day")}, ${shortDateFormatter.format(givenDate)}`;
    } else {
      formattedDate = dateWithWeekDayFormatter.format(givenDate);
    }

    this.currentDate = formattedDate;
  }
}

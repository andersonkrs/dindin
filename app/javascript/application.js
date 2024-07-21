// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import { Application } from "@hotwired/stimulus";
import "./controllers";

window.Stimulus = Application.start();
window.Stimulus.debug = true;

import { config } from "current.js";
config.prefix = "config";

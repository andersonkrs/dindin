module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
  plugins: [require("daisyui")],
  daisyui: {
    themes: ["emerald"],
  },
  theme: {
    extend: {
      strokeWidth: {
        4: "4px",
      },
    },
  },
};

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
        3: "3px",
        4: "4px"
      },
    },
  },
};

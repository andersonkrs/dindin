export function observeMutations(
  callback,
  target = this.element,
  options = {
    childList: true,
    subtree: true,
  },
) {
  const observer = new MutationObserver((mutations) => {
    observer.disconnect();
    Promise.resolve().then(start);
    callback.call(this, mutations);
  });

  function start() {
    if (target.isConnected) observer.observe(target, options);
  }

  start();
}

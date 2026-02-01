import 'dart:js_interop';
import 'dart:js_interop' as web;
import 'package:web/web.dart' as web;

void startObserving(String id, Function(bool) callback) {
  final options = web.IntersectionObserverInit(threshold: 0.2.toJS);
  
  final observer = web.IntersectionObserver(
    (web.JSArray entries, web.IntersectionObserver observer) {
      for (var entry in entries.toDart) {
        final intersectEntry = entry as web.IntersectionObserverEntry;
        callback(intersectEntry.isIntersecting);
      }
    }.toJS,
    options,
  );

  final element = web.document.getElementById(id);
  if (element != null) {
    observer.observe(element);
  }
}

 var Loader = function () {
     var d = document,
         head = d.getElementsByTagName("head")[0];

     var loadJs = function (url, cb) {
         var script = d.createElement('script');
         script.setAttribute('src', url);
         script.setAttribute('type', 'text/javascript');

         var loaded = false;
         var loadFunction = function () {
             if (loaded) return;
           //  console.log("loaded " + url);
             loaded = true;
             cb && cb();
         };
         script.onload = loadFunction;
         script.onreadystatechange = loadFunction;
         head.appendChild(script);
     };

     var cachedBrowser;

     var browser = function () {
         if (!cachedBrowser) {
             var ua = navigator.userAgent.toLowerCase();
             var match = /(webkit)[ \/]([\w.]+)/.exec(ua) ||
				/(opera)(?:.*version)?[ \/]([\w.]+)/.exec(ua) ||
				/(msie) ([\w.]+)/.exec(ua) ||
				!/compatible/.test(ua) && /(mozilla)(?:.*? rv:([\w.]+))?/.exec(ua) ||
				[];
             cachedBrowser = match[1];
         }
         return cachedBrowser;
     };

     var loadCss = function (url, cb) {
         var link = d.createElement("link");
         link.type = "text/css";
         link.rel = "stylesheet";
         link.href = url;

         if (browser() == "msie")
             link.onreadystatechange = function () {
                 /loaded|complete/.test(link.readyState) && cb();
             }
         else if (browser() == "opera")
             link.onload = cb;
         else
         //FF, Safari, Chrome
             (function () {
                 try {
                     link.sheet.cssRule;
                 } catch (e) {
                     setTimeout(arguments.callee, 20);
                     return;
                 };
                 cb();
             })();

         head.appendChild(link);
     };

     return { loadCss: loadCss, loadJs: loadJs };

 } ();

 function PageLet(p, domInserted) {
     var data = p,
		remainingCss = 0;

     var loadCss = function () {
         //load css
         if (data.Css && data.Css.length) {
            // console.log("Loading CSS for pagelet " + p.Id);
             remainingCss = data.Css.length;
             for (var i = remainingCss; i--; )
                 Loader.loadCss(data.Css[i], function () {
                     ! --remainingCss && insertDom();
                 });
         }
         else
             insertDom();
     }

     var insertDom = function () {
         //console.log("Inserting content for pagelet " + p.Id);
         document.getElementById(p.Id).innerHTML = p.Content;
         domInserted();
     }

     var loadJs = function () {
         if (!data.Js) return;
         //load js
         //console.log("Loading JS for pagelet " + p.Id);
         for (var i = 0; i < data.Js.length; i++)
             Loader.loadJs(data.Js[i]);
     }

     return { loadCss: loadCss, loadJs: loadJs };
 }

 var BigPipe = function (count) {

     var d = document,
        pagelets = []; 		/* registered pagelets */

     var onPageletArrive = function (p) {
         count = count || p.count;
         var pagelet = new PageLet(p, function () {
             if (! --count) {
                 //load js
                 for (var i = 0; i < pagelets.length; i++)
                     pagelets[i].loadJs();
             }
         });
         pagelets.push(pagelet);
         pagelet.loadCss();
     };

     return { onPageletArrive: onPageletArrive };
 };
 
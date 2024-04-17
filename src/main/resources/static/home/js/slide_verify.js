"use strict";

// polyfill Object.assign
if (typeof Object.assign != "function") {
    // Must be writable: true, enumerable: false, configurable: true
    Object.defineProperty(Object, "assign", {
        value: function assign(target, varArgs) {
            // .length of function is 2
            "use strict";
            if (target == null) {
                // TypeError if undefined or null
                throw new TypeError("Cannot convert undefined or null to object");
            }

            var to = Object(target);

            for (var index = 1; index < arguments.length; index++) {
                var nextSource = arguments[index];

                if (nextSource != null) {
                    // Skip over if undefined or null
                    for (var nextKey in nextSource) {
                        // Avoid bugs when hasOwnProperty is shadowed
                        if (Object.prototype.hasOwnProperty.call(nextSource, nextKey)) {
                            to[nextKey] = nextSource[nextKey];
                        }
                    }
                }
            }
            return to;
        },
        writable: true,
        configurable: true
    });
}

// polyfill classlist
if (!("classList" in document.documentElement)) {
    Object.defineProperty(Element.prototype, "classList", {
        get: function () {
            var self = this,
                rspaces = /\s+/g,
                implement;

            function classlist() {
                return self.className.trim().split(rspaces);
            }

            function update(fn) {
                return function (value) {
                    var classes = classlist(),
                        index = classes.indexOf(value);

                    fn(classes, index, value);
                    self.className = classes.join(" ");

                    implement.length = classes.length;
                };
            }

            implement = {
                length: (function () {
                    return classlist().length;
                })(),

                add: update(function (classes, index, value) {
                    ~index || classes.push(value);
                }),

                remove: update(function (classes, index) {
                    ~index && classes.splice(index, 1);
                }),

                toggle: update(function (classes, index, value) {
                    ~index ? classes.splice(index, 1) : classes.push(value);
                }),

                contains: function (value) {
                    return !!~classlist().indexOf(value);
                },

                item: function (i) {
                    return classlist()[i] || null;
                }
            };

            return implement;
        }
    });
}

// _createClass
var _createClass = (function () {
    function defineProperties(target, props) {
        for (var i = 0; i < props.length; i++) {
            var descriptor = props[i];
            descriptor.enumerable = descriptor.enumerable || false;
            descriptor.configurable = true;
            if ("value" in descriptor) descriptor.writable = true;
            Object.defineProperty(target, descriptor.key, descriptor);
        }
    }
    return function (Constructor, protoProps, staticProps) {
        if (protoProps) defineProperties(Constructor.prototype, protoProps);
        if (staticProps) defineProperties(Constructor, staticProps);
        return Constructor;
    };
})();

function _classCallCheck(instance, Constructor) {
    if (!(instance instanceof Constructor)) {
        throw new TypeError("Cannot call a class as a function");
    }
}

(function (window) {
    var l = 35, // 滑块边长
        r = 8, // 滑块半径
        w = 350, // canvas宽度
        h = 200, // canvas高度
        PI = Math.PI;
    var L = l + r * 2 + 3; // 滑块实际边长

    function getRandomNumberByRange(start, end) {
        return Math.round(Math.random() * (end - start) + start);
    }

    function createCanvas(width, height) {
        var canvas = createElement("canvas");
        canvas.width = width;
        canvas.height = height;
        return canvas;
    }

    function createImg(onload) {
        var img = createElement("img");
        img.crossOrigin = "anonymous";
        img.onload = onload;
        img.onerror = function () {
            img.src = getRandomImg();
        };
        img.src = getRandomImg();
        return img;
    }

    function createElement(tagName) {
        return document.createElement(tagName);
    }

    function addClass(tag, className) {
        tag.classList.add(className);
    }

    function removeClass(tag, className) {
        tag.classList.remove(className);
    }

    function getRandomImg() {
        return (
            verifyUrl + getRandomNumberByRange(0, 35) + ".jpg"
        );
    }

    function _draw(ctx, x, y, operation) {
        ctx.beginPath();
        ctx.moveTo(x, y);
        ctx.arc(x + l / 2, y - r + 2, r, 0.72 * PI, 2.26 * PI);
        ctx.lineTo(x + l, y);
        ctx.arc(x + l + r - 2, y + l / 2, r, 1.21 * PI, 2.78 * PI);
        ctx.lineTo(x + l, y + l);
        ctx.lineTo(x, y + l);
        ctx.arc(x + r - 2, y + l / 2, r + 0.4, 2.76 * PI, 1.24 * PI, true);
        ctx.lineTo(x, y);
        ctx.lineWidth = 2;
        ctx.fillStyle = "rgba(255, 255, 255, 0.7)";
        ctx.strokeStyle = "rgba(255, 255, 255, 0.7)";
        ctx.stroke();
        ctx[operation]();
        ctx.globalCompositeOperation = "destination-over";
    }

    function sum(x, y) {
        return x + y;
    }

    function square(x) {
        return x * x;
    }

    var SlideVerify = (function () {
        function SlideVerify(_ref) {
            var el = _ref.el,
                onSuccess = _ref.onSuccess,
                onFail = _ref.onFail,
                onRefresh = _ref.onRefresh;

            _classCallCheck(this, SlideVerify);

            this.el = el;
            this.onSuccess = onSuccess;
            this.onFail = onFail;
            this.onRefresh = onRefresh;
        }

        _createClass(SlideVerify, [
            {
                key: "init",
                value: function init() {
                    this.initDOM();
                    this.initImg();
                    this.bindEvents();
                }
            },
            {
                key: "initDOM",
                value: function initDOM() {
                    var canvas = createCanvas(w, h); // 画布
                    var block = canvas.cloneNode(true); // 滑块
                    var sliderContainer = createElement("div");
                    var refreshIcon = createElement("div");
                    var sliderMask = createElement("div");
                    var slider = createElement("div");
                    var sliderIcon = createElement("span");
                    var text = createElement("span");

                    block.className = "slide-verify-block";
                    sliderContainer.className = "sliderContainer";
                    refreshIcon.className = "refreshIcon";
                    sliderMask.className = "sliderMask";
                    slider.className = "slider";
                    sliderIcon.className = "sliderIcon";
                    text.innerHTML = "向右滑动滑块填充拼图";
                    text.className = "sliderText";

                    var el = this.el;
                    el.appendChild(canvas);
                    el.appendChild(refreshIcon);
                    el.appendChild(block);
                    slider.appendChild(sliderIcon);
                    sliderMask.appendChild(slider);
                    sliderContainer.appendChild(sliderMask);
                    sliderContainer.appendChild(text);
                    el.appendChild(sliderContainer);

                    Object.assign(this, {
                        canvas: canvas,
                        block: block,
                        sliderContainer: sliderContainer,
                        refreshIcon: refreshIcon,
                        slider: slider,
                        sliderMask: sliderMask,
                        sliderIcon: sliderIcon,
                        text: text,
                        canvasCtx: canvas.getContext("2d"),
                        blockCtx: block.getContext("2d")
                    });
                }
            },
            {
                key: "initImg",
                value: function initImg() {
                    var _this = this;

                    var img = createImg(function () {
                        _this.draw();
                        _this.canvasCtx.drawImage(img, 0, 0, w, h);
                        _this.blockCtx.drawImage(img, 0, 0, w, h);
                        var y = _this.y - r * 2 - 1;
                        var ImageData = _this.blockCtx.getImageData(_this.x - 3, y, L, L);
                        _this.block.width = L;
                        _this.blockCtx.putImageData(ImageData, 0, y);
                    });
                    this.img = img;
                }
            },
            {
                key: "draw",
                value: function draw() {
                    // 随机创建滑块的位置
                    this.x = getRandomNumberByRange(L + 10, w - (L + 10));
                    this.y = getRandomNumberByRange(10 + r * 2, h - (L + 10));
                    _draw(this.canvasCtx, this.x, this.y, "fill");
                    _draw(this.blockCtx, this.x, this.y, "clip");
                }
            },
            {
                key: "clean",
                value: function clean() {
                    this.canvasCtx.clearRect(0, 0, w, h);
                    this.blockCtx.clearRect(0, 0, w, h);
                    this.block.width = w;
                }
            },
            {
                key: "bindEvents",
                value: function bindEvents() {
                    var _this2 = this;

                    this.el.onselectstart = function () {
                        return false;
                    };
                    this.refreshIcon.onclick = function () {
                        _this2.reset();
                        typeof _this2.onRefresh === "function" && _this2.onRefresh();
                    };

                    var originX = void 0,
                        originY = void 0,
                        trail = [],
                        isMouseDown = false;
                    this.slider.addEventListener("mousedown", function (e) {
                        (originX = e.x), (originY = e.y);
                        isMouseDown = true;
                    });
                    document.addEventListener("mousemove", function (e) {
                        if (!isMouseDown) return false;
                        var moveX = e.x - originX;
                        var moveY = e.y - originY;
                        if (moveX < 0 || moveX + 40 >= w) return false;
                        _this2.slider.style.left = moveX + "px";
                        var blockLeft = ((w - 40 - 20) / (w - 40)) * moveX;
                        _this2.block.style.left = blockLeft + "px";

                        addClass(_this2.sliderContainer, "sliderContainer_active");
                        _this2.sliderMask.style.width = moveX + "px";
                        trail.push(moveY);
                    });
                    document.addEventListener("mouseup", function (e) {
                        if (!isMouseDown) return false;
                        isMouseDown = false;
                        if (e.x == originX) return false;
                        removeClass(_this2.sliderContainer, "sliderContainer_active");
                        _this2.trail = trail;

                        var _verify = _this2.verify(),
                            spliced = _verify.spliced,
                            TuringTest = _verify.TuringTest;

                        if (spliced) {
                            if (TuringTest) {
                                addClass(_this2.sliderContainer, "sliderContainer_success");
                                typeof _this2.onSuccess === "function" && _this2.onSuccess();
                            } else {
                                addClass(_this2.sliderContainer, "sliderContainer_fail");
                                _this2.text.innerHTML = "再试一次";
                                _this2.reset();
                            }
                        } else {
                            addClass(_this2.sliderContainer, "sliderContainer_fail");
                            typeof _this2.onFail === "function" && _this2.onFail();
                            setTimeout(function () {
                                _this2.reset();
                            }, 1000);
                        }
                    });
                }
            },
            {
                key: "verify",
                value: function verify() {
                    var arr = this.trail;
                    // 拖动时 y 轴的移动距离
                    var average = arr.reduce(sum) / arr.length;

                    // 平均值
                    var deviations = arr.map(function (x) {
                        return x - average;
                    });

                    // 偏差数组
                    var stddev = Math.sqrt(
                        deviations.map(square).reduce(sum) / arr.length
                    );

                    // 标准差
                    var left = parseInt(this.block.style.left);
                    return {
                        spliced: Math.abs(left - this.x) < 10,
                        TuringTest: average !== stddev // 只是简单的验证拖动轨迹，相等时一般为0，表示可能非人为操作
                    };
                }
            },
            {
                key: "reset",
                value: function reset() {
                    this.sliderContainer.className = "sliderContainer";
                    this.slider.style.left = 0;
                    this.block.style.left = 0;
                    this.sliderMask.style.width = 0;
                    this.clean();
                    this.img.src = getRandomImg();

                }
            }
        ]);

        return SlideVerify;
    })();

    window.SlideVerify = {
        init: function init(opts) {
            return new SlideVerify(opts).init();
        }
    };
})(window);

//  SlideVerify.init
SlideVerify.init({
    //el: document.getElementById('loginCodeBtn'),
    el: document.getElementById('J_Captcha'),
    onSuccess: function () {
        var phone, cur, type;
        var parentNode = $('#J_Captcha').parent().parent()[0].id.toString();
        if (parentNode === "login-verifybox") {
            phone = $("#loginPhone").val();
            cur = document.getElementById("loginCodeBtn");
            type = "login";
        } else {
            phone = $("#registerPhone").val();
            cur = document.getElementById("registerCodeBtn");
            type = "register";
        }
        phone = $("#loginPhone").val().trim();
        //phone = $("#loginPhone").val();
        cur = document.getElementById("loginCodeBtn");
        type = "login";
        $.ajax({
            type: "Get",
            url: LogOrRegUrl.SendMessage + "?phone=" + phone,
            data: "",
            dateType: "json",
            success: function (data) {
                if (data == null || data == undefined) {
                    alert("访问频率过高，请稍后再试！");
                    return false;
                }
                if (!data.Success) {
                    //alert(data);
                    //$("#login-verifybox").html(data);
                    timeDown(cur);
                    return false;
                }
                timeDown(cur);
                return true;
            }
        });
        $(".slide-verifybox").html("");
    },
    onFail: cleanMsg,
    onRefresh: cleanMsg
});

function cleanMsg() {
    document.getElementById('J_Msg').innerHTML = '';
}

/*
*点击按钮倒计时效果
**/
var wait = 59;
function timeDown(obj) {
    if (wait === 0) {
        obj.removeAttribute("disabled");
        obj.value = "重获验证码";
        wait = 59;
        obj.style.color = "#23b7b7";
        obj.style.cursor = "";
    } else {
        obj.setAttribute("disabled", true);
        obj.style.color = "#999";
        obj.style.cursor = "default";
        obj.value = wait + "s后重发";
        wait--;
        setTimeout(function () {
                timeDown(obj);
            },
            1000);
    }
}
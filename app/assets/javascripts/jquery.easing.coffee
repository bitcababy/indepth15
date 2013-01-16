#
# * jQuery Easing v1.3 - http://gsgd.co.uk/sandbox/jquery/easing/
# *
# * Uses the built in easing capabilities added In jQuery 1.1
# * to offer multiple easing options
# *
# * TERMS OF USE - jQuery Easing
# * 
# * Open source under the BSD License. 
# * 
# * Copyright © 2008 George McGinley Smith
# * All rights reserved.
# * 
# * Redistribution and use in source and binary forms, with or without modification, 
# * are permitted provided that the following conditions are met:
# * 
# * Redistributions of source code must retain the above copyright notice, this list of 
# * conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice, this list 
# * of conditions and the following disclaimer in the documentation and/or other materials 
# * provided with the distribution.
# * 
# * Neither the name of the author nor the names of contributors may be used to endorse 
# * or promote products derived from this software without specific prior written permission.
# * 
# * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
# * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# *  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
# *  GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED 
# * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED 
# * OF THE POSSIBILITY OF SUCH DAMAGE. 
# *
#

# t: current time, b: begInnIng value, c: change In value, d: duration
jQuery.easing["jswing"] = jQuery.easing["swing"]
jQuery.extend jQuery.easing,
  def: "easeOutQuad"
  swing: (a, b, c, d, e) ->
    jQuery.easing[jQuery.easing.def] a, b, c, d, e

  easeInQuad: (a, b, c, d, e) ->
    d * (b /= e) * b + c

  easeOutQuad: (a, b, c, d, e) ->
    -d * (b /= e) * (b - 2) + c

  easeInOutQuad: (a, b, c, d, e) ->
    return d / 2 * b * b + c  if (b /= e / 2) < 1
    -d / 2 * (--b * (b - 2) - 1) + c

  easeInCubic: (a, b, c, d, e) ->
    d * (b /= e) * b * b + c

  easeOutCubic: (a, b, c, d, e) ->
    d * ((b = b / e - 1) * b * b + 1) + c

  easeInOutCubic: (a, b, c, d, e) ->
    return d / 2 * b * b * b + c  if (b /= e / 2) < 1
    d / 2 * ((b -= 2) * b * b + 2) + c

  easeInQuart: (a, b, c, d, e) ->
    d * (b /= e) * b * b * b + c

  easeOutQuart: (a, b, c, d, e) ->
    -d * ((b = b / e - 1) * b * b * b - 1) + c

  easeInOutQuart: (a, b, c, d, e) ->
    return d / 2 * b * b * b * b + c  if (b /= e / 2) < 1
    -d / 2 * ((b -= 2) * b * b * b - 2) + c

  easeInQuint: (a, b, c, d, e) ->
    d * (b /= e) * b * b * b * b + c

  easeOutQuint: (a, b, c, d, e) ->
    d * ((b = b / e - 1) * b * b * b * b + 1) + c

  easeInOutQuint: (a, b, c, d, e) ->
    return d / 2 * b * b * b * b * b + c  if (b /= e / 2) < 1
    d / 2 * ((b -= 2) * b * b * b * b + 2) + c

  easeInSine: (a, b, c, d, e) ->
    -d * Math.cos(b / e * (Math.PI / 2)) + d + c

  easeOutSine: (a, b, c, d, e) ->
    d * Math.sin(b / e * (Math.PI / 2)) + c

  easeInOutSine: (a, b, c, d, e) ->
    -d / 2 * (Math.cos(Math.PI * b / e) - 1) + c

  easeInExpo: (a, b, c, d, e) ->
    (if b is 0 then c else d * Math.pow(2, 10 * (b / e - 1)) + c)

  easeOutExpo: (a, b, c, d, e) ->
    (if b is e then c + d else d * (-Math.pow(2, -10 * b / e) + 1) + c)

  easeInOutExpo: (a, b, c, d, e) ->
    return c  if b is 0
    return c + d  if b is e
    return d / 2 * Math.pow(2, 10 * (b - 1)) + c  if (b /= e / 2) < 1
    d / 2 * (-Math.pow(2, -10 * --b) + 2) + c

  easeInCirc: (a, b, c, d, e) ->
    -d * (Math.sqrt(1 - (b /= e) * b) - 1) + c

  easeOutCirc: (a, b, c, d, e) ->
    d * Math.sqrt(1 - (b = b / e - 1) * b) + c

  easeInOutCirc: (a, b, c, d, e) ->
    return -d / 2 * (Math.sqrt(1 - b * b) - 1) + c  if (b /= e / 2) < 1
    d / 2 * (Math.sqrt(1 - (b -= 2) * b) + 1) + c

  easeInElastic: (a, b, c, d, e) ->
    f = 1.70158
    g = 0
    h = d
    return c  if b is 0
    return c + d  if (b /= e) is 1
    g = e * .3  unless g
    if h < Math.abs(d)
      h = d
      f = g / 4
    else
      f = g / (2 * Math.PI) * Math.asin(d / h)
    -(h * Math.pow(2, 10 * (b -= 1)) * Math.sin((b * e - f) * 2 * Math.PI / g)) + c

  easeOutElastic: (a, b, c, d, e) ->
    f = 1.70158
    g = 0
    h = d
    return c  if b is 0
    return c + d  if (b /= e) is 1
    g = e * .3  unless g
    if h < Math.abs(d)
      h = d
      f = g / 4
    else
      f = g / (2 * Math.PI) * Math.asin(d / h)
    h * Math.pow(2, -10 * b) * Math.sin((b * e - f) * 2 * Math.PI / g) + d + c

  easeInOutElastic: (a, b, c, d, e) ->
    f = 1.70158
    g = 0
    h = d
    return c  if b is 0
    return c + d  if (b /= e / 2) is 2
    g = e * .3 * 1.5  unless g
    if h < Math.abs(d)
      h = d
      f = g / 4
    else
      f = g / (2 * Math.PI) * Math.asin(d / h)
    return -.5 * h * Math.pow(2, 10 * (b -= 1)) * Math.sin((b * e - f) * 2 * Math.PI / g) + c  if b < 1
    h * Math.pow(2, -10 * (b -= 1)) * Math.sin((b * e - f) * 2 * Math.PI / g) * .5 + d + c

  easeInBack: (a, b, c, d, e, f) ->
    f = 1.70158  if f is `undefined`
    d * (b /= e) * b * ((f + 1) * b - f) + c

  easeOutBack: (a, b, c, d, e, f) ->
    f = 1.70158  if f is `undefined`
    d * ((b = b / e - 1) * b * ((f + 1) * b + f) + 1) + c

  easeInOutBack: (a, b, c, d, e, f) ->
    f = 1.70158  if f is `undefined`
    return d / 2 * b * b * (((f *= 1.525) + 1) * b - f) + c  if (b /= e / 2) < 1
    d / 2 * ((b -= 2) * b * (((f *= 1.525) + 1) * b + f) + 2) + c

  easeInBounce: (a, b, c, d, e) ->
    d - jQuery.easing.easeOutBounce(a, e - b, 0, d, e) + c

  easeOutBounce: (a, b, c, d, e) ->
    if (b /= e) < 1 / 2.75
      d * 7.5625 * b * b + c
    else if b < 2 / 2.75
      d * (7.5625 * (b -= 1.5 / 2.75) * b + .75) + c
    else if b < 2.5 / 2.75
      d * (7.5625 * (b -= 2.25 / 2.75) * b + .9375) + c
    else
      d * (7.5625 * (b -= 2.625 / 2.75) * b + .984375) + c

  easeInOutBounce: (a, b, c, d, e) ->
    return jQuery.easing.easeInBounce(a, b * 2, 0, d, e) * .5 + c  if b < e / 2
    jQuery.easing.easeOutBounce(a, b * 2 - e, 0, d, e) * .5 + d * .5 + c


#
# *
# * TERMS OF USE - EASING EQUATIONS
# * 
# * Open source under the BSD License. 
# * 
# * Copyright © 2001 Robert Penner
# * All rights reserved.
# * 
# * Redistribution and use in source and binary forms, with or without modification, 
# * are permitted provided that the following conditions are met:
# * 
# * Redistributions of source code must retain the above copyright notice, this list of 
# * conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice, this list 
# * of conditions and the following disclaimer in the documentation and/or other materials 
# * provided with the distribution.
# * 
# * Neither the name of the author nor the names of contributors may be used to endorse 
# * or promote products derived from this software without specific prior written permission.
# * 
# * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
# * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# *  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
# *  GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED 
# * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED 
# * OF THE POSSIBILITY OF SUCH DAMAGE. 
# *
# 
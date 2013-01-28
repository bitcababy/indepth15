#     Underscore.js 1.4.3
#     http://underscorejs.org
#     (c) 2009-2012 Jeremy Ashkenas, DocumentCloud Inc.
#     Underscore may be freely distributed under the MIT license.

(->
	# Baseline setup
	# --------------

	# Establish the root object, `window` in the browser, or `global` on the server.
	root = this
	exports = undefined
	module = undefined

	# Save the previous value of the `_` variable.
	previousUnderscore = root._

	# Establish the object that gets returned to break out of a loop iteration.
	breaker = {}

	# Save bytes in the minified (but not gzipped) version:
	ArrayProto = Array::
	ObjProto = Object::
	FuncProto = Function::

	# Create quick reference variables for speed access to core prototypes.
	push = ArrayProto.push
	slice = ArrayProto.slice
	concat = ArrayProto.concat
	toString = ObjProto.toString
	hasOwnProperty = ObjProto.hasOwnProperty

	# All **ECMAScript 5** native function implementations that we hope to use
	# are declared here.
	nativeForEach = ArrayProto.forEach
	nativeMap = ArrayProto.map
	nativeReduce = ArrayProto.reduce
	nativeReduceRight = ArrayProto.reduceRight
	nativeFilter = ArrayProto.filter
	nativeEvery = ArrayProto.every
	nativeSome = ArrayProto.some
	nativeIndexOf = ArrayProto.indexOf
	nativeLastIndexOf = ArrayProto.lastIndexOf
	nativeIsArray = Array.isArray
	nativeKeys = Object.keys
	nativeBind = FuncProto.bind

	# Create a safe reference to the Underscore object for use below.
	_ = (obj) ->
		return obj	if obj instanceof _
		return new _(obj)	unless this instanceof _
		@_wrapped = obj

	# Export the Underscore object for **Node.js**, with
	# backwards-compatibility for the old `require()` API. If we're in
	# the browser, add `_` as a global object via a string identifier,
	# for Closure Compiler "advanced" mode.
	if exports?
		exports = module.exports = _	if module? and module.exports
		exports._ = _
	else
		root._ = _

	# Current version.
	_.VERSION = "1.4.3"

	# Collection Functions
	# --------------------

	# The cornerstone, an `each` implementation, aka `forEach`.
	# Handles objects with the built-in `forEach`, arrays, and raw objects.
	# Delegates to **ECMAScript 5**'s native `forEach` if available.
	each = _.each = _.forEach = (obj, iterator, context) ->
		return	unless obj?
		return obj.forEach iterator, context if nativeForEach and obj.forEach is nativeForEach
			
		if obj.length is +obj.length
			i = 0
			l = obj.length

			while i < l
				return	if iterator.call(context, obj[i], i, obj) is breaker
				i++
		else
			for key of obj
				return	if	_.has(obj, key) and iterator.call(context, obj[key], key, obj) is breaker

	# Return the results of applying the iterator to each element.
	# Delegates to **ECMAScript 5**'s native `map` if available.
	_.map = _.collect = (obj, iterator, context) ->
		results = []
		return results	unless obj?
		return obj.map(iterator, context)	if nativeMap and obj.map is nativeMap
		each obj, (value, index, list) ->
			results[results.length] = iterator.call(context, value, index, list)
		return results

	# **Reduce** builds up a single result from a list of values, aka `inject`,
	# or `foldl`. Delegates to **ECMAScript 5**'s native `reduce` if available.
	reduceError = "Reduce of empty array with no initial value"
	_.reduce = _.foldl = _.inject = (obj, iterator, memo, context) ->
		initial = arguments_.length > 2
		obj = []	unless obj?
		if nativeReduce and obj.reduce is nativeReduce
			iterator = _.bind(iterator, context)	if context
			return (if initial then obj.reduce(iterator, memo) else obj.reduce(iterator))

		each obj, (value, index, list) ->
			unless initial
				memo = value
				initial = true
			else
				memo = iterator.call(context, memo, value, index, list)

		throw new TypeError(reduceError)	unless initial
		return memo

	# The right-associative version of reduce, also known as `foldr`.
	# Delegates to **ECMAScript 5**'s native `reduceRight` if available.
	_.reduceRight = _.foldr = (obj, iterator, memo, context) ->
		initial = arguments_.length > 2
		obj = []	unless obj?
		if nativeReduceRight and obj.reduceRight is nativeReduceRight
			iterator = _.bind(iterator, context)	if context
			return (if initial then obj.reduceRight(iterator, memo) else obj.reduceRight(iterator))
		length = obj.length
		if length isnt +length
			keys = _.keys(obj)
			length = keys.length
		each obj, (value, index, list) ->
			index = (if keys then keys[--length] else --length)
			unless initial
				memo = obj[index]
				initial = true
			else
				memo = iterator.call(context, memo, obj[index], index, list)

		throw new TypeError(reduceError)	unless initial
		memo

	# Return the first value which passes a truth test. Aliased as `detect`.
	_.find = _.detect = (obj, iterator, context) ->
		result = undefined
		any obj, (value, index, list) ->
			if iterator.call(context, value, index, list)
				result = value
				return true

		return result


	# Return all the elements that pass a truth test.
	# Delegates to **ECMAScript 5**'s native `filter` if available.
	# Aliased as `select`.
	_.filter = _.select = (obj, iterator, context) ->
		results = []
		return results	unless obj?
		return obj.filter(iterator, context)	if nativeFilter and obj.filter is nativeFilter
		each obj, (value, index, list) ->
			results[results.length] = value	if iterator.call(context, value, index, list)
		return results

	# Return all the elements for which a truth test fails.
	_.reject = (obj, iterator, context) ->
		_.filter obj, ((value, index, list) ->
			not iterator.call(context, value, index, list)
		), context

	# Determine whether all of the elements match a truth test.
	# Delegates to **ECMAScript 5**'s native `every` if available.
	# Aliased as `all`.
	_.every = _.all = (obj, iterator, context) ->
		iterator or (iterator = _.identity)
		result = true
		return result	unless obj?
		return obj.every(iterator, context)	if nativeEvery and obj.every is nativeEvery
		each obj, (value, index, list) ->
			breaker	unless result = result and iterator.call(context, value, index, list)

		return !!result

	# Determine if at least one element in the object matches a truth test.
	# Delegates to **ECMAScript 5**'s native `some` if available.
	# Aliased as `any`.
	any = _.some = _.any = (obj, iterator, context) ->
		iterator or (iterator = _.identity)
		result = false
		return result	unless obj?
		return obj.some(iterator, context)	if nativeSome and obj.some is nativeSome
		each obj, (value, index, list) ->
			breaker	if result or (result = iterator.call(context, value, index, list))
		return !!result

	# Determine if the array or object contains a given value (using `===`).
	# Aliased as `include`.
	_.contains = _.include = (obj, target) ->
		return false	unless obj?
		return obj.indexOf(target) isnt -1	if nativeIndexOf and obj.indexOf is nativeIndexOf
		return any obj, (value) -> value is target

	# Invoke a method (with arguments) on every item in a collection.
	_.invoke = (obj, method) ->
		args = slice.call(arguments_, 2)
		_.map obj, (value) ->
			((if _.isFunction(method) then method else value[method])).apply value, args

	# Convenience version of a common use case of `map`: fetching a property.
	_.pluck = (obj, key) ->
		_.map obj, (value) -> value[key]

	# Convenience version of a common use case of `filter`: selecting only objects
	# with specific `key:value` pairs.
	_.where = (obj, attrs) ->
		return []	if _.isEmpty(attrs)
		return _.filter obj, (value) ->
			for key of attrs
				return false	if attrs[key] isnt value[key]
			true

	# Return the maximum element or (element-based computation).
	# Can't optimize arrays of integers longer than 65,535 elements.
	# See: https://bugs.webkit.org/show_bug.cgi?id=80797
	_.max = (obj, iterator, context) ->
		return Math.max.apply(Math, obj)	if not iterator and _.isArray(obj) and obj[0] is +obj[0] and obj.length < 65535
		return -Infinity	if not iterator and _.isEmpty(obj)
		result =
			computed: -Infinity
			value: -Infinity

		each obj, (value, index, list) ->
			computed = (if iterator then iterator.call(context, value, index, list) else value)
			computed >= result.computed and (result =
				value: value
				computed: computed
			)

		return result.value

	# Return the minimum element (or element-based computation).
	_.min = (obj, iterator, context) ->
		return Math.min.apply(Math, obj)	if not iterator and _.isArray(obj) and obj[0] is +obj[0] and obj.length < 65535
		return Infinity	if not iterator and _.isEmpty(obj)
		result =
			computed: Infinity
			value: Infinity

		each obj, (value, index, list) ->
			computed = (if iterator then iterator.call(context, value, index, list) else value)
			computed < result.computed and (result =
				value: value
				computed: computed
			)

		result.value

	# Shuffle an array.
	_.shuffle = (obj) ->
		rand = undefined
		index = 0
		shuffled = []
		each obj, (value) ->
			rand = _.random(index++)
			shuffled[index - 1] = shuffled[rand]
			shuffled[rand] = value
		return shuffled

	# An internal function to generate lookup iterators.
	lookupIterator = (value) ->
		return if _.isFunction(value) then value else (obj) -> obj[value]

	# Sort the object's values by a criterion produced by an iterator.
	_.sortBy = (obj, value, context) ->
		iterator = lookupIterator(value)
		_.pluck _.map(obj, (value, index, list) ->
			value: value
			index: index
			criteria: iterator.call(context, value, index, list)
		).sort((left, right) ->
			a = left.criteria
			b = right.criteria
			if a isnt b
				return 1	if a > b or a is undefined
				return -1	if a < b or b is undefined
			(if left.index < right.index then -1 else 1)
		), "value"

	# An internal function used for aggregate "group by" operations.
	group = (obj, value, context, behavior) ->
		result = {}
		iterator = lookupIterator(value or _.identity)
		each obj, (value, index) ->
			key = iterator.call(context, value, index, obj)
			behavior result, key, value
		return result

	# Groups the object's values by a criterion. Pass either a string attribute
	# to group by, or a function that returns the criterion.
	_.groupBy = (obj, value, context) ->
		return group obj, value, context, (result, key, value) ->
			((if _.has(result, key) then result[key] else (result[key] = []))).push value

	# Counts instances of an object that group by a certain criterion. Pass
	# either a string attribute to count by, or a function that returns the
	# criterion.
	_.countBy = (obj, value, context) ->
		return group obj, value, context, (result, key) ->
			result[key] = 0	unless _.has(result, key)
			result[key]++

	# Use a comparator function to figure out the smallest index at which
	# an object should be inserted so as to maintain order. Uses binary search.
	_.sortedIndex = (array, obj, iterator, context) ->
		iterator = (if not iterator? then _.identity else lookupIterator(iterator))
		value = iterator.call(context, obj)
		low = 0
		high = array.length
		while low < high
			mid = (low + high) >>> 1
			if iterator.call(context, array[mid]) < value then low = mid + 1 else high = mid
		return low

	# Safely convert anything iterable into a real, live array.
	_.toArray = (obj) ->
		return []	unless obj
		return slice.call(obj)	if _.isArray(obj)
		return _.map(obj, _.identity)	if obj.length is +obj.length
		return _.values obj

# Return the number of elements in an object.
	_.size = (obj) ->
		return 0	unless obj?
		return if (obj.length is +obj.length) then obj.length else _.keys(obj).length

	# Array Functions
	# ---------------

	# Get the first element of an array. Passing **n** will return the first N
	# values in the array. Aliased as `head` and `take`. The **guard** check
	# allows it to work with `_.map`.
	_.first = _.head = _.take = (array, n, guard) ->
		return undefined	unless array?
		if (n?) and not guard then slice.call(array, 0, n) else array[0]

	# Returns everything but the last entry of the array. Especially useful on
	# the arguments object. Passing **n** will return all the values in
	# the array, excluding the last N. The **guard** check allows it to work with
	# `_.map`.
	_.initial = (array, n, guard) ->
		slice.call array, 0, array.length - ((if (not (n?)) or guard then 1 else n))

	# Get the last element of an array. Passing **n** will return the last N
	# values in the array. The **guard** check allows it to work with `_.map`.
	_.last = (array, n, guard) ->
		return undefined	unless array?
		if (n?) and not guard
			slice.call array, Math.max(array.length - n, 0)
		else
			array[array.length - 1]

	# Returns everything but the first entry of the array. Aliased as `tail` and `drop`.
	# Especially useful on the arguments object. Passing an **n** will return
	# the rest N values in the array. The **guard**
	# check allows it to work with `_.map`.
	_.rest = _.tail = _.drop = (array, n, guard) ->
		slice.call array, (if (not (n?)) or guard then 1 else n)

	# Trim out all falsy values from an array.
	_.compact = (array) ->
		_.filter array, _.identity

	# Internal implementation of a recursive `flatten` function.
	flatten = (input, shallow, output) ->
		each input, (value) ->
			if _.isArray(value)
				(if shallow then push.apply(output, value) else flatten(value, shallow, output))
			else
				output.push value
		return output

	# Return a completely flattened version of an array.
	_.flatten = (array, shallow) ->
		return flatten array, shallow, []

	# Return a version of the array that does not contain the specified value(s).
	_.without = (array) ->
		return _.difference array, slice.call(arguments_, 1)

	# Produce a duplicate-free version of the array. If the array has already
	# been sorted, you have the option of using a faster algorithm.
	# Aliased as `unique`.
	_.uniq = _.unique = (array, isSorted, iterator, context) ->
		if _.isFunction(isSorted)
			context = iterator
			iterator = isSorted
			isSorted = false
		initial = (if iterator then _.map(array, iterator, context) else array)
		results = []
		seen = []
		each initial, (value, index) ->
			if (if isSorted then (not index or seen[seen.length - 1] isnt value) else not _.contains(seen, value))
				seen.push value
				results.push array[index]

		return results

	# Produce an array that contains the union: each distinct element from all of
	# the passed-in arrays.
	_.union = ->
		_.uniq concat.apply(ArrayProto, arguments_)

	# Produce an array that contains every item shared between all the
	# passed-in arrays.
	_.intersection = (array) ->
		rest = slice.call(arguments_, 1)
		return _.filter _.uniq(array), (item) ->
			_.every rest, (other) ->
				_.indexOf(other, item) >= 0

	# Take the difference between one array and a number of other arrays.
	# Only the elements present in just the first array will remain.
	_.difference = (array) ->
		rest = concat.apply(ArrayProto, slice.call(arguments_, 1))
		return _.filter array, (value) ->
			not _.contains(rest, value)

	# Zip together multiple lists into a single array -- elements that share
	# an index go together.
	_.zip = ->
		args = slice.call(arguments_)
		length = _.max(_.pluck(args, "length"))
		results = new Array(length)
		i = 0
		while i < length
			results[i] = _.pluck(args, "" + i)
			i++
		return results

	# Converts lists into objects. Pass either a single array of `[key, value]`
	# pairs, or two parallel arrays of the same length -- one of keys, and one of
	# the corresponding values.
	_.object = (list, values) ->
		return {}	unless list?
		result = {}
		i = 0
		l = list.length
		while i < l
			if values
				result[list[i]] = values[i]
			else
				result[list[i][0]] = list[i][1]
			i++
		return result

	# If the browser doesn't supply us with indexOf (I'm looking at you, **MSIE**),
	# we need this function. Return the position of the first occurrence of an
	# item in an array, or -1 if the item is not included in the array.
	# Delegates to **ECMAScript 5**'s native `indexOf` if available.
	# If the array is large and already in sort order, pass `true`
	# for **isSorted** to use binary search.
	_.indexOf = (array, item, isSorted) ->
		return -1	unless array?
		i = 0
		l = array.length
		if isSorted
			if typeof isSorted is "number"
				i = if isSorted < 0 then Math.max(0, l + isSorted) else isSorted
			else
				i = _.sortedIndex(array, item)
				return if array[i] is item then i else -1
		return array.indexOf(item, isSorted)	if nativeIndexOf and array.indexOf is nativeIndexOf
		while i < l
			return i	if array[i] is item
			i++
		return -1

	# Delegates to **ECMAScript 5**'s native `lastIndexOf` if available.
	_.lastIndexOf = (array, item, from) ->
		return -1	unless array?
		hasIndex = from?
		return (if hasIndex then array.lastIndexOf(item, from) else array.lastIndexOf(item))	if nativeLastIndexOf and array.lastIndexOf is nativeLastIndexOf
		i = if hasIndex then from else array.length
		return i	if array[i] is item	while i--
		return -1

	# Generate an integer Array containing an arithmetic progression. A port of
	# the native Python `range()` function. See
	# [the Python documentation](http://docs.python.org/library/functions.html#range).
	_.range = (start, stop, step) ->
		if arguments_.length <= 1
			stop = start or 0
			start = 0
		step = arguments_[2] or 1
		len = Math.max(Math.ceil((stop - start) / step), 0)
		idx = 0
		range = new Array(len)
		while idx < len
			range[idx++] = start
			start += step
		return range

	# Function (ahem) Functions
	# ------------------

	# Reusable constructor function for prototype setting.
	ctor = ->

	# Create a function bound to a given object (assigning `this`, and arguments,
	# optionally). Binding with arguments is also known as `curry`.
	# Delegates to **ECMAScript 5**'s native `Function.bind` if available.
	# We check for `func.bind` first, to fail fast when `func` is undefined.
	_.bind = (func, context) ->
		args = undefined
		bound = undefined
		return nativeBind.apply(func, slice.call(arguments_, 1))	if func.bind is nativeBind and nativeBind
		throw new TypeError	unless _.isFunction(func)
		args = slice.call(arguments_, 2)
		bound = ->
			return func.apply(context, args.concat(slice.call(arguments_)))	unless this instanceof bound
			ctor:: = func::
			self = new ctor
			ctor:: = null
			result = func.apply(self, args.concat(slice.call(arguments_)))
			return result	if Object(result) is result
			self

	# Bind all of an object's methods to that object. Useful for ensuring that
	# all callbacks defined on an object belong to it.
	_.bindAll = (obj) ->
		funcs = slice.call(arguments_, 1)
		funcs = _.functions(obj)	if funcs.length is 0
		each funcs, (f) ->
			obj[f] = _.bind(obj[f], obj)
		return obj

		# Memoize an expensive function by storing its results.
	_.memoize = (func, hasher) ->
		memo = {}
		hasher or (hasher = _.identity)
		->
			key = hasher.apply(this, arguments_)
			if _.has(memo, key) then memo[key] else (memo[key] = func.apply(this, arguments_))

	# Delays a function for the given number of milliseconds, and then calls
	# it with the arguments supplied.
	_.delay = (func, wait) ->
		args = slice.call(arguments_, 2)
		setTimeout (->
			func.apply null, args
		), wait

	# Defers a function, scheduling it to run after the current call stack has
	# cleared.
	_.defer = (func) ->
		_.delay.apply _, [func, 1].concat(slice.call(arguments_, 1))

	# Returns a function, that, when invoked, will only be triggered at most once
	# during a given window of time.
	_.throttle = (func, wait) ->
		context = undefined
		args = undefined
		timeout = undefined
		result = undefined
		previous = 0
		later = ->
			previous = new Date
			timeout = null
			result = func.apply(context, args)

		->
			now = new Date
			remaining = wait - (now - previous)
			context = this
			args = arguments_
			if remaining <= 0
				clearTimeout timeout
				timeout = null
				previous = now
				result = func.apply(context, args)
			else
				timeout = setTimeout(later, remaining)	unless timeout
			return result

	# Returns a function, that, as long as it continues to be invoked, will not
	# be triggered. The function will be called after it stops being called for
	# N milliseconds. If `immediate` is passed, trigger the function on the
	# leading edge, instead of the trailing.
	_.debounce = (func, wait, immediate) ->
		timeout = undefined
		result = undefined
		return ->
			context = this
			args = arguments_
			later = ->
				timeout = null
				result = func.apply(context, args)	unless immediate

			callNow = immediate and not timeout
			clearTimeout timeout
			timeout = setTimeout(later, wait)
			result = func.apply(context, args)	if callNow
			return result

	# Returns a function that will be executed at most one time, no matter how
	# often you call it. Useful for lazy initialization.
	_.once = (func) ->
		ran = false
		memo = undefined
		return ->
			return memo	if ran
			ran = true
			memo = func.apply(this, arguments_)
			func = null
			return memo

	# Returns the first function passed as an argument to the second,
	# allowing you to adjust arguments, run code before and after, and
	# conditionally execute the original function.
	_.wrap = (func, wrapper) ->
		return ->
			args = [func]
			push.apply args, arguments_
			wrapper.apply this, args

	# Returns a function that is the composition of a list of functions, each
	# consuming the return value of the function that follows.
	_.compose = ->
		funcs = arguments_
		return ->
			args = arguments_
			i = funcs.length - 1

			while i >= 0
				args = [funcs[i].apply(this, args)]
				i--
			args[0]

	# Returns a function that will only be executed after being called N times.
	_.after = (times, func) ->
		return func()	if times <= 0
		return ->
			func.apply this, arguments_	if --times < 1

	# Object Functions
	# ----------------

	# Retrieve the names of an object's properties.
	# Delegates to **ECMAScript 5**'s native `Object.keys`
	_.keys = nativeKeys or (obj) ->
		throw new TypeError("Invalid object")	if obj isnt Object(obj)
		keys = []
		keys[keys.length] = key	if _.has(obj, key) for key of obj
		return keys

		# Retrieve the values of an object's properties.
	_.values = (obj) ->
		values = []
		for key of obj
			values.push obj[key]	if _.has(obj, key)
		return values

		# Convert an object into a list of `[key, value]` pairs.
	_.pairs = (obj) ->
		pairs = []
		for key of obj
			pairs.push [key, obj[key]]	if _.has(obj, key)
		pairs

	# Invert the keys and values of an object. The values must be serializable.
	_.invert = (obj) ->
		result = {}
		result[obj[key]] = key	if _.has(obj, key) for key of obj
		return result

	# Return a sorted list of the function names available on the object.
	# Aliased as `methods`
	_.functions = _.methods = (obj) ->
		names = []
		names.push key	if _.isFunction(obj[key]) for key of obj
		names.sort()

	# Extend a given object with all the properties in passed-in object(s).
	_.extend = (obj) ->
		each slice.call(arguments_, 1), (source) ->
			if source
				for prop of source
					obj[prop] = source[prop]
		return obj

	# Return a copy of the object only containing the whitelisted properties.
	_.pick = (obj) ->
		copy = {}
		keys = concat.apply(ArrayProto, slice.call(arguments_, 1))
		each keys, (key) ->
			copy[key] = obj[key]	if key of obj
		return copy

	# Return a copy of the object without the blacklisted properties.
	_.omit = (obj) ->
		copy = {}
		keys = concat.apply(ArrayProto, slice.call(arguments_, 1))
		for key of obj
			copy[key] = obj[key]	unless _.contains(keys, key)
		copy

	# Fill in a given object with default properties.
	_.defaults = (obj) ->
		each slice.call(arguments_, 1), (source) ->
			if source
				for prop of source
					obj[prop] = source[prop]	unless obj[prop]?
		return obj

	# Create a (shallow-cloned) duplicate of an object.
	_.clone = (obj) ->
		return obj	unless _.isObject(obj)
		(if _.isArray(obj) then obj.slice() else _.extend({}, obj))

	# Invokes interceptor with the obj, and then returns obj.
	# The primary purpose of this method is to "tap into" a method chain, in
	# order to perform operations on intermediate results within the chain.
	_.tap = (obj, interceptor) ->
		interceptor obj
		return obj

	# Internal recursive comparison function for `isEqual`.
	eq = (a, b, aStack, bStack) ->
		# Identical objects are equal. `0 === -0`, but they aren't identical.
		# See the Harmony `egal` proposal: http://wiki.ecmascript.org/doku.php?id=harmony:egal.
		return a isnt 0 or 1 / a is 1 / b	if a is b
		# A strict comparison is necessary because `null == undefined`.
		return a is b	if not a? or not b?
		# Unwrap any wrapped objects.
		a = a._wrapped	if a instanceof _
		b = b._wrapped	if b instanceof _
		# Compare `[[Class]]` names.
		className = toString.call(a)
		return false	unless className is toString.call(b)
		switch className
			# Strings, numbers, dates, and booleans are compared by value.
			when "[object String]"
				# Primitives and their corresponding object wrappers are equivalent; thus, `"5"` is
				# equivalent to `new String("5")`.
				return a is String(b)
			when "[object Number]"
			# `NaN`s are equivalent, but non-reflexive. An `egal` comparison is performed for
			# other numeric values.
				return (if a isnt +a then b isnt +b else ((if a is 0 then 1 / a is 1 / b else a is +b)))
			when "[object Date]", "[object Boolean]"
				# Coerce dates and booleans to numeric primitive values. Dates are compared by their
				# millisecond representations. Note that invalid dates with millisecond representations
				# of `NaN` are not equivalent.
				return +a is +b
			when "[object RegExp]"
				# RegExps are compared by their source patterns and flags.
				return a.source is b.source and a.global is b.global and a.multiline is b.multiline and a.ignoreCase is b.ignoreCase
		return false	if typeof a isnt "object" or typeof b isnt "object"
		# Assume equality for cyclic structures. The algorithm for detecting cyclic
		# structures is adapted from ES 5.1 section 15.12.3, abstract operation `JO`.
		length = aStack.length
		# Linear search. Performance is inversely proportional to the number of
		# unique nested structures.
		return bStack[length] is b	if aStack[length] is a	while length--
		# Add the first object to the stack of traversed objects.
		aStack.push a
		bStack.push b
		size = 0
		result = true
		# Recursively compare objects and arrays.
		if className is "[object Array]"
			# Compare array lengths to determine if a deep comparison is necessary.
			size = a.length
			result = size is b.length
			# Deep compare the contents, ignoring non-numeric properties.
			break	unless result = eq(a[size], b[size], aStack, bStack)	while size--	if result
		else
			# Objects with different constructors are not equivalent, but `Object`s
			# from different frames are.
			aCtor = a.constructor
			bCtor = b.constructor
			return false	if aCtor isnt bCtor and not (_.isFunction(aCtor) and (aCtor instanceof aCtor) and _.isFunction(bCtor) and (bCtor instanceof bCtor))

			# Deep compare objects.
			for key of a
				if _.has(a, key)
					# Count the expected number of properties.
					size++
					# Deep compare each member.
					break	unless result = _.has(b, key) and eq(a[key], b[key], aStack, bStack)
			# Ensure that both objects contain the same number of properties.
			if result
				for key of b
					break	if _.has(b, key) and not (size--)
				result = not size
		# Remove the first object from the stack of traversed objects.
		aStack.pop()
		bStack.pop()
		result

	# Perform a deep comparison to check if two objects are equal.
	_.isEqual = (a, b) ->
		eq a, b, [], []

	# Is a given array, string, or object empty?
	# An "empty" object has no enumerable own-properties.
	_.isEmpty = (obj) ->
		return true	unless obj?
		return obj.length is 0	if _.isArray(obj) or _.isString(obj)
		for key of obj
			return false	if _.has(obj, key)
		true

	# Is a given value a DOM element?
	_.isElement = (obj) ->
		!!(obj and obj.nodeType is 1)

	# Is a given value an array?
	# Delegates to ECMA5's native Array.isArray
	_.isArray = nativeIsArray or (obj) ->
		toString.call(obj) is "[object Array]"

	# Is a given variable an object?
	_.isObject = (obj) ->
		obj is Object(obj)

	# Add some isType methods: isArguments, isFunction, isString, isNumber, isDate, isRegExp.
	each ["Arguments", "Function", "String", "Number", "Date", "RegExp"], (name) ->
		_["is" + name] = (obj) ->
			toString.call(obj) is "[object " + name + "]"

	# Define a fallback version of the method in browsers (ahem, IE), where
	# there isn't any inspectable "Arguments" type.
	unless _.isArguments(arguments_)
		_.isArguments = (obj) ->
			!!(obj and _.has(obj, "callee"))
	# Optimize `isFunction` if appropriate.
	if typeof (/./) isnt "function"
		_.isFunction = (obj) ->
			typeof obj is "function"
	# Is a given object a finite number?
	_.isFinite = (obj) ->
		isFinite(obj) and not isNaN(parseFloat(obj))

	# Is the given value `NaN`? (NaN is the only number which does not equal itself).
	_.isNaN = (obj) ->
		_.isNumber(obj) and obj isnt +obj

	# Is a given value a boolean?
	_.isBoolean = (obj) ->
		obj is true or obj is false or toString.call(obj) is "[object Boolean]"

	# Is a given value equal to null?
	_.isNull = (obj) ->
		obj is null

	# Is a given variable undefined?
	_.isUndefined = (obj) ->
		obj is undefined

	# Shortcut function for checking if an object has a given property directly
	# on itself (in other words, not on a prototype).
	_.has = (obj, key) ->
		hasOwnProperty.call obj, key

	# Utility Functions
	# -----------------

	# Run Underscore.js in *noConflict* mode, returning the `_` variable to its
	# previous owner. Returns a reference to the Underscore object.
	_.noConflict = ->
		root._ = previousUnderscore
		this

	# Keep the identity function around for default iterators.
	_.identity = (value) ->
		value

	# Run a function **n** times.
	_.times = (n, iterator, context) ->
		return iterator.call(context, i) for i in [0..n]

	# Return a random integer between min and max (inclusive).
	_.random = (min, max) ->
		unless max?
			max = min
			min = 0
		min + (0 | Math.random() * (max - min + 1))

	# List of HTML entities for escaping.
	entityMap = escape:
		"&": "&amp;"
		"<": "&lt;"
		">": "&gt;"
		"\"": "&quot;"
		"'": "&#x27;"
		"/": "&#x2F;"

	entityMap.unescape = _.invert(entityMap.escape)

	# Regexes containing the keys and values listed immediately above.
	entityRegexes =
		escape: new RegExp("[" + _.keys(entityMap.escape).join("") + "]", "g")
		unescape: new RegExp("(" + _.keys(entityMap.unescape).join("|") + ")", "g")

	# Functions for escaping and unescaping strings to/from HTML interpolation.
	_.each ["escape", "unescape"], (method) ->
		_[method] = (string) ->
			return ""	unless string?
			("" + string).replace entityRegexes[method], (match) ->
				entityMap[method][match]

	# If the value of the named property is a function then invoke it;
	# otherwise, return it.
	_.result = (object, property) ->
		return null	unless object?
		value = object[property]
		(if _.isFunction(value) then value.call(object) else value)

	# Add your own custom functions to the Underscore object.
	_.mixin = (obj) ->
		each _.functions(obj), (name) ->
			func = _[name] = obj[name]
			_::[name] = ->
				args = [@_wrapped]
				push.apply args, arguments_
				result.call this, func.apply(_, args)


	# Generate a unique integer id (unique within the entire client session).
	# Useful for temporary DOM ids.
	idCounter = 0
	_.uniqueId = (prefix) ->
		id = "" + ++idCounter
		(if prefix then prefix + id else id)

	# By default, Underscore uses ERB-style template delimiters, change the
	# following template settings to use alternative delimiters.
	_.templateSettings =
		evaluate: /<%([\s\S]+?)%>/g
		interpolate: /<%=([\s\S]+?)%>/g
		escape: /<%-([\s\S]+?)%>/g

	# When customizing `templateSettings`, if you don't want to define an
	# interpolation, evaluation or escaping regex, we need one that is
	# guaranteed not to match.
	noMatch = /(.)^/

	# Certain characters need to be escaped so that they can be put into a
	# string literal.
	escapes =
		"'": "'"
		"\\": "\\"
		"\r": "r"
		"\n": "n"
		"\t": "t"
		" ": "u2028"
		" ": "u2029"

	escaper = /\\|'|\r|\n|\t|\u2028|\u2029/g

	# JavaScript micro-templating, similar to John Resig's implementation.
	# Underscore templating handles arbitrary delimiters, preserves whitespace,
	# and correctly escapes quotes within interpolated code.
	_.template = (text, data, settings) ->
		settings = _.defaults({}, settings, _.templateSettings)

		# Combine delimiters into one regular expression via alternation.
		matcher = new RegExp([(settings.escape or noMatch).source, (settings.interpolate or noMatch).source, (settings.evaluate or noMatch).source].join("|") + "|$", "g")

		# Compile the template source, escaping string literals appropriately.
		index = 0
		source = "__p+='"
		text.replace matcher, (match, escape, interpolate, evaluate, offset) ->
			source += text.slice(index, offset).replace(escaper, (match) ->
				"\\" + escapes[match]
			)
			source += "'+\n((__t=(" + escape + "))==null?'':_.escape(__t))+\n'"	if escape
			source += "'+\n((__t=(" + interpolate + "))==null?'':__t)+\n'"	if interpolate
			source += "';\n" + evaluate + "\n__p+='"	if evaluate
			index = offset + match.length
			match

		source += "';\n"

		# If a variable is not specified, place data values in local scope.
		source = "with(obj||{}){\n" + source + "}\n"	unless settings.variable
		source = "var __t,__p='',__j=Array.prototype.join," + "print=function(){__p+=__j.call(arguments,'');};\n" + source + "return __p;\n"
		try
			render = new Function(settings.variable or "obj", "_", source)
		catch e
			e.source = source
			throw e
		return render(data, _)	if data
		template = (data) ->
			render.call this, data, _

		# Provide the compiled function source as a convenience for precompilation.
		template.source = "function(" + (settings.variable or "obj") + "){\n" + source + "}"
		template

# Add a "chain" function, which will delegate to the wrapper.
	_.chain = (obj) ->
		_(obj).chain()

	# OOP
	# ---------------
	# If Underscore is called as a function, it returns a wrapped object that
	# can be used OO-style. This wrapper holds altered versions of all the
	# underscore functions. Wrapped objects may be chained.

	# Helper function to continue chaining intermediate results.
	result = (obj) ->
		(if @_chain then _(obj).chain() else obj)

	# Add all of the Underscore functions to the wrapper object.
	_.mixin _

	# Add all mutator Array functions to the wrapper.
	each ["pop", "push", "reverse", "shift", "sort", "splice", "unshift"], (name) ->
		method = ArrayProto[name]
		_::[name] = ->
			obj = @_wrapped
			method.apply obj, arguments_
			delete obj[0]	if (name is "shift" or name is "splice") and obj.length is 0
			result.call this, obj

	# Add all accessor Array functions to the wrapper.
	each ["concat", "join", "slice"], (name) ->
		method = ArrayProto[name]
		_::[name] = ->
			result.call this, method.apply(@_wrapped, arguments_)

	_.extend _::,
		# Start chaining a wrapped Underscore object.
		chain: ->
			@_chain = true
			this

		# Extracts the result from a wrapped and chained object.
		value: ->
			@_wrapped

).call this
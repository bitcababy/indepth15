# #Value parameter - required. All other parameters are optional.
# isDate = (value, sepVal, dayIdx, monthIdx, yearIdx) ->
#   try
#     
#     #Change the below values to determine which format of date you wish to check. It is set to dd/mm/yyyy by default.
#     DayIndex = (if dayIdx isnt `undefined` then dayIdx else 0)
#     MonthIndex = (if monthIdx isnt `undefined` then monthIdx else 0)
#     YearIndex = (if yearIdx isnt `undefined` then yearIdx else 0)
#     value = value.replace(/-/g, "/").replace(/\./g, "/")
#     SplitValue = value.split(sepVal or "/")
#     OK = true
#     OK = false  unless SplitValue[DayIndex].length is 1 or SplitValue[DayIndex].length is 2
#     OK = false  if OK and not (SplitValue[MonthIndex].length is 1 or SplitValue[MonthIndex].length is 2)
#     OK = false  if OK and SplitValue[YearIndex].length isnt 4
#     if OK
#       Day = parseInt(SplitValue[DayIndex], 10)
#       Month = parseInt(SplitValue[MonthIndex], 10)
#       Year = parseInt(SplitValue[YearIndex], 10)
#       if OK = ((Year > 1900) and (Year < new Date().getFullYear()))
#         if OK = (Month <= 12 and Month > 0)
#           LeapYear = (((Year % 4) is 0) and ((Year % 100) isnt 0) or ((Year % 400) is 0))
#           if OK = Day > 0
#             if Month is 2
#               OK = (if LeapYear then Day <= 29 else Day <= 28)
#             else
#               if (Month is 4) or (Month is 6) or (Month is 9) or (Month is 11)
#                 OK = Day <= 30
#               else
#                 OK = Day <= 31
#     return OK
#   catch e
#     return false
# 
# window.ClientSideValidations.validators.local("date") = (element, options) ->
#   "invalid date"  unless isDate(element.val())
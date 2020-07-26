import calendar, datetime, time
moon_datetime_a = datetime.datetime(1969, 7, 20, 20, 17, 40)
moon_time = calendar.timegm(moon_datetime_a.utctimetuple())  # 返回登月时间至今的秒数，负数
moon_datetime_b = datetime.datetime.utcfromtimestamp(moon_time)
# datetime.datetime.utcfromtimestamp不能处理复数的时间戳(但貌似在uniux上没有这个问题)
print(moon_time)
print(moon_datetime_a.isoformat())
print(moon_datetime_b.isoformat())
print(time.strftime('%Y-%m-%dT%H:%M:%S', time.gmtime(moon_time)))  # 将时间格式化

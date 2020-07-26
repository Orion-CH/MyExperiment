def even_filter(nums):
    for num in nums:
        if num % 2 == 0:
            print('1')
            yield num


def multiply_by_three(nums):
    # print('nums is:',nums)
    # print(type(nums))
    # print('length:', len(list(nums)))  # 对生成器一取list之后里面的东西就没了
    for num in nums:
        print('2')
        yield num * 3


def convert_to_string(nums):
    for num in nums:
        print('3')
        yield '*{}*'.format(num)


nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
xPipeline = convert_to_string(multiply_by_three(even_filter(nums)))  # 不优雅
print(list(xPipeline))
# list(even_filter(nums))
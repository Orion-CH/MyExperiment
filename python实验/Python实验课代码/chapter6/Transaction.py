import pickle
import os
import tempfile


class LoadError(Exception):
    pass


class SaveError(Exception):
    pass


class Transaction:
    def __init__(self, amount, date, currency='USD', usd_conversion_rate=1, description=None):
        self._Transaction__amount = None
        self.__amount = amount  # 数额
        self.__date = date
        self.__currency = currency
        self.__usd_conversion_rate = usd_conversion_rate
        self.__description = description

    @property
    def currency(self):
        return self.__currency

    @property
    def usd_conversion_rate(self):
        return self.__usd_conversion_rate

    @property
    def description(self):
        return self.__description

    @property
    def usd(self):  # 不是私有属性
        return self.__amount * self.__usd_conversion_rate  # 金额 * 汇率 = 美元数

    def tostring(self):
        print('---------------------------------------')
        print('amount:' + str(self.__amount))
        print('currency:' + self.currency)
        print('date:' + self.__date)
        print('usd_conversion_rate:' + str(self.usd_conversion_rate))
        print('description:' + (self.description if self.description is not None else 'None'))
        print('usd:', str(self.usd))
        print('---------------------------------------')


class Account:
    """
    >>> import os
    >>> import tempfile
    >>> name = os.path.join(tempfile.gettempdir(), "account01")
    >>> account = Account(name, "Qtrac Ltd.")
    >>> account.number
    >>> os.path.basename(account.number), account.name,
    ('account01', 'Qtrac Ltd.')
    >>> account.balance, account.all_usd, len(account)
    (0.0, True, 0)
    >>> account.apply(Transaction(100, "2008-11-14"))
    >>> account.apply(Transaction(150, "2008-12-09"))
    >>> account.apply(Transaction(-95, "2009-01-22"))
    >>> account.balance, account.all_usd, len(account)
    (155.0, True, 3)
    >>> account.apply(Transaction(50, "2008-12-09", "EUR", 1.53))
    >>> account.balance, account.all_usd, len(account)
    (231.5, False, 4)
    >>> account.save()
    >>> newaccount = Account(name, "Qtrac Ltd.")
    >>> newaccount.balance, newaccount.all_usd, len(newaccount)
    (0.0, True, 0)
    >>> newaccount.load()
    >>> newaccount.balance, newaccount.all_usd, len(newaccount)
    (231.5, False, 4)
    >>> try:  # 删除临时测试文件
    ...     os.remove(name + ".acc")
    ... except EnvironmentError:
    ...     pass
    """

    def __init__(self, number, name):
        self.__number = number
        self.__name = name
        self.__transactions = []

    @property
    def number(self):
        return self.__number

    @property
    def name(self):
        return self.__name

    @name.setter
    def name(self, name):
        assert len(self.__name) >= 4, '账户名至少有4个字符长'
        self.__name = name

    def __len__(self):
        return len(self.__transactions)

    @property
    def balance(self):
        balan = 0
        for i in self.__transactions:
            balan += i.usd  # 以美元为单位
        return balan

    @property
    def all_usd(self):
        for i in self.__transactions:
            if i.currency != 'USD':
                return False
        return True

    def apply(self, transaction):
        if isinstance(transaction, Transaction):
            self.__transactions.append(transaction)
        else:
            return TypeError('不能插入不是交易类型的信息')

    def save(self):
        fh = None
        try:
            data = [self.__number, self.__name, self.__transactions]
            fh = open(self.number + ".acc", "wb")
            pickle.dump(data, fh, pickle.HIGHEST_PROTOCOL)
        except (EnvironmentError, pickle.PicklingError) as err:
            raise SaveError(str(err))
        finally:
            if fh is not None:
                fh.close()

    def load(self):
        """Loads the account's data from file number.acc

        All previous data is lost.
        """
        fh = None
        try:
            fh = open(self.number + ".acc", "rb")
            data = pickle.load(fh)
            assert self.number == data[0], "account number doesn't match"
            self.__name, self.__transactions = data[1:]
        except (EnvironmentError, pickle.UnpicklingError) as err:
            raise LoadError(str(err))
        finally:
            if fh is not None:
                fh.close()

    def tostring(self):
        print('------------Account info------------')
        print('Account no:' + str(self.number))
        print('Account name:' + self.name)
        for i in self.__transactions:
            i.tostring()


t = Transaction(100, "2008-12-09")
# print(t._Transaction__amount)  # 前面有双下划线的属性被变了名字
# print(t.__amount)
print(t.currency)

account = Account('001', 'zheng')
account.apply(Transaction(100, "2008-11-14"))
account.apply(Transaction(150, "2008-12-09"))
account.apply(Transaction(-95, "2009-01-22"))
account.save()

b = Account('001', 'zi')
b.load()
b.tostring()

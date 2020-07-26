import random


# 使用循环，与随机random，设计一个石头剪刀布的游戏，能对异常输入进行处理，直接回车退出
def judge(user1, user2):
    if (user1 == 'rock' and user2 == 'scissors') or (user1 == 'scissors' and user2 == 'paper') \
            or (
            user1 == 'paper' and user2 == 'rock'):
        return True
    else:
        return False

Win_Round = 0
Lost_Round = 0
player = ['rock', 'paper', 'scissors']
while True:
    try:
        player_choice = input('please input your choice(rock, paper, scissors):')

        if player_choice == '':
            break
        elif player_choice not in player:
            raise Exception('invalid choice!')
        computer_choice = random.choice(player)
        print("the choice of computer is: " + computer_choice)
        if computer_choice == player_choice:
            print("The game ended in a tie!")
        elif judge(player_choice, computer_choice):
            print("you are the winner!")
            Win_Round += 1
        else:
            print("you lost!")
            Lost_Round += 1
    except Exception as err:
        print(err)
        continue
print('------------------------------')
print('you won '+str(Win_Round)+' round!\nyou lost '+str(Lost_Round)+' round!')

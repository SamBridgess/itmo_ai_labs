from pyswip import Prolog
import re

functions = {}
def store(d, name):
    def _(f):
        d[name] = f
        return f

    return _


@store(functions, "has_role")
def has_role(op):
    res = list(prolog.query(f'has_role({op}, W).'))
    print(op, "is", end="")
    for value in res:
        print(value['W'] + ", ", end="")
    print()


@store(functions, "has_gadget")
def has_gadget(op):
    res = list(prolog.query(f'has_gadget({op}, W).'))
    print(op, "has", end="")
    for value in res:
        print(value['W'] + ", ", end="")
    print()


@store(functions, "same_team")
def same_team(op1, op2):
    res = bool(list(prolog.query(f'same_team({op1}, {op2}).')))
    if res:
        print('Yes')
    else:
        print('No')


@store(functions, "interchangeable")
def interchangeable(op2, op1):
    res = bool(list(prolog.query(f'interchangeable({op1}, {op2}).')))
    if res:
        print('Yes')
    else:
        print('No')


@store(functions, "sub_role_gadget")
def sub_role_gadget(role):
    res = list(prolog.query(f'sub_role_gadget({role}, W).'))
    print('You should take ', end="")
    for value in res:
        print(value['W'] + ", ", end="")
    print()


prolog = Prolog()
patterns = {
    r'Which roles does (.+) have\?': 'has_role',
    r'Which gadgets does (.+) have\?': 'has_gadget',
    r'Are (.+) and (.+) on the same team\?': 'same_team',
    r'Can (.+) interchange (.+)\?': 'interchangeable',
    r'What gadget should I take to play as (.+)\?': 'sub_role_gadget'
}

KNOWLEDGE_BASE_PATH = '../lab1/1.pl'
prolog.consult(KNOWLEDGE_BASE_PATH)
print('Knowledge base loaded')


while True:
    query = input('> ')
    if query.lower() == 'exit':
        break

    for pattern in patterns:
        match = re.match(pattern, query, re.IGNORECASE)
        if match is None:
            continue

        functions[patterns[pattern]](*match.groups())
        break
    else:
        print("Wrong query")

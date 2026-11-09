# Problem Set 4A
# Name: <your name here>
# Collaborators:
# Time Spent: x:xx

def get_permutations(sequence):
    '''
    Enumerate all permutations of a given string

    sequence (string): an arbitrary string to permute. Assume that it is a
    non-empty string.  

    You MUST use recursion for this part. Non-recursive solutions will not be
    accepted.

    Returns: a list of all permutations of sequence

    Example:
    >>> get_permutations('abc')
    ['abc', 'acb', 'bac', 'bca', 'cab', 'cba']

    Note: depending on your implementation, you may return the permutations in
    a different order than what is listed here.
    '''

    if len(sequence) == 1:
        return list(sequence)
    else:
        permutations = []
        for p in get_permutations(sequence[1:]):
            for i in range(len(p)+1):
                permutations.append(p[:i]+sequence[0]+p[i:])
        return permutations

if __name__ == '__main__':
#    #EXAMPLE
    example_input = 'abc'
    print('Input:', example_input)
    print('Expected Output:', ['abc', 'acb', 'bac', 'bca', 'cab', 'cba'])
    print('Actual Output:', get_permutations(example_input))
    
    print("--------------")
    
    print('Input:', 'xyz')
    print('Expected Output:', ['xyz', 'xzy', 'yxz', 'yzx', 'zyx', 'zxy'])
    print('Actual Output:', get_permutations('xyz'))
    
    print("--------------")
    
    print('Input:', '123')
    print('Expected Output:', ['123', '213', '321', '132', '231', '312'])
    print('Actual Output:', get_permutations('123'))
    
    print("--------------")
    
    print('Input:', 'abcd')
   # print('Expected Output:', ['abcd', 'bacd', 'cbad', 'dbca', 'a', '312'])
    print('Actual Output:', get_permutations('abcd'))
    
    



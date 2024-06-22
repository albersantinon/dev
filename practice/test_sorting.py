import pytest
from sorting import sort

def test_empyt_list():
    #given
    input = []
    #when
    result = sort(input)
    #then
    assert result == []

def test_single_element():
    #given
    input = [1]
    #when
    result = sort(input)
    #then
    assert result == [1]

def test_two_elements():
    #given
    input = [4,7]
    #when
    result = sort(input)
    #then
    assert result == [4,7]

def test_two_elements_inverted():
    #given
    input = [7,4]
    #when
    result = sort(input)
    #then
    assert result == [4,7]

def test_many_elements():
    #given
    input = [1,4,6,8,9,22,56]
    #when
    result = sort(input)
    #then
    assert result == [1,4,6,8,9,22,56]

def test_lots_elements():
    #given
    input = [56,22,1,4,6,9,8]
    #when
    result = sort(input)
    #then
    assert result == [1,4,6,8,9,22,56]
# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class ArithmeticLogicUnit < Day
    def part1
      # The input instructions are effectively a set of subroutines that only
      # differ in three places. The first is a division, {DIV}, which is always
      # either 1 or 26; the second is some sort of checksum, {CHECK}, which
      # compares the `mod` of whatever was in `x` to the input of this
      # subroutine, `w`; the last is some sort of offset which is added to `w`
      # before being multiplied by whatever is in `x` and added to `z`. `z` is
      # the only register that persists between subroutines, and must be 0 at
      # the end if the serial number is valid. The nth digit of the serial number
      # is fed into the nth subroutine.
      #
      #
      # 0    inp w
      # 1    mul x 0
      # 2    add x z
      # 3    mod x 26
      # 4    div z {DIV}
      # 5    add x {CHECK}
      # 6    eql x w
      # 7    eql x 0
      # 8    mul y 0
      # 9    add y 25
      # 10   mul y x
      # 11   add y 1
      # 12   mul z y
      # 13   mul y 0
      # 14   add y w
      # 15   add y {OFFSET}
      # 16   mul y x
      # 17   add z y
      #
      #
      # So what is really happening?
      #  - Read the nth digit from the serial number (input).
      #  - Check the condition: input == (`z` % 26) + {CHECK}.
      #  - If {CHECK} is negative (or {DIV} is 26), set `z` = `z` / 26.
      #  - If the condition passes, next.
      #  - Otherwise, set `z` = 26 * `z` + input + {OFFSET}
      #
      # {CHECK}; {OFFSET} pairs in my input
      #     13 ; 08
      #     12 ; 13
      #     12 ; 08
      #     10 ; 10
      #    -11 ; 12
      #    -13 ; 01
      #     15 ; 13
      #     10 ; 05
      #    -02 ; 10
      #    -06 ; 03
      #     14 ; 02
      #     00 ; 02
      #    -15 ; 12
      #    -04 ; 07
      #
      # So `z` acts like a stack of base-26 numbers. Effectively:
      #  - If {CHECK} is positive, push (input + {OFFSET}) onto the stack.
      #  - If {CHECK} is negative, pop from the stack. If the popped value plus
      #     {CHECK} does not equal the input, then push (input + {OFFSET}) onto the
      #     stack.
      #  - After all instructions have run, we are successful if the stack is empty
      #     (`z` == 0).
      #
      # The stack operations for us to be successful, then, are:
      #  - PUSH input0 + 8
      #  - PUSH input1 + 13
      #  - PUSH input2 + 8
      #  - PUSH input3 + 10
      #  - POP; input4 == pop - 11
      #  - POP; input5 == pop - 13
      #  - PUSH input6 + 13
      #  - PUSH input7 + 5
      #  - POP; input8 == pop - 2
      #  - POP; input9 == pop - 6
      #  - PUSH input10 + 2
      #  - POP; input11 == pop - 0
      #  - POP; input12 == pop - 15
      #  - POP; input13 == pop - 4
      #
      # These can be simplified, thus:
      #  - input4  = (input3 + 10) - 11   -> input3  - 1
      #  - input5  = (input2 + 8) - 13    -> input2  - 5
      #  - input8  = (input7 + 5) - 2     -> input7  + 3
      #  - input9  = (input6 + 13) - 6    -> input6  + 7
      #  - input11 = (input10 + 2) - 0    -> input10 + 2
      #  - input12 = (input1 + 13) - 15   -> input1  - 2
      #  - input13 = (input0 + 8) - 4     -> input0  + 4
      #
      # The largest digit for each is:
      #  - input0  == 5
      #  - input1  == 9
      #  - input2  == 9
      #  - input3  == 9
      #  - input4  == 8
      #  - input5  == 4
      #  - input6  == 2
      #  - input7  == 6
      #  - input8  == 9
      #  - input9  == 9
      #  - input10 == 7
      #  - input11 == 9
      #  - input12 == 7
      #  - input13 == 9

      59_998_426_997_979
    end

    def part2
      # The smallest digit for each is:
      #  - input0  == 1
      #  - input1  == 3
      #  - input2  == 6
      #  - input3  == 2
      #  - input4  == 1
      #  - input5  == 1
      #  - input6  == 1
      #  - input7  == 1
      #  - input8  == 4
      #  - input9  == 8
      #  - input10 == 1
      #  - input11 == 3
      #  - input12 == 1
      #  - input13 == 5

      13_621_111_481_315
    end
  end
end

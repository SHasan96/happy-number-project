!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!       Happy Number Project        !!!!!!!!!!!

! A program to find happy numbers in a given range 
! and print them in descending order of norms.
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

program happy_numbers 
  implicit none
  ! A structure to contain a happy number with its norm
  type Numpair
    integer (kind = 8) :: happy_number
    double precision   :: norm
  end type Numpair
  
  integer (kind = 8)  :: a1, a2
  integer             :: status        !< A variable for input checking
  
  write(*, "(/,a)", advance="no") "Enter first argument (a whole number): "
  ! Take an input and check it's status, exit if any error is enocuntered
  read (*, *, iostat=status) a1
  if (status /= 0) then
      write (*, '( /, a, /, a )' ) "Invalid range and/or arguments!", "Exiting..."
      print *
      call exit(0)
  end if
  write(*, "(a)", advance="no") "Enter second argument (another whole number): "
  ! Take the next input in a similar way
  read (*, *, iostat=status) a2
  if (status /= 0) then
      write (*, '( /, a, /, a )' ) "Invalid range and/or arguments!", "Exiting..."
      print *
      call exit(0)
  end if
  ! If inputs are ok, call a subroutine for further checking
  call check_args(a1,a2)

contains

!> Function that returns the sum of the squared 
!! digits in a given number.
!! @param number - an integer
!! Reference: "rossettacode.org"
function sum_digits_squared(number) result(sum)
  integer (kind = 8), intent(in) :: number
  integer (kind = 8)             :: sum, digit, rest, work

  sum = 0
  work = number
  do
    if (work == 0) then
      exit
    end if
    rest = work / 10
    digit = work - 10 * rest
    sum = sum + digit * digit
    work = rest
  end do
end function sum_digits_squared

!> Function that determines if a number is happy.
!! Returns true or false base on the determination.
!! @param number - an integer
!! Reference: "rossettacode.org"
function is_happy (number) result (happy)
  integer (kind = 8), intent (in) :: number
  integer (kind = 8)              :: tortoise, hare
  logical                         :: happy

  tortoise = number
  hare = number
  do
    tortoise = sum_digits_squared(tortoise)
    hare = sum_digits_squared(sum_digits_squared (hare))
    if (tortoise == hare) then
      exit
    end if
  end do
  happy = tortoise == 1
end function is_happy

!> Function that finds the norm of a happy number.
!! Norm is of double precision data type.
!! @param happynum - an integer which is a happy number
function find_norm(happynum) result(norm)
  integer (kind = 8), intent(in) :: happynum
  integer (kind = 8)             :: dsum, norm_sum
  double precision               :: norm 
  
  norm_sum = happynum**2 
  dsum = happynum
  do while (sum_digits_squared(dsum) /= 1)
    norm_sum = norm_sum + (sum_digits_squared(dsum))**2
    dsum = sum_digits_squared(dsum)
  end do
  norm = norm_sum + 1
  norm = dsqrt(norm)
end function find_norm

!> Subroutine that appends an element to a list.
!! @param list - an array
!! @param element - an elemet for the array (a structure
!!   in this case)
!! @note This is necessassy for maintaining a dynamic array 
!!   and be memory efficient. Elements are added in the 
!!   array and its size is incremented when needed.
!!   We could also create a sperate module for this. 
!! Reference: "https://stackoverflow.com/questions/28048508/
!!      how-to-add-new-element-to-dynamical-array-in-fortran-90"
subroutine append_list(list, element)
  integer                                                 :: i, isize
  type(Numpair), intent(in)                               :: element
  type(Numpair), dimension(:), allocatable, intent(inout) :: list
  type(Numpair), dimension(:), allocatable                :: clist

  if(allocated(list)) then
    isize = size(list)
    allocate(clist(isize+1))
    do i=1,isize          
      clist(i) = list(i)
    end do
    clist(isize+1) = element
    deallocate(list)
    call move_alloc(clist, list)
  else
    allocate(list(1))
    list(1) = element
  end if
end subroutine append_List

!> Subroutine that checks the two user input arguments.
!! If the arguments are valid, the next subroutine will
!! be called using these arguments.
!! @param n1 - first integer argument
!! @param n2 - second integer argument
subroutine check_args(n1, n2)
  integer (kind = 8) :: n1, n2, temp  
  ! Check if arguments are valid.
  if (n1 == n2 .or. n1 < 0 .or. n2 < 0) then
    write (*, '( /, a, /, a )' ) "Invalid range and/or arguments!", "Exiting..."
    print *
    call exit(0)
  end if
  ! If they are, print them for display.
  write (*, '( /, a, i0, /, a, i0 )' ) "First Argument: ", n1, "Second Argument: ", n2
  ! Swap arguments if needed.
  if (n1 > n2) then
    temp = n1
    n1 = n2
    n2 = temp
  end if
  call happy_numbers_in_range(n1,n2)
end subroutine check_args
    

!> Subroutine that prints the happy numbers between two 
!! numbers (inclusive) in descending order of their norms.
!! @param num1 - start of the range
!! @param num2 - end of the range
subroutine happy_numbers_in_range(num1, num2)
  integer (kind = 8), intent(in)           :: num1, num2 
  integer (kind = 8)                       :: number, x
  type(Numpair)                            :: apair
  type(Numpair), dimension(:), allocatable :: numpair_list !< An array of structures
  
  do number = num1, num2
    if (is_happy (number)) then
      apair%happy_number = number
      apair%norm = find_norm(number)
      call append_list(numpair_list, apair)
    end if
  end do
  
  ! Sorting in descending order of the norms in the structures
  call sort(numpair_list, size(numpair_list))
  
  if (size(numpair_list) > 10) then       ! If there are more than 10 happy numbers
    ! Print out array elements. Indexing of fortran arrays start at 1.
    do x = 1, 10
      write(*,"(i0)") numpair_list(x)%happy_number
    end do
    deallocate(numpair_list)
  else if (size(numpair_list) == 0) then  ! If there are no happy numbers
    write(*,"(a)") "NOBODY'S HAPPY!"
  else                                    ! If there are less than or equal to 10 happy numbers
    do x = 1, size(numpair_list)
      write(*,"(i0)") numpair_list(x)%happy_number  
    end do
    deallocate(numpair_list)
  end if
  print *                                 ! Print newline to mark end of program
end subroutine happy_numbers_in_range

!> Function that returns the location of the maximum in the section
!! between start and finish.
!! @param arr - the array
!! @param start - starting index of the section
!! @param finish - ending index of the section
!! @note This is needed for sorting.
!! Reference: "https://pages.mtu.edu/~shene/COURSES/cs201/NOTES/chap08/sorting.f90"
function  find_maximum(arr, start, finish) result(maxpos)
  type(Numpair), dimension(1:), intent(in) :: arr
  integer, intent(in)                      :: start, finish
  integer                                  :: location, i, maxpos
  double precision                         :: maximum

  maximum  = arr(start)%norm              ! Assume the first is the maximum
  location = start                        ! Record its position
  do i = start+1, finish                  ! Start with next element
    if (arr(i)%norm > maximum) then       ! Is arr(i) greater than the maximum?
      maximum  = arr(i)%norm              ! Yes, a new maximum found
      location = i                        ! Record its position
    end if
  end do
  maxpos = location                       ! Return the position
end function  find_maximum

!> Subroutine that swaps the values of its two arguments.
!! The elements that are to be swapped are of the Numpair structure.
!! @param a - first element
!! @param b - second element
!! @note This is needed for sorting.
subroutine  swap(a, b)
  type(Numpair), intent(inout) :: a, b
  type(Numpair)                :: temp

  temp = a
  a = b
  b = temp
end subroutine  swap

!> Subroutine that receives an array and sorts it in descending order.
!! @param arr - an array of Numpair structures to be sorted
!! @param size - size of the array
!! @note The sorting method used is selection sort.
!! Reference: "https://pages.mtu.edu/~shene/COURSES/cs201/NOTES/chap08/sorting.f90"
subroutine  sort(arr, size)
  type(Numpair), dimension(1:), intent(inout) :: arr
  integer, intent(in)                         :: size
  integer                                     :: i, location

  do i = 1, size-1                              ! Exclude the last
    location = find_maximum(arr, i, size)       ! Find maximum from this to last
    call swap(arr(i), arr(location))            ! Swap this and the maximum
  end do
end subroutine sort

end program happy_numbers

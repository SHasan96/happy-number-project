#!/usr/bin/sbcl --script

;;;; HAPPY NUMBER PROGRAM

;;; Function that returns the square of a number.
(defun sqr (n)
  (* n n))

;;; Function that returns the sum of the
;;; individual squared digits in a number.
;;; Reference: "rosettacode.org"
(defun sum-of-sqr-dgts (n)
  ;; @note for self: FLOOR function returns two values, the first is 
  ;; result of dividing number by divisor and truncating toward 
  ;; negative infinity. Second result remainder that satisfies equation: 
  ;; quotient * divisor + remainder = number.
  (loop for i = n then (floor i 10)
    while (plusp i)
      sum (sqr (mod i 10))))
 
;;; Funtion that returns true if a number is happy.
;;; Reference: "rosettacode.org"
(defun is-happy (n &optional cache)
  (or (= n 1) 
    (unless (find n cache)
      (is-happy (sum-of-sqr-dgts n)
        (cons n cache)))))
        
;;; Function that finds and returns the norm of happy nubmer.
(defun find-norm (hnum)
  ;; To introduce a local variable inside a function, use LET
  ;; @note for self: The whole function segment using the let 
  ;;  should be wrapped in it.
  (let ((norm 1))  
    (loop for i = hnum then (sum-of-sqr-dgts i)
      while (/= i 1) do     
        (incf norm (sqr i)))
    (sqrt norm)))
          
;;; Function that stores norms (keys) and happy numbers (values) 
;;; in a hashtable.
(defun fill-hash-table(n1 n2 hash-table)
  (loop for x from n1 to n2 do
    (when (is-happy x)
      (setf (gethash (find-norm x) hash-table) x))))

;;; Function that collects the norms (key) from the
;;; numpair hash table.
;;; Returns a list of keys.
(defun get-key-list(hash-table)
  (loop for k being each hash-key of hash-table 
      collect k))

;;; Function that manipulates a list and then
;;; prints happy numbers accordingly.
(defun print-happys(alist size hash-table)
  (setf alist (sort alist #'<))  ; sort list in ascending order
  (setf alist (reverse alist))   ; reverse to get descending order
  
  (cond ((and (> size 0) (< size 11))        ; 10 or less happy numbers
            (loop for norm in alist do
              (write (gethash norm hash-table))
              (terpri)))
        ( (> size 10)                        ; more than 10 happy numbers 
          (let ((c 1))  
            (loop for norm in alist do
              (write (gethash norm hash-table))
              (terpri)
              (incf c)
              (when (> c 10)
                (return))))) 
        (t (format t "NOBODY'S HAPPY!~%"))))  ; no happy number

 
;;; Function
(defun check-for-int (n)
  (unless (typep n 'integer)
    (format t "~%Invalid range and/or arguments! ~%Exiting...~%~%")
    (quit))
  (return-from check-for-int))
 
;;; Main starts here.

(terpri)
;;Get input arguments
(format t "Enter first argument (a whole number): ")
(finish-output)
(defvar a1 (read))
(clear-input)
(check-for-int a1)
(format t "Enter second argument (another whole number): ")
(finish-output)
(defvar a2 (read))
(clear-input)
(check-for-int a2)

;; A hash table for storing number pairs (norms-happynums)
(defvar *numpairs* (make-hash-table))
;; A list for storing norms (keys) of hash table
(defvar *normslist*)

;; Check arguments in a conditional before using them
(cond ((or (or (< a1 0) (< a2 0)) (= a1 a2)) ; args are negative or same
         (format t "~%Invalid range and/or arguments! ~%Exiting...~%"))
      (t (format t "~%First Argument: ~a ~%" a1)
         (format t "Second Argument: ~a ~%" a2)
         (if (> a1 a2)   ; fill hash-table starting with smaller arg
           (fill-hash-table a2 a1 *numpairs*)   
           (fill-hash-table a1 a2 *numpairs*))
         (setf *normslist* (get-key-list *numpairs*))    
         (print-happys *normslist* (list-length *normslist*) *numpairs*)))
(terpri)

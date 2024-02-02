module stdlib_linalg_blas_aux
     use stdlib_linalg_constants
     implicit none(type, external)
     private

     public :: sp, dp, qp, lk, ilp
     public :: stdlib_dcabs1
     public :: stdlib_icamax
     public :: stdlib_idamax
     public :: stdlib_isamax
     public :: stdlib_izamax
     public :: stdlib_lsame
     public :: stdlib_scabs1
     public :: stdlib_xerbla
     public :: stdlib_xerbla_array
     public :: stdlib_qcabs1
     public :: stdlib_iqamax
     public :: stdlib_iwamax

     contains

     ! ISAMAX finds the index of the first element having maximum absolute value.

     integer(ilp) function stdlib_isamax(n, sx, incx)
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
           ! .. scalar arguments ..
           integer(ilp) :: incx, n
           ! .. array arguments ..
           real(sp) :: sx(*)
        ! =====================================================================
           ! .. local scalars ..
           real(sp) :: smax
           integer(ilp) :: i, ix
           ! .. intrinsic functions ..
           intrinsic :: abs
           stdlib_isamax = 0
           if (n < 1 .or. incx <= 0) return
           stdlib_isamax = 1
           if (n == 1) return
           if (incx == 1) then
              ! code for increment equal to 1
              smax = abs(sx(1))
              do i = 2, n
                 if (abs(sx(i)) > smax) then
                    stdlib_isamax = i
                    smax = abs(sx(i))
                 end if
              end do
           else
              ! code for increment not equal to 1
              ix = 1
              smax = abs(sx(1))
              ix = ix + incx
              do i = 2, n
                 if (abs(sx(ix)) > smax) then
                    stdlib_isamax = i
                    smax = abs(sx(ix))
                 end if
                 ix = ix + incx
              end do
           end if
           return
     end function stdlib_isamax

     ! LSAME returns .TRUE. if CA is the same letter as CB regardless of
     ! case.

     logical(lk) function stdlib_lsame(ca, cb)
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
           ! .. scalar arguments ..
           character :: ca, cb
       ! =====================================================================
           ! .. intrinsic functions ..
           intrinsic :: ichar
           ! .. local scalars ..
           integer(ilp) :: inta, intb, zcode
           ! test if the characters are equal
           stdlib_lsame = ca == cb
           if (stdlib_lsame) return
           ! now test for equivalence if both characters are alphabetic.
           zcode = ichar('z')
           ! use 'z' rather than 'a' so that ascii can be detected on prime
           ! machines, on which ichar returns a value with bit 8 set.
           ! ichar('a') on prime machines returns 193 which is the same as
           ! ichar('a') on an ebcdic machine.
           inta = ichar(ca)
           intb = ichar(cb)
           if (zcode == 90 .or. zcode == 122) then
              ! ascii is assumed - zcode is the ascii code of either lower or
              ! upper case 'z'.
               if (inta >= 97 .and. inta <= 122) inta = inta - 32
               if (intb >= 97 .and. intb <= 122) intb = intb - 32
           else if (zcode == 233 .or. zcode == 169) then
              ! ebcdic is assumed - zcode is the ebcdic code of either lower or
              ! upper case 'z'.
               if (inta >= 129 .and. inta <= 137 .or. inta >= 145 .and. inta <= 153 .or. inta >= 162 .and. &
                         inta <= 169) inta = inta + 64
               if (intb >= 129 .and. intb <= 137 .or. intb >= 145 .and. intb <= 153 .or. intb >= 162 .and. &
                         intb <= 169) intb = intb + 64
           else if (zcode == 218 .or. zcode == 250) then
              ! ascii is assumed, on prime machines - zcode is the ascii code
              ! plus 128 of either lower or upper case 'z'.
               if (inta >= 225 .and. inta <= 250) inta = inta - 32
               if (intb >= 225 .and. intb <= 250) intb = intb - 32
           end if
           stdlib_lsame = inta == intb
           ! return
     end function stdlib_lsame

     ! SCABS1 computes |Re(.)| + |Im(.)| of a complex number

     real(sp) function stdlib_scabs1(z)
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
           ! .. scalar arguments ..
           complex(sp) :: z
        ! =====================================================================
           ! .. intrinsic functions ..
           intrinsic :: abs, aimag, real
           stdlib_scabs1 = abs(real(z, KIND=sp)) + abs(aimag(z))
           return
     end function stdlib_scabs1

     ! XERBLA  is an error handler for the LAPACK routines.
     ! It is called by an LAPACK routine if an input parameter has an
     ! invalid value.  A message is printed and execution stops.
     ! Installers may consider modifying the STOP statement in order to
     ! call system-specific exception-handling facilities.

     subroutine stdlib_xerbla(srname, info)
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
           ! .. scalar arguments ..
           character*(*) :: srname
           integer(ilp) :: info
       ! =====================================================================
           ! .. intrinsic functions ..
           intrinsic :: len_trim
           ! .. executable statements ..
           write (*, fmt=9999) srname(1:len_trim(srname)), info
           stop
9999  format(' ** on entry to ', a, ' parameter number ', i2, ' had ', 'an illegal value')
                
     end subroutine stdlib_xerbla

     ! XERBLA_ARRAY assists other languages in calling XERBLA, the LAPACK
     ! and BLAS error handler.  Rather than taking a Fortran string argument
     ! as the function's name, XERBLA_ARRAY takes an array of single
     ! characters along with the array's length.  XERBLA_ARRAY then copies
     ! up to 32 characters of that array into a Fortran string and passes
     ! that to XERBLA.  If called with a non-positive SRNAME_LEN,
     ! XERBLA_ARRAY will call XERBLA with a string of all blank characters.
     ! Say some macro or other device makes XERBLA_ARRAY available to C99
     ! by a name lapack_xerbla and with a common Fortran calling convention.
     ! Then a C99 program could invoke XERBLA via:
     ! {
     ! int flen = strlen(__func__);
     ! lapack_xerbla(__func__,
     ! }
     ! Providing XERBLA_ARRAY is not necessary for intercepting LAPACK
     ! errors.  XERBLA_ARRAY calls XERBLA.

     subroutine stdlib_xerbla_array(srname_array, srname_len, info)
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
           ! .. scalar arguments ..
           integer(ilp) :: srname_len, info
           ! .. array arguments ..
           character(1) srname_array(srname_len)
       ! =====================================================================
           ! .. local scalars ..
           integer(ilp) :: i
           ! .. local arrays ..
           character*32 srname
           ! .. intrinsic functions ..
           intrinsic :: min, len
           ! .. executable statements ..
           srname = ''
           do i = 1, min(srname_len, len(srname))
              srname(i:i) = srname_array(i)
           end do
           call stdlib_xerbla(srname, info)
           return
     end subroutine stdlib_xerbla_array

     ! QCABS1 computes |Re(.)| + |Im(.)| of a double complex number

     real(qp) function stdlib_qcabs1(z)
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
           ! .. scalar arguments ..
           complex(qp) :: z
        ! =====================================================================
           ! .. intrinsic functions ..
           intrinsic :: abs, real, aimag
           stdlib_qcabs1 = abs(real(z, KIND=qp)) + abs(aimag(z))
           return
     end function stdlib_qcabs1

     ! IQAMAX finds the index of the first element having maximum absolute value.

     integer(ilp) function stdlib_iqamax(n, dx, incx)
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
           ! .. scalar arguments ..
           integer(ilp) :: incx, n
           ! .. array arguments ..
           real(qp) :: dx(*)
        ! =====================================================================
           ! .. local scalars ..
           real(qp) :: dmax
           integer(ilp) :: i, ix
           ! .. intrinsic functions ..
           intrinsic :: abs
           stdlib_iqamax = 0
           if (n < 1 .or. incx <= 0) return
           stdlib_iqamax = 1
           if (n == 1) return
           if (incx == 1) then
              ! code for increment equal to 1
              dmax = abs(dx(1))
              do i = 2, n
                 if (abs(dx(i)) > dmax) then
                    stdlib_iqamax = i
                    dmax = abs(dx(i))
                 end if
              end do
           else
              ! code for increment not equal to 1
              ix = 1
              dmax = abs(dx(1))
              ix = ix + incx
              do i = 2, n
                 if (abs(dx(ix)) > dmax) then
                    stdlib_iqamax = i
                    dmax = abs(dx(ix))
                 end if
                 ix = ix + incx
              end do
           end if
           return
     end function stdlib_iqamax

     ! IWAMAX finds the index of the first element having maximum |Re(.)| + |Im(.)|

     integer(ilp) function stdlib_iwamax(n, zx, incx)
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
           ! .. scalar arguments ..
           integer(ilp) :: incx, n
           ! .. array arguments ..
           complex(qp) :: zx(*)
        ! =====================================================================
           ! .. local scalars ..
           real(qp) :: dmax
           integer(ilp) :: i, ix
           stdlib_iwamax = 0
           if (n < 1 .or. incx <= 0) return
           stdlib_iwamax = 1
           if (n == 1) return
           if (incx == 1) then
              ! code for increment equal to 1
              dmax = stdlib_qcabs1(zx(1))
              do i = 2, n
                 if (stdlib_qcabs1(zx(i)) > dmax) then
                    stdlib_iwamax = i
                    dmax = stdlib_qcabs1(zx(i))
                 end if
              end do
           else
              ! code for increment not equal to 1
              ix = 1
              dmax = stdlib_qcabs1(zx(1))
              ix = ix + incx
              do i = 2, n
                 if (stdlib_qcabs1(zx(ix)) > dmax) then
                    stdlib_iwamax = i
                    dmax = stdlib_qcabs1(zx(ix))
                 end if
                 ix = ix + incx
              end do
           end if
           return
     end function stdlib_iwamax

     ! DCABS1 computes |Re(.)| + |Im(.)| of a double complex number

     real(dp) function stdlib_dcabs1(z)
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
           ! .. scalar arguments ..
           complex(dp) :: z
        ! =====================================================================
           ! .. intrinsic functions ..
           intrinsic :: abs, real, aimag
           stdlib_dcabs1 = abs(real(z, KIND=dp)) + abs(aimag(z))
           return
     end function stdlib_dcabs1

     ! ICAMAX finds the index of the first element having maximum |Re(.)| + |Im(.)|

     integer(ilp) function stdlib_icamax(n, cx, incx)
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
           ! .. scalar arguments ..
           integer(ilp) :: incx, n
           ! .. array arguments ..
           complex(sp) :: cx(*)
        ! =====================================================================
           ! .. local scalars ..
           real(sp) :: smax
           integer(ilp) :: i, ix
           stdlib_icamax = 0
           if (n < 1 .or. incx <= 0) return
           stdlib_icamax = 1
           if (n == 1) return
           if (incx == 1) then
              ! code for increment equal to 1
              smax = stdlib_scabs1(cx(1))
              do i = 2, n
                 if (stdlib_scabs1(cx(i)) > smax) then
                    stdlib_icamax = i
                    smax = stdlib_scabs1(cx(i))
                 end if
              end do
           else
              ! code for increment not equal to 1
              ix = 1
              smax = stdlib_scabs1(cx(1))
              ix = ix + incx
              do i = 2, n
                 if (stdlib_scabs1(cx(ix)) > smax) then
                    stdlib_icamax = i
                    smax = stdlib_scabs1(cx(ix))
                 end if
                 ix = ix + incx
              end do
           end if
           return
     end function stdlib_icamax

     ! IDAMAX finds the index of the first element having maximum absolute value.

     integer(ilp) function stdlib_idamax(n, dx, incx)
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
           ! .. scalar arguments ..
           integer(ilp) :: incx, n
           ! .. array arguments ..
           real(dp) :: dx(*)
        ! =====================================================================
           ! .. local scalars ..
           real(dp) :: dmax
           integer(ilp) :: i, ix
           ! .. intrinsic functions ..
           intrinsic :: abs
           stdlib_idamax = 0
           if (n < 1 .or. incx <= 0) return
           stdlib_idamax = 1
           if (n == 1) return
           if (incx == 1) then
              ! code for increment equal to 1
              dmax = abs(dx(1))
              do i = 2, n
                 if (abs(dx(i)) > dmax) then
                    stdlib_idamax = i
                    dmax = abs(dx(i))
                 end if
              end do
           else
              ! code for increment not equal to 1
              ix = 1
              dmax = abs(dx(1))
              ix = ix + incx
              do i = 2, n
                 if (abs(dx(ix)) > dmax) then
                    stdlib_idamax = i
                    dmax = abs(dx(ix))
                 end if
                 ix = ix + incx
              end do
           end if
           return
     end function stdlib_idamax

     ! IZAMAX finds the index of the first element having maximum |Re(.)| + |Im(.)|

     integer(ilp) function stdlib_izamax(n, zx, incx)
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
           ! .. scalar arguments ..
           integer(ilp) :: incx, n
           ! .. array arguments ..
           complex(dp) :: zx(*)
        ! =====================================================================
           ! .. local scalars ..
           real(dp) :: dmax
           integer(ilp) :: i, ix
           stdlib_izamax = 0
           if (n < 1 .or. incx <= 0) return
           stdlib_izamax = 1
           if (n == 1) return
           if (incx == 1) then
              ! code for increment equal to 1
              dmax = stdlib_dcabs1(zx(1))
              do i = 2, n
                 if (stdlib_dcabs1(zx(i)) > dmax) then
                    stdlib_izamax = i
                    dmax = stdlib_dcabs1(zx(i))
                 end if
              end do
           else
              ! code for increment not equal to 1
              ix = 1
              dmax = stdlib_dcabs1(zx(1))
              ix = ix + incx
              do i = 2, n
                 if (stdlib_dcabs1(zx(ix)) > dmax) then
                    stdlib_izamax = i
                    dmax = stdlib_dcabs1(zx(ix))
                 end if
                 ix = ix + incx
              end do
           end if
           return
     end function stdlib_izamax

end module stdlib_linalg_blas_aux

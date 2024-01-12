module stdlib_linalg_blas_c
     use stdlib_linalg_constants
     use stdlib_linalg_blas_aux
     use stdlib_linalg_blas_s
     use stdlib_linalg_blas_d
     implicit none(type,external)
     private






     public :: sp,dp,lk,int32,int64
     public :: stdlib_caxpy
     public :: stdlib_ccopy
     public :: stdlib_cdotc
     public :: stdlib_cdotu
     public :: stdlib_cgbmv
     public :: stdlib_cgemm
     public :: stdlib_cgemv
     public :: stdlib_cgerc
     public :: stdlib_cgeru
     public :: stdlib_chbmv
     public :: stdlib_chemm
     public :: stdlib_chemv
     public :: stdlib_cher
     public :: stdlib_cher2
     public :: stdlib_cher2k
     public :: stdlib_cherk
     public :: stdlib_chpmv
     public :: stdlib_chpr
     public :: stdlib_chpr2
     public :: stdlib_crotg
     public :: stdlib_cscal
     public :: stdlib_csrot
     public :: stdlib_csscal
     public :: stdlib_cswap
     public :: stdlib_csymm
     public :: stdlib_csyr2k
     public :: stdlib_csyrk
     public :: stdlib_ctbmv
     public :: stdlib_ctbsv
     public :: stdlib_ctpmv
     public :: stdlib_ctpsv
     public :: stdlib_ctrmm
     public :: stdlib_ctrmv
     public :: stdlib_ctrsm
     public :: stdlib_ctrsv


     contains
     
     
     ! CAXPY constant times a vector plus a vector.
     subroutine stdlib_caxpy(n,ca,cx,incx,cy,incy)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           complex(sp) ca
           integer(int32) incx,incy,n
           ! ..
           ! .. array arguments ..
           complex(sp) cx(*),cy(*)
           ! ..
     
        ! =====================================================================
     
           ! .. local scalars ..
           integer(int32) i,ix,iy
           ! ..
     
     
           if (n<=0) return
           if (stdlib_scabs1(ca)==0.0_sp) return
           if (incx==1 .and. incy==1) then
     
              ! code for both increments equal to 1
     
              do i = 1,n
                 cy(i) = cy(i) + ca*cx(i)
              end do
           else
     
              ! code for unequal increments or equal increments
                ! not equal to 1
     
              ix = 1
              iy = 1
              if (incx<0) ix = (-n+1)*incx + 1
              if (incy<0) iy = (-n+1)*incy + 1
              do i = 1,n
                 cy(iy) = cy(iy) + ca*cx(ix)
                 ix = ix + incx
                 iy = iy + incy
              end do
           end if
     
           return
     
           ! end of stdlib_caxpy
     
     end subroutine stdlib_caxpy
     
     
     ! CCOPY copies a vector x to a vector y.
     subroutine stdlib_ccopy(n,cx,incx,cy,incy)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,incy,n
           ! ..
           ! .. array arguments ..
           complex(sp) cx(*),cy(*)
           ! ..
     
        ! =====================================================================
     
           ! .. local scalars ..
           integer(int32) i,ix,iy
           ! ..
           if (n<=0) return
           if (incx==1 .and. incy==1) then
     
              ! code for both increments equal to 1
     
              do i = 1,n
                 cy(i) = cx(i)
              end do
           else
     
              ! code for unequal increments or equal increments
                ! not equal to 1
     
              ix = 1
              iy = 1
              if (incx<0) ix = (-n+1)*incx + 1
              if (incy<0) iy = (-n+1)*incy + 1
              do i = 1,n
                 cy(iy) = cx(ix)
                 ix = ix + incx
                 iy = iy + incy
              end do
           end if
           return
     
           ! end of stdlib_ccopy
     
     end subroutine stdlib_ccopy
     
     
     ! CDOTC forms the dot product of two complex vectors
     ! CDOTC = X^H * Y
     complex(sp) function stdlib_cdotc(n,cx,incx,cy,incy)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,incy,n
           ! ..
           ! .. array arguments ..
           complex(sp) cx(*),cy(*)
           ! ..
     
        ! =====================================================================
     
           ! .. local scalars ..
           complex(sp) ctemp
           integer(int32) i,ix,iy
           ! ..
           ! .. intrinsic functions ..
           intrinsic conjg
           ! ..
           ctemp = (0.0,0.0)
           stdlib_cdotc = (0.0,0.0)
           if (n<=0) return
           if (incx==1 .and. incy==1) then
     
              ! code for both increments equal to 1
     
              do i = 1,n
                 ctemp = ctemp + conjg(cx(i))*cy(i)
              end do
           else
     
              ! code for unequal increments or equal increments
                ! not equal to 1
     
              ix = 1
              iy = 1
              if (incx<0) ix = (-n+1)*incx + 1
              if (incy<0) iy = (-n+1)*incy + 1
              do i = 1,n
                 ctemp = ctemp + conjg(cx(ix))*cy(iy)
                 ix = ix + incx
                 iy = iy + incy
              end do
           end if
           stdlib_cdotc = ctemp
           return
     
           ! end of stdlib_cdotc
     
     end function stdlib_cdotc
     
     
     ! CDOTU forms the dot product of two complex vectors
     ! CDOTU = X^T * Y
     complex(sp) function stdlib_cdotu(n,cx,incx,cy,incy)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,incy,n
           ! ..
           ! .. array arguments ..
           complex(sp) cx(*),cy(*)
           ! ..
     
        ! =====================================================================
     
           ! .. local scalars ..
           complex(sp) ctemp
           integer(int32) i,ix,iy
           ! ..
           ctemp = (0.0,0.0)
           stdlib_cdotu = (0.0,0.0)
           if (n<=0) return
           if (incx==1 .and. incy==1) then
     
              ! code for both increments equal to 1
     
              do i = 1,n
                 ctemp = ctemp + cx(i)*cy(i)
              end do
           else
     
              ! code for unequal increments or equal increments
                ! not equal to 1
     
              ix = 1
              iy = 1
              if (incx<0) ix = (-n+1)*incx + 1
              if (incy<0) iy = (-n+1)*incy + 1
              do i = 1,n
                 ctemp = ctemp + cx(ix)*cy(iy)
                 ix = ix + incx
                 iy = iy + incy
              end do
           end if
           stdlib_cdotu = ctemp
           return
     
           ! end of stdlib_cdotu
     
     end function stdlib_cdotu
     
     
     ! CGBMV  performs one of the matrix-vector operations
     ! y := alpha*A*x + beta*y,   or   y := alpha*A**T*x + beta*y,   or
     ! y := alpha*A**H*x + beta*y,
     ! where alpha and beta are scalars, x and y are vectors and A is an
     ! m by n band matrix, with kl sub-diagonals and ku super-diagonals.
     subroutine stdlib_cgbmv(trans,m,n,kl,ku,alpha,a,lda,x,incx,beta,y,incy)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           complex(sp) alpha,beta
           integer(int32) incx,incy,kl,ku,lda,m,n
           character trans
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),x(*),y(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           complex(sp) one
           parameter (one= (1.0_sp,0.0_sp))
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
           ! .. local scalars ..
           complex(sp) temp
           integer(int32) i,info,ix,iy,j,jx,jy,k,kup1,kx,ky,lenx,leny
           logical(lk) noconj
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg,max,min
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(trans,'n') .and. .not.stdlib_lsame(trans,'t') &
                     .and..not.stdlib_lsame(trans,'c')) then
               info = 1
           else if (m<0) then
               info = 2
           else if (n<0) then
               info = 3
           else if (kl<0) then
               info = 4
           else if (ku<0) then
               info = 5
           else if (lda< (kl+ku+1)) then
               info = 8
           else if (incx==0) then
               info = 10
           else if (incy==0) then
               info = 13
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_cgbmv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((m==0) .or. (n==0) .or.((alpha==zero).and. (beta==one))) return
     
           noconj = stdlib_lsame(trans,'t')
     
           ! set  lenx  and  leny, the lengths of the vectors x and y, and set
           ! up the start points in  x  and  y.
     
           if (stdlib_lsame(trans,'n')) then
               lenx = n
               leny = m
           else
               lenx = m
               leny = n
           end if
           if (incx>0) then
               kx = 1
           else
               kx = 1 - (lenx-1)*incx
           end if
           if (incy>0) then
               ky = 1
           else
               ky = 1 - (leny-1)*incy
           end if
     
           ! start the operations. in this version the elements of a are
           ! accessed sequentially with one pass through the band part of a.
     
           ! first form  y := beta*y.
     
           if (beta/=one) then
               if (incy==1) then
                   if (beta==zero) then
                       do 10 i = 1,leny
                           y(i) = zero
        10             continue
                   else
                       do 20 i = 1,leny
                           y(i) = beta*y(i)
        20             continue
                   end if
               else
                   iy = ky
                   if (beta==zero) then
                       do 30 i = 1,leny
                           y(iy) = zero
                           iy = iy + incy
        30             continue
                   else
                       do 40 i = 1,leny
                           y(iy) = beta*y(iy)
                           iy = iy + incy
        40             continue
                   end if
               end if
           end if
           if (alpha==zero) return
           kup1 = ku + 1
           if (stdlib_lsame(trans,'n')) then
     
              ! form  y := alpha*a*x + y.
     
               jx = kx
               if (incy==1) then
                   do 60 j = 1,n
                       temp = alpha*x(jx)
                       k = kup1 - j
                       do 50 i = max(1,j-ku),min(m,j+kl)
                           y(i) = y(i) + temp*a(k+i,j)
        50             continue
                       jx = jx + incx
        60         continue
               else
                   do 80 j = 1,n
                       temp = alpha*x(jx)
                       iy = ky
                       k = kup1 - j
                       do 70 i = max(1,j-ku),min(m,j+kl)
                           y(iy) = y(iy) + temp*a(k+i,j)
                           iy = iy + incy
        70             continue
                       jx = jx + incx
                       if (j>ku) ky = ky + incy
        80         continue
               end if
           else
     
              ! form  y := alpha*a**t*x + y  or  y := alpha*a**h*x + y.
     
               jy = ky
               if (incx==1) then
                   do 110 j = 1,n
                       temp = zero
                       k = kup1 - j
                       if (noconj) then
                           do 90 i = max(1,j-ku),min(m,j+kl)
                               temp = temp + a(k+i,j)*x(i)
        90                 continue
                       else
                           do 100 i = max(1,j-ku),min(m,j+kl)
                               temp = temp + conjg(a(k+i,j))*x(i)
       100                 continue
                       end if
                       y(jy) = y(jy) + alpha*temp
                       jy = jy + incy
       110         continue
               else
                   do 140 j = 1,n
                       temp = zero
                       ix = kx
                       k = kup1 - j
                       if (noconj) then
                           do 120 i = max(1,j-ku),min(m,j+kl)
                               temp = temp + a(k+i,j)*x(ix)
                               ix = ix + incx
       120                 continue
                       else
                           do 130 i = max(1,j-ku),min(m,j+kl)
                               temp = temp + conjg(a(k+i,j))*x(ix)
                               ix = ix + incx
       130                 continue
                       end if
                       y(jy) = y(jy) + alpha*temp
                       jy = jy + incy
                       if (j>ku) kx = kx + incx
       140         continue
               end if
           end if
     
           return
     
           ! end of stdlib_cgbmv
     
     end subroutine stdlib_cgbmv
     
     
     ! CGEMM  performs one of the matrix-matrix operations
     ! C := alpha*op( A )*op( B ) + beta*C,
     ! where  op( X ) is one of
     ! op( X ) = X   or   op( X ) = X**T   or   op( X ) = X**H,
     ! alpha and beta are scalars, and A, B and C are matrices, with op( A )
     ! an m by k matrix,  op( B )  a  k by n matrix and  C an m by n matrix.
     subroutine stdlib_cgemm(transa,transb,m,n,k,alpha,a,lda,b,ldb,beta,c,ldc)
     
        ! -- reference blas level3 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           complex(sp) alpha,beta
           integer(int32) k,lda,ldb,ldc,m,n
           character transa,transb
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),b(ldb,*),c(ldc,*)
           ! ..
     
        ! =====================================================================
     
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg,max
           ! ..
           ! .. local scalars ..
           complex(sp) temp
           integer(int32) i,info,j,l,nrowa,nrowb
           logical(lk) conja,conjb,nota,notb
           ! ..
           ! .. parameters ..
           complex(sp) one
           parameter (one= (1.0_sp,0.0_sp))
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
     
           ! set  nota  and  notb  as  true if  a  and  b  respectively are not
           ! conjugated or transposed, set  conja and conjb  as true if  a  and
           ! b  respectively are to be  transposed but  not conjugated  and set
           ! nrowa and  nrowb  as the number of rows of  a  and  b  respectively.
     
           nota = stdlib_lsame(transa,'n')
           notb = stdlib_lsame(transb,'n')
           conja = stdlib_lsame(transa,'c')
           conjb = stdlib_lsame(transb,'c')
           if (nota) then
               nrowa = m
           else
               nrowa = k
           end if
           if (notb) then
               nrowb = k
           else
               nrowb = n
           end if
     
           ! test the input parameters.
     
           info = 0
           if ((.not.nota) .and. (.not.conja) .and.(.not.stdlib_lsame(transa,'t'))) then
               info = 1
           else if ((.not.notb) .and. (.not.conjb) .and.(.not.stdlib_lsame(transb,'t'))) &
                     then
               info = 2
           else if (m<0) then
               info = 3
           else if (n<0) then
               info = 4
           else if (k<0) then
               info = 5
           else if (lda<max(1,nrowa)) then
               info = 8
           else if (ldb<max(1,nrowb)) then
               info = 10
           else if (ldc<max(1,m)) then
               info = 13
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_cgemm ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((m==0) .or. (n==0) .or.(((alpha==zero).or. (k==0)).and. (beta==one))) &
                     return
     
           ! and when  alpha.eq.zero.
     
           if (alpha==zero) then
               if (beta==zero) then
                   do 20 j = 1,n
                       do 10 i = 1,m
                           c(i,j) = zero
        10             continue
        20         continue
               else
                   do 40 j = 1,n
                       do 30 i = 1,m
                           c(i,j) = beta*c(i,j)
        30             continue
        40         continue
               end if
               return
           end if
     
           ! start the operations.
     
           if (notb) then
               if (nota) then
     
                 ! form  c := alpha*a*b + beta*c.
     
                   do 90 j = 1,n
                       if (beta==zero) then
                           do 50 i = 1,m
                               c(i,j) = zero
        50                 continue
                       else if (beta/=one) then
                           do 60 i = 1,m
                               c(i,j) = beta*c(i,j)
        60                 continue
                       end if
                       do 80 l = 1,k
                           temp = alpha*b(l,j)
                           do 70 i = 1,m
                               c(i,j) = c(i,j) + temp*a(i,l)
        70                 continue
        80             continue
        90         continue
               else if (conja) then
     
                 ! form  c := alpha*a**h*b + beta*c.
     
                   do 120 j = 1,n
                       do 110 i = 1,m
                           temp = zero
                           do 100 l = 1,k
                               temp = temp + conjg(a(l,i))*b(l,j)
       100                 continue
                           if (beta==zero) then
                               c(i,j) = alpha*temp
                           else
                               c(i,j) = alpha*temp + beta*c(i,j)
                           end if
       110             continue
       120         continue
               else
     
                 ! form  c := alpha*a**t*b + beta*c
     
                   do 150 j = 1,n
                       do 140 i = 1,m
                           temp = zero
                           do 130 l = 1,k
                               temp = temp + a(l,i)*b(l,j)
       130                 continue
                           if (beta==zero) then
                               c(i,j) = alpha*temp
                           else
                               c(i,j) = alpha*temp + beta*c(i,j)
                           end if
       140             continue
       150         continue
               end if
           else if (nota) then
               if (conjb) then
     
                 ! form  c := alpha*a*b**h + beta*c.
     
                   do 200 j = 1,n
                       if (beta==zero) then
                           do 160 i = 1,m
                               c(i,j) = zero
       160                 continue
                       else if (beta/=one) then
                           do 170 i = 1,m
                               c(i,j) = beta*c(i,j)
       170                 continue
                       end if
                       do 190 l = 1,k
                           temp = alpha*conjg(b(j,l))
                           do 180 i = 1,m
                               c(i,j) = c(i,j) + temp*a(i,l)
       180                 continue
       190             continue
       200         continue
               else
     
                 ! form  c := alpha*a*b**t + beta*c
     
                   do 250 j = 1,n
                       if (beta==zero) then
                           do 210 i = 1,m
                               c(i,j) = zero
       210                 continue
                       else if (beta/=one) then
                           do 220 i = 1,m
                               c(i,j) = beta*c(i,j)
       220                 continue
                       end if
                       do 240 l = 1,k
                           temp = alpha*b(j,l)
                           do 230 i = 1,m
                               c(i,j) = c(i,j) + temp*a(i,l)
       230                 continue
       240             continue
       250         continue
               end if
           else if (conja) then
               if (conjb) then
     
                 ! form  c := alpha*a**h*b**h + beta*c.
     
                   do 280 j = 1,n
                       do 270 i = 1,m
                           temp = zero
                           do 260 l = 1,k
                               temp = temp + conjg(a(l,i))*conjg(b(j,l))
       260                 continue
                           if (beta==zero) then
                               c(i,j) = alpha*temp
                           else
                               c(i,j) = alpha*temp + beta*c(i,j)
                           end if
       270             continue
       280         continue
               else
     
                 ! form  c := alpha*a**h*b**t + beta*c
     
                   do 310 j = 1,n
                       do 300 i = 1,m
                           temp = zero
                           do 290 l = 1,k
                               temp = temp + conjg(a(l,i))*b(j,l)
       290                 continue
                           if (beta==zero) then
                               c(i,j) = alpha*temp
                           else
                               c(i,j) = alpha*temp + beta*c(i,j)
                           end if
       300             continue
       310         continue
               end if
           else
               if (conjb) then
     
                 ! form  c := alpha*a**t*b**h + beta*c
     
                   do 340 j = 1,n
                       do 330 i = 1,m
                           temp = zero
                           do 320 l = 1,k
                               temp = temp + a(l,i)*conjg(b(j,l))
       320                 continue
                           if (beta==zero) then
                               c(i,j) = alpha*temp
                           else
                               c(i,j) = alpha*temp + beta*c(i,j)
                           end if
       330             continue
       340         continue
               else
     
                 ! form  c := alpha*a**t*b**t + beta*c
     
                   do 370 j = 1,n
                       do 360 i = 1,m
                           temp = zero
                           do 350 l = 1,k
                               temp = temp + a(l,i)*b(j,l)
       350                 continue
                           if (beta==zero) then
                               c(i,j) = alpha*temp
                           else
                               c(i,j) = alpha*temp + beta*c(i,j)
                           end if
       360             continue
       370         continue
               end if
           end if
     
           return
     
           ! end of stdlib_cgemm
     
     end subroutine stdlib_cgemm
     
     
     ! CGEMV performs one of the matrix-vector operations
     ! y := alpha*A*x + beta*y,   or   y := alpha*A**T*x + beta*y,   or
     ! y := alpha*A**H*x + beta*y,
     ! where alpha and beta are scalars, x and y are vectors and A is an
     ! m by n matrix.
     subroutine stdlib_cgemv(trans,m,n,alpha,a,lda,x,incx,beta,y,incy)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           complex(sp) alpha,beta
           integer(int32) incx,incy,lda,m,n
           character trans
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),x(*),y(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           complex(sp) one
           parameter (one= (1.0_sp,0.0_sp))
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
           ! .. local scalars ..
           complex(sp) temp
           integer(int32) i,info,ix,iy,j,jx,jy,kx,ky,lenx,leny
           logical(lk) noconj
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg,max
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(trans,'n') .and. .not.stdlib_lsame(trans,'t') &
                     .and..not.stdlib_lsame(trans,'c')) then
               info = 1
           else if (m<0) then
               info = 2
           else if (n<0) then
               info = 3
           else if (lda<max(1,m)) then
               info = 6
           else if (incx==0) then
               info = 8
           else if (incy==0) then
               info = 11
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_cgemv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((m==0) .or. (n==0) .or.((alpha==zero).and. (beta==one))) return
     
           noconj = stdlib_lsame(trans,'t')
     
           ! set  lenx  and  leny, the lengths of the vectors x and y, and set
           ! up the start points in  x  and  y.
     
           if (stdlib_lsame(trans,'n')) then
               lenx = n
               leny = m
           else
               lenx = m
               leny = n
           end if
           if (incx>0) then
               kx = 1
           else
               kx = 1 - (lenx-1)*incx
           end if
           if (incy>0) then
               ky = 1
           else
               ky = 1 - (leny-1)*incy
           end if
     
           ! start the operations. in this version the elements of a are
           ! accessed sequentially with one pass through a.
     
           ! first form  y := beta*y.
     
           if (beta/=one) then
               if (incy==1) then
                   if (beta==zero) then
                       do 10 i = 1,leny
                           y(i) = zero
        10             continue
                   else
                       do 20 i = 1,leny
                           y(i) = beta*y(i)
        20             continue
                   end if
               else
                   iy = ky
                   if (beta==zero) then
                       do 30 i = 1,leny
                           y(iy) = zero
                           iy = iy + incy
        30             continue
                   else
                       do 40 i = 1,leny
                           y(iy) = beta*y(iy)
                           iy = iy + incy
        40             continue
                   end if
               end if
           end if
           if (alpha==zero) return
           if (stdlib_lsame(trans,'n')) then
     
              ! form  y := alpha*a*x + y.
     
               jx = kx
               if (incy==1) then
                   do 60 j = 1,n
                       temp = alpha*x(jx)
                       do 50 i = 1,m
                           y(i) = y(i) + temp*a(i,j)
        50             continue
                       jx = jx + incx
        60         continue
               else
                   do 80 j = 1,n
                       temp = alpha*x(jx)
                       iy = ky
                       do 70 i = 1,m
                           y(iy) = y(iy) + temp*a(i,j)
                           iy = iy + incy
        70             continue
                       jx = jx + incx
        80         continue
               end if
           else
     
              ! form  y := alpha*a**t*x + y  or  y := alpha*a**h*x + y.
     
               jy = ky
               if (incx==1) then
                   do 110 j = 1,n
                       temp = zero
                       if (noconj) then
                           do 90 i = 1,m
                               temp = temp + a(i,j)*x(i)
        90                 continue
                       else
                           do 100 i = 1,m
                               temp = temp + conjg(a(i,j))*x(i)
       100                 continue
                       end if
                       y(jy) = y(jy) + alpha*temp
                       jy = jy + incy
       110         continue
               else
                   do 140 j = 1,n
                       temp = zero
                       ix = kx
                       if (noconj) then
                           do 120 i = 1,m
                               temp = temp + a(i,j)*x(ix)
                               ix = ix + incx
       120                 continue
                       else
                           do 130 i = 1,m
                               temp = temp + conjg(a(i,j))*x(ix)
                               ix = ix + incx
       130                 continue
                       end if
                       y(jy) = y(jy) + alpha*temp
                       jy = jy + incy
       140         continue
               end if
           end if
     
           return
     
           ! end of stdlib_cgemv
     
     end subroutine stdlib_cgemv
     
     
     ! CGERC  performs the rank 1 operation
     ! A := alpha*x*y**H + A,
     ! where alpha is a scalar, x is an m element vector, y is an n element
     ! vector and A is an m by n matrix.
     subroutine stdlib_cgerc(m,n,alpha,x,incx,y,incy,a,lda)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           complex(sp) alpha
           integer(int32) incx,incy,lda,m,n
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),x(*),y(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
           ! .. local scalars ..
           complex(sp) temp
           integer(int32) i,info,ix,j,jy,kx
           ! ..
     
           ! .. intrinsic functions ..
           intrinsic conjg,max
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (m<0) then
               info = 1
           else if (n<0) then
               info = 2
           else if (incx==0) then
               info = 5
           else if (incy==0) then
               info = 7
           else if (lda<max(1,m)) then
               info = 9
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_cgerc ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((m==0) .or. (n==0) .or. (alpha==zero)) return
     
           ! start the operations. in this version the elements of a are
           ! accessed sequentially with one pass through a.
     
           if (incy>0) then
               jy = 1
           else
               jy = 1 - (n-1)*incy
           end if
           if (incx==1) then
               do 20 j = 1,n
                   if (y(jy)/=zero) then
                       temp = alpha*conjg(y(jy))
                       do 10 i = 1,m
                           a(i,j) = a(i,j) + x(i)*temp
        10             continue
                   end if
                   jy = jy + incy
        20     continue
           else
               if (incx>0) then
                   kx = 1
               else
                   kx = 1 - (m-1)*incx
               end if
               do 40 j = 1,n
                   if (y(jy)/=zero) then
                       temp = alpha*conjg(y(jy))
                       ix = kx
                       do 30 i = 1,m
                           a(i,j) = a(i,j) + x(ix)*temp
                           ix = ix + incx
        30             continue
                   end if
                   jy = jy + incy
        40     continue
           end if
     
           return
     
           ! end of stdlib_cgerc
     
     end subroutine stdlib_cgerc
     
     
     ! CGERU  performs the rank 1 operation
     ! A := alpha*x*y**T + A,
     ! where alpha is a scalar, x is an m element vector, y is an n element
     ! vector and A is an m by n matrix.
     subroutine stdlib_cgeru(m,n,alpha,x,incx,y,incy,a,lda)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           complex(sp) alpha
           integer(int32) incx,incy,lda,m,n
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),x(*),y(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
           ! .. local scalars ..
           complex(sp) temp
           integer(int32) i,info,ix,j,jy,kx
           ! ..
     
           ! .. intrinsic functions ..
           intrinsic max
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (m<0) then
               info = 1
           else if (n<0) then
               info = 2
           else if (incx==0) then
               info = 5
           else if (incy==0) then
               info = 7
           else if (lda<max(1,m)) then
               info = 9
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_cgeru ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((m==0) .or. (n==0) .or. (alpha==zero)) return
     
           ! start the operations. in this version the elements of a are
           ! accessed sequentially with one pass through a.
     
           if (incy>0) then
               jy = 1
           else
               jy = 1 - (n-1)*incy
           end if
           if (incx==1) then
               do 20 j = 1,n
                   if (y(jy)/=zero) then
                       temp = alpha*y(jy)
                       do 10 i = 1,m
                           a(i,j) = a(i,j) + x(i)*temp
        10             continue
                   end if
                   jy = jy + incy
        20     continue
           else
               if (incx>0) then
                   kx = 1
               else
                   kx = 1 - (m-1)*incx
               end if
               do 40 j = 1,n
                   if (y(jy)/=zero) then
                       temp = alpha*y(jy)
                       ix = kx
                       do 30 i = 1,m
                           a(i,j) = a(i,j) + x(ix)*temp
                           ix = ix + incx
        30             continue
                   end if
                   jy = jy + incy
        40     continue
           end if
     
           return
     
           ! end of stdlib_cgeru
     
     end subroutine stdlib_cgeru
     
     
     ! CHBMV  performs the matrix-vector  operation
     ! y := alpha*A*x + beta*y,
     ! where alpha and beta are scalars, x and y are n element vectors and
     ! A is an n by n hermitian band matrix, with k super-diagonals.
     subroutine stdlib_chbmv(uplo,n,k,alpha,a,lda,x,incx,beta,y,incy)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           complex(sp) alpha,beta
           integer(int32) incx,incy,k,lda,n
           character uplo
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),x(*),y(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           complex(sp) one
           parameter (one= (1.0_sp,0.0_sp))
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
           ! .. local scalars ..
           complex(sp) temp1,temp2
           integer(int32) i,info,ix,iy,j,jx,jy,kplus1,kx,ky,l
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg,max,min,real
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (n<0) then
               info = 2
           else if (k<0) then
               info = 3
           else if (lda< (k+1)) then
               info = 6
           else if (incx==0) then
               info = 8
           else if (incy==0) then
               info = 11
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_chbmv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. ((alpha==zero).and. (beta==one))) return
     
           ! set up the start points in  x  and  y.
     
           if (incx>0) then
               kx = 1
           else
               kx = 1 - (n-1)*incx
           end if
           if (incy>0) then
               ky = 1
           else
               ky = 1 - (n-1)*incy
           end if
     
           ! start the operations. in this version the elements of the array a
           ! are accessed sequentially with one pass through a.
     
           ! first form  y := beta*y.
     
           if (beta/=one) then
               if (incy==1) then
                   if (beta==zero) then
                       do 10 i = 1,n
                           y(i) = zero
        10             continue
                   else
                       do 20 i = 1,n
                           y(i) = beta*y(i)
        20             continue
                   end if
               else
                   iy = ky
                   if (beta==zero) then
                       do 30 i = 1,n
                           y(iy) = zero
                           iy = iy + incy
        30             continue
                   else
                       do 40 i = 1,n
                           y(iy) = beta*y(iy)
                           iy = iy + incy
        40             continue
                   end if
               end if
           end if
           if (alpha==zero) return
           if (stdlib_lsame(uplo,'u')) then
     
              ! form  y  when upper triangle of a is stored.
     
               kplus1 = k + 1
               if ((incx==1) .and. (incy==1)) then
                   do 60 j = 1,n
                       temp1 = alpha*x(j)
                       temp2 = zero
                       l = kplus1 - j
                       do 50 i = max(1,j-k),j - 1
                           y(i) = y(i) + temp1*a(l+i,j)
                           temp2 = temp2 + conjg(a(l+i,j))*x(i)
        50             continue
                       y(j) = y(j) + temp1*real(a(kplus1,j)) + alpha*temp2
        60         continue
               else
                   jx = kx
                   jy = ky
                   do 80 j = 1,n
                       temp1 = alpha*x(jx)
                       temp2 = zero
                       ix = kx
                       iy = ky
                       l = kplus1 - j
                       do 70 i = max(1,j-k),j - 1
                           y(iy) = y(iy) + temp1*a(l+i,j)
                           temp2 = temp2 + conjg(a(l+i,j))*x(ix)
                           ix = ix + incx
                           iy = iy + incy
        70             continue
                       y(jy) = y(jy) + temp1*real(a(kplus1,j)) + alpha*temp2
                       jx = jx + incx
                       jy = jy + incy
                       if (j>k) then
                           kx = kx + incx
                           ky = ky + incy
                       end if
        80         continue
               end if
           else
     
              ! form  y  when lower triangle of a is stored.
     
               if ((incx==1) .and. (incy==1)) then
                   do 100 j = 1,n
                       temp1 = alpha*x(j)
                       temp2 = zero
                       y(j) = y(j) + temp1*real(a(1,j))
                       l = 1 - j
                       do 90 i = j + 1,min(n,j+k)
                           y(i) = y(i) + temp1*a(l+i,j)
                           temp2 = temp2 + conjg(a(l+i,j))*x(i)
        90             continue
                       y(j) = y(j) + alpha*temp2
       100         continue
               else
                   jx = kx
                   jy = ky
                   do 120 j = 1,n
                       temp1 = alpha*x(jx)
                       temp2 = zero
                       y(jy) = y(jy) + temp1*real(a(1,j))
                       l = 1 - j
                       ix = jx
                       iy = jy
                       do 110 i = j + 1,min(n,j+k)
                           ix = ix + incx
                           iy = iy + incy
                           y(iy) = y(iy) + temp1*a(l+i,j)
                           temp2 = temp2 + conjg(a(l+i,j))*x(ix)
       110             continue
                       y(jy) = y(jy) + alpha*temp2
                       jx = jx + incx
                       jy = jy + incy
       120         continue
               end if
           end if
     
           return
     
           ! end of stdlib_chbmv
     
     end subroutine stdlib_chbmv
     
     
     ! CHEMM  performs one of the matrix-matrix operations
     ! C := alpha*A*B + beta*C,
     ! or
     ! C := alpha*B*A + beta*C,
     ! where alpha and beta are scalars, A is an hermitian matrix and  B and
     ! C are m by n matrices.
     subroutine stdlib_chemm(side,uplo,m,n,alpha,a,lda,b,ldb,beta,c,ldc)
     
        ! -- reference blas level3 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           complex(sp) alpha,beta
           integer(int32) lda,ldb,ldc,m,n
           character side,uplo
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),b(ldb,*),c(ldc,*)
           ! ..
     
        ! =====================================================================
     
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg,max,real
           ! ..
           ! .. local scalars ..
           complex(sp) temp1,temp2
           integer(int32) i,info,j,k,nrowa
           logical(lk) upper
           ! ..
           ! .. parameters ..
           complex(sp) one
           parameter (one= (1.0_sp,0.0_sp))
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
     
           ! set nrowa as the number of rows of a.
     
           if (stdlib_lsame(side,'l')) then
               nrowa = m
           else
               nrowa = n
           end if
           upper = stdlib_lsame(uplo,'u')
     
           ! test the input parameters.
     
           info = 0
           if ((.not.stdlib_lsame(side,'l')) .and. (.not.stdlib_lsame(side,'r'))) then
               info = 1
           else if ((.not.upper) .and. (.not.stdlib_lsame(uplo,'l'))) then
               info = 2
           else if (m<0) then
               info = 3
           else if (n<0) then
               info = 4
           else if (lda<max(1,nrowa)) then
               info = 7
           else if (ldb<max(1,m)) then
               info = 9
           else if (ldc<max(1,m)) then
               info = 12
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_chemm ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((m==0) .or. (n==0) .or.((alpha==zero).and. (beta==one))) return
     
           ! and when  alpha.eq.zero.
     
           if (alpha==zero) then
               if (beta==zero) then
                   do 20 j = 1,n
                       do 10 i = 1,m
                           c(i,j) = zero
        10             continue
        20         continue
               else
                   do 40 j = 1,n
                       do 30 i = 1,m
                           c(i,j) = beta*c(i,j)
        30             continue
        40         continue
               end if
               return
           end if
     
           ! start the operations.
     
           if (stdlib_lsame(side,'l')) then
     
              ! form  c := alpha*a*b + beta*c.
     
               if (upper) then
                   do 70 j = 1,n
                       do 60 i = 1,m
                           temp1 = alpha*b(i,j)
                           temp2 = zero
                           do 50 k = 1,i - 1
                               c(k,j) = c(k,j) + temp1*a(k,i)
                               temp2 = temp2 + b(k,j)*conjg(a(k,i))
        50                 continue
                           if (beta==zero) then
                               c(i,j) = temp1*real(a(i,i)) + alpha*temp2
                           else
                               c(i,j) = beta*c(i,j) + temp1*real(a(i,i)) +alpha*temp2
                           end if
        60             continue
        70         continue
               else
                   do 100 j = 1,n
                       do 90 i = m,1,-1
                           temp1 = alpha*b(i,j)
                           temp2 = zero
                           do 80 k = i + 1,m
                               c(k,j) = c(k,j) + temp1*a(k,i)
                               temp2 = temp2 + b(k,j)*conjg(a(k,i))
        80                 continue
                           if (beta==zero) then
                               c(i,j) = temp1*real(a(i,i)) + alpha*temp2
                           else
                               c(i,j) = beta*c(i,j) + temp1*real(a(i,i)) +alpha*temp2
                           end if
        90             continue
       100         continue
               end if
           else
     
              ! form  c := alpha*b*a + beta*c.
     
               do 170 j = 1,n
                   temp1 = alpha*real(a(j,j))
                   if (beta==zero) then
                       do 110 i = 1,m
                           c(i,j) = temp1*b(i,j)
       110             continue
                   else
                       do 120 i = 1,m
                           c(i,j) = beta*c(i,j) + temp1*b(i,j)
       120             continue
                   end if
                   do 140 k = 1,j - 1
                       if (upper) then
                           temp1 = alpha*a(k,j)
                       else
                           temp1 = alpha*conjg(a(j,k))
                       end if
                       do 130 i = 1,m
                           c(i,j) = c(i,j) + temp1*b(i,k)
       130             continue
       140         continue
                   do 160 k = j + 1,n
                       if (upper) then
                           temp1 = alpha*conjg(a(j,k))
                       else
                           temp1 = alpha*a(k,j)
                       end if
                       do 150 i = 1,m
                           c(i,j) = c(i,j) + temp1*b(i,k)
       150             continue
       160         continue
       170     continue
           end if
     
           return
     
           ! end of stdlib_chemm
     
     end subroutine stdlib_chemm
     
     
     ! CHEMV  performs the matrix-vector  operation
     ! y := alpha*A*x + beta*y,
     ! where alpha and beta are scalars, x and y are n element vectors and
     ! A is an n by n hermitian matrix.
     subroutine stdlib_chemv(uplo,n,alpha,a,lda,x,incx,beta,y,incy)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           complex(sp) alpha,beta
           integer(int32) incx,incy,lda,n
           character uplo
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),x(*),y(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           complex(sp) one
           parameter (one= (1.0_sp,0.0_sp))
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
           ! .. local scalars ..
           complex(sp) temp1,temp2
           integer(int32) i,info,ix,iy,j,jx,jy,kx,ky
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg,max,real
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (n<0) then
               info = 2
           else if (lda<max(1,n)) then
               info = 5
           else if (incx==0) then
               info = 7
           else if (incy==0) then
               info = 10
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_chemv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. ((alpha==zero).and. (beta==one))) return
     
           ! set up the start points in  x  and  y.
     
           if (incx>0) then
               kx = 1
           else
               kx = 1 - (n-1)*incx
           end if
           if (incy>0) then
               ky = 1
           else
               ky = 1 - (n-1)*incy
           end if
     
           ! start the operations. in this version the elements of a are
           ! accessed sequentially with one pass through the triangular part
           ! of a.
     
           ! first form  y := beta*y.
     
           if (beta/=one) then
               if (incy==1) then
                   if (beta==zero) then
                       do 10 i = 1,n
                           y(i) = zero
        10             continue
                   else
                       do 20 i = 1,n
                           y(i) = beta*y(i)
        20             continue
                   end if
               else
                   iy = ky
                   if (beta==zero) then
                       do 30 i = 1,n
                           y(iy) = zero
                           iy = iy + incy
        30             continue
                   else
                       do 40 i = 1,n
                           y(iy) = beta*y(iy)
                           iy = iy + incy
        40             continue
                   end if
               end if
           end if
           if (alpha==zero) return
           if (stdlib_lsame(uplo,'u')) then
     
              ! form  y  when a is stored in upper triangle.
     
               if ((incx==1) .and. (incy==1)) then
                   do 60 j = 1,n
                       temp1 = alpha*x(j)
                       temp2 = zero
                       do 50 i = 1,j - 1
                           y(i) = y(i) + temp1*a(i,j)
                           temp2 = temp2 + conjg(a(i,j))*x(i)
        50             continue
                       y(j) = y(j) + temp1*real(a(j,j)) + alpha*temp2
        60         continue
               else
                   jx = kx
                   jy = ky
                   do 80 j = 1,n
                       temp1 = alpha*x(jx)
                       temp2 = zero
                       ix = kx
                       iy = ky
                       do 70 i = 1,j - 1
                           y(iy) = y(iy) + temp1*a(i,j)
                           temp2 = temp2 + conjg(a(i,j))*x(ix)
                           ix = ix + incx
                           iy = iy + incy
        70             continue
                       y(jy) = y(jy) + temp1*real(a(j,j)) + alpha*temp2
                       jx = jx + incx
                       jy = jy + incy
        80         continue
               end if
           else
     
              ! form  y  when a is stored in lower triangle.
     
               if ((incx==1) .and. (incy==1)) then
                   do 100 j = 1,n
                       temp1 = alpha*x(j)
                       temp2 = zero
                       y(j) = y(j) + temp1*real(a(j,j))
                       do 90 i = j + 1,n
                           y(i) = y(i) + temp1*a(i,j)
                           temp2 = temp2 + conjg(a(i,j))*x(i)
        90             continue
                       y(j) = y(j) + alpha*temp2
       100         continue
               else
                   jx = kx
                   jy = ky
                   do 120 j = 1,n
                       temp1 = alpha*x(jx)
                       temp2 = zero
                       y(jy) = y(jy) + temp1*real(a(j,j))
                       ix = jx
                       iy = jy
                       do 110 i = j + 1,n
                           ix = ix + incx
                           iy = iy + incy
                           y(iy) = y(iy) + temp1*a(i,j)
                           temp2 = temp2 + conjg(a(i,j))*x(ix)
       110             continue
                       y(jy) = y(jy) + alpha*temp2
                       jx = jx + incx
                       jy = jy + incy
       120         continue
               end if
           end if
     
           return
     
           ! end of stdlib_chemv
     
     end subroutine stdlib_chemv
     
     
     ! CHER   performs the hermitian rank 1 operation
     ! A := alpha*x*x**H + A,
     ! where alpha is a real scalar, x is an n element vector and A is an
     ! n by n hermitian matrix.
     subroutine stdlib_cher(uplo,n,alpha,x,incx,a,lda)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(sp) alpha
           integer(int32) incx,lda,n
           character uplo
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),x(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
           ! .. local scalars ..
           complex(sp) temp
           integer(int32) i,info,ix,j,jx,kx
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg,max,real
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (n<0) then
               info = 2
           else if (incx==0) then
               info = 5
           else if (lda<max(1,n)) then
               info = 7
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_cher  ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. (alpha==real(zero))) return
     
           ! set the start point in x if the increment is not unity.
     
           if (incx<=0) then
               kx = 1 - (n-1)*incx
           else if (incx/=1) then
               kx = 1
           end if
     
           ! start the operations. in this version the elements of a are
           ! accessed sequentially with one pass through the triangular part
           ! of a.
     
           if (stdlib_lsame(uplo,'u')) then
     
              ! form  a  when a is stored in upper triangle.
     
               if (incx==1) then
                   do 20 j = 1,n
                       if (x(j)/=zero) then
                           temp = alpha*conjg(x(j))
                           do 10 i = 1,j - 1
                               a(i,j) = a(i,j) + x(i)*temp
        10                 continue
                           a(j,j) = real(a(j,j)) + real(x(j)*temp)
                       else
                           a(j,j) = real(a(j,j))
                       end if
        20         continue
               else
                   jx = kx
                   do 40 j = 1,n
                       if (x(jx)/=zero) then
                           temp = alpha*conjg(x(jx))
                           ix = kx
                           do 30 i = 1,j - 1
                               a(i,j) = a(i,j) + x(ix)*temp
                               ix = ix + incx
        30                 continue
                           a(j,j) = real(a(j,j)) + real(x(jx)*temp)
                       else
                           a(j,j) = real(a(j,j))
                       end if
                       jx = jx + incx
        40         continue
               end if
           else
     
              ! form  a  when a is stored in lower triangle.
     
               if (incx==1) then
                   do 60 j = 1,n
                       if (x(j)/=zero) then
                           temp = alpha*conjg(x(j))
                           a(j,j) = real(a(j,j)) + real(temp*x(j))
                           do 50 i = j + 1,n
                               a(i,j) = a(i,j) + x(i)*temp
        50                 continue
                       else
                           a(j,j) = real(a(j,j))
                       end if
        60         continue
               else
                   jx = kx
                   do 80 j = 1,n
                       if (x(jx)/=zero) then
                           temp = alpha*conjg(x(jx))
                           a(j,j) = real(a(j,j)) + real(temp*x(jx))
                           ix = jx
                           do 70 i = j + 1,n
                               ix = ix + incx
                               a(i,j) = a(i,j) + x(ix)*temp
        70                 continue
                       else
                           a(j,j) = real(a(j,j))
                       end if
                       jx = jx + incx
        80         continue
               end if
           end if
     
           return
     
           ! end of stdlib_cher
     
     end subroutine stdlib_cher
     
     
     ! CHER2  performs the hermitian rank 2 operation
     ! A := alpha*x*y**H + conjg( alpha )*y*x**H + A,
     ! where alpha is a scalar, x and y are n element vectors and A is an n
     ! by n hermitian matrix.
     subroutine stdlib_cher2(uplo,n,alpha,x,incx,y,incy,a,lda)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           complex(sp) alpha
           integer(int32) incx,incy,lda,n
           character uplo
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),x(*),y(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
           ! .. local scalars ..
           complex(sp) temp1,temp2
           integer(int32) i,info,ix,iy,j,jx,jy,kx,ky
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg,max,real
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (n<0) then
               info = 2
           else if (incx==0) then
               info = 5
           else if (incy==0) then
               info = 7
           else if (lda<max(1,n)) then
               info = 9
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_cher2 ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. (alpha==zero)) return
     
           ! set up the start points in x and y if the increments are not both
           ! unity.
     
           if ((incx/=1) .or. (incy/=1)) then
               if (incx>0) then
                   kx = 1
               else
                   kx = 1 - (n-1)*incx
               end if
               if (incy>0) then
                   ky = 1
               else
                   ky = 1 - (n-1)*incy
               end if
               jx = kx
               jy = ky
           end if
     
           ! start the operations. in this version the elements of a are
           ! accessed sequentially with one pass through the triangular part
           ! of a.
     
           if (stdlib_lsame(uplo,'u')) then
     
              ! form  a  when a is stored in the upper triangle.
     
               if ((incx==1) .and. (incy==1)) then
                   do 20 j = 1,n
                       if ((x(j)/=zero) .or. (y(j)/=zero)) then
                           temp1 = alpha*conjg(y(j))
                           temp2 = conjg(alpha*x(j))
                           do 10 i = 1,j - 1
                               a(i,j) = a(i,j) + x(i)*temp1 + y(i)*temp2
        10                 continue
                           a(j,j) = real(a(j,j)) +real(x(j)*temp1+y(j)*temp2)
                       else
                           a(j,j) = real(a(j,j))
                       end if
        20         continue
               else
                   do 40 j = 1,n
                       if ((x(jx)/=zero) .or. (y(jy)/=zero)) then
                           temp1 = alpha*conjg(y(jy))
                           temp2 = conjg(alpha*x(jx))
                           ix = kx
                           iy = ky
                           do 30 i = 1,j - 1
                               a(i,j) = a(i,j) + x(ix)*temp1 + y(iy)*temp2
                               ix = ix + incx
                               iy = iy + incy
        30                 continue
                           a(j,j) = real(a(j,j)) +real(x(jx)*temp1+y(jy)*temp2)
                       else
                           a(j,j) = real(a(j,j))
                       end if
                       jx = jx + incx
                       jy = jy + incy
        40         continue
               end if
           else
     
              ! form  a  when a is stored in the lower triangle.
     
               if ((incx==1) .and. (incy==1)) then
                   do 60 j = 1,n
                       if ((x(j)/=zero) .or. (y(j)/=zero)) then
                           temp1 = alpha*conjg(y(j))
                           temp2 = conjg(alpha*x(j))
                           a(j,j) = real(a(j,j)) +real(x(j)*temp1+y(j)*temp2)
                           do 50 i = j + 1,n
                               a(i,j) = a(i,j) + x(i)*temp1 + y(i)*temp2
        50                 continue
                       else
                           a(j,j) = real(a(j,j))
                       end if
        60         continue
               else
                   do 80 j = 1,n
                       if ((x(jx)/=zero) .or. (y(jy)/=zero)) then
                           temp1 = alpha*conjg(y(jy))
                           temp2 = conjg(alpha*x(jx))
                           a(j,j) = real(a(j,j)) +real(x(jx)*temp1+y(jy)*temp2)
                           ix = jx
                           iy = jy
                           do 70 i = j + 1,n
                               ix = ix + incx
                               iy = iy + incy
                               a(i,j) = a(i,j) + x(ix)*temp1 + y(iy)*temp2
        70                 continue
                       else
                           a(j,j) = real(a(j,j))
                       end if
                       jx = jx + incx
                       jy = jy + incy
        80         continue
               end if
           end if
     
           return
     
           ! end of stdlib_cher2
     
     end subroutine stdlib_cher2
     
     
     ! CHER2K  performs one of the hermitian rank 2k operations
     ! C := alpha*A*B**H + conjg( alpha )*B*A**H + beta*C,
     ! or
     ! C := alpha*A**H*B + conjg( alpha )*B**H*A + beta*C,
     ! where  alpha and beta  are scalars with  beta  real,  C is an  n by n
     ! hermitian matrix and  A and B  are  n by k matrices in the first case
     ! and  k by n  matrices in the second case.
     subroutine stdlib_cher2k(uplo,trans,n,k,alpha,a,lda,b,ldb,beta,c,ldc)
     
        ! -- reference blas level3 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           complex(sp) alpha
           real(sp) beta
           integer(int32) k,lda,ldb,ldc,n
           character trans,uplo
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),b(ldb,*),c(ldc,*)
           ! ..
     
        ! =====================================================================
     
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg,max,real
           ! ..
           ! .. local scalars ..
           complex(sp) temp1,temp2
           integer(int32) i,info,j,l,nrowa
           logical(lk) upper
           ! ..
           ! .. parameters ..
           real(sp) one
           parameter (one=1.0_sp)
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
     
           ! test the input parameters.
     
           if (stdlib_lsame(trans,'n')) then
               nrowa = n
           else
               nrowa = k
           end if
           upper = stdlib_lsame(uplo,'u')
     
           info = 0
           if ((.not.upper) .and. (.not.stdlib_lsame(uplo,'l'))) then
               info = 1
           else if ((.not.stdlib_lsame(trans,'n')) .and.(.not.stdlib_lsame(trans,'c'))) &
                     then
               info = 2
           else if (n<0) then
               info = 3
           else if (k<0) then
               info = 4
           else if (lda<max(1,nrowa)) then
               info = 7
           else if (ldb<max(1,nrowa)) then
               info = 9
           else if (ldc<max(1,n)) then
               info = 12
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_cher2k',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. (((alpha==zero).or.(k==0)).and. (beta==one))) return
     
           ! and when  alpha.eq.zero.
     
           if (alpha==zero) then
               if (upper) then
                   if (beta==real(zero)) then
                       do 20 j = 1,n
                           do 10 i = 1,j
                               c(i,j) = zero
        10                 continue
        20             continue
                   else
                       do 40 j = 1,n
                           do 30 i = 1,j - 1
                               c(i,j) = beta*c(i,j)
        30                 continue
                           c(j,j) = beta*real(c(j,j))
        40             continue
                   end if
               else
                   if (beta==real(zero)) then
                       do 60 j = 1,n
                           do 50 i = j,n
                               c(i,j) = zero
        50                 continue
        60             continue
                   else
                       do 80 j = 1,n
                           c(j,j) = beta*real(c(j,j))
                           do 70 i = j + 1,n
                               c(i,j) = beta*c(i,j)
        70                 continue
        80             continue
                   end if
               end if
               return
           end if
     
           ! start the operations.
     
           if (stdlib_lsame(trans,'n')) then
     
              ! form  c := alpha*a*b**h + conjg( alpha )*b*a**h +
                         ! c.
     
               if (upper) then
                   do 130 j = 1,n
                       if (beta==real(zero)) then
                           do 90 i = 1,j
                               c(i,j) = zero
        90                 continue
                       else if (beta/=one) then
                           do 100 i = 1,j - 1
                               c(i,j) = beta*c(i,j)
       100                 continue
                           c(j,j) = beta*real(c(j,j))
                       else
                           c(j,j) = real(c(j,j))
                       end if
                       do 120 l = 1,k
                           if ((a(j,l)/=zero) .or. (b(j,l)/=zero)) then
                               temp1 = alpha*conjg(b(j,l))
                               temp2 = conjg(alpha*a(j,l))
                               do 110 i = 1,j - 1
                                   c(i,j) = c(i,j) + a(i,l)*temp1 +b(i,l)*temp2
       110                     continue
                               c(j,j) = real(c(j,j)) +real(a(j,l)*temp1+b(j,l)*temp2)
                           end if
       120             continue
       130         continue
               else
                   do 180 j = 1,n
                       if (beta==real(zero)) then
                           do 140 i = j,n
                               c(i,j) = zero
       140                 continue
                       else if (beta/=one) then
                           do 150 i = j + 1,n
                               c(i,j) = beta*c(i,j)
       150                 continue
                           c(j,j) = beta*real(c(j,j))
                       else
                           c(j,j) = real(c(j,j))
                       end if
                       do 170 l = 1,k
                           if ((a(j,l)/=zero) .or. (b(j,l)/=zero)) then
                               temp1 = alpha*conjg(b(j,l))
                               temp2 = conjg(alpha*a(j,l))
                               do 160 i = j + 1,n
                                   c(i,j) = c(i,j) + a(i,l)*temp1 +b(i,l)*temp2
       160                     continue
                               c(j,j) = real(c(j,j)) +real(a(j,l)*temp1+b(j,l)*temp2)
                           end if
       170             continue
       180         continue
               end if
           else
     
              ! form  c := alpha*a**h*b + conjg( alpha )*b**h*a +
                         ! c.
     
               if (upper) then
                   do 210 j = 1,n
                       do 200 i = 1,j
                           temp1 = zero
                           temp2 = zero
                           do 190 l = 1,k
                               temp1 = temp1 + conjg(a(l,i))*b(l,j)
                               temp2 = temp2 + conjg(b(l,i))*a(l,j)
       190                 continue
                           if (i==j) then
                               if (beta==real(zero)) then
                                   c(j,j) = real(alpha*temp1+conjg(alpha)*temp2)
                               else
                                   c(j,j) = beta*real(c(j,j)) +real(alpha*temp1+conjg(alpha)&
                                             *temp2)
                               end if
                           else
                               if (beta==real(zero)) then
                                   c(i,j) = alpha*temp1 + conjg(alpha)*temp2
                               else
                                   c(i,j) = beta*c(i,j) + alpha*temp1 +conjg(alpha)*temp2
                               end if
                           end if
       200             continue
       210         continue
               else
                   do 240 j = 1,n
                       do 230 i = j,n
                           temp1 = zero
                           temp2 = zero
                           do 220 l = 1,k
                               temp1 = temp1 + conjg(a(l,i))*b(l,j)
                               temp2 = temp2 + conjg(b(l,i))*a(l,j)
       220                 continue
                           if (i==j) then
                               if (beta==real(zero)) then
                                   c(j,j) = real(alpha*temp1+conjg(alpha)*temp2)
                               else
                                   c(j,j) = beta*real(c(j,j)) +real(alpha*temp1+conjg(alpha)&
                                             *temp2)
                               end if
                           else
                               if (beta==real(zero)) then
                                   c(i,j) = alpha*temp1 + conjg(alpha)*temp2
                               else
                                   c(i,j) = beta*c(i,j) + alpha*temp1 +conjg(alpha)*temp2
                               end if
                           end if
       230             continue
       240         continue
               end if
           end if
     
           return
     
           ! end of stdlib_cher2k
     
     end subroutine stdlib_cher2k
     
     
     ! CHERK  performs one of the hermitian rank k operations
     ! C := alpha*A*A**H + beta*C,
     ! or
     ! C := alpha*A**H*A + beta*C,
     ! where  alpha and beta  are  real scalars,  C is an  n by n  hermitian
     ! matrix and  A  is an  n by k  matrix in the  first case and a  k by n
     ! matrix in the second case.
     subroutine stdlib_cherk(uplo,trans,n,k,alpha,a,lda,beta,c,ldc)
     
        ! -- reference blas level3 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(sp) alpha,beta
           integer(int32) k,lda,ldc,n
           character trans,uplo
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),c(ldc,*)
           ! ..
     
        ! =====================================================================
     
     
     
     
           ! .. intrinsic functions ..
           intrinsic cmplx,conjg,max,real
           ! ..
           ! .. local scalars ..
           complex(sp) temp
           real(sp) rtemp
           integer(int32) i,info,j,l,nrowa
           logical(lk) upper
           ! ..
           ! .. parameters ..
           real(sp) one,zero
           parameter (one=1.0_sp,zero=0.0_sp)
           ! ..
     
           ! test the input parameters.
     
           if (stdlib_lsame(trans,'n')) then
               nrowa = n
           else
               nrowa = k
           end if
           upper = stdlib_lsame(uplo,'u')
     
           info = 0
           if ((.not.upper) .and. (.not.stdlib_lsame(uplo,'l'))) then
               info = 1
           else if ((.not.stdlib_lsame(trans,'n')) .and.(.not.stdlib_lsame(trans,'c'))) &
                     then
               info = 2
           else if (n<0) then
               info = 3
           else if (k<0) then
               info = 4
           else if (lda<max(1,nrowa)) then
               info = 7
           else if (ldc<max(1,n)) then
               info = 10
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_cherk ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. (((alpha==zero).or.(k==0)).and. (beta==one))) return
     
           ! and when  alpha.eq.zero.
     
           if (alpha==zero) then
               if (upper) then
                   if (beta==zero) then
                       do 20 j = 1,n
                           do 10 i = 1,j
                               c(i,j) = zero
        10                 continue
        20             continue
                   else
                       do 40 j = 1,n
                           do 30 i = 1,j - 1
                               c(i,j) = beta*c(i,j)
        30                 continue
                           c(j,j) = beta*real(c(j,j))
        40             continue
                   end if
               else
                   if (beta==zero) then
                       do 60 j = 1,n
                           do 50 i = j,n
                               c(i,j) = zero
        50                 continue
        60             continue
                   else
                       do 80 j = 1,n
                           c(j,j) = beta*real(c(j,j))
                           do 70 i = j + 1,n
                               c(i,j) = beta*c(i,j)
        70                 continue
        80             continue
                   end if
               end if
               return
           end if
     
           ! start the operations.
     
           if (stdlib_lsame(trans,'n')) then
     
              ! form  c := alpha*a*a**h + beta*c.
     
               if (upper) then
                   do 130 j = 1,n
                       if (beta==zero) then
                           do 90 i = 1,j
                               c(i,j) = zero
        90                 continue
                       else if (beta/=one) then
                           do 100 i = 1,j - 1
                               c(i,j) = beta*c(i,j)
       100                 continue
                           c(j,j) = beta*real(c(j,j))
                       else
                           c(j,j) = real(c(j,j))
                       end if
                       do 120 l = 1,k
                           if (a(j,l)/=cmplx(zero)) then
                               temp = alpha*conjg(a(j,l))
                               do 110 i = 1,j - 1
                                   c(i,j) = c(i,j) + temp*a(i,l)
       110                     continue
                               c(j,j) = real(c(j,j)) + real(temp*a(i,l))
                           end if
       120             continue
       130         continue
               else
                   do 180 j = 1,n
                       if (beta==zero) then
                           do 140 i = j,n
                               c(i,j) = zero
       140                 continue
                       else if (beta/=one) then
                           c(j,j) = beta*real(c(j,j))
                           do 150 i = j + 1,n
                               c(i,j) = beta*c(i,j)
       150                 continue
                       else
                           c(j,j) = real(c(j,j))
                       end if
                       do 170 l = 1,k
                           if (a(j,l)/=cmplx(zero)) then
                               temp = alpha*conjg(a(j,l))
                               c(j,j) = real(c(j,j)) + real(temp*a(j,l))
                               do 160 i = j + 1,n
                                   c(i,j) = c(i,j) + temp*a(i,l)
       160                     continue
                           end if
       170             continue
       180         continue
               end if
           else
     
              ! form  c := alpha*a**h*a + beta*c.
     
               if (upper) then
                   do 220 j = 1,n
                       do 200 i = 1,j - 1
                           temp = zero
                           do 190 l = 1,k
                               temp = temp + conjg(a(l,i))*a(l,j)
       190                 continue
                           if (beta==zero) then
                               c(i,j) = alpha*temp
                           else
                               c(i,j) = alpha*temp + beta*c(i,j)
                           end if
       200             continue
                       rtemp = zero
                       do 210 l = 1,k
                           rtemp = rtemp + conjg(a(l,j))*a(l,j)
       210             continue
                       if (beta==zero) then
                           c(j,j) = alpha*rtemp
                       else
                           c(j,j) = alpha*rtemp + beta*real(c(j,j))
                       end if
       220         continue
               else
                   do 260 j = 1,n
                       rtemp = zero
                       do 230 l = 1,k
                           rtemp = rtemp + conjg(a(l,j))*a(l,j)
       230             continue
                       if (beta==zero) then
                           c(j,j) = alpha*rtemp
                       else
                           c(j,j) = alpha*rtemp + beta*real(c(j,j))
                       end if
                       do 250 i = j + 1,n
                           temp = zero
                           do 240 l = 1,k
                               temp = temp + conjg(a(l,i))*a(l,j)
       240                 continue
                           if (beta==zero) then
                               c(i,j) = alpha*temp
                           else
                               c(i,j) = alpha*temp + beta*c(i,j)
                           end if
       250             continue
       260         continue
               end if
           end if
     
           return
     
           ! end of stdlib_cherk
     
     end subroutine stdlib_cherk
     
     
     ! CHPMV  performs the matrix-vector operation
     ! y := alpha*A*x + beta*y,
     ! where alpha and beta are scalars, x and y are n element vectors and
     ! A is an n by n hermitian matrix, supplied in packed form.
     subroutine stdlib_chpmv(uplo,n,alpha,ap,x,incx,beta,y,incy)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           complex(sp) alpha,beta
           integer(int32) incx,incy,n
           character uplo
           ! ..
           ! .. array arguments ..
           complex(sp) ap(*),x(*),y(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           complex(sp) one
           parameter (one= (1.0_sp,0.0_sp))
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
           ! .. local scalars ..
           complex(sp) temp1,temp2
           integer(int32) i,info,ix,iy,j,jx,jy,k,kk,kx,ky
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg,real
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (n<0) then
               info = 2
           else if (incx==0) then
               info = 6
           else if (incy==0) then
               info = 9
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_chpmv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. ((alpha==zero).and. (beta==one))) return
     
           ! set up the start points in  x  and  y.
     
           if (incx>0) then
               kx = 1
           else
               kx = 1 - (n-1)*incx
           end if
           if (incy>0) then
               ky = 1
           else
               ky = 1 - (n-1)*incy
           end if
     
           ! start the operations. in this version the elements of the array ap
           ! are accessed sequentially with one pass through ap.
     
           ! first form  y := beta*y.
     
           if (beta/=one) then
               if (incy==1) then
                   if (beta==zero) then
                       do 10 i = 1,n
                           y(i) = zero
        10             continue
                   else
                       do 20 i = 1,n
                           y(i) = beta*y(i)
        20             continue
                   end if
               else
                   iy = ky
                   if (beta==zero) then
                       do 30 i = 1,n
                           y(iy) = zero
                           iy = iy + incy
        30             continue
                   else
                       do 40 i = 1,n
                           y(iy) = beta*y(iy)
                           iy = iy + incy
        40             continue
                   end if
               end if
           end if
           if (alpha==zero) return
           kk = 1
           if (stdlib_lsame(uplo,'u')) then
     
              ! form  y  when ap contains the upper triangle.
     
               if ((incx==1) .and. (incy==1)) then
                   do 60 j = 1,n
                       temp1 = alpha*x(j)
                       temp2 = zero
                       k = kk
                       do 50 i = 1,j - 1
                           y(i) = y(i) + temp1*ap(k)
                           temp2 = temp2 + conjg(ap(k))*x(i)
                           k = k + 1
        50             continue
                       y(j) = y(j) + temp1*real(ap(kk+j-1)) + alpha*temp2
                       kk = kk + j
        60         continue
               else
                   jx = kx
                   jy = ky
                   do 80 j = 1,n
                       temp1 = alpha*x(jx)
                       temp2 = zero
                       ix = kx
                       iy = ky
                       do 70 k = kk,kk + j - 2
                           y(iy) = y(iy) + temp1*ap(k)
                           temp2 = temp2 + conjg(ap(k))*x(ix)
                           ix = ix + incx
                           iy = iy + incy
        70             continue
                       y(jy) = y(jy) + temp1*real(ap(kk+j-1)) + alpha*temp2
                       jx = jx + incx
                       jy = jy + incy
                       kk = kk + j
        80         continue
               end if
           else
     
              ! form  y  when ap contains the lower triangle.
     
               if ((incx==1) .and. (incy==1)) then
                   do 100 j = 1,n
                       temp1 = alpha*x(j)
                       temp2 = zero
                       y(j) = y(j) + temp1*real(ap(kk))
                       k = kk + 1
                       do 90 i = j + 1,n
                           y(i) = y(i) + temp1*ap(k)
                           temp2 = temp2 + conjg(ap(k))*x(i)
                           k = k + 1
        90             continue
                       y(j) = y(j) + alpha*temp2
                       kk = kk + (n-j+1)
       100         continue
               else
                   jx = kx
                   jy = ky
                   do 120 j = 1,n
                       temp1 = alpha*x(jx)
                       temp2 = zero
                       y(jy) = y(jy) + temp1*real(ap(kk))
                       ix = jx
                       iy = jy
                       do 110 k = kk + 1,kk + n - j
                           ix = ix + incx
                           iy = iy + incy
                           y(iy) = y(iy) + temp1*ap(k)
                           temp2 = temp2 + conjg(ap(k))*x(ix)
       110             continue
                       y(jy) = y(jy) + alpha*temp2
                       jx = jx + incx
                       jy = jy + incy
                       kk = kk + (n-j+1)
       120         continue
               end if
           end if
     
           return
     
           ! end of stdlib_chpmv
     
     end subroutine stdlib_chpmv
     
     
     ! CHPR    performs the hermitian rank 1 operation
     ! A := alpha*x*x**H + A,
     ! where alpha is a real scalar, x is an n element vector and A is an
     ! n by n hermitian matrix, supplied in packed form.
     subroutine stdlib_chpr(uplo,n,alpha,x,incx,ap)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(sp) alpha
           integer(int32) incx,n
           character uplo
           ! ..
           ! .. array arguments ..
           complex(sp) ap(*),x(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
           ! .. local scalars ..
           complex(sp) temp
           integer(int32) i,info,ix,j,jx,k,kk,kx
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg,real
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (n<0) then
               info = 2
           else if (incx==0) then
               info = 5
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_chpr  ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. (alpha==real(zero))) return
     
           ! set the start point in x if the increment is not unity.
     
           if (incx<=0) then
               kx = 1 - (n-1)*incx
           else if (incx/=1) then
               kx = 1
           end if
     
           ! start the operations. in this version the elements of the array ap
           ! are accessed sequentially with one pass through ap.
     
           kk = 1
           if (stdlib_lsame(uplo,'u')) then
     
              ! form  a  when upper triangle is stored in ap.
     
               if (incx==1) then
                   do 20 j = 1,n
                       if (x(j)/=zero) then
                           temp = alpha*conjg(x(j))
                           k = kk
                           do 10 i = 1,j - 1
                               ap(k) = ap(k) + x(i)*temp
                               k = k + 1
        10                 continue
                           ap(kk+j-1) = real(ap(kk+j-1)) + real(x(j)*temp)
                       else
                           ap(kk+j-1) = real(ap(kk+j-1))
                       end if
                       kk = kk + j
        20         continue
               else
                   jx = kx
                   do 40 j = 1,n
                       if (x(jx)/=zero) then
                           temp = alpha*conjg(x(jx))
                           ix = kx
                           do 30 k = kk,kk + j - 2
                               ap(k) = ap(k) + x(ix)*temp
                               ix = ix + incx
        30                 continue
                           ap(kk+j-1) = real(ap(kk+j-1)) + real(x(jx)*temp)
                       else
                           ap(kk+j-1) = real(ap(kk+j-1))
                       end if
                       jx = jx + incx
                       kk = kk + j
        40         continue
               end if
           else
     
              ! form  a  when lower triangle is stored in ap.
     
               if (incx==1) then
                   do 60 j = 1,n
                       if (x(j)/=zero) then
                           temp = alpha*conjg(x(j))
                           ap(kk) = real(ap(kk)) + real(temp*x(j))
                           k = kk + 1
                           do 50 i = j + 1,n
                               ap(k) = ap(k) + x(i)*temp
                               k = k + 1
        50                 continue
                       else
                           ap(kk) = real(ap(kk))
                       end if
                       kk = kk + n - j + 1
        60         continue
               else
                   jx = kx
                   do 80 j = 1,n
                       if (x(jx)/=zero) then
                           temp = alpha*conjg(x(jx))
                           ap(kk) = real(ap(kk)) + real(temp*x(jx))
                           ix = jx
                           do 70 k = kk + 1,kk + n - j
                               ix = ix + incx
                               ap(k) = ap(k) + x(ix)*temp
        70                 continue
                       else
                           ap(kk) = real(ap(kk))
                       end if
                       jx = jx + incx
                       kk = kk + n - j + 1
        80         continue
               end if
           end if
     
           return
     
           ! end of stdlib_chpr
     
     end subroutine stdlib_chpr
     
     
     ! CHPR2  performs the hermitian rank 2 operation
     ! A := alpha*x*y**H + conjg( alpha )*y*x**H + A,
     ! where alpha is a scalar, x and y are n element vectors and A is an
     ! n by n hermitian matrix, supplied in packed form.
     subroutine stdlib_chpr2(uplo,n,alpha,x,incx,y,incy,ap)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           complex(sp) alpha
           integer(int32) incx,incy,n
           character uplo
           ! ..
           ! .. array arguments ..
           complex(sp) ap(*),x(*),y(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
           ! .. local scalars ..
           complex(sp) temp1,temp2
           integer(int32) i,info,ix,iy,j,jx,jy,k,kk,kx,ky
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg,real
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (n<0) then
               info = 2
           else if (incx==0) then
               info = 5
           else if (incy==0) then
               info = 7
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_chpr2 ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. (alpha==zero)) return
     
           ! set up the start points in x and y if the increments are not both
           ! unity.
     
           if ((incx/=1) .or. (incy/=1)) then
               if (incx>0) then
                   kx = 1
               else
                   kx = 1 - (n-1)*incx
               end if
               if (incy>0) then
                   ky = 1
               else
                   ky = 1 - (n-1)*incy
               end if
               jx = kx
               jy = ky
           end if
     
           ! start the operations. in this version the elements of the array ap
           ! are accessed sequentially with one pass through ap.
     
           kk = 1
           if (stdlib_lsame(uplo,'u')) then
     
              ! form  a  when upper triangle is stored in ap.
     
               if ((incx==1) .and. (incy==1)) then
                   do 20 j = 1,n
                       if ((x(j)/=zero) .or. (y(j)/=zero)) then
                           temp1 = alpha*conjg(y(j))
                           temp2 = conjg(alpha*x(j))
                           k = kk
                           do 10 i = 1,j - 1
                               ap(k) = ap(k) + x(i)*temp1 + y(i)*temp2
                               k = k + 1
        10                 continue
                           ap(kk+j-1) = real(ap(kk+j-1)) +real(x(j)*temp1+y(j)*temp2)
                       else
                           ap(kk+j-1) = real(ap(kk+j-1))
                       end if
                       kk = kk + j
        20         continue
               else
                   do 40 j = 1,n
                       if ((x(jx)/=zero) .or. (y(jy)/=zero)) then
                           temp1 = alpha*conjg(y(jy))
                           temp2 = conjg(alpha*x(jx))
                           ix = kx
                           iy = ky
                           do 30 k = kk,kk + j - 2
                               ap(k) = ap(k) + x(ix)*temp1 + y(iy)*temp2
                               ix = ix + incx
                               iy = iy + incy
        30                 continue
                           ap(kk+j-1) = real(ap(kk+j-1)) +real(x(jx)*temp1+y(jy)*temp2)
                       else
                           ap(kk+j-1) = real(ap(kk+j-1))
                       end if
                       jx = jx + incx
                       jy = jy + incy
                       kk = kk + j
        40         continue
               end if
           else
     
              ! form  a  when lower triangle is stored in ap.
     
               if ((incx==1) .and. (incy==1)) then
                   do 60 j = 1,n
                       if ((x(j)/=zero) .or. (y(j)/=zero)) then
                           temp1 = alpha*conjg(y(j))
                           temp2 = conjg(alpha*x(j))
                           ap(kk) = real(ap(kk)) +real(x(j)*temp1+y(j)*temp2)
                           k = kk + 1
                           do 50 i = j + 1,n
                               ap(k) = ap(k) + x(i)*temp1 + y(i)*temp2
                               k = k + 1
        50                 continue
                       else
                           ap(kk) = real(ap(kk))
                       end if
                       kk = kk + n - j + 1
        60         continue
               else
                   do 80 j = 1,n
                       if ((x(jx)/=zero) .or. (y(jy)/=zero)) then
                           temp1 = alpha*conjg(y(jy))
                           temp2 = conjg(alpha*x(jx))
                           ap(kk) = real(ap(kk)) +real(x(jx)*temp1+y(jy)*temp2)
                           ix = jx
                           iy = jy
                           do 70 k = kk + 1,kk + n - j
                               ix = ix + incx
                               iy = iy + incy
                               ap(k) = ap(k) + x(ix)*temp1 + y(iy)*temp2
        70                 continue
                       else
                           ap(kk) = real(ap(kk))
                       end if
                       jx = jx + incx
                       jy = jy + incy
                       kk = kk + n - j + 1
        80         continue
               end if
           end if
     
           return
     
           ! end of stdlib_chpr2
     
     end subroutine stdlib_chpr2
     ! !
     
     ! The computation uses the formulas
     ! |x| = sqrt( Re(x)**2 + Im(x)**2 )
     ! sgn(x) = x / |x|  if x /= 0
     ! = 1        if x  = 0
     ! c = |a| / sqrt(|a|**2 + |b|**2)
     ! s = sgn(a) * conjg(b) / sqrt(|a|**2 + |b|**2)
     ! When a and b are real and r /= 0, the formulas simplify to
     ! r = sgn(a)*sqrt(|a|**2 + |b|**2)
     ! c = a / r
     ! s = b / r
     ! the same as in SROTG when |a| > |b|.  When |b| >= |a|, the
     ! sign of c and s will be different from those computed by SROTG
     ! if the signs of a and b are not the same.
     subroutine stdlib_crotg( a, b, c, s )
        integer, parameter :: wp = kind(1.e0)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
        ! .. constants ..
        real(sp), parameter ::szero = 0.0_sp
        real(sp), parameter :: sone  = 1.0_sp
        complex(sp), parameter :: czero  = 0.0_sp
        ! ..
        ! .. scaling constants ..
     real(sp), parameter :: safmin = real(radix(0._sp),wp)**max(minexponent(0._sp)-1,1-&
               maxexponent(0._sp)   )
     real(sp), parameter :: safmax = real(radix(0._sp),wp)**max(1-minexponent(0._sp),maxexponent(&
               0._sp)-1   )
     real(sp), parameter :: rtmin = sqrt( real(radix(0._sp),wp)**max(minexponent(0._sp)-1,1-&
               maxexponent(0._sp)   ) / epsilon(0._sp) )
     real(sp), parameter :: rtmax = sqrt( real(radix(0._sp),wp)**max(1-minexponent(0._sp),&
               maxexponent(0._sp)-1   ) * epsilon(0._sp) )
        ! ..
        ! .. scalar arguments ..
        real(sp) :: c
        complex(sp) :: a, b, s
        ! ..
        ! .. local scalars ..
        real(sp) :: d, f1, f2, g1, g2, h2, p, u, uu, v, vv, w
        complex(sp) :: f, fs, g, gs, r, t
        ! ..
        ! .. intrinsic functions ..
        intrinsic :: abs, aimag, conjg, max, min, real, sqrt
        ! ..
        ! .. statement functions ..
        real(sp) :: abssq
        ! ..
        ! .. statement function definitions ..
        abssq( t ) = real( t )**2 + aimag( t )**2
        ! ..
        ! .. executable statements ..
     
        f = a
        g = b
        if( g == czero ) then
           c = sone
           s = czero
           r = f
        else if( f == czero ) then
           c =szero
           g1 = max( abs(real(g)), abs(aimag(g)) )
           if( g1 > rtmin .and. g1 < rtmax ) then
     
              ! use unscaled algorithm
     
              g2 = abssq( g )
              d = sqrt( g2 )
              s = conjg( g ) / d
              r = d
           else
     
              ! use scaled algorithm
     
              u = min( safmax, max( safmin, g1 ) )
              uu = sone / u
              gs = g*uu
              g2 = abssq( gs )
              d = sqrt( g2 )
              s = conjg( gs ) / d
              r = d*u
           end if
        else
           f1 = max( abs(real(f)), abs(aimag(f)) )
           g1 = max( abs(real(g)), abs(aimag(g)) )
     if( f1 > rtmin .and. f1 < rtmax .and.          g1 > rtmin .and. g1 < rtmax ) then
     
              ! use unscaled algorithm
     
              f2 = abssq( f )
              g2 = abssq( g )
              h2 = f2 + g2
              if( f2 > rtmin .and. h2 < rtmax ) then
                 d = sqrt( f2*h2 )
              else
                 d = sqrt( f2 )*sqrt( h2 )
              end if
              p = 1 / d
              c = f2*p
              s = conjg( g )*( f*p )
              r = f*( h2*p )
           else
     
              ! use scaled algorithm
     
              u = min( safmax, max( safmin, f1, g1 ) )
              uu = sone / u
              gs = g*uu
              g2 = abssq( gs )
              if( f1*uu < rtmin ) then
     
                 ! f is not well-scaled when scaled by g1.
                 ! use a different scaling for f.
     
                 v = min( safmax, max( safmin, f1 ) )
                 vv = sone / v
                 w = v * uu
                 fs = f*vv
                 f2 = abssq( fs )
                 h2 = f2*w**2 + g2
              else
     
                 ! otherwise use the same scaling for f and g.
     
                 w = sone
                 fs = f*uu
                 f2 = abssq( fs )
                 h2 = f2 + g2
              end if
              if( f2 > rtmin .and. h2 < rtmax ) then
                 d = sqrt( f2*h2 )
              else
                 d = sqrt( f2 )*sqrt( h2 )
              end if
              p = 1 / d
              c = ( f2*p )*w
              s = conjg( gs )*( fs*p )
              r = ( fs*( h2*p ) )*u
           end if
        end if
        a = r
        return
     end subroutine stdlib_crotg
     
     
     ! CSCAL scales a vector by a constant.
     subroutine stdlib_cscal(n,ca,cx,incx)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           complex(sp) ca
           integer(int32) incx,n
           ! ..
           ! .. array arguments ..
           complex(sp) cx(*)
           ! ..
     
        ! =====================================================================
     
           ! .. local scalars ..
           integer(int32) i,nincx
           ! ..
           if (n<=0 .or. incx<=0) return
           if (incx==1) then
     
              ! code for increment equal to 1
     
              do i = 1,n
                 cx(i) = ca*cx(i)
              end do
           else
     
              ! code for increment not equal to 1
     
              nincx = n*incx
              do i = 1,nincx,incx
                 cx(i) = ca*cx(i)
              end do
           end if
           return
     
           ! end of stdlib_cscal
     
     end subroutine stdlib_cscal
     
     
     ! CSROT applies a plane rotation, where the cos and sin (c and s) are real
     ! and the vectors cx and cy are complex.
     ! jack dongarra, linpack, 3/11/78.
     subroutine stdlib_csrot( n, cx, incx, cy, incy, c, s )
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32)           incx, incy, n
           real(sp)              c, s
           ! ..
           ! .. array arguments ..
           complex(sp)           cx( * ), cy( * )
           ! ..
     
        ! =====================================================================
     
           ! .. local scalars ..
           integer(int32)           i, ix, iy
           complex(sp)           ctemp
           ! ..
           ! .. executable statements ..
     
           if( n<=0 )return
           if( incx==1 .and. incy==1 ) then
     
              ! code for both increments equal to 1
     
              do i = 1, n
                 ctemp = c*cx( i ) + s*cy( i )
                 cy( i ) = c*cy( i ) - s*cx( i )
                 cx( i ) = ctemp
              end do
           else
     
              ! code for unequal increments or equal increments not equal
                ! to 1
     
              ix = 1
              iy = 1
              if( incx<0 )ix = ( -n+1 )*incx + 1
              if( incy<0 )iy = ( -n+1 )*incy + 1
              do i = 1, n
                 ctemp = c*cx( ix ) + s*cy( iy )
                 cy( iy ) = c*cy( iy ) - s*cx( ix )
                 cx( ix ) = ctemp
                 ix = ix + incx
                 iy = iy + incy
              end do
           end if
           return
     
           ! end of stdlib_csrot
     
     end subroutine stdlib_csrot
     
     
     ! CSSCAL scales a complex vector by a real constant.
     subroutine stdlib_csscal(n,sa,cx,incx)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(sp) sa
           integer(int32) incx,n
           ! ..
           ! .. array arguments ..
           complex(sp) cx(*)
           ! ..
     
        ! =====================================================================
     
           ! .. local scalars ..
           integer(int32) i,nincx
           ! ..
           ! .. intrinsic functions ..
           intrinsic aimag,cmplx,real
           ! ..
           if (n<=0 .or. incx<=0) return
           if (incx==1) then
     
              ! code for increment equal to 1
     
              do i = 1,n
                 cx(i) = cmplx(sa*real(cx(i)),sa*aimag(cx(i)))
              end do
           else
     
              ! code for increment not equal to 1
     
              nincx = n*incx
              do i = 1,nincx,incx
                 cx(i) = cmplx(sa*real(cx(i)),sa*aimag(cx(i)))
              end do
           end if
           return
     
           ! end of stdlib_csscal
     
     end subroutine stdlib_csscal
     
     
     ! CSWAP interchanges two vectors.
     subroutine stdlib_cswap(n,cx,incx,cy,incy)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,incy,n
           ! ..
           ! .. array arguments ..
           complex(sp) cx(*),cy(*)
           ! ..
     
        ! =====================================================================
     
           ! .. local scalars ..
           complex(sp) ctemp
           integer(int32) i,ix,iy
           ! ..
           if (n<=0) return
           if (incx==1 .and. incy==1) then
     
             ! code for both increments equal to 1
              do i = 1,n
                 ctemp = cx(i)
                 cx(i) = cy(i)
                 cy(i) = ctemp
              end do
           else
     
             ! code for unequal increments or equal increments not equal
               ! to 1
     
              ix = 1
              iy = 1
              if (incx<0) ix = (-n+1)*incx + 1
              if (incy<0) iy = (-n+1)*incy + 1
              do i = 1,n
                 ctemp = cx(ix)
                 cx(ix) = cy(iy)
                 cy(iy) = ctemp
                 ix = ix + incx
                 iy = iy + incy
              end do
           end if
           return
     
           ! end of stdlib_cswap
     
     end subroutine stdlib_cswap
     
     
     ! CSYMM  performs one of the matrix-matrix operations
     ! C := alpha*A*B + beta*C,
     ! or
     ! C := alpha*B*A + beta*C,
     ! where  alpha and beta are scalars, A is a symmetric matrix and  B and
     ! C are m by n matrices.
     subroutine stdlib_csymm(side,uplo,m,n,alpha,a,lda,b,ldb,beta,c,ldc)
     
        ! -- reference blas level3 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           complex(sp) alpha,beta
           integer(int32) lda,ldb,ldc,m,n
           character side,uplo
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),b(ldb,*),c(ldc,*)
           ! ..
     
        ! =====================================================================
     
     
     
     
           ! .. intrinsic functions ..
           intrinsic max
           ! ..
           ! .. local scalars ..
           complex(sp) temp1,temp2
           integer(int32) i,info,j,k,nrowa
           logical(lk) upper
           ! ..
           ! .. parameters ..
           complex(sp) one
           parameter (one= (1.0_sp,0.0_sp))
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
     
           ! set nrowa as the number of rows of a.
     
           if (stdlib_lsame(side,'l')) then
               nrowa = m
           else
               nrowa = n
           end if
           upper = stdlib_lsame(uplo,'u')
     
           ! test the input parameters.
     
           info = 0
           if ((.not.stdlib_lsame(side,'l')) .and. (.not.stdlib_lsame(side,'r'))) then
               info = 1
           else if ((.not.upper) .and. (.not.stdlib_lsame(uplo,'l'))) then
               info = 2
           else if (m<0) then
               info = 3
           else if (n<0) then
               info = 4
           else if (lda<max(1,nrowa)) then
               info = 7
           else if (ldb<max(1,m)) then
               info = 9
           else if (ldc<max(1,m)) then
               info = 12
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_csymm ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((m==0) .or. (n==0) .or.((alpha==zero).and. (beta==one))) return
     
           ! and when  alpha.eq.zero.
     
           if (alpha==zero) then
               if (beta==zero) then
                   do 20 j = 1,n
                       do 10 i = 1,m
                           c(i,j) = zero
        10             continue
        20         continue
               else
                   do 40 j = 1,n
                       do 30 i = 1,m
                           c(i,j) = beta*c(i,j)
        30             continue
        40         continue
               end if
               return
           end if
     
           ! start the operations.
     
           if (stdlib_lsame(side,'l')) then
     
              ! form  c := alpha*a*b + beta*c.
     
               if (upper) then
                   do 70 j = 1,n
                       do 60 i = 1,m
                           temp1 = alpha*b(i,j)
                           temp2 = zero
                           do 50 k = 1,i - 1
                               c(k,j) = c(k,j) + temp1*a(k,i)
                               temp2 = temp2 + b(k,j)*a(k,i)
        50                 continue
                           if (beta==zero) then
                               c(i,j) = temp1*a(i,i) + alpha*temp2
                           else
                               c(i,j) = beta*c(i,j) + temp1*a(i,i) +alpha*temp2
                           end if
        60             continue
        70         continue
               else
                   do 100 j = 1,n
                       do 90 i = m,1,-1
                           temp1 = alpha*b(i,j)
                           temp2 = zero
                           do 80 k = i + 1,m
                               c(k,j) = c(k,j) + temp1*a(k,i)
                               temp2 = temp2 + b(k,j)*a(k,i)
        80                 continue
                           if (beta==zero) then
                               c(i,j) = temp1*a(i,i) + alpha*temp2
                           else
                               c(i,j) = beta*c(i,j) + temp1*a(i,i) +alpha*temp2
                           end if
        90             continue
       100         continue
               end if
           else
     
              ! form  c := alpha*b*a + beta*c.
     
               do 170 j = 1,n
                   temp1 = alpha*a(j,j)
                   if (beta==zero) then
                       do 110 i = 1,m
                           c(i,j) = temp1*b(i,j)
       110             continue
                   else
                       do 120 i = 1,m
                           c(i,j) = beta*c(i,j) + temp1*b(i,j)
       120             continue
                   end if
                   do 140 k = 1,j - 1
                       if (upper) then
                           temp1 = alpha*a(k,j)
                       else
                           temp1 = alpha*a(j,k)
                       end if
                       do 130 i = 1,m
                           c(i,j) = c(i,j) + temp1*b(i,k)
       130             continue
       140         continue
                   do 160 k = j + 1,n
                       if (upper) then
                           temp1 = alpha*a(j,k)
                       else
                           temp1 = alpha*a(k,j)
                       end if
                       do 150 i = 1,m
                           c(i,j) = c(i,j) + temp1*b(i,k)
       150             continue
       160         continue
       170     continue
           end if
     
           return
     
           ! end of stdlib_csymm
     
     end subroutine stdlib_csymm
     
     
     ! CSYR2K  performs one of the symmetric rank 2k operations
     ! C := alpha*A*B**T + alpha*B*A**T + beta*C,
     ! or
     ! C := alpha*A**T*B + alpha*B**T*A + beta*C,
     ! where  alpha and beta  are scalars,  C is an  n by n symmetric matrix
     ! and  A and B  are  n by k  matrices  in the  first  case  and  k by n
     ! matrices in the second case.
     subroutine stdlib_csyr2k(uplo,trans,n,k,alpha,a,lda,b,ldb,beta,c,ldc)
     
        ! -- reference blas level3 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           complex(sp) alpha,beta
           integer(int32) k,lda,ldb,ldc,n
           character trans,uplo
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),b(ldb,*),c(ldc,*)
           ! ..
     
        ! =====================================================================
     
     
     
     
           ! .. intrinsic functions ..
           intrinsic max
           ! ..
           ! .. local scalars ..
           complex(sp) temp1,temp2
           integer(int32) i,info,j,l,nrowa
           logical(lk) upper
           ! ..
           ! .. parameters ..
           complex(sp) one
           parameter (one= (1.0_sp,0.0_sp))
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
     
           ! test the input parameters.
     
           if (stdlib_lsame(trans,'n')) then
               nrowa = n
           else
               nrowa = k
           end if
           upper = stdlib_lsame(uplo,'u')
     
           info = 0
           if ((.not.upper) .and. (.not.stdlib_lsame(uplo,'l'))) then
               info = 1
           else if ((.not.stdlib_lsame(trans,'n')) .and.(.not.stdlib_lsame(trans,'t'))) &
                     then
               info = 2
           else if (n<0) then
               info = 3
           else if (k<0) then
               info = 4
           else if (lda<max(1,nrowa)) then
               info = 7
           else if (ldb<max(1,nrowa)) then
               info = 9
           else if (ldc<max(1,n)) then
               info = 12
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_csyr2k',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. (((alpha==zero).or.(k==0)).and. (beta==one))) return
     
           ! and when  alpha.eq.zero.
     
           if (alpha==zero) then
               if (upper) then
                   if (beta==zero) then
                       do 20 j = 1,n
                           do 10 i = 1,j
                               c(i,j) = zero
        10                 continue
        20             continue
                   else
                       do 40 j = 1,n
                           do 30 i = 1,j
                               c(i,j) = beta*c(i,j)
        30                 continue
        40             continue
                   end if
               else
                   if (beta==zero) then
                       do 60 j = 1,n
                           do 50 i = j,n
                               c(i,j) = zero
        50                 continue
        60             continue
                   else
                       do 80 j = 1,n
                           do 70 i = j,n
                               c(i,j) = beta*c(i,j)
        70                 continue
        80             continue
                   end if
               end if
               return
           end if
     
           ! start the operations.
     
           if (stdlib_lsame(trans,'n')) then
     
              ! form  c := alpha*a*b**t + alpha*b*a**t + c.
     
               if (upper) then
                   do 130 j = 1,n
                       if (beta==zero) then
                           do 90 i = 1,j
                               c(i,j) = zero
        90                 continue
                       else if (beta/=one) then
                           do 100 i = 1,j
                               c(i,j) = beta*c(i,j)
       100                 continue
                       end if
                       do 120 l = 1,k
                           if ((a(j,l)/=zero) .or. (b(j,l)/=zero)) then
                               temp1 = alpha*b(j,l)
                               temp2 = alpha*a(j,l)
                               do 110 i = 1,j
                                   c(i,j) = c(i,j) + a(i,l)*temp1 +b(i,l)*temp2
       110                     continue
                           end if
       120             continue
       130         continue
               else
                   do 180 j = 1,n
                       if (beta==zero) then
                           do 140 i = j,n
                               c(i,j) = zero
       140                 continue
                       else if (beta/=one) then
                           do 150 i = j,n
                               c(i,j) = beta*c(i,j)
       150                 continue
                       end if
                       do 170 l = 1,k
                           if ((a(j,l)/=zero) .or. (b(j,l)/=zero)) then
                               temp1 = alpha*b(j,l)
                               temp2 = alpha*a(j,l)
                               do 160 i = j,n
                                   c(i,j) = c(i,j) + a(i,l)*temp1 +b(i,l)*temp2
       160                     continue
                           end if
       170             continue
       180         continue
               end if
           else
     
              ! form  c := alpha*a**t*b + alpha*b**t*a + c.
     
               if (upper) then
                   do 210 j = 1,n
                       do 200 i = 1,j
                           temp1 = zero
                           temp2 = zero
                           do 190 l = 1,k
                               temp1 = temp1 + a(l,i)*b(l,j)
                               temp2 = temp2 + b(l,i)*a(l,j)
       190                 continue
                           if (beta==zero) then
                               c(i,j) = alpha*temp1 + alpha*temp2
                           else
                               c(i,j) = beta*c(i,j) + alpha*temp1 +alpha*temp2
                           end if
       200             continue
       210         continue
               else
                   do 240 j = 1,n
                       do 230 i = j,n
                           temp1 = zero
                           temp2 = zero
                           do 220 l = 1,k
                               temp1 = temp1 + a(l,i)*b(l,j)
                               temp2 = temp2 + b(l,i)*a(l,j)
       220                 continue
                           if (beta==zero) then
                               c(i,j) = alpha*temp1 + alpha*temp2
                           else
                               c(i,j) = beta*c(i,j) + alpha*temp1 +alpha*temp2
                           end if
       230             continue
       240         continue
               end if
           end if
     
           return
     
           ! end of stdlib_csyr2k
     
     end subroutine stdlib_csyr2k
     
     
     ! CSYRK  performs one of the symmetric rank k operations
     ! C := alpha*A*A**T + beta*C,
     ! or
     ! C := alpha*A**T*A + beta*C,
     ! where  alpha and beta  are scalars,  C is an  n by n symmetric matrix
     ! and  A  is an  n by k  matrix in the first case and a  k by n  matrix
     ! in the second case.
     subroutine stdlib_csyrk(uplo,trans,n,k,alpha,a,lda,beta,c,ldc)
     
        ! -- reference blas level3 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           complex(sp) alpha,beta
           integer(int32) k,lda,ldc,n
           character trans,uplo
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),c(ldc,*)
           ! ..
     
        ! =====================================================================
     
     
     
     
           ! .. intrinsic functions ..
           intrinsic max
           ! ..
           ! .. local scalars ..
           complex(sp) temp
           integer(int32) i,info,j,l,nrowa
           logical(lk) upper
           ! ..
           ! .. parameters ..
           complex(sp) one
           parameter (one= (1.0_sp,0.0_sp))
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
     
           ! test the input parameters.
     
           if (stdlib_lsame(trans,'n')) then
               nrowa = n
           else
               nrowa = k
           end if
           upper = stdlib_lsame(uplo,'u')
     
           info = 0
           if ((.not.upper) .and. (.not.stdlib_lsame(uplo,'l'))) then
               info = 1
           else if ((.not.stdlib_lsame(trans,'n')) .and.(.not.stdlib_lsame(trans,'t'))) &
                     then
               info = 2
           else if (n<0) then
               info = 3
           else if (k<0) then
               info = 4
           else if (lda<max(1,nrowa)) then
               info = 7
           else if (ldc<max(1,n)) then
               info = 10
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_csyrk ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. (((alpha==zero).or.(k==0)).and. (beta==one))) return
     
           ! and when  alpha.eq.zero.
     
           if (alpha==zero) then
               if (upper) then
                   if (beta==zero) then
                       do 20 j = 1,n
                           do 10 i = 1,j
                               c(i,j) = zero
        10                 continue
        20             continue
                   else
                       do 40 j = 1,n
                           do 30 i = 1,j
                               c(i,j) = beta*c(i,j)
        30                 continue
        40             continue
                   end if
               else
                   if (beta==zero) then
                       do 60 j = 1,n
                           do 50 i = j,n
                               c(i,j) = zero
        50                 continue
        60             continue
                   else
                       do 80 j = 1,n
                           do 70 i = j,n
                               c(i,j) = beta*c(i,j)
        70                 continue
        80             continue
                   end if
               end if
               return
           end if
     
           ! start the operations.
     
           if (stdlib_lsame(trans,'n')) then
     
              ! form  c := alpha*a*a**t + beta*c.
     
               if (upper) then
                   do 130 j = 1,n
                       if (beta==zero) then
                           do 90 i = 1,j
                               c(i,j) = zero
        90                 continue
                       else if (beta/=one) then
                           do 100 i = 1,j
                               c(i,j) = beta*c(i,j)
       100                 continue
                       end if
                       do 120 l = 1,k
                           if (a(j,l)/=zero) then
                               temp = alpha*a(j,l)
                               do 110 i = 1,j
                                   c(i,j) = c(i,j) + temp*a(i,l)
       110                     continue
                           end if
       120             continue
       130         continue
               else
                   do 180 j = 1,n
                       if (beta==zero) then
                           do 140 i = j,n
                               c(i,j) = zero
       140                 continue
                       else if (beta/=one) then
                           do 150 i = j,n
                               c(i,j) = beta*c(i,j)
       150                 continue
                       end if
                       do 170 l = 1,k
                           if (a(j,l)/=zero) then
                               temp = alpha*a(j,l)
                               do 160 i = j,n
                                   c(i,j) = c(i,j) + temp*a(i,l)
       160                     continue
                           end if
       170             continue
       180         continue
               end if
           else
     
              ! form  c := alpha*a**t*a + beta*c.
     
               if (upper) then
                   do 210 j = 1,n
                       do 200 i = 1,j
                           temp = zero
                           do 190 l = 1,k
                               temp = temp + a(l,i)*a(l,j)
       190                 continue
                           if (beta==zero) then
                               c(i,j) = alpha*temp
                           else
                               c(i,j) = alpha*temp + beta*c(i,j)
                           end if
       200             continue
       210         continue
               else
                   do 240 j = 1,n
                       do 230 i = j,n
                           temp = zero
                           do 220 l = 1,k
                               temp = temp + a(l,i)*a(l,j)
       220                 continue
                           if (beta==zero) then
                               c(i,j) = alpha*temp
                           else
                               c(i,j) = alpha*temp + beta*c(i,j)
                           end if
       230             continue
       240         continue
               end if
           end if
     
           return
     
           ! end of stdlib_csyrk
     
     end subroutine stdlib_csyrk
     
     
     ! CTBMV  performs one of the matrix-vector operations
     ! x := A*x,   or   x := A**T*x,   or   x := A**H*x,
     ! where x is an n element vector and  A is an n by n unit, or non-unit,
     ! upper or lower triangular band matrix, with ( k + 1 ) diagonals.
     subroutine stdlib_ctbmv(uplo,trans,diag,n,k,a,lda,x,incx)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,k,lda,n
           character diag,trans,uplo
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),x(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
           ! .. local scalars ..
           complex(sp) temp
           integer(int32) i,info,ix,j,jx,kplus1,kx,l
           logical(lk) noconj,nounit
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg,max,min
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (.not.stdlib_lsame(trans,'n') .and. .not.stdlib_lsame(trans,'t') &
                     .and..not.stdlib_lsame(trans,'c')) then
               info = 2
           else if (.not.stdlib_lsame(diag,'u') .and. .not.stdlib_lsame(diag,'n')) then
               info = 3
           else if (n<0) then
               info = 4
           else if (k<0) then
               info = 5
           else if (lda< (k+1)) then
               info = 7
           else if (incx==0) then
               info = 9
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_ctbmv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if (n==0) return
     
           noconj = stdlib_lsame(trans,'t')
           nounit = stdlib_lsame(diag,'n')
     
           ! set up the start point in x if the increment is not unity. this
           ! will be  ( n - 1 )*incx   too small for descending loops.
     
           if (incx<=0) then
               kx = 1 - (n-1)*incx
           else if (incx/=1) then
               kx = 1
           end if
     
           ! start the operations. in this version the elements of a are
           ! accessed sequentially with one pass through a.
     
           if (stdlib_lsame(trans,'n')) then
     
               ! form  x := a*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   kplus1 = k + 1
                   if (incx==1) then
                       do 20 j = 1,n
                           if (x(j)/=zero) then
                               temp = x(j)
                               l = kplus1 - j
                               do 10 i = max(1,j-k),j - 1
                                   x(i) = x(i) + temp*a(l+i,j)
        10                     continue
                               if (nounit) x(j) = x(j)*a(kplus1,j)
                           end if
        20             continue
                   else
                       jx = kx
                       do 40 j = 1,n
                           if (x(jx)/=zero) then
                               temp = x(jx)
                               ix = kx
                               l = kplus1 - j
                               do 30 i = max(1,j-k),j - 1
                                   x(ix) = x(ix) + temp*a(l+i,j)
                                   ix = ix + incx
        30                     continue
                               if (nounit) x(jx) = x(jx)*a(kplus1,j)
                           end if
                           jx = jx + incx
                           if (j>k) kx = kx + incx
        40             continue
                   end if
               else
                   if (incx==1) then
                       do 60 j = n,1,-1
                           if (x(j)/=zero) then
                               temp = x(j)
                               l = 1 - j
                               do 50 i = min(n,j+k),j + 1,-1
                                   x(i) = x(i) + temp*a(l+i,j)
        50                     continue
                               if (nounit) x(j) = x(j)*a(1,j)
                           end if
        60             continue
                   else
                       kx = kx + (n-1)*incx
                       jx = kx
                       do 80 j = n,1,-1
                           if (x(jx)/=zero) then
                               temp = x(jx)
                               ix = kx
                               l = 1 - j
                               do 70 i = min(n,j+k),j + 1,-1
                                   x(ix) = x(ix) + temp*a(l+i,j)
                                   ix = ix - incx
        70                     continue
                               if (nounit) x(jx) = x(jx)*a(1,j)
                           end if
                           jx = jx - incx
                           if ((n-j)>=k) kx = kx - incx
        80             continue
                   end if
               end if
           else
     
              ! form  x := a**t*x  or  x := a**h*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   kplus1 = k + 1
                   if (incx==1) then
                       do 110 j = n,1,-1
                           temp = x(j)
                           l = kplus1 - j
                           if (noconj) then
                               if (nounit) temp = temp*a(kplus1,j)
                               do 90 i = j - 1,max(1,j-k),-1
                                   temp = temp + a(l+i,j)*x(i)
        90                     continue
                           else
                               if (nounit) temp = temp*conjg(a(kplus1,j))
                               do 100 i = j - 1,max(1,j-k),-1
                                   temp = temp + conjg(a(l+i,j))*x(i)
       100                     continue
                           end if
                           x(j) = temp
       110             continue
                   else
                       kx = kx + (n-1)*incx
                       jx = kx
                       do 140 j = n,1,-1
                           temp = x(jx)
                           kx = kx - incx
                           ix = kx
                           l = kplus1 - j
                           if (noconj) then
                               if (nounit) temp = temp*a(kplus1,j)
                               do 120 i = j - 1,max(1,j-k),-1
                                   temp = temp + a(l+i,j)*x(ix)
                                   ix = ix - incx
       120                     continue
                           else
                               if (nounit) temp = temp*conjg(a(kplus1,j))
                               do 130 i = j - 1,max(1,j-k),-1
                                   temp = temp + conjg(a(l+i,j))*x(ix)
                                   ix = ix - incx
       130                     continue
                           end if
                           x(jx) = temp
                           jx = jx - incx
       140             continue
                   end if
               else
                   if (incx==1) then
                       do 170 j = 1,n
                           temp = x(j)
                           l = 1 - j
                           if (noconj) then
                               if (nounit) temp = temp*a(1,j)
                               do 150 i = j + 1,min(n,j+k)
                                   temp = temp + a(l+i,j)*x(i)
       150                     continue
                           else
                               if (nounit) temp = temp*conjg(a(1,j))
                               do 160 i = j + 1,min(n,j+k)
                                   temp = temp + conjg(a(l+i,j))*x(i)
       160                     continue
                           end if
                           x(j) = temp
       170             continue
                   else
                       jx = kx
                       do 200 j = 1,n
                           temp = x(jx)
                           kx = kx + incx
                           ix = kx
                           l = 1 - j
                           if (noconj) then
                               if (nounit) temp = temp*a(1,j)
                               do 180 i = j + 1,min(n,j+k)
                                   temp = temp + a(l+i,j)*x(ix)
                                   ix = ix + incx
       180                     continue
                           else
                               if (nounit) temp = temp*conjg(a(1,j))
                               do 190 i = j + 1,min(n,j+k)
                                   temp = temp + conjg(a(l+i,j))*x(ix)
                                   ix = ix + incx
       190                     continue
                           end if
                           x(jx) = temp
                           jx = jx + incx
       200             continue
                   end if
               end if
           end if
     
           return
     
           ! end of stdlib_ctbmv
     
     end subroutine stdlib_ctbmv
     
     
     ! CTBSV  solves one of the systems of equations
     ! A*x = b,   or   A**T*x = b,   or   A**H*x = b,
     ! where b and x are n element vectors and A is an n by n unit, or
     ! non-unit, upper or lower triangular band matrix, with ( k + 1 )
     ! diagonals.
     ! No test for singularity or near-singularity is included in this
     ! routine. Such tests must be performed before calling this routine.
     subroutine stdlib_ctbsv(uplo,trans,diag,n,k,a,lda,x,incx)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,k,lda,n
           character diag,trans,uplo
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),x(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
           ! .. local scalars ..
           complex(sp) temp
           integer(int32) i,info,ix,j,jx,kplus1,kx,l
           logical(lk) noconj,nounit
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg,max,min
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (.not.stdlib_lsame(trans,'n') .and. .not.stdlib_lsame(trans,'t') &
                     .and..not.stdlib_lsame(trans,'c')) then
               info = 2
           else if (.not.stdlib_lsame(diag,'u') .and. .not.stdlib_lsame(diag,'n')) then
               info = 3
           else if (n<0) then
               info = 4
           else if (k<0) then
               info = 5
           else if (lda< (k+1)) then
               info = 7
           else if (incx==0) then
               info = 9
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_ctbsv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if (n==0) return
     
           noconj = stdlib_lsame(trans,'t')
           nounit = stdlib_lsame(diag,'n')
     
           ! set up the start point in x if the increment is not unity. this
           ! will be  ( n - 1 )*incx  too small for descending loops.
     
           if (incx<=0) then
               kx = 1 - (n-1)*incx
           else if (incx/=1) then
               kx = 1
           end if
     
           ! start the operations. in this version the elements of a are
           ! accessed by sequentially with one pass through a.
     
           if (stdlib_lsame(trans,'n')) then
     
              ! form  x := inv( a )*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   kplus1 = k + 1
                   if (incx==1) then
                       do 20 j = n,1,-1
                           if (x(j)/=zero) then
                               l = kplus1 - j
                               if (nounit) x(j) = x(j)/a(kplus1,j)
                               temp = x(j)
                               do 10 i = j - 1,max(1,j-k),-1
                                   x(i) = x(i) - temp*a(l+i,j)
        10                     continue
                           end if
        20             continue
                   else
                       kx = kx + (n-1)*incx
                       jx = kx
                       do 40 j = n,1,-1
                           kx = kx - incx
                           if (x(jx)/=zero) then
                               ix = kx
                               l = kplus1 - j
                               if (nounit) x(jx) = x(jx)/a(kplus1,j)
                               temp = x(jx)
                               do 30 i = j - 1,max(1,j-k),-1
                                   x(ix) = x(ix) - temp*a(l+i,j)
                                   ix = ix - incx
        30                     continue
                           end if
                           jx = jx - incx
        40             continue
                   end if
               else
                   if (incx==1) then
                       do 60 j = 1,n
                           if (x(j)/=zero) then
                               l = 1 - j
                               if (nounit) x(j) = x(j)/a(1,j)
                               temp = x(j)
                               do 50 i = j + 1,min(n,j+k)
                                   x(i) = x(i) - temp*a(l+i,j)
        50                     continue
                           end if
        60             continue
                   else
                       jx = kx
                       do 80 j = 1,n
                           kx = kx + incx
                           if (x(jx)/=zero) then
                               ix = kx
                               l = 1 - j
                               if (nounit) x(jx) = x(jx)/a(1,j)
                               temp = x(jx)
                               do 70 i = j + 1,min(n,j+k)
                                   x(ix) = x(ix) - temp*a(l+i,j)
                                   ix = ix + incx
        70                     continue
                           end if
                           jx = jx + incx
        80             continue
                   end if
               end if
           else
     
              ! form  x := inv( a**t )*x  or  x := inv( a**h )*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   kplus1 = k + 1
                   if (incx==1) then
                       do 110 j = 1,n
                           temp = x(j)
                           l = kplus1 - j
                           if (noconj) then
                               do 90 i = max(1,j-k),j - 1
                                   temp = temp - a(l+i,j)*x(i)
        90                     continue
                               if (nounit) temp = temp/a(kplus1,j)
                           else
                               do 100 i = max(1,j-k),j - 1
                                   temp = temp - conjg(a(l+i,j))*x(i)
       100                     continue
                               if (nounit) temp = temp/conjg(a(kplus1,j))
                           end if
                           x(j) = temp
       110             continue
                   else
                       jx = kx
                       do 140 j = 1,n
                           temp = x(jx)
                           ix = kx
                           l = kplus1 - j
                           if (noconj) then
                               do 120 i = max(1,j-k),j - 1
                                   temp = temp - a(l+i,j)*x(ix)
                                   ix = ix + incx
       120                     continue
                               if (nounit) temp = temp/a(kplus1,j)
                           else
                               do 130 i = max(1,j-k),j - 1
                                   temp = temp - conjg(a(l+i,j))*x(ix)
                                   ix = ix + incx
       130                     continue
                               if (nounit) temp = temp/conjg(a(kplus1,j))
                           end if
                           x(jx) = temp
                           jx = jx + incx
                           if (j>k) kx = kx + incx
       140             continue
                   end if
               else
                   if (incx==1) then
                       do 170 j = n,1,-1
                           temp = x(j)
                           l = 1 - j
                           if (noconj) then
                               do 150 i = min(n,j+k),j + 1,-1
                                   temp = temp - a(l+i,j)*x(i)
       150                     continue
                               if (nounit) temp = temp/a(1,j)
                           else
                               do 160 i = min(n,j+k),j + 1,-1
                                   temp = temp - conjg(a(l+i,j))*x(i)
       160                     continue
                               if (nounit) temp = temp/conjg(a(1,j))
                           end if
                           x(j) = temp
       170             continue
                   else
                       kx = kx + (n-1)*incx
                       jx = kx
                       do 200 j = n,1,-1
                           temp = x(jx)
                           ix = kx
                           l = 1 - j
                           if (noconj) then
                               do 180 i = min(n,j+k),j + 1,-1
                                   temp = temp - a(l+i,j)*x(ix)
                                   ix = ix - incx
       180                     continue
                               if (nounit) temp = temp/a(1,j)
                           else
                               do 190 i = min(n,j+k),j + 1,-1
                                   temp = temp - conjg(a(l+i,j))*x(ix)
                                   ix = ix - incx
       190                     continue
                               if (nounit) temp = temp/conjg(a(1,j))
                           end if
                           x(jx) = temp
                           jx = jx - incx
                           if ((n-j)>=k) kx = kx - incx
       200             continue
                   end if
               end if
           end if
     
           return
     
           ! end of stdlib_ctbsv
     
     end subroutine stdlib_ctbsv
     
     
     ! CTPMV  performs one of the matrix-vector operations
     ! x := A*x,   or   x := A**T*x,   or   x := A**H*x,
     ! where x is an n element vector and  A is an n by n unit, or non-unit,
     ! upper or lower triangular matrix, supplied in packed form.
     subroutine stdlib_ctpmv(uplo,trans,diag,n,ap,x,incx)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,n
           character diag,trans,uplo
           ! ..
           ! .. array arguments ..
           complex(sp) ap(*),x(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
           ! .. local scalars ..
           complex(sp) temp
           integer(int32) i,info,ix,j,jx,k,kk,kx
           logical(lk) noconj,nounit
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (.not.stdlib_lsame(trans,'n') .and. .not.stdlib_lsame(trans,'t') &
                     .and..not.stdlib_lsame(trans,'c')) then
               info = 2
           else if (.not.stdlib_lsame(diag,'u') .and. .not.stdlib_lsame(diag,'n')) then
               info = 3
           else if (n<0) then
               info = 4
           else if (incx==0) then
               info = 7
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_ctpmv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if (n==0) return
     
           noconj = stdlib_lsame(trans,'t')
           nounit = stdlib_lsame(diag,'n')
     
           ! set up the start point in x if the increment is not unity. this
           ! will be  ( n - 1 )*incx  too small for descending loops.
     
           if (incx<=0) then
               kx = 1 - (n-1)*incx
           else if (incx/=1) then
               kx = 1
           end if
     
           ! start the operations. in this version the elements of ap are
           ! accessed sequentially with one pass through ap.
     
           if (stdlib_lsame(trans,'n')) then
     
              ! form  x:= a*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   kk = 1
                   if (incx==1) then
                       do 20 j = 1,n
                           if (x(j)/=zero) then
                               temp = x(j)
                               k = kk
                               do 10 i = 1,j - 1
                                   x(i) = x(i) + temp*ap(k)
                                   k = k + 1
        10                     continue
                               if (nounit) x(j) = x(j)*ap(kk+j-1)
                           end if
                           kk = kk + j
        20             continue
                   else
                       jx = kx
                       do 40 j = 1,n
                           if (x(jx)/=zero) then
                               temp = x(jx)
                               ix = kx
                               do 30 k = kk,kk + j - 2
                                   x(ix) = x(ix) + temp*ap(k)
                                   ix = ix + incx
        30                     continue
                               if (nounit) x(jx) = x(jx)*ap(kk+j-1)
                           end if
                           jx = jx + incx
                           kk = kk + j
        40             continue
                   end if
               else
                   kk = (n* (n+1))/2
                   if (incx==1) then
                       do 60 j = n,1,-1
                           if (x(j)/=zero) then
                               temp = x(j)
                               k = kk
                               do 50 i = n,j + 1,-1
                                   x(i) = x(i) + temp*ap(k)
                                   k = k - 1
        50                     continue
                               if (nounit) x(j) = x(j)*ap(kk-n+j)
                           end if
                           kk = kk - (n-j+1)
        60             continue
                   else
                       kx = kx + (n-1)*incx
                       jx = kx
                       do 80 j = n,1,-1
                           if (x(jx)/=zero) then
                               temp = x(jx)
                               ix = kx
                               do 70 k = kk,kk - (n- (j+1)),-1
                                   x(ix) = x(ix) + temp*ap(k)
                                   ix = ix - incx
        70                     continue
                               if (nounit) x(jx) = x(jx)*ap(kk-n+j)
                           end if
                           jx = jx - incx
                           kk = kk - (n-j+1)
        80             continue
                   end if
               end if
           else
     
              ! form  x := a**t*x  or  x := a**h*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   kk = (n* (n+1))/2
                   if (incx==1) then
                       do 110 j = n,1,-1
                           temp = x(j)
                           k = kk - 1
                           if (noconj) then
                               if (nounit) temp = temp*ap(kk)
                               do 90 i = j - 1,1,-1
                                   temp = temp + ap(k)*x(i)
                                   k = k - 1
        90                     continue
                           else
                               if (nounit) temp = temp*conjg(ap(kk))
                               do 100 i = j - 1,1,-1
                                   temp = temp + conjg(ap(k))*x(i)
                                   k = k - 1
       100                     continue
                           end if
                           x(j) = temp
                           kk = kk - j
       110             continue
                   else
                       jx = kx + (n-1)*incx
                       do 140 j = n,1,-1
                           temp = x(jx)
                           ix = jx
                           if (noconj) then
                               if (nounit) temp = temp*ap(kk)
                               do 120 k = kk - 1,kk - j + 1,-1
                                   ix = ix - incx
                                   temp = temp + ap(k)*x(ix)
       120                     continue
                           else
                               if (nounit) temp = temp*conjg(ap(kk))
                               do 130 k = kk - 1,kk - j + 1,-1
                                   ix = ix - incx
                                   temp = temp + conjg(ap(k))*x(ix)
       130                     continue
                           end if
                           x(jx) = temp
                           jx = jx - incx
                           kk = kk - j
       140             continue
                   end if
               else
                   kk = 1
                   if (incx==1) then
                       do 170 j = 1,n
                           temp = x(j)
                           k = kk + 1
                           if (noconj) then
                               if (nounit) temp = temp*ap(kk)
                               do 150 i = j + 1,n
                                   temp = temp + ap(k)*x(i)
                                   k = k + 1
       150                     continue
                           else
                               if (nounit) temp = temp*conjg(ap(kk))
                               do 160 i = j + 1,n
                                   temp = temp + conjg(ap(k))*x(i)
                                   k = k + 1
       160                     continue
                           end if
                           x(j) = temp
                           kk = kk + (n-j+1)
       170             continue
                   else
                       jx = kx
                       do 200 j = 1,n
                           temp = x(jx)
                           ix = jx
                           if (noconj) then
                               if (nounit) temp = temp*ap(kk)
                               do 180 k = kk + 1,kk + n - j
                                   ix = ix + incx
                                   temp = temp + ap(k)*x(ix)
       180                     continue
                           else
                               if (nounit) temp = temp*conjg(ap(kk))
                               do 190 k = kk + 1,kk + n - j
                                   ix = ix + incx
                                   temp = temp + conjg(ap(k))*x(ix)
       190                     continue
                           end if
                           x(jx) = temp
                           jx = jx + incx
                           kk = kk + (n-j+1)
       200             continue
                   end if
               end if
           end if
     
           return
     
           ! end of stdlib_ctpmv
     
     end subroutine stdlib_ctpmv
     
     
     ! CTPSV  solves one of the systems of equations
     ! A*x = b,   or   A**T*x = b,   or   A**H*x = b,
     ! where b and x are n element vectors and A is an n by n unit, or
     ! non-unit, upper or lower triangular matrix, supplied in packed form.
     ! No test for singularity or near-singularity is included in this
     ! routine. Such tests must be performed before calling this routine.
     subroutine stdlib_ctpsv(uplo,trans,diag,n,ap,x,incx)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,n
           character diag,trans,uplo
           ! ..
           ! .. array arguments ..
           complex(sp) ap(*),x(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
           ! .. local scalars ..
           complex(sp) temp
           integer(int32) i,info,ix,j,jx,k,kk,kx
           logical(lk) noconj,nounit
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (.not.stdlib_lsame(trans,'n') .and. .not.stdlib_lsame(trans,'t') &
                     .and..not.stdlib_lsame(trans,'c')) then
               info = 2
           else if (.not.stdlib_lsame(diag,'u') .and. .not.stdlib_lsame(diag,'n')) then
               info = 3
           else if (n<0) then
               info = 4
           else if (incx==0) then
               info = 7
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_ctpsv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if (n==0) return
     
           noconj = stdlib_lsame(trans,'t')
           nounit = stdlib_lsame(diag,'n')
     
           ! set up the start point in x if the increment is not unity. this
           ! will be  ( n - 1 )*incx  too small for descending loops.
     
           if (incx<=0) then
               kx = 1 - (n-1)*incx
           else if (incx/=1) then
               kx = 1
           end if
     
           ! start the operations. in this version the elements of ap are
           ! accessed sequentially with one pass through ap.
     
           if (stdlib_lsame(trans,'n')) then
     
              ! form  x := inv( a )*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   kk = (n* (n+1))/2
                   if (incx==1) then
                       do 20 j = n,1,-1
                           if (x(j)/=zero) then
                               if (nounit) x(j) = x(j)/ap(kk)
                               temp = x(j)
                               k = kk - 1
                               do 10 i = j - 1,1,-1
                                   x(i) = x(i) - temp*ap(k)
                                   k = k - 1
        10                     continue
                           end if
                           kk = kk - j
        20             continue
                   else
                       jx = kx + (n-1)*incx
                       do 40 j = n,1,-1
                           if (x(jx)/=zero) then
                               if (nounit) x(jx) = x(jx)/ap(kk)
                               temp = x(jx)
                               ix = jx
                               do 30 k = kk - 1,kk - j + 1,-1
                                   ix = ix - incx
                                   x(ix) = x(ix) - temp*ap(k)
        30                     continue
                           end if
                           jx = jx - incx
                           kk = kk - j
        40             continue
                   end if
               else
                   kk = 1
                   if (incx==1) then
                       do 60 j = 1,n
                           if (x(j)/=zero) then
                               if (nounit) x(j) = x(j)/ap(kk)
                               temp = x(j)
                               k = kk + 1
                               do 50 i = j + 1,n
                                   x(i) = x(i) - temp*ap(k)
                                   k = k + 1
        50                     continue
                           end if
                           kk = kk + (n-j+1)
        60             continue
                   else
                       jx = kx
                       do 80 j = 1,n
                           if (x(jx)/=zero) then
                               if (nounit) x(jx) = x(jx)/ap(kk)
                               temp = x(jx)
                               ix = jx
                               do 70 k = kk + 1,kk + n - j
                                   ix = ix + incx
                                   x(ix) = x(ix) - temp*ap(k)
        70                     continue
                           end if
                           jx = jx + incx
                           kk = kk + (n-j+1)
        80             continue
                   end if
               end if
           else
     
              ! form  x := inv( a**t )*x  or  x := inv( a**h )*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   kk = 1
                   if (incx==1) then
                       do 110 j = 1,n
                           temp = x(j)
                           k = kk
                           if (noconj) then
                               do 90 i = 1,j - 1
                                   temp = temp - ap(k)*x(i)
                                   k = k + 1
        90                     continue
                               if (nounit) temp = temp/ap(kk+j-1)
                           else
                               do 100 i = 1,j - 1
                                   temp = temp - conjg(ap(k))*x(i)
                                   k = k + 1
       100                     continue
                               if (nounit) temp = temp/conjg(ap(kk+j-1))
                           end if
                           x(j) = temp
                           kk = kk + j
       110             continue
                   else
                       jx = kx
                       do 140 j = 1,n
                           temp = x(jx)
                           ix = kx
                           if (noconj) then
                               do 120 k = kk,kk + j - 2
                                   temp = temp - ap(k)*x(ix)
                                   ix = ix + incx
       120                     continue
                               if (nounit) temp = temp/ap(kk+j-1)
                           else
                               do 130 k = kk,kk + j - 2
                                   temp = temp - conjg(ap(k))*x(ix)
                                   ix = ix + incx
       130                     continue
                               if (nounit) temp = temp/conjg(ap(kk+j-1))
                           end if
                           x(jx) = temp
                           jx = jx + incx
                           kk = kk + j
       140             continue
                   end if
               else
                   kk = (n* (n+1))/2
                   if (incx==1) then
                       do 170 j = n,1,-1
                           temp = x(j)
                           k = kk
                           if (noconj) then
                               do 150 i = n,j + 1,-1
                                   temp = temp - ap(k)*x(i)
                                   k = k - 1
       150                     continue
                               if (nounit) temp = temp/ap(kk-n+j)
                           else
                               do 160 i = n,j + 1,-1
                                   temp = temp - conjg(ap(k))*x(i)
                                   k = k - 1
       160                     continue
                               if (nounit) temp = temp/conjg(ap(kk-n+j))
                           end if
                           x(j) = temp
                           kk = kk - (n-j+1)
       170             continue
                   else
                       kx = kx + (n-1)*incx
                       jx = kx
                       do 200 j = n,1,-1
                           temp = x(jx)
                           ix = kx
                           if (noconj) then
                               do 180 k = kk,kk - (n- (j+1)),-1
                                   temp = temp - ap(k)*x(ix)
                                   ix = ix - incx
       180                     continue
                               if (nounit) temp = temp/ap(kk-n+j)
                           else
                               do 190 k = kk,kk - (n- (j+1)),-1
                                   temp = temp - conjg(ap(k))*x(ix)
                                   ix = ix - incx
       190                     continue
                               if (nounit) temp = temp/conjg(ap(kk-n+j))
                           end if
                           x(jx) = temp
                           jx = jx - incx
                           kk = kk - (n-j+1)
       200             continue
                   end if
               end if
           end if
     
           return
     
           ! end of stdlib_ctpsv
     
     end subroutine stdlib_ctpsv
     
     
     ! CTRMM  performs one of the matrix-matrix operations
     ! B := alpha*op( A )*B,   or   B := alpha*B*op( A )
     ! where  alpha  is a scalar,  B  is an m by n matrix,  A  is a unit, or
     ! non-unit,  upper or lower triangular matrix  and  op( A )  is one  of
     ! op( A ) = A   or   op( A ) = A**T   or   op( A ) = A**H.
     subroutine stdlib_ctrmm(side,uplo,transa,diag,m,n,alpha,a,lda,b,ldb)
     
        ! -- reference blas level3 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           complex(sp) alpha
           integer(int32) lda,ldb,m,n
           character diag,side,transa,uplo
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),b(ldb,*)
           ! ..
     
        ! =====================================================================
     
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg,max
           ! ..
           ! .. local scalars ..
           complex(sp) temp
           integer(int32) i,info,j,k,nrowa
           logical(lk) lside,noconj,nounit,upper
           ! ..
           ! .. parameters ..
           complex(sp) one
           parameter (one= (1.0_sp,0.0_sp))
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
     
           ! test the input parameters.
     
           lside = stdlib_lsame(side,'l')
           if (lside) then
               nrowa = m
           else
               nrowa = n
           end if
           noconj = stdlib_lsame(transa,'t')
           nounit = stdlib_lsame(diag,'n')
           upper = stdlib_lsame(uplo,'u')
     
           info = 0
           if ((.not.lside) .and. (.not.stdlib_lsame(side,'r'))) then
               info = 1
           else if ((.not.upper) .and. (.not.stdlib_lsame(uplo,'l'))) then
               info = 2
           else if ((.not.stdlib_lsame(transa,'n')) .and.(.not.stdlib_lsame(transa,'t')) .and.(&
                     .not.stdlib_lsame(transa,'c'))) then
               info = 3
           else if ((.not.stdlib_lsame(diag,'u')) .and. (.not.stdlib_lsame(diag,'n'))) &
                     then
               info = 4
           else if (m<0) then
               info = 5
           else if (n<0) then
               info = 6
           else if (lda<max(1,nrowa)) then
               info = 9
           else if (ldb<max(1,m)) then
               info = 11
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_ctrmm ',info)
               return
           end if
     
           ! quick return if possible.
     
           if (m==0 .or. n==0) return
     
           ! and when  alpha.eq.zero.
     
           if (alpha==zero) then
               do 20 j = 1,n
                   do 10 i = 1,m
                       b(i,j) = zero
        10         continue
        20     continue
               return
           end if
     
           ! start the operations.
     
           if (lside) then
               if (stdlib_lsame(transa,'n')) then
     
                 ! form  b := alpha*a*b.
     
                   if (upper) then
                       do 50 j = 1,n
                           do 40 k = 1,m
                               if (b(k,j)/=zero) then
                                   temp = alpha*b(k,j)
                                   do 30 i = 1,k - 1
                                       b(i,j) = b(i,j) + temp*a(i,k)
        30                         continue
                                   if (nounit) temp = temp*a(k,k)
                                   b(k,j) = temp
                               end if
        40                 continue
        50             continue
                   else
                       do 80 j = 1,n
                           do 70 k = m,1,-1
                               if (b(k,j)/=zero) then
                                   temp = alpha*b(k,j)
                                   b(k,j) = temp
                                   if (nounit) b(k,j) = b(k,j)*a(k,k)
                                   do 60 i = k + 1,m
                                       b(i,j) = b(i,j) + temp*a(i,k)
        60                         continue
                               end if
        70                 continue
        80             continue
                   end if
               else
     
                 ! form  b := alpha*a**t*b   or   b := alpha*a**h*b.
     
                   if (upper) then
                       do 120 j = 1,n
                           do 110 i = m,1,-1
                               temp = b(i,j)
                               if (noconj) then
                                   if (nounit) temp = temp*a(i,i)
                                   do 90 k = 1,i - 1
                                       temp = temp + a(k,i)*b(k,j)
        90                         continue
                               else
                                   if (nounit) temp = temp*conjg(a(i,i))
                                   do 100 k = 1,i - 1
                                       temp = temp + conjg(a(k,i))*b(k,j)
       100                         continue
                               end if
                               b(i,j) = alpha*temp
       110                 continue
       120             continue
                   else
                       do 160 j = 1,n
                           do 150 i = 1,m
                               temp = b(i,j)
                               if (noconj) then
                                   if (nounit) temp = temp*a(i,i)
                                   do 130 k = i + 1,m
                                       temp = temp + a(k,i)*b(k,j)
       130                         continue
                               else
                                   if (nounit) temp = temp*conjg(a(i,i))
                                   do 140 k = i + 1,m
                                       temp = temp + conjg(a(k,i))*b(k,j)
       140                         continue
                               end if
                               b(i,j) = alpha*temp
       150                 continue
       160             continue
                   end if
               end if
           else
               if (stdlib_lsame(transa,'n')) then
     
                 ! form  b := alpha*b*a.
     
                   if (upper) then
                       do 200 j = n,1,-1
                           temp = alpha
                           if (nounit) temp = temp*a(j,j)
                           do 170 i = 1,m
                               b(i,j) = temp*b(i,j)
       170                 continue
                           do 190 k = 1,j - 1
                               if (a(k,j)/=zero) then
                                   temp = alpha*a(k,j)
                                   do 180 i = 1,m
                                       b(i,j) = b(i,j) + temp*b(i,k)
       180                         continue
                               end if
       190                 continue
       200             continue
                   else
                       do 240 j = 1,n
                           temp = alpha
                           if (nounit) temp = temp*a(j,j)
                           do 210 i = 1,m
                               b(i,j) = temp*b(i,j)
       210                 continue
                           do 230 k = j + 1,n
                               if (a(k,j)/=zero) then
                                   temp = alpha*a(k,j)
                                   do 220 i = 1,m
                                       b(i,j) = b(i,j) + temp*b(i,k)
       220                         continue
                               end if
       230                 continue
       240             continue
                   end if
               else
     
                 ! form  b := alpha*b*a**t   or   b := alpha*b*a**h.
     
                   if (upper) then
                       do 280 k = 1,n
                           do 260 j = 1,k - 1
                               if (a(j,k)/=zero) then
                                   if (noconj) then
                                       temp = alpha*a(j,k)
                                   else
                                       temp = alpha*conjg(a(j,k))
                                   end if
                                   do 250 i = 1,m
                                       b(i,j) = b(i,j) + temp*b(i,k)
       250                         continue
                               end if
       260                 continue
                           temp = alpha
                           if (nounit) then
                               if (noconj) then
                                   temp = temp*a(k,k)
                               else
                                   temp = temp*conjg(a(k,k))
                               end if
                           end if
                           if (temp/=one) then
                               do 270 i = 1,m
                                   b(i,k) = temp*b(i,k)
       270                     continue
                           end if
       280             continue
                   else
                       do 320 k = n,1,-1
                           do 300 j = k + 1,n
                               if (a(j,k)/=zero) then
                                   if (noconj) then
                                       temp = alpha*a(j,k)
                                   else
                                       temp = alpha*conjg(a(j,k))
                                   end if
                                   do 290 i = 1,m
                                       b(i,j) = b(i,j) + temp*b(i,k)
       290                         continue
                               end if
       300                 continue
                           temp = alpha
                           if (nounit) then
                               if (noconj) then
                                   temp = temp*a(k,k)
                               else
                                   temp = temp*conjg(a(k,k))
                               end if
                           end if
                           if (temp/=one) then
                               do 310 i = 1,m
                                   b(i,k) = temp*b(i,k)
       310                     continue
                           end if
       320             continue
                   end if
               end if
           end if
     
           return
     
           ! end of stdlib_ctrmm
     
     end subroutine stdlib_ctrmm
     
     
     ! CTRMV  performs one of the matrix-vector operations
     ! x := A*x,   or   x := A**T*x,   or   x := A**H*x,
     ! where x is an n element vector and  A is an n by n unit, or non-unit,
     ! upper or lower triangular matrix.
     subroutine stdlib_ctrmv(uplo,trans,diag,n,a,lda,x,incx)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,lda,n
           character diag,trans,uplo
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),x(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
           ! .. local scalars ..
           complex(sp) temp
           integer(int32) i,info,ix,j,jx,kx
           logical(lk) noconj,nounit
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg,max
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (.not.stdlib_lsame(trans,'n') .and. .not.stdlib_lsame(trans,'t') &
                     .and..not.stdlib_lsame(trans,'c')) then
               info = 2
           else if (.not.stdlib_lsame(diag,'u') .and. .not.stdlib_lsame(diag,'n')) then
               info = 3
           else if (n<0) then
               info = 4
           else if (lda<max(1,n)) then
               info = 6
           else if (incx==0) then
               info = 8
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_ctrmv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if (n==0) return
     
           noconj = stdlib_lsame(trans,'t')
           nounit = stdlib_lsame(diag,'n')
     
           ! set up the start point in x if the increment is not unity. this
           ! will be  ( n - 1 )*incx  too small for descending loops.
     
           if (incx<=0) then
               kx = 1 - (n-1)*incx
           else if (incx/=1) then
               kx = 1
           end if
     
           ! start the operations. in this version the elements of a are
           ! accessed sequentially with one pass through a.
     
           if (stdlib_lsame(trans,'n')) then
     
              ! form  x := a*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   if (incx==1) then
                       do 20 j = 1,n
                           if (x(j)/=zero) then
                               temp = x(j)
                               do 10 i = 1,j - 1
                                   x(i) = x(i) + temp*a(i,j)
        10                     continue
                               if (nounit) x(j) = x(j)*a(j,j)
                           end if
        20             continue
                   else
                       jx = kx
                       do 40 j = 1,n
                           if (x(jx)/=zero) then
                               temp = x(jx)
                               ix = kx
                               do 30 i = 1,j - 1
                                   x(ix) = x(ix) + temp*a(i,j)
                                   ix = ix + incx
        30                     continue
                               if (nounit) x(jx) = x(jx)*a(j,j)
                           end if
                           jx = jx + incx
        40             continue
                   end if
               else
                   if (incx==1) then
                       do 60 j = n,1,-1
                           if (x(j)/=zero) then
                               temp = x(j)
                               do 50 i = n,j + 1,-1
                                   x(i) = x(i) + temp*a(i,j)
        50                     continue
                               if (nounit) x(j) = x(j)*a(j,j)
                           end if
        60             continue
                   else
                       kx = kx + (n-1)*incx
                       jx = kx
                       do 80 j = n,1,-1
                           if (x(jx)/=zero) then
                               temp = x(jx)
                               ix = kx
                               do 70 i = n,j + 1,-1
                                   x(ix) = x(ix) + temp*a(i,j)
                                   ix = ix - incx
        70                     continue
                               if (nounit) x(jx) = x(jx)*a(j,j)
                           end if
                           jx = jx - incx
        80             continue
                   end if
               end if
           else
     
              ! form  x := a**t*x  or  x := a**h*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   if (incx==1) then
                       do 110 j = n,1,-1
                           temp = x(j)
                           if (noconj) then
                               if (nounit) temp = temp*a(j,j)
                               do 90 i = j - 1,1,-1
                                   temp = temp + a(i,j)*x(i)
        90                     continue
                           else
                               if (nounit) temp = temp*conjg(a(j,j))
                               do 100 i = j - 1,1,-1
                                   temp = temp + conjg(a(i,j))*x(i)
       100                     continue
                           end if
                           x(j) = temp
       110             continue
                   else
                       jx = kx + (n-1)*incx
                       do 140 j = n,1,-1
                           temp = x(jx)
                           ix = jx
                           if (noconj) then
                               if (nounit) temp = temp*a(j,j)
                               do 120 i = j - 1,1,-1
                                   ix = ix - incx
                                   temp = temp + a(i,j)*x(ix)
       120                     continue
                           else
                               if (nounit) temp = temp*conjg(a(j,j))
                               do 130 i = j - 1,1,-1
                                   ix = ix - incx
                                   temp = temp + conjg(a(i,j))*x(ix)
       130                     continue
                           end if
                           x(jx) = temp
                           jx = jx - incx
       140             continue
                   end if
               else
                   if (incx==1) then
                       do 170 j = 1,n
                           temp = x(j)
                           if (noconj) then
                               if (nounit) temp = temp*a(j,j)
                               do 150 i = j + 1,n
                                   temp = temp + a(i,j)*x(i)
       150                     continue
                           else
                               if (nounit) temp = temp*conjg(a(j,j))
                               do 160 i = j + 1,n
                                   temp = temp + conjg(a(i,j))*x(i)
       160                     continue
                           end if
                           x(j) = temp
       170             continue
                   else
                       jx = kx
                       do 200 j = 1,n
                           temp = x(jx)
                           ix = jx
                           if (noconj) then
                               if (nounit) temp = temp*a(j,j)
                               do 180 i = j + 1,n
                                   ix = ix + incx
                                   temp = temp + a(i,j)*x(ix)
       180                     continue
                           else
                               if (nounit) temp = temp*conjg(a(j,j))
                               do 190 i = j + 1,n
                                   ix = ix + incx
                                   temp = temp + conjg(a(i,j))*x(ix)
       190                     continue
                           end if
                           x(jx) = temp
                           jx = jx + incx
       200             continue
                   end if
               end if
           end if
     
           return
     
           ! end of stdlib_ctrmv
     
     end subroutine stdlib_ctrmv
     
     
     ! CTRSM  solves one of the matrix equations
     ! op( A )*X = alpha*B,   or   X*op( A ) = alpha*B,
     ! where alpha is a scalar, X and B are m by n matrices, A is a unit, or
     ! non-unit,  upper or lower triangular matrix  and  op( A )  is one  of
     ! op( A ) = A   or   op( A ) = A**T   or   op( A ) = A**H.
     ! The matrix X is overwritten on B.
     subroutine stdlib_ctrsm(side,uplo,transa,diag,m,n,alpha,a,lda,b,ldb)
     
        ! -- reference blas level3 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           complex(sp) alpha
           integer(int32) lda,ldb,m,n
           character diag,side,transa,uplo
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),b(ldb,*)
           ! ..
     
        ! =====================================================================
     
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg,max
           ! ..
           ! .. local scalars ..
           complex(sp) temp
           integer(int32) i,info,j,k,nrowa
           logical(lk) lside,noconj,nounit,upper
           ! ..
           ! .. parameters ..
           complex(sp) one
           parameter (one= (1.0_sp,0.0_sp))
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
     
           ! test the input parameters.
     
           lside = stdlib_lsame(side,'l')
           if (lside) then
               nrowa = m
           else
               nrowa = n
           end if
           noconj = stdlib_lsame(transa,'t')
           nounit = stdlib_lsame(diag,'n')
           upper = stdlib_lsame(uplo,'u')
     
           info = 0
           if ((.not.lside) .and. (.not.stdlib_lsame(side,'r'))) then
               info = 1
           else if ((.not.upper) .and. (.not.stdlib_lsame(uplo,'l'))) then
               info = 2
           else if ((.not.stdlib_lsame(transa,'n')) .and.(.not.stdlib_lsame(transa,'t')) .and.(&
                     .not.stdlib_lsame(transa,'c'))) then
               info = 3
           else if ((.not.stdlib_lsame(diag,'u')) .and. (.not.stdlib_lsame(diag,'n'))) &
                     then
               info = 4
           else if (m<0) then
               info = 5
           else if (n<0) then
               info = 6
           else if (lda<max(1,nrowa)) then
               info = 9
           else if (ldb<max(1,m)) then
               info = 11
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_ctrsm ',info)
               return
           end if
     
           ! quick return if possible.
     
           if (m==0 .or. n==0) return
     
           ! and when  alpha.eq.zero.
     
           if (alpha==zero) then
               do 20 j = 1,n
                   do 10 i = 1,m
                       b(i,j) = zero
        10         continue
        20     continue
               return
           end if
     
           ! start the operations.
     
           if (lside) then
               if (stdlib_lsame(transa,'n')) then
     
                 ! form  b := alpha*inv( a )*b.
     
                   if (upper) then
                       do 60 j = 1,n
                           if (alpha/=one) then
                               do 30 i = 1,m
                                   b(i,j) = alpha*b(i,j)
        30                     continue
                           end if
                           do 50 k = m,1,-1
                               if (b(k,j)/=zero) then
                                   if (nounit) b(k,j) = b(k,j)/a(k,k)
                                   do 40 i = 1,k - 1
                                       b(i,j) = b(i,j) - b(k,j)*a(i,k)
        40                         continue
                               end if
        50                 continue
        60             continue
                   else
                       do 100 j = 1,n
                           if (alpha/=one) then
                               do 70 i = 1,m
                                   b(i,j) = alpha*b(i,j)
        70                     continue
                           end if
                           do 90 k = 1,m
                               if (b(k,j)/=zero) then
                                   if (nounit) b(k,j) = b(k,j)/a(k,k)
                                   do 80 i = k + 1,m
                                       b(i,j) = b(i,j) - b(k,j)*a(i,k)
        80                         continue
                               end if
        90                 continue
       100             continue
                   end if
               else
     
                 ! form  b := alpha*inv( a**t )*b
                 ! or    b := alpha*inv( a**h )*b.
     
                   if (upper) then
                       do 140 j = 1,n
                           do 130 i = 1,m
                               temp = alpha*b(i,j)
                               if (noconj) then
                                   do 110 k = 1,i - 1
                                       temp = temp - a(k,i)*b(k,j)
       110                         continue
                                   if (nounit) temp = temp/a(i,i)
                               else
                                   do 120 k = 1,i - 1
                                       temp = temp - conjg(a(k,i))*b(k,j)
       120                         continue
                                   if (nounit) temp = temp/conjg(a(i,i))
                               end if
                               b(i,j) = temp
       130                 continue
       140             continue
                   else
                       do 180 j = 1,n
                           do 170 i = m,1,-1
                               temp = alpha*b(i,j)
                               if (noconj) then
                                   do 150 k = i + 1,m
                                       temp = temp - a(k,i)*b(k,j)
       150                         continue
                                   if (nounit) temp = temp/a(i,i)
                               else
                                   do 160 k = i + 1,m
                                       temp = temp - conjg(a(k,i))*b(k,j)
       160                         continue
                                   if (nounit) temp = temp/conjg(a(i,i))
                               end if
                               b(i,j) = temp
       170                 continue
       180             continue
                   end if
               end if
           else
               if (stdlib_lsame(transa,'n')) then
     
                 ! form  b := alpha*b*inv( a ).
     
                   if (upper) then
                       do 230 j = 1,n
                           if (alpha/=one) then
                               do 190 i = 1,m
                                   b(i,j) = alpha*b(i,j)
       190                     continue
                           end if
                           do 210 k = 1,j - 1
                               if (a(k,j)/=zero) then
                                   do 200 i = 1,m
                                       b(i,j) = b(i,j) - a(k,j)*b(i,k)
       200                         continue
                               end if
       210                 continue
                           if (nounit) then
                               temp = one/a(j,j)
                               do 220 i = 1,m
                                   b(i,j) = temp*b(i,j)
       220                     continue
                           end if
       230             continue
                   else
                       do 280 j = n,1,-1
                           if (alpha/=one) then
                               do 240 i = 1,m
                                   b(i,j) = alpha*b(i,j)
       240                     continue
                           end if
                           do 260 k = j + 1,n
                               if (a(k,j)/=zero) then
                                   do 250 i = 1,m
                                       b(i,j) = b(i,j) - a(k,j)*b(i,k)
       250                         continue
                               end if
       260                 continue
                           if (nounit) then
                               temp = one/a(j,j)
                               do 270 i = 1,m
                                   b(i,j) = temp*b(i,j)
       270                     continue
                           end if
       280             continue
                   end if
               else
     
                 ! form  b := alpha*b*inv( a**t )
                 ! or    b := alpha*b*inv( a**h ).
     
                   if (upper) then
                       do 330 k = n,1,-1
                           if (nounit) then
                               if (noconj) then
                                   temp = one/a(k,k)
                               else
                                   temp = one/conjg(a(k,k))
                               end if
                               do 290 i = 1,m
                                   b(i,k) = temp*b(i,k)
       290                     continue
                           end if
                           do 310 j = 1,k - 1
                               if (a(j,k)/=zero) then
                                   if (noconj) then
                                       temp = a(j,k)
                                   else
                                       temp = conjg(a(j,k))
                                   end if
                                   do 300 i = 1,m
                                       b(i,j) = b(i,j) - temp*b(i,k)
       300                         continue
                               end if
       310                 continue
                           if (alpha/=one) then
                               do 320 i = 1,m
                                   b(i,k) = alpha*b(i,k)
       320                     continue
                           end if
       330             continue
                   else
                       do 380 k = 1,n
                           if (nounit) then
                               if (noconj) then
                                   temp = one/a(k,k)
                               else
                                   temp = one/conjg(a(k,k))
                               end if
                               do 340 i = 1,m
                                   b(i,k) = temp*b(i,k)
       340                     continue
                           end if
                           do 360 j = k + 1,n
                               if (a(j,k)/=zero) then
                                   if (noconj) then
                                       temp = a(j,k)
                                   else
                                       temp = conjg(a(j,k))
                                   end if
                                   do 350 i = 1,m
                                       b(i,j) = b(i,j) - temp*b(i,k)
       350                         continue
                               end if
       360                 continue
                           if (alpha/=one) then
                               do 370 i = 1,m
                                   b(i,k) = alpha*b(i,k)
       370                     continue
                           end if
       380             continue
                   end if
               end if
           end if
     
           return
     
           ! end of stdlib_ctrsm
     
     end subroutine stdlib_ctrsm
     
     
     ! CTRSV  solves one of the systems of equations
     ! A*x = b,   or   A**T*x = b,   or   A**H*x = b,
     ! where b and x are n element vectors and A is an n by n unit, or
     ! non-unit, upper or lower triangular matrix.
     ! No test for singularity or near-singularity is included in this
     ! routine. Such tests must be performed before calling this routine.
     subroutine stdlib_ctrsv(uplo,trans,diag,n,a,lda,x,incx)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,lda,n
           character diag,trans,uplo
           ! ..
           ! .. array arguments ..
           complex(sp) a(lda,*),x(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           complex(sp) zero
           parameter (zero= (0.0_sp,0.0_sp))
           ! ..
           ! .. local scalars ..
           complex(sp) temp
           integer(int32) i,info,ix,j,jx,kx
           logical(lk) noconj,nounit
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic conjg,max
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (.not.stdlib_lsame(trans,'n') .and. .not.stdlib_lsame(trans,'t') &
                     .and..not.stdlib_lsame(trans,'c')) then
               info = 2
           else if (.not.stdlib_lsame(diag,'u') .and. .not.stdlib_lsame(diag,'n')) then
               info = 3
           else if (n<0) then
               info = 4
           else if (lda<max(1,n)) then
               info = 6
           else if (incx==0) then
               info = 8
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_ctrsv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if (n==0) return
     
           noconj = stdlib_lsame(trans,'t')
           nounit = stdlib_lsame(diag,'n')
     
           ! set up the start point in x if the increment is not unity. this
           ! will be  ( n - 1 )*incx  too small for descending loops.
     
           if (incx<=0) then
               kx = 1 - (n-1)*incx
           else if (incx/=1) then
               kx = 1
           end if
     
           ! start the operations. in this version the elements of a are
           ! accessed sequentially with one pass through a.
     
           if (stdlib_lsame(trans,'n')) then
     
              ! form  x := inv( a )*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   if (incx==1) then
                       do 20 j = n,1,-1
                           if (x(j)/=zero) then
                               if (nounit) x(j) = x(j)/a(j,j)
                               temp = x(j)
                               do 10 i = j - 1,1,-1
                                   x(i) = x(i) - temp*a(i,j)
        10                     continue
                           end if
        20             continue
                   else
                       jx = kx + (n-1)*incx
                       do 40 j = n,1,-1
                           if (x(jx)/=zero) then
                               if (nounit) x(jx) = x(jx)/a(j,j)
                               temp = x(jx)
                               ix = jx
                               do 30 i = j - 1,1,-1
                                   ix = ix - incx
                                   x(ix) = x(ix) - temp*a(i,j)
        30                     continue
                           end if
                           jx = jx - incx
        40             continue
                   end if
               else
                   if (incx==1) then
                       do 60 j = 1,n
                           if (x(j)/=zero) then
                               if (nounit) x(j) = x(j)/a(j,j)
                               temp = x(j)
                               do 50 i = j + 1,n
                                   x(i) = x(i) - temp*a(i,j)
        50                     continue
                           end if
        60             continue
                   else
                       jx = kx
                       do 80 j = 1,n
                           if (x(jx)/=zero) then
                               if (nounit) x(jx) = x(jx)/a(j,j)
                               temp = x(jx)
                               ix = jx
                               do 70 i = j + 1,n
                                   ix = ix + incx
                                   x(ix) = x(ix) - temp*a(i,j)
        70                     continue
                           end if
                           jx = jx + incx
        80             continue
                   end if
               end if
           else
     
              ! form  x := inv( a**t )*x  or  x := inv( a**h )*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   if (incx==1) then
                       do 110 j = 1,n
                           temp = x(j)
                           if (noconj) then
                               do 90 i = 1,j - 1
                                   temp = temp - a(i,j)*x(i)
        90                     continue
                               if (nounit) temp = temp/a(j,j)
                           else
                               do 100 i = 1,j - 1
                                   temp = temp - conjg(a(i,j))*x(i)
       100                     continue
                               if (nounit) temp = temp/conjg(a(j,j))
                           end if
                           x(j) = temp
       110             continue
                   else
                       jx = kx
                       do 140 j = 1,n
                           ix = kx
                           temp = x(jx)
                           if (noconj) then
                               do 120 i = 1,j - 1
                                   temp = temp - a(i,j)*x(ix)
                                   ix = ix + incx
       120                     continue
                               if (nounit) temp = temp/a(j,j)
                           else
                               do 130 i = 1,j - 1
                                   temp = temp - conjg(a(i,j))*x(ix)
                                   ix = ix + incx
       130                     continue
                               if (nounit) temp = temp/conjg(a(j,j))
                           end if
                           x(jx) = temp
                           jx = jx + incx
       140             continue
                   end if
               else
                   if (incx==1) then
                       do 170 j = n,1,-1
                           temp = x(j)
                           if (noconj) then
                               do 150 i = n,j + 1,-1
                                   temp = temp - a(i,j)*x(i)
       150                     continue
                               if (nounit) temp = temp/a(j,j)
                           else
                               do 160 i = n,j + 1,-1
                                   temp = temp - conjg(a(i,j))*x(i)
       160                     continue
                               if (nounit) temp = temp/conjg(a(j,j))
                           end if
                           x(j) = temp
       170             continue
                   else
                       kx = kx + (n-1)*incx
                       jx = kx
                       do 200 j = n,1,-1
                           ix = kx
                           temp = x(jx)
                           if (noconj) then
                               do 180 i = n,j + 1,-1
                                   temp = temp - a(i,j)*x(ix)
                                   ix = ix - incx
       180                     continue
                               if (nounit) temp = temp/a(j,j)
                           else
                               do 190 i = n,j + 1,-1
                                   temp = temp - conjg(a(i,j))*x(ix)
                                   ix = ix - incx
       190                     continue
                               if (nounit) temp = temp/conjg(a(j,j))
                           end if
                           x(jx) = temp
                           jx = jx - incx
       200             continue
                   end if
               end if
           end if
     
           return
     
           ! end of stdlib_ctrsv
     
     end subroutine stdlib_ctrsv



end module stdlib_linalg_blas_c
